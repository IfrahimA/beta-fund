-- Drop existing tables
DROP TABLE IF EXISTS LETTER CASCADE;
DROP TABLE IF EXISTS DONOR CASCADE;
DROP TABLE IF EXISTS DONOR_CIRCLE CASCADE;
DROP TABLE IF EXISTS "class" CASCADE;
DROP TABLE IF EXISTS EMPLOYER CASCADE;
DROP TABLE IF EXISTS DONATION CASCADE;
DROP TABLE IF EXISTS PAYMENT CASCADE;
DROP TABLE IF EXISTS "event" CASCADE;

-- Create DONOR table
CREATE TABLE DONOR (
    DonorID SERIAL PRIMARY KEY,
    FirstName TEXT,
    LastName TEXT,
    PhoneNumber TEXT,
    Email TEXT,
    Category TEXT CHECK (Category IN ('Alumni', 'Parent', 'Family', 'Faculty', 'Student', 'Other'))
);

-- Create LETTER table
CREATE TABLE LETTER (
    LetterID SERIAL PRIMARY KEY,
    LetterType TEXT,
    LetterDate TEXT,
    DonorID INTEGER,
    FOREIGN KEY (DonorID) REFERENCES DONOR(DonorID)
);

-- Create DONOR_CIRCLE table
CREATE TABLE DONOR_CIRCLE (
    CircleID SERIAL PRIMARY KEY,
    CircleName TEXT,
    MinAmount NUMERIC(10, 2),
    MaxAmount NUMERIC(10, 2),
    DonorID INTEGER,
    FOREIGN KEY (DonorID) REFERENCES DONOR(DonorID)
);

-- Create "class" table
CREATE TABLE "class" (
    ClassID SERIAL PRIMARY KEY,
    ClassYear INTEGER, 
    DonorID INTEGER,
    FOREIGN KEY (DonorID) REFERENCES DONOR(DonorID)
);

-- Create "event" table
CREATE TABLE "event" (
    EventID SERIAL PRIMARY KEY,
    EventName TEXT,
    EventDate DATE,
    EventLocation TEXT,
    DonorID INTEGER,
    FOREIGN KEY (DonorID) REFERENCES DONOR(DonorID)
);

-- Create DONATION table
CREATE TABLE DONATION (
    DonationID SERIAL PRIMARY KEY,
    Amount NUMERIC(10, 2),
    "Date" DATE,  -- Date field changed to DATE type
    Pledge NUMERIC(10, 2),
    MatchingGiftEligible BOOLEAN,
    DonorID INTEGER,
    FOREIGN KEY (DonorID) REFERENCES DONOR(DonorID)
);

-- Create EMPLOYER table
CREATE TABLE EMPLOYER (
    EmployerID SERIAL PRIMARY KEY,
    EmployerName TEXT,
    DonorID INTEGER,
    FOREIGN KEY (DonorID) REFERENCES DONOR(DonorID)
);

-- Create PAYMENT table
CREATE TABLE PAYMENT (
    PaymentID SERIAL PRIMARY KEY,
    PaymentMethod TEXT CHECK (PaymentMethod IN ('Check', 'Credit Card', 'Deferred')),
    DonationID INTEGER,
    FOREIGN KEY (DonationID) REFERENCES DONATION(DonationID)
);

-- Insert data into DONOR table
INSERT INTO DONOR (FirstName, LastName, PhoneNumber, Email, Category) 
VALUES 
    ('John', 'Doe', '555-1234', 'john.doe@example.com', 'Alumni'),
    ('Jane', 'Smith', '555-5678', 'jane.smith@example.com', 'Parent'),
    ('Alice', 'Johnson', '555-8765', 'alice.johnson@example.com', 'Faculty'),
    ('Bob', 'Williams', '555-4321', 'bob.williams@example.com', 'Student'),
    ('Charlie', 'Brown', '555-6789', 'charlie.brown@example.com', 'Alumni'),
    ('Diana', 'Clark', '555-9876', 'diana.clark@example.com', 'Other');

-- Insert data into LETTER table
INSERT INTO LETTER (LetterType, LetterDate, DonorID)
VALUES 
    ('Thank You', '2024-01-15', 1),
    ('Receipt', '2024-01-16', 2),
    ('Appeal', '2024-01-17', 3),
    ('Reminder', '2024-01-18', 4),
    ('Thank You', '2024-01-19', 5),
    ('Appeal', '2024-01-20', 6);

-- Insert data into DONOR_CIRCLE table
INSERT INTO DONOR_CIRCLE (CircleName, MinAmount, MaxAmount, DonorID)
VALUES 
    ('Silver Circle', 100.00, 499.99, 1),
    ('Gold Circle', 500.00, 999.99, 2),
    ('Platinum Circle', 1000.00, 4999.99, 3),
    ('Diamond Circle', 5000.00, 9999.99, 4),
    ('Elite Circle', 10000.00, 19999.99, 5),
    ('Grand Circle', 20000.00, 50000.00, 6);

-- Insert data into "class" table
INSERT INTO "class" (ClassYear, DonorID)
VALUES 
    (2024, 1),
    (2023, 2),
    (2022, 3),
    (2021, 4),
    (2020, 5),
    (2024, 6);

-- Insert data into "event" table
INSERT INTO "event" (EventName, EventDate, EventLocation, DonorID)
VALUES 
    ('Annual Gala', '2024-05-10', 'Grand Ballroom', 1),
    ('Homecoming', '2024-09-22', 'Campus Courtyard', 2),
    ('Faculty Dinner', '2024-11-05', 'Faculty Lounge', 3),
    ('Student Orientation', '2024-08-20', 'Student Center', 4),
    ('Fundraising Banquet', '2024-10-30', 'Hilton Hotel', 5),
    ('Alumni Meet & Greet', '2024-06-15', 'Alumni Hall', 6);

-- Insert data into DONATION table
INSERT INTO DONATION (Amount, "Date", Pledge, MatchingGiftEligible, DonorID)
VALUES 
    (200.00, '2024-01-01', 50.00, TRUE, 1),
    (300.00, '2024-02-14', 100.00, FALSE, 2),
    (1500.00, '2024-03-01', 200.00, TRUE, 3),
    (50.00, '2024-04-10', 20.00, FALSE, 4),
    (5000.00, '2024-05-01', 500.00, TRUE, 5),
    (25000.00, '2024-06-10', 1000.00, TRUE, 6);

-- Insert data into EMPLOYER table
INSERT INTO EMPLOYER (EmployerName, DonorID)
VALUES 
    ('TechCorp', 1),
    ('EduFund', 2),
    ('UniCo', 3),
    ('StudentWorks', 4),
    ('GlobalTech', 5),
    ('BigBusiness', 6);

-- Insert data into PAYMENT table
INSERT INTO PAYMENT (PaymentMethod, DonationID)
VALUES 
    ('Credit Card', 1),
    ('Check', 2),
    ('Credit Card', 3),
    ('Deferred', 4),
    ('Credit Card', 5),
    ('Check', 6);