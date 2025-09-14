-- create a new database 
CREATE DATABASE hospital_db;

USE hospital_db;

-- create a patients table
CREATE TABLE patients (Patient_id INT PRIMARY KEY, name VARCHAR(100), gender VARCHAR(10), dob date, phone VARCHAR(15), address TEXT);

-- Insert the recorde
INSERT INTO patients VALUES
(1, 'Amit Sharma', 'Male', '1990-01-01', '9876543210', 'Delhi'),
(2, 'Reena Das', 'Female', '1985-05-12', '9876543211', 'Mumbai'),
(3, 'John Paul', 'Male', '2000-07-15', '9876543212', 'Kolkata'),
(4, 'Sneha Jain', 'Female', '1995-03-10', '9876543213', 'Chennai'),
(5, 'Vikram Singh', 'Male', '1992-12-01', '9876543214', 'Delhi'),
(6, 'Fatima Khan', 'Female', '1988-09-18', '9876543215', 'Bhopal'),
(7, 'Rajeev Reddy', 'Male', '1993-04-22', '9876543216', 'Hyderabad'),
(8, 'Priya Nair', 'Female', '1999-11-11', '9876543217', 'Kochi'),
(9, 'Ankit Verma', 'Male', '2001-06-30', '9876543218', 'Jaipur'),
(10, 'Divya Joshi', 'Female', '1996-08-14', '9876543219', 'Ahmedabad');


-- create a doctors table
CREATE TABLE Doctors (doctor_id INT PRIMARY KEY, name VARCHAR(100), specialization VARCHAR(50), department_id INT);

-- Insert the recorde
INSERT INTO Doctors VALUES
(1, 'Dr. Mehta', 'Cardiologist', 1),
(2, 'Dr. Das', 'Neurologist', 2),
(3, 'Dr. Rao', 'Orthopedic', 3),
(4, 'Dr. Kapoor', 'Pediatrician', 4),
(5, 'Dr. Verma', 'Surgeon', 1),
(6, 'Dr. Sen', 'Dermatologist', 5),
(7, 'Dr. Menon', 'ENT Specialist', 6),
(8, 'Dr. Sharma', 'General Physician', 7),
(9, 'Dr. Aggarwal', 'Psychiatrist', 8),
(10, 'Dr. Khan', 'Gastroenterologist', 9);

-- create a departments table
CREATE TABLE Departments(department_id INT PRIMARY KEY, department_name VARCHAR(50));

-- Insert the recorde
INSERT INTO Departments VALUES
(1, 'Cardiology'),
(2, 'Neurology'),
(3, 'Orthopedics'),
(4, 'Pediatrics'),
(5, 'Dermatology'),
(6, 'ENT'),
(7, 'General Medicine'),
(8, 'Psychiatry'),
(9, 'Gastroenterology'),
(10, 'Surgery');


-- create a Appointments table
CREATE TABLE Appointments (appintment_id INT PRIMARY KEY, patient_id INT, doctor_id INT, appintment_date DATE, appointment_time TIME, reason TEXT);

-- Insert the recorde
INSERT INTO Appointments VALUES
(1, 1, 1, '2024-03-15', '10:00:00', 'Heart pain'),
(2, 2, 2, '2024-04-01', '11:30:00', 'Migraine'),
(3, 3, 3, '2024-05-10', '12:00:00', 'Knee pain'),
(4, 4, 4, '2024-06-05', '14:00:00', 'Fever'),
(5, 5, 5, '2024-07-07', '09:00:00', 'Surgery consultation'),
(6, 6, 1, '2024-08-10', '10:30:00', 'Chest pain'),
(7, 7, 6, '2024-06-25', '15:30:00', 'Skin rash'),
(8, 8, 7, '2024-08-12', '16:00:00', 'Ear pain'),
(9, 9, 8, '2024-08-20', '13:30:00', 'Cough'),
(10, 10, 9, '2024-09-01', '10:00:00', 'Anxiety');


-- create a Admisssions table
CREATE TABLE Admissions(admission_id INT PRIMARY KEY, patient_id INT, room_id INT, doctor_id INT, admission_date DATE, ddischarge_date date); 

-- Insert the recorde
INSERT INTO Admissions VALUES
(1, 1, 101, 1, '2024-03-01', '2024-03-11'),
(2, 2, 102, 2, '2024-04-05', '2024-04-15'),
(3, 3, 103, 3, '2024-05-12', NULL),
(4, 4, 104, 4, '2024-06-01', '2024-06-05'),
(5, 5, 105, 5, '2024-06-15', '2024-06-25'),
(6, 6, 106, 1, '2024-07-01', '2024-07-10'),
(7, 7, 107, 6, '2024-07-20', '2024-07-30'),
(8, 8, 108, 7, '2024-08-05', NULL),
(9, 9, 109, 8, '2024-08-15', '2024-08-22'),
(10, 10, 110, 9, '2024-09-01', NULL);


