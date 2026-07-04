DROP DATABASE IF EXISTS nhs_db;
CREATE DATABASE nhs_db;
USE nhs_db;

CREATE TABLE Patients (
    PatientID VARCHAR(10) PRIMARY KEY,
    PatientName VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL
);

CREATE TABLE Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    DoctorName VARCHAR(100) NOT NULL,
    DoctorSpecialty VARCHAR(100) NOT NULL
);

CREATE TABLE Clinics (
    ClinicID INT AUTO_INCREMENT PRIMARY KEY,
    ClinicName VARCHAR(100) NOT NULL,
    ClinicAddress VARCHAR(255) NOT NULL
);

CREATE TABLE Medications (
    MedicationID INT AUTO_INCREMENT PRIMARY KEY,
    MedicationName VARCHAR(100) NOT NULL
);

CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID VARCHAR(10),
    DoctorID INT,
    ClinicID INT,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,
    Notes TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (ClinicID) REFERENCES Clinics(ClinicID)
);

CREATE TABLE Appointment_Medications (
    AppointmentID INT,
    MedicationID INT,
    PRIMARY KEY (AppointmentID, MedicationID),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID),
    FOREIGN KEY (MedicationID) REFERENCES Medications(MedicationID)
);

INSERT INTO Patients (PatientID, PatientName, Address) VALUES
('P001', 'John Smith', '123 Hill Rd'),
('P002', 'Mary Jones', '456 Lake Ave'),
('P003', 'David White', '789 Oak St'),
('P004', 'Emma Brown', '12 River Rd'),
('P005', 'Chris Green', '34 Pine St'),
('P006', 'Sarah Clark', '77 King St'),
('P007', 'Michael Harris', '88 Queen Rd'),
('P008', 'Laura Scott', '19 Church Lane'),
('P009', 'James Turner', '42 Station Rd'),
('P010', 'Olivia Walker', '65 Market St');

INSERT INTO Doctors (DoctorName, DoctorSpecialty) VALUES
('Dr Adams', 'Cardiology'),
('Dr Brown', 'General Practice'),
('Dr Wilson', 'Neurology'),
('Dr Taylor', 'Dermatology'),
('Dr Lee', 'Pediatrics'),
('Dr Evans', 'Orthopaedics'),
('Dr Patel', 'Oncology'),
('Dr Roberts', 'Psychiatry'),
('Dr Khan', 'ENT'),
('Dr Moore', 'Radiology');

INSERT INTO Clinics (ClinicName, ClinicAddress) VALUES
('Clinic A', '10 Main St'),
('Clinic B', '22 River Rd'),
('Clinic C', '55 Park Ave'),
('Clinic D', '18 Green St'),
('Clinic E', '90 High Road'),
('Clinic F', '7 West Lane'),
('Clinic G', '31 North Street'),
('Clinic H', '44 South Road'),
('Clinic I', '12 East Avenue'),
('Clinic J', '5 Central Square');

INSERT INTO Medications (MedicationName) VALUES
('Aspirin'),
('Beta Blocker'),
('Paracetamol'),
('Ibuprofen'),
('Amoxicillin'),
('Metformin'),
('Atorvastatin'),
('Omeprazole'),
('Salbutamol'),
('Cetirizine');

SELECT * FROM Patients;

INSERT INTO Appointments 
(PatientID, DoctorID, ClinicID, AppointmentDate, AppointmentTime, Notes)
VALUES
('P001', 1, 1, '2024-05-01', '10:00:00', 'Follow-up'),
('P002', 2, 2, '2024-05-03', '09:00:00', 'First visit'),
('P003', 3, 3, '2024-05-05', '11:30:00', 'Headache'),
('P004', 4, 1, '2024-05-07', '14:00:00', 'Skin rash'),
('P005', 5, 2, '2024-05-09', '15:15:00', 'Child checkup'),
('P006', 6, 4, '2024-05-11', '10:30:00', 'Knee pain'),
('P007', 7, 5, '2024-05-13', '13:00:00', 'Cancer screening'),
('P008', 8, 6, '2024-05-15', '09:45:00', 'Mental health consultation'),
('P009', 9, 7, '2024-05-17', '11:00:00', 'Ear pain'),
('P010', 10, 8, '2024-05-20', '16:00:00', 'X-ray appointment');

