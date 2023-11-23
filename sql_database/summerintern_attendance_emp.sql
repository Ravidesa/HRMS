-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: summerintern
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `attendance_emp`
--

DROP TABLE IF EXISTS `attendance_emp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendance_emp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `punch_in` varchar(45) NOT NULL,
  `punch_out` varchar(45) NOT NULL,
  `work_duration` varchar(45) NOT NULL,
  `punch_date` date NOT NULL,
  `week_day` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `use_id_attendance_idx` (`user_id`),
  CONSTRAINT `use_id_attendance` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance_emp`
--

LOCK TABLES `attendance_emp` WRITE;
/*!40000 ALTER TABLE `attendance_emp` DISABLE KEYS */;
INSERT INTO `attendance_emp` VALUES (1,63,'11:45:03 AM','11:45:12 AM','00 : 00 : 08 ','2023-07-13','Thursday'),(4,40,'11:58:36 AM','11:58:47 AM','00 : 00 : 11 ','2023-07-13','Thursday'),(5,63,'11:46:03 AM','11:48:12 AM','00 : 00 : 10','2023-07-14','Friday'),(6,63,'11:46:03 AM','11:48:12 AM','00 : 00 : 17','2023-07-17','Monday'),(7,53,'4:30:24 PM','4:30:42 PM','00 : 00 : 18 ','2023-07-13','Thursday'),(8,40,'3:03:46 PM','3:03:47 PM','00 : 00 : 00 ','2023-07-15','Saturday'),(9,57,'3:18:57 PM','3:19:04 PM','00 : 00 : 06 ','2023-07-15','Saturday'),(10,53,'5:58:01 PM','5:58:03 PM','00 : 00 : 02 ','2023-07-15','Saturday');
/*!40000 ALTER TABLE `attendance_emp` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-16 12:46:30