-- Create a Rooms table
CREATE TABLE Rooms(room_id INT PRIMARY KEY, room_type VARCHAR(20), is_occupied BOOLEAN);

-- Insert the recorde
INSERT INTO Rooms VALUES
(101, 'General', TRUE),
(102, 'Private', TRUE),
(103, 'ICU', TRUE),
(104, 'General', FALSE),
(105, 'Private', FALSE),
(106, 'ICU', FALSE),
(107, 'Semi-Private', FALSE),
(108, 'Private', TRUE),
(109, 'General', FALSE),
(110, 'ICU', TRUE);


-- Create a Medical_History table
CREATE TABLE Medical_History(history_id INT PRIMARY KEY, patient_id INT, illness VARCHAR(100), diagnosis_date DATE, treatment TEXT);

-- Insert the recorde
INSERT INTO Medical_History VALUES
(1, 1, 'Hypertension', '2023-11-01', 'Medication & diet control'),
(2, 2, 'Migraine', '2023-12-15', 'Pain relief & monitoring'),
(3, 3, 'Arthritis', '2024-01-10', 'Physiotherapy & painkillers'),
(4, 4, 'Flu', '2024-02-05', 'Rest & hydration'),
(5, 5, 'Appendicitis', '2024-03-12', 'Surgery'),
(6, 6, 'Angina', '2024-04-01', 'Cardiac medication'),
(7, 7, 'Eczema', '2024-05-20', 'Topical cream'),
(8, 8, 'Ear Infection', '2024-06-10', 'Antibiotics'),
(9, 9, 'Bronchitis', '2024-07-01', 'Cough syrup & antibiotics'),
(10, 10, 'Depression', '2024-08-05', 'Therapy & medication');

-- Create a Prescriptions  table
CREATE TABLE Prescriptions (Prescription_id INT PRIMARY KEY, patient_id INT, doctor_id INT, medication VARCHAR(100), dosage VARCHAR(50), prescribed_date DATE);

-- Insert the recorde
INSERT INTO Prescriptions VALUES
(1, 1, 1, 'Amlodipine', '5mg daily', '2024-03-01'),
(2, 2, 2, 'Sumatriptan', '50mg as needed', '2024-04-01'),
(3, 3, 3, 'Ibuprofen', '400mg twice daily', '2024-05-10'),
(4, 4, 4, 'Paracetamol', '500mg every 6 hrs', '2024-06-05'),
(5, 5, 5, 'Amoxicillin', '500mg thrice daily', '2024-07-07'),
(6, 6, 1, 'Nitroglycerin', '0.4mg under tongue', '2024-07-10'),
(7, 7, 6, 'Hydrocortisone', 'Apply twice daily', '2024-07-20'),
(8, 8, 7, 'Ciprofloxacin', '250mg twice daily', '2024-08-12'),
(9, 9, 8, 'Cough Syrup', '10ml thrice daily', '2024-08-20'),
(10, 10, 9, 'Sertraline', '50mg daily', '2024-09-01');

-- create a Staff table
CREATE TABLE Staff (staff_id INT PRIMARY KEY, name VARCHAR(100), department_id INT, role VARCHAR(50), shift_start TIME, shift_end TIME);

-- Insert the recorde
INSERT INTO Staff VALUES
(1, 'Ramesh Kumar', 1, 'Nurse', '08:00:00', '16:00:00'),
(2, 'Sonal Verma', 2, 'Lab Technician', '09:00:00', '17:00:00'),
(3, 'Ajay Singh', 3, 'Receptionist', '10:00:00', '18:00:00'),
(4, 'Neha Gupta', 1, 'Assistant Nurse', '07:00:00', '15:00:00'),
(5, 'Vikram Shah', 4, 'Pharmacist', '11:00:00', '19:00:00'),
(6, 'Pooja Reddy', 5, 'Nurse', '08:00:00', '16:00:00'),
(7, 'Anil Mehta', 6, 'Lab Technician', '09:00:00', '17:00:00'),
(8, 'Kiran Joshi', 7, 'Accountant', '10:00:00', '18:00:00'),
(9, 'Sneha Nair', 1, 'Head Nurse', '08:00:00', '16:00:00'),
(10, 'Rohit Das', 8, 'Counselor', '12:00:00', '20:00:00');


