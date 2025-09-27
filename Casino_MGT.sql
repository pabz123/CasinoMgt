create database if not exists Casino_MGT;

#core entities of the casino

use Casino_MGT;

create table customers(
customer_id int primary key not null auto_increment,
first_name varchar(15) ,
last_name varchar(16) ,
dob date,
gender enum('male','female','other'),
national_id_passport varchar(24),
phone varchar(12),
email varchar(22),
address varchar(33),
loyalty_id varchar(15) not null,
constraint fk_loyalty_id  foreign key(loyalty_id) references Loyalty_Programs(loyalty_id) );

create table employee(
employee_id int primary key not null auto_increment,
first_name varchar(15) not null,
last_name varchar(16) not null,
role_id int not null,
shift_id int not null,
salary decimal(10,2),
hire_date datetime,
phone varchar(12),
email  varchar(22),

constraint fk_role_id   foreign key(role_id) references Roles(role_id),
constraint fk_shift_id  foreign key(shift_id) references shifts(shift_id));

create table Roles(
role_id int primary key not null,
role_name varchar(22),
description varchar(55));

create table shifts(
shift_id int primary key not null ,
shift_name varchar(22),
start_time datetime,
end_time datetime);

#gaming operations

create table games(
game_id int primary key not null auto_increment,
game_name varchar(22),
category enum('Table','Slot','Electronic'),
min_bet decimal(10,2),
max_bet decimal(10,2),
location varchar(22));

create table tables(
table_id int primary key not null auto_increment,
game_id int not null,
table_number int not null,
seating_capacity int ,
dealer_id int not null,
constraint fk_game_id foreign key(game_id) references games(game_id),
constraint fk_dealer_id foreign key(dealer_id) references employee(employee_id));



create table Slot_Machines(
slot_id int primary key not null auto_increment,
game_id int not null,
machine_number int,
location varchar(22),
status  enum('Active','Maintenance','Out of order'),
constraint fk_game_id foreign key(game_id) references games(game_id));

create table Bets(
bet_id int primary key not null auto_increment,
customer_id int not null,
game_id int not null,
table_id int,
slot_id int,
amount decimal(10,2),
bet_time datetime default now(),
outcome enum('Win', 'Lose','Draw') not null,
payout_amount decimal(10,2) not null,
constraint fk_customer_id foreign key(customer_id) references customers(customer_id),
constraint fk_game_id foreign key(game_id) references games(game_id),
constraint fk_table_id foreign key(table_id) references tables(table_id),
constraint fk_slot_id foreign key(slot_id) references Slot_Machines(slot_id));


#Financial Management

create table Transactions(
transaction_id int primary key not null auto_increment,
customer_id int,
employee_id int,
amount decimal(10,2), 
transaction_type enum('Deposit','Withdrawal','Bet','Payout','Purchase'),
payment_method enum('Cash','Card','Mobile Money','Chips'),
transaction_time datetime default now(),
constraint fk_customer_id foreign key(customer_id) references customers(customer_id),
constraint fk_employee_id foreign key(employee_id) references employee(employee_id));

create table Chips(
chip_id int primary key not null auto_increment,
denomination varchar(12),
color varchar(12),
in_circulation int );

create table Cashier_Desks(
desk_id int primary key not null auto_increment,
location varchar(12),
employee_id int,
constraint fk_employee_id foreign key(employee_id) references employee(employee_id));

create table Cashier_Transactions(
cashier_txn_id int primary key not null auto_increment,
transaction_id int,
desk_id int,
constraint fk_transaction_id foreign key(transaction_id) references Transactions(transaction_id),
constraint fk_desk_id foreign key(desk_id) references Cashier_Desks(desk_id));

#customer loyalty services

create table Loyalty_Programs(
loyalty_id int primary key not null auto_increment,
tier_name enum('Bronze','Silver','Gold','Platinum'),
points_required int,
discounts decimal(10,2));

create table Loyalty_Points(
loyalty_point_id int primary key not null auto_increment,
customer_id int,
points_balance int,
last_update datetime default now(),
constraint fk_customer_id foreign key(customer_id) references customers(customer_id));

create table Rewards(
reward_id int primary key not null auto_increment,
reward_name varchar(22),
description varchar(55),
points_required int);

create table Customer_Rewards(
customer_reward_id int primary key not null auto_increment,
customer_id int,
reward_id int,
redeem_date datetime default now(),
constraint fk_customer_id foreign key(customer_id) references customers(customer_id),
constraint fk_reward_id foreign key(reward_id) references Rewards(reward_id));

#Hospitality & Inventory

create table Restuarants(
restuarant_id int primary key not null auto_increment,
name varchar(22),
location varchar(12),
capacity int);

create table Orders(
order_id int primary key not null auto_increment,
customer_id int,
restuarant_id int,
employee_id int,
order_time datetime default now(),
total_amount decimal(10,2),
constraint fk_customer_id foreign key(customer_id) references customers(customer_id),
constraint fk_restuarant_id foreign key(restuarant_id) references Restuarants(restuarant_id),
constraint fk_employee_id foreign key(employee_id) references employee(employee_id));

create table Order_Items(
order_item_id int primary key not null auto_increment,
order_id int,
menu_item_id int,
quantity int,
price decimal(10,2), 
constraint fk_order_id foreign key(order_id) references Orders(order_id),
constraint fk_menu_item_id foreign key(menu_item_id) references Menu_Items(menu_item_id));

create table Menu_Items(
menu_item_id int primary key not null auto_increment,
restuarant_id int,
item_name varchar(22),
price decimal(10,2),
category enum('Drink','Food','Snack'),
constraint fk_restuarant_id foreign key(restuarant_id) references Restuarants(restuarant_id));

#Security & Compliance

create table Surveillance(
camera_id int primary key not null auto_increment,
location varchar(15),
 status ENUM('Active','Inactive','Maintenance') DEFAULT 'Active');

create table Security_Logs(
log_id int primary key not null auto_increment,
employee_id int,
event_type enum('Suspicious activity','Theft','Dispute'),
event_time datetime default now(),
Description text,
constraint fk_employee_id foreign key(employee_id) references employee(employee_id));
 
 create table Access_Logs(
 access_id int primary key not null auto_increment,
 employee_id int,
 entry_time datetime default now(),
 area_accessed varchar(15),
 constraint fk_employee_id foreign key(employee_id) references employee(employee_id));
 
 
 INSERT IGNORE INTO games(game_name, category) VALUES
('Table','Games played at tables (Blackjack, Poker, Roulette)'),
('Slot','Slot machine games'),
('Electronic','Electronic / Video games');

INSERT IGNORE INTO Transactions  (payment_method) VALUES ('Cash'),('Card'),('MobileMoney'),('Chips');

INSERT IGNORE INTO roles (role_name, description) VALUES
('Dealer','Table dealer'),
('Pit Boss','Pit supervisor'),
('Cashier','Handles cash transactions'),
('Security','Security staff'),
('Manager','Managerial staff'),
('Waiter','Restaurant server'),
('Maintenance','Maintenance staff'),
('Admin','System administrator');

INSERT IGNORE INTO shifts (shift_name, start_time, end_time) VALUES
('Morning','08:00:00','16:00:00'),
('Evening','16:00:00','00:00:00'),
('Night','00:00:00','08:00:00');
 
















































