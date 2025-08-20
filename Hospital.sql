-- 1. Create database
CREATE DATABASE HospitalDB;

-- 2. Use the database
USE HospitalDB;

-- 3. Create tables
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    contact VARCHAR(15)
);

CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    specialization VARCHAR(100),
    contact VARCHAR(15)
);

CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

CREATE TABLE Bills (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    amount DECIMAL(10,2),
    bill_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- 4. Alter table to add column
ALTER TABLE Patients ADD address VARCHAR(255);

-- 5. Insert records
INSERT INTO Patients (name, age, gender, contact, address) VALUES
('Ravi Kumar', 30, 'Male', '9876543210', 'Hyderabad'),
('Sneha Reddy', 25, 'Female', '9876501234', 'Vijayawada');

INSERT INTO Doctors (name, specialization, contact) VALUES
('Dr. Anil Sharma', 'Cardiologist', '9988776655'),
('Dr. Kavya Menon', 'Dermatologist', '9911223344');

INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status) VALUES
(1, 1, '2025-08-20', 'Scheduled'),
(2, 2, '2025-08-21', 'Completed');

INSERT INTO Bills (patient_id, amount, bill_date) VALUES
(1, 5000.00, '2025-08-20'),
(2, 3000.00, '2025-08-21');

-- 6. Update data
UPDATE Appointments SET status='Completed' WHERE appointment_id=1;

-- 7. Delete data
DELETE FROM Bills WHERE bill_id=2;

-- 8. WHERE condition
SELECT * FROM Patients WHERE age > 26;

-- 9. Aggregate functions
SELECT doctor_id, COUNT(*) AS total_appointments
FROM Appointments
GROUP BY doctor_id;

-- 10. GROUP BY with HAVING
SELECT doctor_id, COUNT(*) AS completed_cases
FROM Appointments
WHERE status='Completed'
GROUP BY doctor_id
HAVING COUNT(*) > 0;

-- 11. LIKE operator
SELECT * FROM Doctors WHERE name LIKE 'Dr.%';

-- 12. Subqueries
SELECT name FROM Patients
WHERE patient_id IN (SELECT patient_id FROM Bills WHERE amount > 4000);

-- 13. Stored procedure
DELIMITER //
CREATE PROCEDURE GetPatientBills(IN pid INT)
BEGIN
    SELECT * FROM Bills WHERE patient_id = pid;
END //
DELIMITER ;

-- Call the stored procedure
CALL GetPatientBills(1);

-- 14. Trigger example
DELIMITER //
CREATE TRIGGER BeforeBillInsert
BEFORE INSERT ON Bills
FOR EACH ROW
BEGIN
    IF NEW.amount < 0 THEN
        SET NEW.amount = 0;
    END IF;
END //
DELIMITER ;
