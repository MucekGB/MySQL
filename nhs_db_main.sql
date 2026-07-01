-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: nhs_db
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `appointment_log`
--

DROP TABLE IF EXISTS `appointment_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment_log` (
  `LogID` int NOT NULL AUTO_INCREMENT,
  `AppointmentID` int DEFAULT NULL,
  `LogMessage` varchar(255) DEFAULT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`LogID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment_log`
--

LOCK TABLES `appointment_log` WRITE;
/*!40000 ALTER TABLE `appointment_log` DISABLE KEYS */;
INSERT INTO `appointment_log` VALUES (1,11,'New appointment created for PatientID: P001','2026-06-29 13:50:09');
/*!40000 ALTER TABLE `appointment_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointment_medications`
--

DROP TABLE IF EXISTS `appointment_medications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment_medications` (
  `AppointmentID` int NOT NULL,
  `MedicationID` int NOT NULL,
  PRIMARY KEY (`AppointmentID`,`MedicationID`),
  KEY `MedicationID` (`MedicationID`),
  CONSTRAINT `appointment_medications_ibfk_1` FOREIGN KEY (`AppointmentID`) REFERENCES `appointments` (`AppointmentID`),
  CONSTRAINT `appointment_medications_ibfk_2` FOREIGN KEY (`MedicationID`) REFERENCES `medications` (`MedicationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment_medications`
--

LOCK TABLES `appointment_medications` WRITE;
/*!40000 ALTER TABLE `appointment_medications` DISABLE KEYS */;
INSERT INTO `appointment_medications` VALUES (1,1),(1,2),(2,3),(3,4),(4,5),(5,6),(6,7),(7,8),(8,9),(9,10);
/*!40000 ALTER TABLE `appointment_medications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `AppointmentID` int NOT NULL AUTO_INCREMENT,
  `PatientID` varchar(10) DEFAULT NULL,
  `DoctorID` int DEFAULT NULL,
  `ClinicID` int DEFAULT NULL,
  `AppointmentDate` date NOT NULL,
  `AppointmentTime` time NOT NULL,
  `Notes` text,
  PRIMARY KEY (`AppointmentID`),
  KEY `PatientID` (`PatientID`),
  KEY `DoctorID` (`DoctorID`),
  KEY `ClinicID` (`ClinicID`),
  CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`PatientID`) REFERENCES `patients` (`PatientID`),
  CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`DoctorID`) REFERENCES `doctors` (`DoctorID`),
  CONSTRAINT `appointments_ibfk_3` FOREIGN KEY (`ClinicID`) REFERENCES `clinics` (`ClinicID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES (1,'P001',1,1,'2024-05-01','10:00:00','Follow-up'),(2,'P002',2,2,'2024-05-03','09:00:00','First visit'),(3,'P003',3,3,'2024-05-05','11:30:00','Headache'),(4,'P004',4,1,'2024-05-07','14:00:00','Skin rash'),(5,'P005',5,2,'2024-05-09','15:15:00','Child checkup'),(6,'P006',6,4,'2024-05-11','10:30:00','Knee pain'),(7,'P007',7,5,'2024-05-13','13:00:00','Cancer screening'),(8,'P008',8,6,'2024-05-15','09:45:00','Mental health consultation'),(9,'P009',9,7,'2024-05-17','11:00:00','Ear pain'),(10,'P010',10,8,'2024-05-20','16:00:00','X-ray appointment'),(11,'P001',1,1,'2024-06-01','12:00:00','Checkup');
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clinics`
--

DROP TABLE IF EXISTS `clinics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clinics` (
  `ClinicID` int NOT NULL AUTO_INCREMENT,
  `ClinicName` varchar(100) NOT NULL,
  `ClinicAddress` varchar(255) NOT NULL,
  PRIMARY KEY (`ClinicID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinics`
--

LOCK TABLES `clinics` WRITE;
/*!40000 ALTER TABLE `clinics` DISABLE KEYS */;
INSERT INTO `clinics` VALUES (1,'Clinic A','10 Main St'),(2,'Clinic B','22 River Rd'),(3,'Clinic C','55 Park Ave'),(4,'Clinic D','18 Green St'),(5,'Clinic E','90 High Road'),(6,'Clinic F','7 West Lane'),(7,'Clinic G','31 North Street'),(8,'Clinic H','44 South Road'),(9,'Clinic I','12 East Avenue'),(10,'Clinic J','5 Central Square');
/*!40000 ALTER TABLE `clinics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctors`
--

DROP TABLE IF EXISTS `doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctors` (
  `DoctorID` int NOT NULL AUTO_INCREMENT,
  `DoctorName` varchar(100) NOT NULL,
  `DoctorSpecialty` varchar(100) NOT NULL,
  PRIMARY KEY (`DoctorID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctors`
--

LOCK TABLES `doctors` WRITE;
/*!40000 ALTER TABLE `doctors` DISABLE KEYS */;
INSERT INTO `doctors` VALUES (1,'Dr Adams','Cardiology'),(2,'Dr Brown','General Practice'),(3,'Dr Wilson','Neurology'),(4,'Dr Taylor','Dermatology'),(5,'Dr Lee','Pediatrics'),(6,'Dr Evans','Orthopaedics'),(7,'Dr Patel','Oncology'),(8,'Dr Roberts','Psychiatry'),(9,'Dr Khan','ENT'),(10,'Dr Moore','Radiology');
/*!40000 ALTER TABLE `doctors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medications`
--

DROP TABLE IF EXISTS `medications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medications` (
  `MedicationID` int NOT NULL AUTO_INCREMENT,
  `MedicationName` varchar(100) NOT NULL,
  PRIMARY KEY (`MedicationID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medications`
--

LOCK TABLES `medications` WRITE;
/*!40000 ALTER TABLE `medications` DISABLE KEYS */;
INSERT INTO `medications` VALUES (1,'Aspirin'),(2,'Beta Blocker'),(3,'Paracetamol'),(4,'Ibuprofen'),(5,'Amoxicillin'),(6,'Metformin'),(7,'Atorvastatin'),(8,'Omeprazole'),(9,'Salbutamol'),(10,'Cetirizine');
/*!40000 ALTER TABLE `medications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patients` (
  `PatientID` varchar(10) NOT NULL,
  `PatientName` varchar(100) NOT NULL,
  `Address` varchar(255) NOT NULL,
  PRIMARY KEY (`PatientID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES ('P001','John Smith','123 Hill Rd'),('P002','Mary Jones','456 Lake Ave'),('P003','David White','789 Oak St'),('P004','Emma Brown','12 River Rd'),('P005','Chris Green','34 Pine St'),('P006','Sarah Clark','77 King St'),('P007','Michael Harris','88 Queen Rd'),('P008','Laura Scott','19 Church Lane'),('P009','James Turner','42 Station Rd'),('P010','Olivia Walker','65 Market St');
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-01 15:26:56
