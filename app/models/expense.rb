class Expense < ActiveRecord::Base
  belongs_to :trip
  belongs_to :user

  def amount_owe
    @trip = self.trip
    if @trip.expense_per_person > self.amount_spent
      @trip.expense_per_person - self.amount_spent
    else
      0
    end
  end

  def amount_get
    @trip = self.trip
    if @trip.expense_per_person < self.amount_spent
      self.amount_spent - @trip.expense_per_person
    else
      0
    end
  end

end
