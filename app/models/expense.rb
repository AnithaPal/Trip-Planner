class Expense < ActiveRecord::Base
  belongs_to :trip
  belongs_to :user

  def amount_owe
    if trip.expense_per_person > self.amount_spent
      (trip.expense_per_person - self.amount_spent).round(2)
    else
      0
    end
  end

  def amount_get
    if trip.expense_per_person < self.amount_spent
      (self.amount_spent - trip.expense_per_person).round(2)
    else
      0
    end
  end

end
