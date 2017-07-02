class Transfer
  attr_reader :sender, :receiver, :amount, :status, :transfer

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    @sender.valid? && @receiver.valid? && @amount < @sender.balance ? true : false
  end

  def execute_transaction
    if self.valid?
      @sender.balance -= @amount
      @receiver.balance += @amount
      @status = "complete"
      @reverse_transfer_amount = @amount
      @amount = 0
      @transfer = self
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @transfer != nil
      @sender.balance += @reverse_transfer_amount
      @receiver.balance -= @reverse_transfer_amount
      @reverse_transfer_amount = 0
      @status = "reversed"
    else
      "could not find transaction"
    end
  end

end
