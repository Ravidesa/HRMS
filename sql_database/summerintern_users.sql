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
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fname` varchar(45) NOT NULL,
  `lname` varchar(45) DEFAULT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `gender` varchar(45) NOT NULL,
  `role` varchar(45) NOT NULL,
  `createdAccount` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint DEFAULT '0',
  `isDeleted` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (20,'Ravi','Desai','rd@gmail.com','12345','Male','SA','2023-06-21 16:29:10',0,0),(35,'Yash','Parajapati','yp@gmail.com','12345','Male','HR','2023-06-22 11:51:16',0,0),(40,'Vishal','Prajapatii','vp@gmail.com','12345','Male','HR','2023-06-23 18:15:03',0,0),(46,'Akash','Thakkar','at@gmail.com','12345','Male','HR','2023-06-23 18:48:53',0,0),(50,'rajkumar','rao','rajrao@gmail.com','12345','Male','EMPLOYEE','2023-06-26 16:43:57',0,0),(53,'Rakeshh','Jain','rajkej@gmail.com','12345','Male','EMPLOYEE','2023-06-26 18:21:25',0,0),(57,'Jigar','Balodhan','jb@gmail.com','12345','Male','HR','2023-06-27 11:50:42',0,1),(60,'Neel','Ramani','nr@gmail.com','12345','Male','HR','2023-06-27 15:56:09',1,0),(63,'Deepika','Bishnoi','deepikab@gmail.com','12345','Female','EMPLOYEE','2023-06-27 17:18:00',0,0),(65,'Raju','Rastogi','rajur@gmail.com','12345','Male','EMPLOYEE','2023-06-27 18:32:35',0,0),(66,'Jaydeep','Galchar','jdd@gmail.com','12345','Male','HR','2023-06-28 11:20:24',0,0),(67,'ranjeet','desai','ranjeetd@gmail.com','12345','Male','EMPLOYEE','2023-06-28 13:03:56',0,0),(69,'Vishall','Patell','vishalpatel@gmail.com','12345','Male','EMPLOYEE','2023-06-29 14:43:07',0,1),(70,'Vishalll','Ramaniii','vishalramanii@gmail.com','12345','Male','EMPLOYEE','2023-06-29 14:46:32',0,1),(71,'Jiten','Patel','jitenp@gmail.com','12345','Male','HR','2023-07-15 11:41:49',0,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-16 12:46:29
