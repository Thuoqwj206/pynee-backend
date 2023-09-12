-- Create the database
DROP DATABASE IF EXISTS `PyneeDB`;
CREATE DATABASE `PyneeDB`;

-- Use the database
USE `PyneeDB`;

-- Create the Account table
CREATE TABLE `account` (
    `account_id` INT AUTO_INCREMENT PRIMARY KEY,
    `role` ENUM('customer', 'admin', 'touroperator', 'employee') NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NOT NULL
);

-- Create the Customer Profile table
CREATE TABLE `customer` (
    `customer_id` INT AUTO_INCREMENT PRIMARY KEY,
    `account_id` INT NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `address` VARCHAR(255),
    `phone` VARCHAR(20),
    FOREIGN KEY (`account_id`) REFERENCES `account`(`account_id`)
);
-- Create the touroperator table
CREATE TABLE `touroperator` (
    `touroperator_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT,
    `status` ENUM('active', 'closed') NOT NULL
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
    `account_id` INT NOT NULL,
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
-- Sample data for the 'account' table
INSERT INTO `account` (`role`, `email`, `password`) VALUES
    ('customer', 'customer1@example.com', 'password1'),
    ('customer', 'customer2@example.com', 'password2'),
    ('admin', 'admin@example.com', 'adminpassword'),
    ('touroperator', 'operator1@example.com', 'operatorpassword1'),
    ('touroperator', 'operator2@example.com', 'operatorpassword2'),
    ('employee', 'employee1@example.com', 'employeepassword1'),
    ('employee', 'employee2@example.com', 'employeepassword2'),
    ('customer', 'customer3@example.com', 'password3'),
    ('admin', 'admin2@example.com', 'adminpassword2'),
    ('touroperator', 'operator3@example.com', 'operatorpassword3');

-- Sample data for the 'customer' table
INSERT INTO `customer` (`account_id`, `name`, `address`, `phone`) VALUES
    (1, 'Customer 1', '123 Main St', '555-1234'),
    (2, 'Customer 2', '456 Oak Ave', '555-5678'),
    (8, 'Customer 3', '789 Elm Rd', '555-9876'),
    (9, 'Admin Customer', '101 Admin Ln', '555-1010');

-- Sample data for the 'touroperator' table
INSERT INTO `touroperator` (`name`, `description`, `status`) VALUES
    ('Operator 1', 'Description for Operator 1', 'active'),
    ('Operator 2', 'Description for Operator 2', 'closed'),
    ('Operator 3', 'Description for Operator 3', 'active');

-- Sample data for the 'tour' table
INSERT INTO `tour` (`name`, `description`, `touroperator_id`, `status`) VALUES
    ('Tour 1', 'Description for Tour 1', 1, 'available'),
    ('Tour 2', 'Description for Tour 2', 1, 'available'),
    ('Tour 3', 'Description for Tour 3', 2, 'unavailable');

-- Sample data for the 'tour_for_sale' table
INSERT INTO `tour_for_sale` (`tour_id`, `price`, `departure_date`, `quantity`, `status`) VALUES
    (1, 100.00, '2023-09-15', 10, 'active'),
    (2, 150.00, '2023-09-20', 5, 'active'),
    (3, 200.00, '2023-09-25', 8, 'cancelled');

-- Sample data for the 'complaint' table
INSERT INTO `complaint` (`customer_id`, `tour_for_sale_id`, `description`, `creation_date`, `status`) VALUES
    (1, 1, 'Complaint 1', NOW(), 'unresolved'),
    (2, 2, 'Complaint 2', NOW(), 'resolved'),
    (3, 3, 'Complaint 3', NOW(), 'unresolved');

-- Sample data for the 'feedback' table
INSERT INTO `feedback` (`customer_id`, `description`, `creation_date`, `tour_for_sale_id`) VALUES
    (1, 'Feedback 1', NOW(), 1),
    (2, 'Feedback 2', NOW(), 2),
    (3, 'Feedback 3', NOW(), 3);

-- Sample data for the 'employee' table
INSERT INTO `employee` (`account_id`, `employee_name`, `status`) VALUES
    (6, 'Employee 1', 'active'),
    (7, 'Employee 2', 'suspended');

-- Sample data for the 'booking' table
INSERT INTO `booking` (`tour_id`, `customer_id`, `booking_date`, `status`) VALUES
    (1, 1, NOW(), 'paid'),
    (2, 2, NOW(), 'paid'),
    (3, 3, NOW(), 'unpaid');
