SQL Queries to Create Tables for Hospital

1. Patient Table
CREATE TABLE Patient (
    Patient_ID INT PRIMARY KEY AUTO_INCREMENT,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Gender VARCHAR(10),
    DOB DATE,
    Contact_Number VARCHAR(15),
    Address VARCHAR(150),
    Email VARCHAR(100),
    Blood_Group VARCHAR(5),
    Registration_Date DATE
);

2️. Doctor Table
CREATE TABLE Doctor (
    Doctor_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Specialization VARCHAR(100),
    Contact_Number VARCHAR(15),
    Email VARCHAR(100),
    Consultation_Fee DECIMAL(10,2),
    Availability_Status VARCHAR(20)
);

3️. Department Table
CREATE TABLE Department (
    Department_ID INT PRIMARY KEY AUTO_INCREMENT,
    Department_Name VARCHAR(100),
    Location VARCHAR(100),
    Head_Doctor_ID INT,
    FOREIGN KEY (Head_Doctor_ID) REFERENCES Doctor(Doctor_ID)
);

4️. Receptionist Table
CREATE TABLE Receptionist (
    Receptionist_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Username VARCHAR(50) UNIQUE,
    Password VARCHAR(100),
    Contact_Number VARCHAR(15),
    Shift_Timing VARCHAR(50),
    Email VARCHAR(100)
);

5️. Appointment Table
CREATE TABLE Appointment (
    Appointment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Patient_ID INT,
    Doctor_ID INT,
    Receptionist_ID INT,
    Appointment_Date DATE,
    Appointment_Time TIME,
    Status VARCHAR(20),
    Remarks VARCHAR(200),
    
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID),
    FOREIGN KEY (Receptionist_ID) REFERENCES Receptionist(Receptionist_ID)
);

6️. Payment Table
CREATE TABLE Payment (
    Payment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Appointment_ID INT,
    Patient_ID INT,
    Amount DECIMAL(10,2),
    Payment_Date DATE,
    Payment_Mode VARCHAR(20),
    Payment_Status VARCHAR(20),
    
    FOREIGN KEY (Appointment_ID) REFERENCES Appointment(Appointment_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
);

7️. Room Table
CREATE TABLE Room (
    Room_ID INT PRIMARY KEY AUTO_INCREMENT,
    Room_Number VARCHAR(10),
    Room_Type VARCHAR(20),
    Status VARCHAR(20),
    Charges_Per_Day DECIMAL(10,2)
);

8️. Admission Table
CREATE TABLE Admission (
    Admission_ID INT PRIMARY KEY AUTO_INCREMENT,
    Patient_ID INT,
    Room_ID INT,
    Admission_Date DATE,
    Discharge_Date DATE,
    Doctor_ID INT,
    Total_Bill DECIMAL(10,2),
    
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Room_ID) REFERENCES Room(Room_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID)
);
