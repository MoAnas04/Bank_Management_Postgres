create table Branches (
  id bigserial primary key,
  ifs_code varchar(255) not null unique,
  name varchar(255) not null,
  country varchar(255) not null,
  state varchar(255) not null , -- check constraint for state and city
  city varchar(255) not null,
  address varchar(255) not null,
  postal_code int not null,
  created_at timestamp without time zone not null default now(),
  updated_at timestamp without time zone
  check(updated_at > created_at)
);

create table Customers (
  id bigserial primary key,
  branch_id bigint not null references Branches(id),
  first_name varchar(255) not null,
  last_name varchar(255) not null,
  country text not null,
  state text not null, -- check constraint for state and city
  city text not null,
  address text [] not null,
  postal_code int not null,
  created_at timestamp without time zone not null default now(),
  updated_at timestamp without time zone,
  check(updated_at > created_at)
);

create index branch_idx on Customers(branch_id);

create table Accounts(
  id bigserial primary key,
  number bigint not null unique,
  atm_pin int not null default 1234,
  customer_id bigint not null references Customers(id),
  status varchar(255) not null,
  type text not null,
  balance float not null,
  created_at timestamp without time zone not null default now(),
  updated_at timestamp without time zone,
  check(created_at < updated_at)
);

create index accounts_customer_id_index on Accounts(customer_id);

create table Loans (
  id bigserial primary key,
  customer_id bigint not null references Customers(id),
  type text not null,
  amount float not null,
  interest float not null,
  period float not null,
  balance float not null,
  created_at timestamp without time zone null default now(),
  monthly_emi float not null,
  monthly_emi_remaining int not null,
  monthly_emi_date date not null,
  updated_at timestamp without time zone,
  check (balance <= amount),
  check (updated_at > created_at)
  check (monthly_emi_remaining < period)
);

create index loans_customer_id_index on Loans(customer_id);

--check for prepaid??
create table Loan_Payments (
  id bigserial primary key,
  loan_id bigint not null references Loans(id),
  payment_id varchar(255) not null unique,
  date timestamp without time zone not null,
  amount float not null,
  prepaid boolean not null
);

create index loan_payments_loan_id_index on Loan_Payments(loan_id);

create table Transactions (
  id bigserial primary key,
  sender_id bigint not null references Accounts(id),
  receiver_id bigint not null references Accounts(id),
  amount float not null,
  status text not null,
  created_at timestamp without time zone default now() not null
);

create index transactions_sender_id_index on Transactions(sender_id);
create index transactions_receiver_id_index on Transactions(receiver_id);

create table Withdraws (
  id bigserial primary key,
  account_id bigint not null references Accounts(id),
  amount float not null,
  balance float not null,
  created_at timestamp without time zone default now() not null,
  check (amount <= balance)
);

create index withdraws_account_id_index on Withdraws(account_id);

create table Deposits (
  id bigserial primary key,
  account_id bigint not null references Accounts(id),
  amount float not null check(amount < 200000),
  balance float not null,
  created_at timestamp without time zone default now() not null
);

create index deposits_account_id_index on Deposits(account_id);