SELECT * FROM Appointments;

INSERT INTO Appointment_Medications (AppointmentID, MedicationID) VALUES
(1,1),
(1,2),
(2,3),
(3,4),
(4,5),
(5,6),
(6,7),
(7,8),
(8,9),
(9,10);

SELECT * FROM Appointment_Medications;

SELECT 
    a.AppointmentID,
    p.PatientName,
    d.DoctorName,
    c.ClinicName,
    a.AppointmentDate,
    a.AppointmentTime
FROM Appointments a
INNER JOIN Patients p ON a.PatientID = p.PatientID
INNER JOIN Doctors d ON a.DoctorID = d.DoctorID
INNER JOIN Clinics c ON a.ClinicID = c.ClinicID;

SELECT 
    c.ClinicName,
    AVG(a.AppointmentID) AS AverageAppointmentID
FROM Clinics c
LEFT JOIN Appointments a ON c.ClinicID = a.ClinicID
GROUP BY c.ClinicName;

SELECT 
    AppointmentID,
    PatientID,
    DoctorID,
    ClinicID,
    AppointmentDate,
    AppointmentTime,
    Notes
FROM Appointments
WHERE AppointmentDate >= '2024-05-03'
ORDER BY AppointmentDate ASC;

CREATE PROCEDURE GetPatientAppointments(IN patient_code VARCHAR(10))
BEGIN
    SELECT * 
    FROM Appointments
    WHERE PatientID = patient_code;
END //

DELIMITER //

CREATE PROCEDURE GetPatientAppointments(IN patient_code VARCHAR(10))
BEGIN
    SELECT * 
    FROM Appointments
    WHERE PatientID = patient_code;
END //

DELIMITER ;

CALL GetPatientAppointments('P001');

CREATE TABLE Appointment_Log (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT,
    LogMessage VARCHAR(255),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER after_appointment_insert
AFTER INSERT ON Appointments
FOR EACH ROW
INSERT INTO Appointment_Log (AppointmentID, LogMessage)
VALUES (
    NEW.AppointmentID,
    CONCAT('New appointment created for PatientID: ', NEW.PatientID)
);

INSERT INTO Appointments 
(PatientID, DoctorID, ClinicID, AppointmentDate, AppointmentTime, Notes)
VALUES
('P001', 1, 1, '2024-06-01', '12:00:00', 'Checkup');

SELECT * FROM Appointment_Log;

CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'Admin123!';
CREATE USER 'doctor_user'@'localhost' IDENTIFIED BY 'Doctor123!';
CREATE USER 'patient_user'@'localhost' IDENTIFIED BY 'Patient123!';
CREATE USER 'reception_user'@'localhost' IDENTIFIED BY 'Reception123!';


GRANT ALL PRIVILEGES ON nhs_db.* TO 'admin_user'@'localhost';

GRANT SELECT, INSERT, UPDATE ON nhs_db.Appointments TO 'doctor_user'@'localhost';

GRANT SELECT ON nhs_db.Patients TO 'patient_user'@'localhost';

GRANT SELECT, INSERT, UPDATE ON nhs_db.Appointments TO 'reception_user'@'localhost';

FLUSH PRIVILEGES;

SELECT user, host, plugin
FROM mysql.user
WHERE user IN ('admin_user','doctor_user','patient_user','reception_user');

SELECT a.AppointmentID, m.MedicationName
FROM Appointment_Medications a
LEFT JOIN Medications m
ON a.MedicationID = m.MedicationID

UNION

SELECT a.AppointmentID, m.MedicationName
FROM Appointment_Medications a
RIGHT JOIN Medications m
ON a.MedicationID = m.MedicationID;

SELECT SHA2('Patient123',256);