-- create a Billing table
CREATE TABLE Billing (bill_id INT PRIMARY KEY, patient_id INT, admission_id INT, consultation_fee DECIMAL(10, 2), treatment_cost DECIMAL(10, 2), room_charges DECIMAL(10, 2), total_amount DECIMAL(10, 2), billing_date DATE, paid BOOLEAN);

-- Insert the recorde
INSERT INTO Billing VALUES
(1, 1, 1, 500.00, 20000.00, 3000.00, 23500.00, '2024-03-11', TRUE),
(2, 2, 2, 400.00, 15000.00, 2500.00, 17900.00, '2024-04-15', TRUE),
(3, 3, 3, 600.00, 10000.00, 0.00, 10600.00, '2024-05-22', FALSE),
(4, 4, 4, 300.00, 5000.00, 1000.00, 6300.00, '2024-06-05', TRUE),
(5, 5, 5, 700.00, 25000.00, 3500.00, 29200.00, '2024-06-25', FALSE),
(6, 6, 6, 450.00, 8000.00, 2000.00, 10450.00, '2024-07-10', TRUE),
(7, 7, 7, 350.00, 6000.00, 1500.00, 7850.00, '2024-07-30', TRUE),
(8, 8, 8, 500.00, 12000.00, 0.00, 12500.00, '2024-08-10', FALSE),
(9, 9, 9, 400.00, 3000.00, 0.00, 3400.00, '2024-08-22', TRUE),
(10, 10, 10, 600.00, 7000.00, 2500.00, 10100.00, '2024-09-01', FALSE);

-- create a vital_signs
create table vital_signs (vital_id INT PRIMARY KEY,
patient_id INT,
admission_id INT,
heart_rate INT,
blood_pressure VARCHAR(10),
temperature DECIMAL(4,1),
oxygen_level INT);

-- Insert the records 
INSERT INTO vital_signs 
(vital_id, patient_id, admission_id, heart_rate, blood_pressure, temperature, oxygen_level)
VALUES
(1, 101, 201, 78, '120/80', 36.8, 98),
(2, 102, 202, 85, '118/76', 37.0, 97),
(3, 103, 203, 130, '140/95', 38.5, 95),   -- High HR
(4, 104, 204, 60, '88/55', 36.9, 94),    -- Low BP
(5, 105, 205, 48, '100/65', 36.2, 96),   -- Low HR
(6, 106, 206, 92, '160/110', 37.5, 93),  -- High BP
(7, 107, 207, 75, '122/78', 39.5, 98),   -- High temp
(8, 108, 208, 82, '118/75', 34.5, 97),   -- Low temp
(9, 109, 209, 95, '130/85', 37.2, 89),   -- Low O2
(10, 110, 210, 72, '115/70', 36.7, 99);

create table pharmacy_inventory(
medicine_id INT PRIMARY KEY,
medicine_name VARCHAR(100),
available_quantity INT);

INSERT INTO pharmacy_inventory 
(medicine_id, medicine_name, available_quantity)
VALUES
(1, 'Paracetamol 500mg', 200),
(2, 'Amoxicillin 250mg', 120),
(3, 'Ibuprofen 400mg', 150),
(4, 'Metformin 500mg', 90),
(5, 'Atorvastatin 10mg', 75),
(6, 'Omeprazole 20mg', 60),
(7, 'Losartan 50mg', 100),
(8, 'Azithromycin 500mg', 50),
(9, 'Cetirizine 10mg', 180),
(10, 'Insulin 10ml', 40);

-- drop and add prescriptions with needed columns 
 
 
create table prescriptions(
prescription_id INT PRIMARY KEY,
patient_id INT,
doctor_id INT,
medication VARCHAR(100),
dosage VARCHAR(50),
quantity INT,
date_issued date);

INSERT INTO prescriptions
(prescription_id, patient_id, doctor_id, medication, dosage, quantity, date_issued)
VALUES
(1, 1, 1, 'Paracetamol 500mg', '1 tablet twice daily', 10, '2025-09-01'),
(2, 2, 2, 'Amoxicillin 250mg', '1 capsule thrice daily', 15, '2025-09-01'),
(3, 3, 3, 'Ibuprofen 400mg', '1 tablet after meals', 12, '2025-09-02'),
(4, 4, 4, 'Metformin 500mg', '1 tablet twice daily', 20, '2025-09-02'),
(5, 5, 5, 'Atorvastatin 10mg', '1 tablet at night', 30, '2025-09-03'),
(6, 6, 1, 'Omeprazole 20mg', '1 capsule before breakfast', 10, '2025-09-03'),
(7, 7, 6, 'Losartan 50mg', '1 tablet daily', 25, '2025-09-03'),
(8, 8, 7, 'Azithromycin 500mg', '1 tablet daily for 3 days', 3, '2025-09-03'),
(9, 9, 8, 'Cetirizine 10mg', '1 tablet at night', 7, '2025-09-03'),
(10, 10, 9, 'Insulin 10ml', '10 units before meals', 5, '2025-09-03');

