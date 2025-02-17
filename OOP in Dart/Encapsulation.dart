class BankAccount {
  double _balance = 0;

  void deposit(double amount) {
    _balance += amount;
  }

  double get balance => _balance; // Getter
}

void main() {
  BankAccount account = BankAccount();
  account.deposit(1000);
  print("Balance: \$${account.balance}");
}
