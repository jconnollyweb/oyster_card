class Oystercard
  attr_reader :balance, :in_journey
  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1

  def initialize 
    @balance = 0
    @in_journey = false
  end 

  def top_up(amount)
    fail "Maximum balance of £#{MAXIMUM_BALANCE} exceeded" if @balance + amount >   MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail "You have insufficient funds" if @balance < MINIMUM_CHARGE
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @in_journey = false
  end

  private
  
  def deduct(amount)
    @balance -= amount
  end

end 