-- drop and add appointment table wth added columns

CREATE TABLE Appointments( 
appintment_id INT PRIMARY KEY, patient_id INT, doctor_id INT, appintment_date DATE, appointment_time TIME, reason TEXT, `status` text);

-- Insert the recorde
INSERT INTO Appointments VALUES
(1, 1, 1, '2024-03-15', '10:00:00', 'Heart pain', 'Completed'),
(2, 2, 2, '2024-04-01', '11:30:00', 'Migraine', 'Missed'),
(3, 3, 3, '2024-05-10', '12:00:00', 'Knee pain', 'Scheduled'),
(4, 4, 4, '2024-06-05', '14:00:00', 'Fever', 'Completed'),
(5, 5, 5, '2024-07-07', '09:00:00', 'Surgery consultation', 'Cancelled'),
(6, 6, 1, '2024-08-10', '10:30:00', 'Chest pain', 'Scheduled'),
(7, 7, 6, '2024-06-25', '15:30:00', 'Skin rash', 'Completed'),
(8, 8, 7, '2024-08-12', '16:00:00', 'Ear pain', 'Missed'),
(9, 9, 8, '2024-08-20', '13:30:00', 'Cough', 'Scheduled'),
(10, 10, 9, '2024-09-01', '10:00:00', 'Anxiety', 'Scheduled');

-- create table appointment alert 
CREATE TABLE appointment_alerts (
    alert_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT,
    patient_id INT,
    doctor_id INT,
    alert_message VARCHAR(255),
    alert_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

create table medical_inventory (
supply_id INT PRIMARY KEY,
supply_name VARCHAR(100),
available_quantity INT,
unit VARCHAR(20),
expiry_date date);

INSERT INTO medical_inventory (supply_id, supply_name, available_quantity, unit, expiry_date)
VALUES
(1, 'Syringes', 500, 'pcs', '2027-01-01'),
(2, 'Gloves', 1000, 'pairs', '2026-05-15'),
(3, 'Face Masks', 800, 'pcs', '2026-08-01'),
(4, 'IV Fluids', 200, 'bottles', '2025-12-30'),
(5, 'Bandages', 600, 'rolls', '2026-03-20'),
(6, 'Antibiotic Ointment', 150, 'tubes', '2026-11-10'),
(7, 'Surgical Blades', 300, 'pcs', '2027-04-15'),
(8, 'Hand Sanitizer', 400, 'bottles', '2026-09-05'),
(9, 'Cotton Balls', 1200, 'pcs', '2027-02-12'),
(10, 'Thermometers', 100, 'pcs', '2028-01-01');

create table inventory_transaction (
transaction_id INT PRIMARY KEY AUTO_INCREMENT,
supply_id INT,
transaction_type ENUM('Received', 'Used'),
quantity INT,
transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (supply_id) REFERENCES medical_inventory(supply_id)
);

INSERT INTO inventory_transaction
(transaction_id, supply_id, transaction_type, quantity, transaction_date)
VALUES
(1, 1, 'Received', 200, '2025-09-01 09:30:00'),   -- Syringes
(2, 2, 'Used', 150, '2025-09-01 10:15:00'),       -- Gloves
(3, 3, 'Used', 50, '2025-09-02 11:00:00'),        -- Face Masks
(4, 4, 'Received', 100, '2025-09-02 14:45:00'),   -- IV Fluids
(5, 5, 'Used', 75, '2025-09-03 09:20:00'),        -- Bandages
(6, 6, 'Received', 50, '2025-09-03 10:05:00'),    -- Antibiotic Ointment
(7, 7, 'Used', 30, '2025-09-04 12:10:00'),        -- Surgical Blades
(8, 8, 'Received', 80, '2025-09-04 13:00:00'),    -- Hand Sanitizer
(9, 9, 'Used', 200, '2025-09-05 15:30:00'),       -- Cotton Balls
(10, 10, 'Used', 10, '2025-09-05 16:15:00');     -- thermometers

alter table admissions rename column ddischarge_date to discharge_date;