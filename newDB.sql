create table Branch (
  IFS_Code varchar(255) not null primary key,
  Branch_Name varchar(255) not null,
  City varchar(255) not null,
  Branch_Address varchar(255) not null,
  State varchar(255) not null,
  Country varchar(255) not null,
  PIN_Code varchar(255) not null
);

create table Account_Master (
  id bigserial primary key,
  Account_Type varchar(255) not null,
  prefix varchar(255) not null,
  Min_balance decimal(10,2) not null,
  interest decimal(10,2) not null
);

create table Customer (
  CustomerID int not null primary key,
  IFS_Code varchar(255) not null references Branch(IFS_Code),
  F_Name varchar(255) not null,
  L_Name varchar(255) not null,
  Login_ID varchar(255) not null,
  Acc_Pass varchar(255) not null,
  Trans_Pass varchar(255) not null,
  Acc_Status varchar(255) not null,
  City varchar(255) not null,
  State varchar(255) not null,
  Country varchar(255) not null,
  Acc_Open_Date date not null,
  Last_login date not null
);

create table Accounts(
  Account_No varchar(255) not null primary key,
  customer_ID int not null references Customer(CustomerID),
  acc_status varchar(255) not null,
  acc_open_date date not null,
  account_type varchar(255) not null,
  account_balance decimal not null
);

create table Employee (
  Emp_ID int not null primary key,
  Emp_Name varchar(255) not null,
  Login_ID varchar(255) not null,
  password varchar(25) not null,
  Email_ID varchar(255) not null,
  Contact_No varchar(25) not null,
  Create_Date date not null,
  Last_Login date not null
);

create table Loan (
  Loan_ID int not null primary key,
  Loan_Type varchar(25) not null,
  Loan_Amount varchar(25) not null,
  Customer_ID int not null references Customer(CustomerID),
  Interest float not null,
  Start_Date date not null
);

create table Loan_Payment (
  Payment_ID int not null primary key,
  Date date not null,
  Paid_Amount float not null,
  Principle_Amount float not null,
  Balance float not null
);

create table Loan_type (
  Loan_Type varchar(25) not null,
  prefix varchar(25) not null,
  Max_Amount float not null,
  Min_Amount float not null,
  Interest float not null,
  status varchar(25) not null
);

create table Register_Payee (
  SL_No decimal not null primary key,
  Payee_Name varchar(25) not null,
  Account_No varchar(25) not null references Accounts(Account_No),
  Account_Type varchar(25) not null,
  Bank_Name varchar(25) not null,
  IFS_Code varchar(25) not null  references Branch(IFS_Code)
);

create table Transactions (
  Transaction_ID int not null primary key,
  Payment_Date date not null,
  Payee_ID int not null references Customer(CustomerID),
  Recieve_ID int not null references Customer(CustomerID),
  Amount decimal not null,
  Payment_State text not null
);
