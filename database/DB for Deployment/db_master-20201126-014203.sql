--
-- DbNinja v3.2.7 for MySQL
--
-- Dump date: 2020-11-26 01:42:03 (UTC)
-- Server version: 10.4.11-MariaDB
-- Database: db_master
--

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

CREATE DATABASE `db_master` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `db_master`;

--
-- Structure for table: tbl_campus
--
CREATE TABLE `tbl_campus` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `campus_name` char(100) NOT NULL,
  `campus_code` varchar(30) NOT NULL,
  `campus_address` text DEFAULT NULL,
  `campus_email` varchar(150) DEFAULT NULL,
  `campus_telephone` tinytext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_cos_salary
--
CREATE TABLE `tbl_cos_salary` (
  `no` int(11) NOT NULL,
  `position_id` int(11) DEFAULT NULL,
  `salary_type` char(10) DEFAULT NULL,
  `salary` decimal(10,0) DEFAULT NULL,
  `date_implemented` date DEFAULT NULL,
  `campus_id` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_department
--
CREATE TABLE `tbl_department` (
  `no` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `department_code` char(8) NOT NULL,
  `department_desc` varchar(50) DEFAULT NULL,
  `campus_id` tinyint(4) DEFAULT NULL,
  `is_project` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_dtr_code
--
CREATE TABLE `tbl_dtr_code` (
  `no` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `dtr_code` char(20) NOT NULL,
  `dtr_code_desc` char(255) NOT NULL,
  `payable` enum('0','1') NOT NULL DEFAULT '0',
  `affected` enum('0','1') NOT NULL DEFAULT '0',
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_employee
--
CREATE TABLE `tbl_employee` (
  `no` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` char(20) DEFAULT NULL,
  `employee_picture` text DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `ext_name` varchar(5) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `birthplace` varchar(255) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `citizenship` varchar(50) DEFAULT NULL,
  `dual_citizen` varchar(70) DEFAULT NULL,
  `marital_status` varchar(15) DEFAULT NULL,
  `blood_type` varchar(3) DEFAULT NULL,
  `height` decimal(8,2) DEFAULT 0.00 COMMENT 'Meter',
  `weight` decimal(8,2) DEFAULT 0.00 COMMENT 'Kilogram',
  `resadd_house_block_no` char(50) DEFAULT NULL,
  `resadd_street` char(50) DEFAULT NULL,
  `resadd_sub_village` char(50) DEFAULT NULL,
  `resadd_brgy` char(50) DEFAULT NULL,
  `resadd_mun_city` char(50) DEFAULT NULL,
  `resadd_province` char(50) DEFAULT NULL,
  `resadd_zip_code` char(5) DEFAULT NULL,
  `peradd_house_block_no` char(50) DEFAULT NULL,
  `peradd_street` char(50) DEFAULT NULL,
  `peradd_sub_village` char(50) DEFAULT NULL,
  `peradd_brgy` char(50) DEFAULT NULL,
  `peradd_mun_city` char(50) DEFAULT NULL,
  `peradd_province` char(50) DEFAULT NULL,
  `peradd_zip_code` char(5) DEFAULT NULL,
  `cellphone_no` varchar(50) DEFAULT NULL,
  `telephone_no` varchar(25) DEFAULT NULL,
  `gsis_no` varchar(15) DEFAULT NULL,
  `sss_no` varchar(15) DEFAULT NULL,
  `tin_no` varchar(15) DEFAULT NULL,
  `philhealth_no` varchar(15) DEFAULT NULL,
  `pagibig_no` varchar(50) DEFAULT NULL,
  `email_address` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=4348 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_employee_education
--
CREATE TABLE `tbl_employee_education` (
  `no` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` char(20) DEFAULT NULL,
  `level` enum('Elementary','Secondary','Vocational','College','Graduate Studies') NOT NULL,
  `school_name` varchar(100) DEFAULT NULL,
  `school_address` varchar(100) DEFAULT NULL,
  `school_degree` varchar(30) DEFAULT NULL,
  `year_graduated` varchar(4) DEFAULT NULL,
  `period_from` char(20) DEFAULT NULL,
  `period_to` char(20) DEFAULT NULL,
  `highest_level` varchar(50) DEFAULT NULL,
  `academic_honor` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=4060 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_employee_eligibility
--
CREATE TABLE `tbl_employee_eligibility` (
  `no` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` char(20) DEFAULT NULL,
  `eligibility_name` varchar(100) DEFAULT NULL,
  `eligibility_rating` double DEFAULT 0,
  `eligibility_date_exam` date DEFAULT NULL,
  `eligibility_place_exam` char(255) DEFAULT NULL,
  `eligibility_license` char(20) DEFAULT NULL,
  `eligibility_validity` date DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=195 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_employee_employment
--
CREATE TABLE `tbl_employee_employment` (
  `no` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` char(20) DEFAULT NULL,
  `date_from` date DEFAULT NULL,
  `date_to` date DEFAULT NULL,
  `position` char(200) NOT NULL,
  `company` char(255) DEFAULT NULL,
  `salary` float DEFAULT NULL,
  `salary_grade` char(20) DEFAULT NULL,
  `appointment` char(100) DEFAULT NULL,
  `govt_service` enum('0','1') NOT NULL,
  PRIMARY KEY (`no`),
  KEY `emp_id` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_employee_family_background
--
CREATE TABLE `tbl_employee_family_background` (
  `no` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` char(20) DEFAULT NULL,
  `relationship` tinyint(4) DEFAULT NULL COMMENT '0:child;1:Spouse;2:Mother;3:Father',
  `first_name` char(50) DEFAULT NULL,
  `middle_name` char(50) DEFAULT NULL,
  `last_name` char(50) DEFAULT NULL,
  `ext_name` char(10) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `occupation` char(50) DEFAULT NULL,
  `employer` char(100) DEFAULT NULL,
  `business_address` char(100) DEFAULT NULL,
  `telephone_no` char(50) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=1729 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_employee_other_info
--
CREATE TABLE `tbl_employee_other_info` (
  `no` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(50) DEFAULT NULL,
  `other_skill` varchar(255) DEFAULT NULL,
  `other_recognition` varchar(255) DEFAULT NULL,
  `other_organization` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_employee_references
--
CREATE TABLE `tbl_employee_references` (
  `no` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` char(20) DEFAULT NULL,
  `reference_name` varchar(100) DEFAULT NULL,
  `reference_position` varchar(30) DEFAULT NULL,
  `reference_address` varchar(100) DEFAULT NULL,
  `reference_contact` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_employee_sched
--
CREATE TABLE `tbl_employee_sched` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `date` char(20) DEFAULT NULL,
  `sched_code` char(10) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=760 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_employee_status
--
CREATE TABLE `tbl_employee_status` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `privilege` smallint(6) DEFAULT NULL,
  `department_id` char(8) DEFAULT NULL,
  `campus_id` int(11) NOT NULL,
  `active_status` tinyint(2) NOT NULL DEFAULT 1,
  `date_start` date NOT NULL,
  `date_end` date DEFAULT NULL,
  `position_id` int(11) DEFAULT NULL,
  `etype_id` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=384 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_employee_training_seminar
--
CREATE TABLE `tbl_employee_training_seminar` (
  `no` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(50) DEFAULT NULL,
  `training_title` varchar(255) DEFAULT NULL,
  `training_from` date DEFAULT NULL,
  `training_to` date DEFAULT NULL,
  `training_hours` int(11) DEFAULT 0,
  `training_type` char(50) NOT NULL,
  `training_sponsor` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_employee_type
--
CREATE TABLE `tbl_employee_type` (
  `etype_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `etype_desc` char(100) NOT NULL,
  `isTeaching` tinyint(2) NOT NULL,
  `jo` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`etype_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_employee_update_delete
--
CREATE TABLE `tbl_employee_update_delete` (
  `no` int(10) NOT NULL AUTO_INCREMENT,
  `updated_action` tinyint(50) NOT NULL,
  `updated_table` varchar(50) NOT NULL,
  `updated_old_data` varchar(255) DEFAULT NULL,
  `updated_new_data` varchar(255) DEFAULT NULL,
  `updated_employee_id` int(10) DEFAULT NULL,
  `updated_admin_id` int(10) DEFAULT NULL,
  `updated_date` date DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=658 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_employee_voluntary_work
--
CREATE TABLE `tbl_employee_voluntary_work` (
  `no` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(50) DEFAULT NULL,
  `organization_name` varchar(255) DEFAULT NULL,
  `date_from` varchar(50) DEFAULT NULL,
  `date_to` varchar(50) DEFAULT NULL,
  `total_hours` int(11) DEFAULT 0,
  `organization_position` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_event
--
CREATE TABLE `tbl_event` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `event_name` char(255) DEFAULT NULL,
  `event_date` date DEFAULT NULL,
  `event_start` char(20) DEFAULT NULL,
  `event_end` char(20) DEFAULT NULL,
  `dtr_code_id` tinyint(3) DEFAULT NULL,
  `campus_id` tinyint(3) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_fingerprint
--
CREATE TABLE `tbl_fingerprint` (
  `fprint_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` char(20) DEFAULT NULL,
  `xml` text NOT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`fprint_id`),
  KEY `fprint_emp_id` (`employee_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_position
--
CREATE TABLE `tbl_position` (
  `no` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `position_code` varchar(20) NOT NULL,
  `position_desc` varchar(50) NOT NULL,
  `is_teaching` smallint(6) NOT NULL,
  `salary_grade` smallint(5) NOT NULL,
  `etype_id` tinyint(3) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_privilege
--
CREATE TABLE `tbl_privilege` (
  `priv_id` int(11) NOT NULL AUTO_INCREMENT,
  `priv_desc` varchar(150) NOT NULL,
  `priv_level` int(11) NOT NULL,
  PRIMARY KEY (`priv_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_salary_grade
--
CREATE TABLE `tbl_salary_grade` (
  `no` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `salary_grade` smallint(33) DEFAULT NULL,
  `step_increment` varchar(60) NOT NULL,
  `campus_id` tinyint(4) DEFAULT NULL,
  `date_implemented` date DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_schedule
--
CREATE TABLE `tbl_schedule` (
  `no` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sched_code` char(10) DEFAULT NULL,
  `weekday` enum('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday') DEFAULT NULL,
  `am_in` time DEFAULT NULL,
  `am_out` time DEFAULT NULL,
  `pm_in` time DEFAULT NULL,
  `pm_out` time DEFAULT NULL,
  PRIMARY KEY (`no`),
  KEY `SchedCode` (`sched_code`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_schedule_preset
--
CREATE TABLE `tbl_schedule_preset` (
  `preset_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sched_code` char(50) NOT NULL,
  `sched_day` char(50) NOT NULL,
  `sched_time` char(255) NOT NULL,
  PRIMARY KEY (`preset_id`),
  KEY `sched_code` (`sched_code`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_settings
--
CREATE TABLE `tbl_settings` (
  `no` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `keyword` char(255) NOT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_user_employee
--
CREATE TABLE `tbl_user_employee` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` char(11) NOT NULL,
  `employee_username` char(150) DEFAULT NULL,
  `employee_password` text NOT NULL,
  PRIMARY KEY (`no`),
  UNIQUE KEY `emp_id` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=351 DEFAULT CHARSET=latin1 COMMENT='table for the employee side only';


--
-- Data for table: tbl_campus
--
LOCK TABLES `tbl_campus` WRITE;
ALTER TABLE `tbl_campus` DISABLE KEYS;

INSERT INTO `tbl_campus` (`id`,`campus_name`,`campus_code`,`campus_address`,`campus_email`,`campus_telephone`) VALUES (1,'Pili','PIL','San Jose, Pili, Camarines Sur',NULL,NULL),(2,'Pasacao','PAS','Pasacao, Camarines Sur',NULL,NULL),(3,'Calabanga','CAL','Calabanga, Camarines Sur 4405',NULL,NULL),(4,'Sipocot','SIP','Impig, Sipocot, Camarines Sur 4408','cbsua.sipocot@yahoo.com','(054) 881-6681');

ALTER TABLE `tbl_campus` ENABLE KEYS;
UNLOCK TABLES;
COMMIT;

--
-- Data for table: tbl_cos_salary
--
LOCK TABLES `tbl_cos_salary` WRITE;
ALTER TABLE `tbl_cos_salary` DISABLE KEYS;

INSERT INTO `tbl_cos_salary` (`no`,`position_id`,`salary_type`,`salary`,`date_implemented`,`campus_id`) VALUES (1,156,'Per month',11914,'2018-07-03',4),(0,158,'Per month',19895,'2020-07-01',4),(0,15,'Per hour',295,'2020-01-01',4);

ALTER TABLE `tbl_cos_salary` ENABLE KEYS;
UNLOCK TABLES;
COMMIT;

--
-- Data for table: tbl_dtr_code
--
LOCK TABLES `tbl_dtr_code` WRITE;
ALTER TABLE `tbl_dtr_code` DISABLE KEYS;

INSERT INTO `tbl_dtr_code` (`no`,`dtr_code`,`dtr_code_desc`,`payable`,`affected`) VALUES (1,'BO:BO','Brownout','1','1'),(2,'HL:HL','Holiday','1','0'),(3,'OB:OB','Official Business','1','1'),(4,'AB:AB','Absent','0','0'),(5,'WF:HM','Work from Home','1','1'),(6,'LV:LV','Official Leave','1','0');

ALTER TABLE `tbl_dtr_code` ENABLE KEYS;
UNLOCK TABLES;
COMMIT;

--
-- Data for table: tbl_employee
--
LOCK TABLES `tbl_employee` WRITE;
ALTER TABLE `tbl_employee` DISABLE KEYS;

INSERT INTO `tbl_employee` (`no`,`first_name`,`last_name`) VALUES (1,'HR','HR');

ALTER TABLE `tbl_employee` ENABLE KEYS;
UNLOCK TABLES;
COMMIT;

--
-- Data for table: tbl_employee_status
--
LOCK TABLES `tbl_employee_status` WRITE;
ALTER TABLE `tbl_employee_status` DISABLE KEYS;

INSERT INTO `tbl_employee_status` (`no`,`employee_id`,`privilege`,`campus_id`,`active_status`,`date_start`,`etype_id`) VALUES (1,1,1,1,1,'2020-01-01',2);

ALTER TABLE `tbl_employee_status` ENABLE KEYS;
UNLOCK TABLES;
COMMIT;

--
-- Data for table: tbl_employee_type
--
LOCK TABLES `tbl_employee_type` WRITE;
ALTER TABLE `tbl_employee_type` DISABLE KEYS;

INSERT INTO `tbl_employee_type` (`etype_id`,`etype_desc`,`isTeaching`,`jo`) VALUES (1,'Permanent | Teaching',1,0),(2,'Permanent | Non-Teaching',0,0),(3,'Casual',0,0),(4,'Temporary',1,0),(5,'COS | Teaching',1,1),(6,'COS | Non-Teaching',0,1),(7,'Project-Based',0,1);

ALTER TABLE `tbl_employee_type` ENABLE KEYS;
UNLOCK TABLES;
COMMIT;

--
-- Data for table: tbl_position
--
LOCK TABLES `tbl_position` WRITE;
ALTER TABLE `tbl_position` DISABLE KEYS;

INSERT INTO `tbl_position` (`no`,`position_code`,`position_desc`,`is_teaching`,`salary_grade`,`etype_id`) VALUES (1,'INST1','Instructor I',1,12,1),(2,'INST2','Instructor II',1,13,1),(3,'INST3','Instructor III',1,14,1),(4,'AP1','Assistant Professor I',1,15,1),(5,'AP2','Assistant Professor II',1,16,1),(6,'AP3','Assistant Professor III',1,17,1),(7,'AP4','Assistant Professor IV',1,18,1),(8,'APRO1','Associate Professor I',1,19,1),(9,'APRO2','Associate Professor II',1,20,1),(10,'APRO3','Associate Professor III',1,21,1),(11,'APRO4','Associate Professor IV',1,22,1),(12,'APRO5','Associate Professor V',1,23,1),(13,'PROF1','Professor I',1,24,1),(14,'PROF2','Professor II',1,25,1),(15,'PROF3','Professor III',1,26,1),(16,'PROF4','Professor IV',1,27,1),(17,'PROF5','Professor V',1,28,1),(18,'PROF6','Professor VI',1,29,1),(19,'UNIPROF','College Professor',1,30,1),(20,'ADA1','Administrative Aide I',0,1,2),(21,'ADA2','Administrative Aide II',0,2,2),(22,'ADA3','Administrative Aide III',0,3,2),(23,'ADA4','Administrative Aide IV',0,4,2),(24,'ADA5','Administrative Aide V',0,5,2),(25,'ADA6','Administrative Aide VI',0,6,2),(26,'ADAS1','Administrative Assistant I',0,7,2),(27,'ADAS2','Administrative Assistant II',0,8,2),(28,'ADAS3','Administrative Assistant III',0,9,2),(29,'ADAS4','Administrative Assistant IV',0,10,2),(30,'ADAS5','Administrative Assistant V',0,11,2),(31,'ADAS6','Administrative Assistant VI',0,12,2),(32,'SADAS1','Senior Administrative Assistant I',0,13,2),(33,'SADAS2','Senior Administrative Assistant II',0,14,2),(34,'SADAS3','Senior Administrative Assistant III',0,15,2),(35,'SADAS4','Senior Administrative Assistant IV',0,16,2),(36,'SADAS5','Senior Administrative Assistant V',0,18,2),(37,'ADOF1','Administrative Officer I',0,10,2),(38,'ADOF2','Administrative Officer II',0,11,2),(39,'ADOF3','Administrative Officer III',0,14,2),(40,'ADOF4','Administrative Officer IV',0,15,2),(41,'ADOF5','Administrative Officer V',0,18,2),(42,'SADOF','Supervising Administrative Officer',0,22,2),(43,'CADOF','Chief Administrative Officer',0,24,2),(44,'A1','Accountant I',0,12,2),(45,'A2','Accountant II',0,16,2),(46,'A3','Accountant III',0,19,2),(47,'A4','Accountant IV',0,22,2),(53,'NURS1','Nurse I',0,11,2),(54,'NURS2','Nurse II',0,15,2),(55,'NURS3','Nurse III',0,17,2),(56,'NURS4','Nurse IV',0,19,2),(57,'NURS5','Nurse V',0,20,2),(58,'NURS6','Nurse VI',0,22,2),(59,'NURS7','Nurse VII',0,24,2),(60,'CL1','College Librarian I',0,13,2),(61,'CL2','College Librarian II',0,15,2),(62,'CL3','College Librarian III',0,18,2),(63,'CL4','College Librarian IV',0,22,2),(64,'CL5','College Librarian V',0,24,2),(65,'LIBA','Librarian Aide',0,2,2),(66,'LIB1','Librarian I',0,11,2),(67,'LIB2','Librarian II',0,15,2),(68,'LIB3','Librarian III',0,18,2),(69,'LIB4','Librarian IV',0,22,2),(70,'LIB5','Librarian V',0,24,2),(71,'R1','Registrar I',0,11,2),(72,'R2','Registrar II',0,15,2),(73,'R3','Registrar III',0,18,2),(74,'R4','Registrar IV',0,22,2),(75,'R5','Registrar V',0,24,2),(76,'UNISEC1','University Secretary I',0,28,2),(77,'UNISEC2','University Secretary II',0,29,2),(78,'SUCVP1','SUC Vice-President I',0,25,2),(79,'SUCVP2','SUC Vice-President II',0,26,2),(80,'SUCVP3','SUC Vice-President III',0,27,2),(81,'SUCVP4','SUC Vice-President IV',0,28,2),(82,'SUCPRES1','SUC President I',0,27,2),(83,'SUCPRES2','SUC President II',0,28,2),(84,'SUCPRES3','SUC President III',0,29,2),(85,'SUCPRES4','SUC President IV',0,30,2),(86,'GUIDC1','Guidance Counselor I',0,11,2),(87,'GUIDC2','Guidance Counselor II',0,12,2),(88,'GUIDC3','Guidance Counselor III',0,13,2),(89,'GCOOR1','Guidance Coordinator I',0,14,2),(90,'GCOOR2','Guidance Coordinator II',0,15,2),(91,'GCOOR3','Guidance Coordinator III',0,16,2),(92,'SECG1','Security Guard I',0,3,2),(93,'SECG2','Security Guard II',0,5,2),(94,'SECG3','Security Guard III',0,8,2),(95,'ATY1','Attorney I',0,16,2),(96,'ATY2','Attorney II',0,18,2),(97,'ATY3','Attorney III',0,21,2),(98,'ATY4','Attorney IV',0,23,2),(99,'ATY5','Attorney V',0,25,2),(100,'ATY6','Attorney VI',0,26,2),(101,'SL1','School Librarian I',0,11,2),(102,'SL2','School Librarian II',0,12,2),(103,'SL3','School Librarian III',0,13,2),(112,'BS1','Board Secretary I ',0,14,2),(113,'BS2','Board Secretary II',0,17,2),(114,'BS3','Board Secretary III',0,20,2),(115,'BS4','Board Secretary IV',0,22,2),(116,'BS5','Board Secretary V',0,24,2),(117,'PDO1','Project Development Officer I',0,8,2),(118,'PDO2','Project Development Officer II',0,11,2),(119,'PDO3','Project Development Officer III',0,18,2),(120,'PDO4','Project Development Officer IV',0,22,2),(121,'PDO5','Project Development Officer V',0,24,2),(122,'ARC1','Architect I',0,12,2),(123,'ARC2','Architect II',0,16,2),(124,'ARC3','Architect III',0,19,2),(125,'ARC4','Architect IV',0,22,2),(126,'ARC5','Architect V',0,24,2),(127,'ENG1','Engineer I',0,12,2),(128,'ENG2','Engineer II',0,16,2),(129,'ENG3','Engineer III',0,19,2),(130,'ENG4','Engineer IV',0,22,2),(131,'ENG5','Engineer V',0,24,2),(132,'DENT1','Dentist I',0,14,2),(133,'DENT2','Dentist II',0,17,2),(134,'DENT3','Dentist III',0,20,0),(135,'DENT4','Dentist IV',0,23,2),(136,'DENT5','Dentist V',0,24,2),(137,'DENT6','Dentist VI',0,26,2),(138,'DENT7','Dentist VII',0,28,2),(139,'MDOF1','Medical Officer I',0,16,2),(140,'MDOF2','Medical Officer II',0,18,2),(141,'MDOF3','Medical Officer III',0,21,2),(142,'MDOF4','Medical Officer IV',0,23,2),(143,'MDOF5','Medical Officer V',0,25,2),(144,'FAWK1','Farm Worker I',0,2,2),(145,'FAWK2','Farm Worker II',0,4,2),(146,'AK1','Animal Keeper I',0,4,2),(147,'AK2','Animal Keeper II',0,6,2),(148,'AK3','Animal Keeper III',0,9,2),(149,'WCHM1','Watchman I',0,2,2),(150,'WCHM2','Watchman II',0,4,2),(151,'WCHM3','Watchman III',0,7,2),(152,'DORMG1','Dormitory Manager I',0,9,2),(153,'DORMG2','Dormitory Manager II',0,11,2),(154,'DORMG3','Dormitory Manager III',0,15,2),(155,'DORMG4','Dormitory Manager IV',0,18,2),(156,'JO','Administrative Aide',0,0,6),(157,'COS','COS Instructor',1,0,5),(158,'PROG','Programmer',0,0,7);

ALTER TABLE `tbl_position` ENABLE KEYS;
UNLOCK TABLES;
COMMIT;

--
-- Data for table: tbl_privilege
--
LOCK TABLES `tbl_privilege` WRITE;
ALTER TABLE `tbl_privilege` DISABLE KEYS;

INSERT INTO `tbl_privilege` (`priv_id`,`priv_desc`,`priv_level`) VALUES (1,'HR Officer',1),(2,'SUC President',2),(3,'Campus Administrator',3),(4,'Accountant',4),(5,'Cashier',5),(6,'College Dean',6),(7,'Payroll Officer',7),(8,'N/A',0);

ALTER TABLE `tbl_privilege` ENABLE KEYS;
UNLOCK TABLES;
COMMIT;

--
-- Data for table: tbl_salary_grade
--
LOCK TABLES `tbl_salary_grade` WRITE;
ALTER TABLE `tbl_salary_grade` DISABLE KEYS;

INSERT INTO `tbl_salary_grade` (`no`,`salary_grade`,`step_increment`,`campus_id`,`date_implemented`) VALUES (1,1,'10510,10602,10695,10789,10884,10982,11076,11173',4,'2020-01-01'),(2,2,'11200,11293,11386,11480,11575,11671,11767,11864',4,'2020-01-01'),(3,3,'11914,12013,12112,12212,12313,12414,12517,12620',4,'2020-01-01'),(4,4,'12674,12778,12884,12990,13097,13206,13315,13424',4,'2020-01-01'),(5,5,'13481,13606,13705,13818,13932,14047,14163,14280',4,'2020-01-01'),(6,6,'14340,14459,14578,14699,14820,14942,15066,15190',4,'2020-01-01'),(7,7,'15254,15380,15507,15635,15765,15895,16026,16158',4,'2020-01-01'),(8,8,'16282,16433,16585,16739,16895,17051,17209,17369',4,'2020-01-01'),(9,9,'17473,17627,17781,17937,18095,18253,18413,18575',4,'2020-01-01'),(10,10,'18718,18883,19048,19215,19384,19567,19725,19898',4,'2020-01-01'),(11,11,'20179,20437,20698,20963,21231,21502,21777,22055',4,'2020-01-01'),(12,12,'22149,22410,22674,22942,23212,23486,23763,24043',4,'2020-01-01'),(13,13,'24224,24510,24799,25091,25387,25686,25989,26296',4,'2020-01-01'),(14,14,'26494,26806,27122,27442,27766,28093,28424,28759',4,'2020-01-01'),(15,15,'29010,29359,29713,30071,30432,30799,31170,31545',4,'2020-01-01'),(16,16,'31765,32147,32535,32926,33323,33724,34130,34541',4,'2020-01-01'),(17,17,'34781,35201,35624,36053,36487,36927,37371,37821',4,'2020-01-01'),(18,18,'38085,38543,39007,39477,39952,40433,40920,41413',4,'2020-01-01'),(19,19,'42099,42730,43371,44020,44680,45350,46030,46720',4,'2020-01-01'),(20,20,'47037,47742,48457,49184,49921,50669,51428,52199',4,'2020-01-01'),(21,21,'52554,53341,54141,54952,55776,56612,57460,58322',4,'2020-01-01'),(22,22,'58717,59597,60491,61397,62318,63252,64200,65162',4,'2020-01-01'),(23,23,'65604,66587,67585,68598,69627,70670,71730,72805',4,'2020-01-01'),(24,24,'73299,74397,75512,76644,77793,78959,80143,81344',4,'2020-01-01'),(25,25,'82439,83674,84928,86201,87493,88805,90136,91487',4,'2020-01-01'),(26,26,'92108,93488,94889,96312,97755,99221,100708,102217',4,'2020-01-01'),(27,27,'102910,104453,106019,107608,109221,110858,112519,114210',4,'2020-01-01'),(28,28,'114981,116704,118453,120229,122031,123860,125716,127601',4,'2020-01-01'),(29,29,'128467,130392,132346,134330,136343,138387,140461,142566',4,'2020-01-01'),(30,30,'143534,145685,147869,150085,152335,154618,156935,159288',4,'2020-01-01'),(31,31,'198168,201615,205121,208689,212318,216011,219768,223590',4,'2020-01-01'),(32,32,'233857,238035,242288,246618,251024,255509,260074,264721',4,'2020-01-01'),(33,33,'289401,298083',4,'2020-01-01'),(34,0,'0',4,'2020-01-01');

ALTER TABLE `tbl_salary_grade` ENABLE KEYS;
UNLOCK TABLES;
COMMIT;

--
-- Data for table: tbl_schedule
--
LOCK TABLES `tbl_schedule` WRITE;
ALTER TABLE `tbl_schedule` DISABLE KEYS;

INSERT INTO `tbl_schedule` (`no`,`sched_code`,`weekday`,`am_in`,`am_out`,`pm_in`,`pm_out`) VALUES (1,'SCHED0001','Monday','07:30:00','11:30:00','13:00:00','17:00:00'),(2,'SCHED0001','Tuesday','07:30:00','11:30:00','13:00:00','17:00:00'),(3,'SCHED0001','Wednesday','07:30:00','11:30:00','13:00:00','17:00:00'),(4,'SCHED0001','Thursday','07:30:00','11:30:00','13:00:00','17:00:00'),(5,'SCHED0001','Friday','07:30:00','11:30:00','13:00:00','17:00:00'),(6,'SCHED0002','Monday','08:00:00','12:00:00','13:00:00','17:00:00'),(7,'SCHED0002','Tuesday','08:00:00','12:00:00','13:00:00','17:00:00'),(8,'SCHED0002','Wednesday','08:00:00','12:00:00','13:00:00','17:00:00'),(9,'SCHED0002','Thursday','08:00:00','12:00:00','13:00:00','17:00:00'),(10,'SCHED0002','Friday','08:00:00','12:00:00','13:00:00','17:00:00');

ALTER TABLE `tbl_schedule` ENABLE KEYS;
UNLOCK TABLES;
COMMIT;

--
-- Data for table: tbl_schedule_preset
--
LOCK TABLES `tbl_schedule_preset` WRITE;
ALTER TABLE `tbl_schedule_preset` DISABLE KEYS;

INSERT INTO `tbl_schedule_preset` (`preset_id`,`sched_code`,`sched_day`,`sched_time`) VALUES (1,'SCHED0001','WEEKDAYS','07:30AM - 11:30AM | 01:00PM - 05:00PM'),(2,'SCHED0002','WEEKDAYS','08:00AM - 12:00NN | 01:00PM - 05:00PM');

ALTER TABLE `tbl_schedule_preset` ENABLE KEYS;
UNLOCK TABLES;
COMMIT;

--
-- Data for table: tbl_settings
--
LOCK TABLES `tbl_settings` WRITE;
ALTER TABLE `tbl_settings` DISABLE KEYS;

INSERT INTO `tbl_settings` (`no`,`keyword`,`value`) VALUES (1,'offline_server_ip','192.168.1.222'),(2,'offline_server_user','root'),(3,'offline_server_password','password'),(4,'online_server_ip','66.96.147.104'),(5,'online_server_user','cbsuadtrs'),(6,'online_server_password','@SEAug8g^ZE'),(7,'log_interval','5'),(8,'auto_sync','1'),(9,'bio_server_ip',''),(10,'bio_server_user',''),(11,'bio_server_password','');

ALTER TABLE `tbl_settings` ENABLE KEYS;
UNLOCK TABLES;
COMMIT;

--
-- Data for table: tbl_user_employee
--
LOCK TABLES `tbl_user_employee` WRITE;
ALTER TABLE `tbl_user_employee` DISABLE KEYS;

INSERT INTO `tbl_user_employee` (`no`,`employee_id`,`employee_username`,`employee_password`) VALUES (1,1,'hr_hr','$2y$10$f8zoAMzVMrxbkgrf9eG/4uteIuGoT6YIjs/V8Ox7kg8q9YvcZhbM.');

ALTER TABLE `tbl_user_employee` ENABLE KEYS;
UNLOCK TABLES;
COMMIT;


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;

