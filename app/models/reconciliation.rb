class Reconciliation
  attr_reader :giver, :receiver, :amount

  def initialize(receiver, giver, amount)
    @giver = giver
    @receiver = receiver
    @amount = amount
  end
end
