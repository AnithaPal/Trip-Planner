class Trip < ActiveRecord::Base
  belongs_to :user

  has_many :polls
  has_many :trippers, dependent: :destroy
  has_many :users, through: :trippers
  has_many :expenses
  has_many :invites

  default_scope { order('trips.created_at DESC') }

  validates_presence_of :name

  def is_owner_or_invited?(person)
    person == user || users.include?(person)
  end

  def total_expenses
    expenses.sum(:amount_spent)
  end

  def expense_per_person
    user_amt = user_count
    if user_amt > 0
      expenses.sum(:amount_spent) / user_amt
    else
      expenses.sum(:amount_spent)
    end
  end

  def user_count
    no_of_owners = 1
    trippers.count + no_of_owners
  end

  def all_users
    col = users.to_a
    col << user
    col
  end

  def reconciliations
    result = []
    hsh = { givers: [], receivers: [] }

    all_users.each do |user|
      diff = expense_per_person - user.expenses_for_trip(self)

      if diff > 0
        result << Reconciliation.new("unsure", user.name, diff.abs)
        hsh[:givers] << [user.name, diff.abs]
      else
        hsh[:receivers] << [user.name, diff.abs]
      end
    end

    result = sort_money(hsh)
  end

  def sort_money(hsh)
    result = []

    amts_owed = hsh[:givers].sort { |x, y| x.last <=> y.last }
    amts_over = hsh[:receivers].sort { |x, y| x.last <=> y.last }

    ri = amts_over.length
    gi = amts_owed.length

    while ri > 0 && gi > 0
      receiver, over = amts_over[ri - 1]
      giver, owed = amts_owed[gi - 1]

      diff = over - owed
      if diff > 0
        result << Reconciliation.new(receiver, giver, owed)
        amts_over << [receiver, diff]
        amts_over.sort! { |x, y| x.last <=> y.last }
        gi -= 1
      elsif diff < 0
        result << Reconciliation.new(receiver, giver, over)
        amts_owed << [giver, diff.abs]
        amts_owed.sort! { |x, y| x.last <=> y.last }
        ri -= 1
      elsif diff == 0
        result << Reconciliation.new(receiver, giver, owed)
        ri -= 1
        gi -= 1
      end

      amts_over.delete([receiver, over])
      amts_owed.delete([giver, owed])
    end

    result
  end
end

class Reconciliation
  attr_reader :giver, :receiver, :amount

  def initialize(receiver, giver, amount)
    @giver = giver
    @receiver = receiver
    @amount = amount
  end
end
