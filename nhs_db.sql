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
    AppointmentID INT NOT NULL,
    MedicationID INT NOT NULL,
    PRIMARY KEY (AppointmentID, MedicationID),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID),
    FOREIGN KEY (MedicationID) REFERENCES Medications(MedicationID)
);

CREATE TABLE Appointment_Log (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT,
    LogMessage VARCHAR(255),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO Patients VALUES
('P001','John Smith','123 Hill Rd'),
('P002','Mary Jones','456 Lake Ave'),
('P003','David White','789 Oak St'),
('P004','Emma Brown','12 River Rd'),
('P005','Chris Green','34 Pine St'),
('P006','Sarah Clark','77 King St'),
('P007','Michael Harris','88 Queen Rd'),
('P008','Laura Scott','19 Church Lane'),
('P009','James Turner','42 Station Rd'),
('P010','Olivia Walker','65 Market St');

INSERT INTO Doctors (DoctorName, DoctorSpecialty) VALUES
('Dr Adams','Cardiology'),
('Dr Brown','General Practice'),
('Dr Wilson','Neurology'),
('Dr Taylor','Dermatology'),
('Dr Lee','Pediatrics'),
('Dr Evans','Orthopaedics'),
('Dr Patel','Oncology'),
('Dr Roberts','Psychiatry'),
('Dr Khan','ENT'),
('Dr Moore','Radiology');

INSERT INTO Clinics (ClinicName, ClinicAddress) VALUES
('Clinic A','10 Main St'),
('Clinic B','22 River Rd'),
('Clinic C','55 Park Ave'),
('Clinic D','18 Green St'),
('Clinic E','90 High Road'),
('Clinic F','7 West Lane'),
('Clinic G','31 North Street'),
('Clinic H','44 South Road'),
('Clinic I','12 East Avenue'),
('Clinic J','5 Central Square');

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

INSERT INTO Appointments (PatientID, DoctorID, ClinicID, AppointmentDate, AppointmentTime, Notes) VALUES
('P001',1,1,'2024-05-01','10:00:00','Follow-up'),
('P002',2,2,'2024-05-03','09:00:00','First visit'),
('P003',3,3,'2024-05-05','11:30:00','Headache'),
('P004',4,1,'2024-05-07','14:00:00','Skin rash'),
('P005',5,2,'2024-05-09','15:15:00','Child checkup'),
('P006',6,4,'2024-05-11','10:30:00','Knee pain'),
('P007',7,5,'2024-05-13','13:00:00','Cancer screening'),
('P008',8,6,'2024-05-15','09:45:00','Mental health consultation'),
('P009',9,7,'2024-05-17','11:00:00','Ear pain'),
('P010',10,8,'2024-05-20','16:00:00','X-ray appointment');

INSERT INTO Appointment_Medications VALUES
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

UPDATE Patients
SET Address = '65 Market Street'
WHERE PatientID = 'P010';

DELETE FROM Appointment_Medications
WHERE AppointmentID = 9 AND MedicationID = 10;

INSERT INTO Appointment_Medications VALUES
(9,10);

SELECT 
    p.PatientID,
    p.PatientName,
    COUNT(a.AppointmentID) AS TotalAppointments
FROM Patients p
LEFT JOIN Appointments a ON p.PatientID = a.PatientID
GROUP BY p.PatientID, p.PatientName;

SELECT 
    a.AppointmentID,
    p.PatientName,
    d.DoctorName,
    c.ClinicName,
    a.AppointmentDate,
    a.AppointmentTime,
    a.Notes
FROM Appointments a
INNER JOIN Patients p ON a.PatientID = p.PatientID
INNER JOIN Doctors d ON a.DoctorID = d.DoctorID
INNER JOIN Clinics c ON a.ClinicID = c.ClinicID;

SELECT 
    a.AppointmentID,
    m.MedicationName
FROM Appointment_Medications am
RIGHT JOIN Medications m ON am.MedicationID = m.MedicationID
LEFT JOIN Appointments a ON am.AppointmentID = a.AppointmentID;

SELECT 
    a.AppointmentID,
    m.MedicationName
FROM Appointments a
LEFT JOIN Appointment_Medications am ON a.AppointmentID = am.AppointmentID
LEFT JOIN Medications m ON am.MedicationID = m.MedicationID
UNION
SELECT 
    a.AppointmentID,
    m.MedicationName
FROM Appointments a
RIGHT JOIN Appointment_Medications am ON a.AppointmentID = am.AppointmentID
RIGHT JOIN Medications m ON am.MedicationID = m.MedicationID;

SELECT 
    c.ClinicName,
    AVG(a.AppointmentID) AS AverageAppointmentID
FROM Clinics c
LEFT JOIN Appointments a ON c.ClinicID = a.ClinicID
GROUP BY c.ClinicName;

SELECT 
    AppointmentID,
    PatientID,
    AppointmentDate,
    AppointmentTime,
    Notes
FROM Appointments
WHERE AppointmentDate > '2024-05-05'
ORDER BY AppointmentDate ASC;

DELIMITER //

CREATE PROCEDURE GetPatientAppointments(IN selectedPatientID VARCHAR(10))
BEGIN
    SELECT 
        a.AppointmentID,
        p.PatientName,
        d.DoctorName,
        c.ClinicName,
        a.AppointmentDate,
        a.AppointmentTime,
        a.Notes
    FROM Appointments a
    INNER JOIN Patients p ON a.PatientID = p.PatientID
    INNER JOIN Doctors d ON a.DoctorID = d.DoctorID
    INNER JOIN Clinics c ON a.ClinicID = c.ClinicID
    WHERE a.PatientID = selectedPatientID;
END //

CREATE TRIGGER after_appointment_insert
AFTER INSERT ON Appointments
FOR EACH ROW
BEGIN
    INSERT INTO Appointment_Log (AppointmentID, LogMessage)
    VALUES (
        NEW.AppointmentID,
        CONCAT('New appointment created for PatientID: ', NEW.PatientID)
    );
END //

DELIMITER ;

CALL GetPatientAppointments('P001');

INSERT INTO Appointments (PatientID, DoctorID, ClinicID, AppointmentDate, AppointmentTime, Notes)
VALUES ('P001',1,1,'2024-06-01','12:00:00','Checkup');

SELECT * FROM Appointment_Log;

DROP USER IF EXISTS 'admin_user'@'localhost';
DROP USER IF EXISTS 'doctor_user'@'localhost';
DROP USER IF EXISTS 'patient_user'@'localhost';
DROP USER IF EXISTS 'receptionist_user'@'localhost';

CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'AdminPass123!';
CREATE USER 'doctor_user'@'localhost' IDENTIFIED BY 'DoctorPass123!';
CREATE USER 'patient_user'@'localhost' IDENTIFIED BY 'PatientPass123!';
CREATE USER 'receptionist_user'@'localhost' IDENTIFIED BY 'ReceptionPass123!';

GRANT ALL PRIVILEGES ON nhs_db.* TO 'admin_user'@'localhost';

GRANT SELECT, UPDATE ON nhs_db.Appointments TO 'doctor_user'@'localhost';
GRANT SELECT ON nhs_db.Patients TO 'doctor_user'@'localhost';
GRANT SELECT ON nhs_db.Medications TO 'doctor_user'@'localhost';

GRANT SELECT ON nhs_db.Appointments TO 'patient_user'@'localhost';
GRANT SELECT ON nhs_db.Patients TO 'patient_user'@'localhost';

GRANT SELECT, INSERT, UPDATE ON nhs_db.Appointments TO 'receptionist_user'@'localhost';
GRANT SELECT ON nhs_db.Patients TO 'receptionist_user'@'localhost';
GRANT SELECT ON nhs_db.Doctors TO 'receptionist_user'@'localhost';
GRANT SELECT ON nhs_db.Clinics TO 'receptionist_user'@'localhost';

FLUSH PRIVILEGES;

SHOW GRANTS FOR 'admin_user'@'localhost';
SHOW GRANTS FOR 'doctor_user'@'localhost';
SHOW GRANTS FOR 'patient_user'@'localhost';
SHOW GRANTS FOR 'receptionist_user'@'localhost';

SELECT 
    user,
    host,
    plugin
FROM mysql.user
WHERE user IN ('admin_user','doctor_user','patient_user','receptionist_user');

SELECT 
    'PatientPass123!' AS PlainPassword,
    SHA2('PatientPass123!', 256) AS HashedPassword;
