-- Create the database
DROP DATABASE IF EXISTS `PyneeDB`;
CREATE DATABASE `PyneeDB`;

-- Use the database
USE `PyneeDB`;

-- Create the Account table
CREATE TABLE `account` (
    `account_id` INT AUTO_INCREMENT PRIMARY KEY UNIQUE,
    `role` ENUM('customer', 'admin', 'touroperator', 'employee') NOT NULL,
    `username` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NOT NULL
);

-- Create the Customer Profile table
CREATE TABLE `customer` (
    `customer_id` INT AUTO_INCREMENT PRIMARY KEY,
    `account_id` INT NOT NULL UNIQUE,
    `name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `address` VARCHAR(255),
    `phone` VARCHAR(20),
    FOREIGN KEY (`account_id`) REFERENCES `account`(`account_id`)
);
-- Create the touroperator table
CREATE TABLE `touroperator` (
    `touroperator_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT,
     `account_id` INT NOT NULL UNIQUE,
    `status` ENUM('active', 'closed') NOT NULL,
    FOREIGN KEY (`account_id`) references `account`(`account_id`)
);
-- Create the Tour and Ticket table
CREATE TABLE `tour` (
    `tour_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT,
    `touroperator_id` INT,
    `status` ENUM('available','unavailable','banned') NOT NULL,
    FOREIGN KEY (`touroperator_id`) REFERENCES `touroperator`(`touroperator_id`)
);
CREATE TABLE `tour_for_sale` (
    `tour_for_sale_id` INT AUTO_INCREMENT PRIMARY KEY,
    `tour_id` INT NOT NULL,
    `price` DECIMAL(10, 2) NOT NULL,
    `departure_date` DATE,
    `quantity` INT,
    `status` ENUM('cancelled','active'),
    FOREIGN KEY (`tour_id`) REFERENCES `tour`(`tour_id`)
);


-- Create the Complaint table
CREATE TABLE `complaint` (
    `complaint_id` INT AUTO_INCREMENT PRIMARY KEY,
    `customer_id` INT NOT NULL,
    `tour_for_sale_id` INT NOT NULL,
    `description` TEXT NOT NULL,
    `creation_date` DATETIME NOT NULL,
    `status` ENUM('resolved', 'unresolved') NOT NULL,
    
    FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`),
    FOREIGN KEY (`tour_for_sale_id`) REFERENCES `tour_for_sale`(`tour_for_sale_id`)
);

-- Create the Feeback table
CREATE TABLE `feedback` (
    `feedback_id` INT AUTO_INCREMENT PRIMARY KEY,
    `customer_id` INT NOT NULL,
    `description` TEXT NOT NULL,
    `creation_date` DATETIME NOT NULL,
    `tour_for_sale_id` INT NOT NULL,
    FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`),
	FOREIGN KEY (`tour_for_sale_id`) REFERENCES `tour_for_sale`(`tour_for_sale_id`)
);

-- Create the Employee table
CREATE TABLE `employee` (
    `employee_id` INT AUTO_INCREMENT PRIMARY KEY,
    `account_id` INT NOT NULL UNIQUE,
    `employee_name` VARCHAR(255) NOT NULL,
    `status` ENUM('active', 'suspended') NOT NULL,
    
    FOREIGN KEY (`account_id`) REFERENCES `account`(`account_id`)
);

-- Create the Customer Booking table
CREATE TABLE `booking` (
    `booking_id` INT AUTO_INCREMENT PRIMARY KEY,
    `tour_id` INT NOT NULL,
    `customer_id` INT NOT NULL,
	`booking_date` DATETIME NOT NULL,
    `status` ENUM('paid', 'unpaid','refunding','cancelled') NOT NULL,
    
    FOREIGN KEY (`tour_id`) REFERENCES `tour`(`tour_id`),
    FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`)
);

-- Insert values into the account table
INSERT INTO `account` (`role`, `username`, `password`)
VALUES
    ('customer', 'user1', 'password1'),
    ('admin', 'admin1', 'adminpass'),
    ('touroperator', 'operator1', 'operatorpass'),
    ('employee', 'employee1', 'employeepass'),
    ('customer', 'user2', 'password2'),
    ('customer', 'user3', 'password3'),
    ('touroperator', 'operator2', 'operatorpass2'),
    ('employee', 'employee2', 'employeepass2'),
    ('customer', 'user4', 'password4'),
    ('admin', 'admin2', 'adminpass2');

-- Insert values into the customer table
INSERT INTO `customer` (`account_id`, `name`, `email`, `address`, `phone`)
VALUES
    (1, 'John Doe', 'john@example.com', '123 Main St', '123-456-7890'),
    (5, 'Jane Smith', 'jane@example.com', '456 Elm St', '987-654-3210'),
    (6, 'Bob Johnson', 'bob@example.com', '789 Oak St', '555-555-5555'),
    (9, 'Alice Brown', 'alice@example.com', '101 Pine St', '111-222-3333'),
    (10, 'Eve Wilson', 'eve@example.com', '222 Cedar St', '444-444-4444');

-- Insert values into the touroperator table
INSERT INTO `touroperator` (`name`, `description`, `account_id`, `status`)
VALUES
    ('TourCo1', 'A tour operator description', 3, 'active'),
    ('TourCo2', 'Another tour operator', 7, 'active');

-- Insert values into the tour table
INSERT INTO `tour` (`name`, `description`, `touroperator_id`, `status`)
VALUES
    ('Tour 1', 'Description for Tour 1', 1, 'available'),
    ('Tour 2', 'Description for Tour 2', 1, 'available'),
    ('Tour 3', 'Description for Tour 3', 2, 'available');

-- Insert values into the tour_for_sale table
INSERT INTO `tour_for_sale` (`tour_id`, `price`, `departure_date`, `quantity`, `status`)
VALUES
    (1, 100.00, '2023-10-15', 20, 'active'),
    (2, 120.00, '2023-11-01', 15, 'active'),
    (3, 80.00, '2023-09-30', 30, 'active');

-- Insert values into the complaint table
INSERT INTO `complaint` (`customer_id`, `tour_for_sale_id`, `description`, `creation_date`, `status`)
VALUES
    (2, 1, 'Complaint about Tour 1', NOW(), 'unresolved'),
    (3, 2, 'Complaint about Tour 2', NOW(), 'unresolved');

-- Insert values into the feedback table
INSERT INTO `feedback` (`customer_id`, `description`, `creation_date`, `tour_for_sale_id`)
VALUES
    (1, 'Great tour!', NOW(), 1),
    (4, 'Enjoyed the experience.', NOW(), 3);

-- Insert values into the employee table
INSERT INTO `employee` (`account_id`, `employee_name`, `status`)
VALUES
    (4, 'Employee 1', 'active'),
    (8, 'Employee 2', 'active');

-- Insert values into the booking table
INSERT INTO `booking` (`tour_id`, `customer_id`, `booking_date`, `status`)
VALUES
    (1, 1, NOW(), 'paid'),
    (2, 2, NOW(), 'paid'),
    (3, 3, NOW(), 'paid');

