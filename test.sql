USE nhs_db;

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
