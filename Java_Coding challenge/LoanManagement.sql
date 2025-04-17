CREATE DATABASE loan;
USE loan;

CREATE TABLE Customer (
    customerId INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) NOT NULL,
    address VARCHAR(255),
    creditScore INT NOT NULL
);

CREATE TABLE Loan (
    loanId INT PRIMARY KEY,
    customerId INT NOT NULL,
    principalAmount DECIMAL(12,2) NOT NULL,
    interestRate DECIMAL(5,2) NOT NULL,
    loanTerm INT NOT NULL,
    loanType VARCHAR(50) CHECK (loanType IN ('CarLoan', 'HomeLoan')),
    loanStatus VARCHAR(50) CHECK (loanStatus IN ('Pending', 'Approved', 'Rejected')),
    FOREIGN KEY (customerId) REFERENCES Customer(customerId) ON DELETE CASCADE
);

CREATE TABLE HomeLoan (
    loanId INT PRIMARY KEY,
    propertyAddress VARCHAR(255),
    propertyValue INT,
    FOREIGN KEY (loanId) REFERENCES Loan(loanId) ON DELETE CASCADE
);

CREATE TABLE CarLoan (
    loanId INT PRIMARY KEY,
    carModel VARCHAR(100),
    carValue INT,
    FOREIGN KEY (loanId) REFERENCES Loan(loanId) ON DELETE CASCADE
);
