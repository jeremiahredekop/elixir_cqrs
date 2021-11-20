defmodule OpenBankAccount do
  use TypedStruct

  typedstruct enforce: true do
    field :account_number, non_neg_integer()
    field :initial_balance, non_neg_integer()
  end

end

defmodule BankAccountOpened do
  @derive Jason.Encoder
  use TypedStruct

  typedstruct enforce: true do
    field :account_number, non_neg_integer()
    field :initial_balance, non_neg_integer()
  end
end

defmodule BankAccount do
  use TypedStruct

  typedstruct enforce: true do
    field :account_number, non_neg_integer()
    field :initial_balance, integer()
    field :balance, integer()
  end

  # Public Api


  def execute(
        %BankAccount{account_number: nil},
        %OpenBankAccount{account_number: account_number, initial_balance: initial_balance}
      )
      when initial_balance > 0 do
    %BankAccountOpened{account_number: account_number, initial_balance: initial_balance}
  end

  def execute(%BankAccount{}, %OpenBankAccount{initial_balance: initial_balance})
      when initial_balance <= 0 do
    {:error, :initial_balance_must_be_above_zero}
  end

  def execute(%BankAccount{}, %OpenBankAccount{}) do
    {:error, :account_already_opened}
  end

  def apply(%BankAccount{} = account, %BankAccountOpened{} = event) do
    %BankAccountOpened{account_number: account_number, initial_balance: initial_balance} = event

    %BankAccount{account | account_number: account_number, balance: initial_balance}
  end
end
