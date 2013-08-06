require "rspec"

require_relative "account"

describe Account do
  let (:account_number) {"0123456789"}
  let (:account) {Account.new(account_number)}
  let (:account2) {Account.new(account_number, 40)}

  describe "#initialize" do
    it "returns a instance of account" do
      expect(Account.new(account_number)).to be_a_kind_of(Account)
    end

    it "account has a valid number of digits" do
      expect {Account.new("2")}.to raise_error(InvalidAccountNumberError)
    end

    it "new account expects an account number" do
      expect {Account.new}.to raise_error(ArgumentError)
    end

    it "only accepts digits for account number" do
      expect {Account.new("1231aa2945")}.to raise_error(InvalidAccountNumberError)
    end


  end

  describe "#transactions" do
    it "sets initial starting point in transactions to 0 if no starting balance is passed" do
      account.transactions.should eq [0]
    end

    it 'sets starting array to starting balance passed upon initialize' do
      account2.transactions.should eq [40]
    end
  end

  describe "#balance" do
    it "add all values in transactions array" do
      account1 = Account.new("1234567890", 50)
      account1.balance.should eq 50
    end
  end

  describe "#acct_number" do
    it "hides all but the last 4 numbers in account number" do
      account.acct_number.should eq("******6789")
    end
  end

  describe "#deposit!" do
    it "returns error when deposit number is negative" do
      expect {account.deposit!(-2)}.to raise_error(NegativeDepositError)
    end

    it "should add deposit amount to original balance" do
      account2.deposit!(5).should eq 45
    end
  end

  describe "#withdraw!" do
    it "should subtract withdraw amount from original balance" do
      account2.withdraw!(5).should eq 35
    end

    it "should raise OverdraftError when withdrawing amount greater than balance" do
      expect {account.withdraw!(100)}.to raise_error(OverdraftError)
    end      
  end
end
