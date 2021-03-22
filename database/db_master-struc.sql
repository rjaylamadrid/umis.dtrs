--
-- DbNinja v3.2.7 for MySQL
--
-- Dump date: 2021-03-22 07:13:33 (UTC)
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
-- Structure for table: tbl_emp_leave
--
CREATE TABLE `tbl_emp_leave` (
  `leave_id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(50) NOT NULL,
  `lv_dateof_filing` date DEFAULT NULL,
  `lv_office` char(100) NOT NULL,
  `lv_type` char(100) NOT NULL,
  `lv_type_others` varchar(150) DEFAULT NULL,
  `lv_where` char(150) DEFAULT NULL,
  `lv_where_specific` varchar(150) DEFAULT NULL,
  `lv_commutation` char(15) DEFAULT NULL,
  `lv_date_fr` date DEFAULT NULL,
  `lv_date_to` date DEFAULT NULL,
  `lv_no_days` int(11) NOT NULL,
  `emp_salary` char(50) DEFAULT NULL,
  `lv_recommendation` char(150) DEFAULT NULL,
  `lv_status` int(1) unsigned zerofill DEFAULT 0 COMMENT '0=Pending;1=Recommended;2=Approved;3=Disapproved',
  `lv_days_with_pay` int(11) DEFAULT NULL,
  `lv_days_without_pay` int(11) DEFAULT NULL,
  `lv_hr_id` int(11) DEFAULT NULL,
  `lv_approved_others` char(150) DEFAULT NULL,
  `lv_disapproved_reason` char(150) DEFAULT NULL,
  `lv_date_requested` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`leave_id`)
) ENGINE=InnoDB AUTO_INCREMENT=221 DEFAULT CHARSET=latin1 COMMENT='table for the leave of employees';


--
-- Structure for table: tbl_emp_leave_credits
--
CREATE TABLE `tbl_emp_leave_credits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `vacation` float DEFAULT NULL,
  `sick` float DEFAULT NULL,
  `date_credited` date NOT NULL,
  `is_active` tinyint(2) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_emp_leave_grant
--
CREATE TABLE `tbl_emp_leave_grant` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` char(10) NOT NULL,
  `grant_code` char(50) NOT NULL,
  `grant_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1 COMMENT='table for the Employee leave grant';


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
  `weight` double unsigned DEFAULT NULL COMMENT 'Kilogram',
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
) ENGINE=InnoDB AUTO_INCREMENT=40351 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_employee_education
--
CREATE TABLE `tbl_employee_education` (
  `no` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` char(20) DEFAULT NULL,
  `level` enum('Elementary','Secondary','Vocational','College','Graduate Studies') NOT NULL,
  `school_name` varchar(100) DEFAULT NULL,
  `school_address` varchar(100) DEFAULT NULL,
  `school_degree` varchar(100) DEFAULT NULL,
  `year_graduated` varchar(4) DEFAULT NULL,
  `period_from` char(20) DEFAULT NULL,
  `period_to` char(20) DEFAULT NULL,
  `highest_level` varchar(50) DEFAULT NULL,
  `academic_honor` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=4062 DEFAULT CHARSET=latin1;


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
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_employee_employment
--
CREATE TABLE `tbl_employee_employment` (
  `no` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `date_from` date DEFAULT NULL,
  `date_to` date DEFAULT NULL,
  `position` char(200) NOT NULL,
  `company` char(255) DEFAULT NULL,
  `salary` float DEFAULT NULL,
  `salary_grade` char(20) DEFAULT NULL,
  `step` tinyint(2) DEFAULT NULL,
  `appointment` char(100) DEFAULT NULL,
  `govt_service` enum('0','1') NOT NULL,
  PRIMARY KEY (`no`),
  KEY `emp_id` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=latin1;


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
) ENGINE=InnoDB AUTO_INCREMENT=1753 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_employee_other_info
--
CREATE TABLE `tbl_employee_other_info` (
  `no` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(50) DEFAULT NULL,
  `other_skill` varchar(255) DEFAULT NULL,
  `other_recognition` varchar(255) DEFAULT NULL,
  `other_organization` varchar(255) DEFAULT NULL,
  `answers` text DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;


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
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_employee_sched
--
CREATE TABLE `tbl_employee_sched` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `date` char(20) DEFAULT NULL,
  `sched_code` char(10) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=774 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_employee_service
--
CREATE TABLE `tbl_employee_service` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `position_id` int(11) NOT NULL,
  `date_start` date NOT NULL,
  `date_end` date DEFAULT NULL,
  `etype_id` int(15) NOT NULL,
  `salary` varchar(10) DEFAULT NULL,
  `salary_grade` smallint(2) DEFAULT NULL,
  `step` tinyint(2) DEFAULT NULL,
  `campus_id` tinyint(2) DEFAULT NULL,
  `remarks` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=latin1;


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
  `date_start` date NOT NULL,
  `date_end` date DEFAULT NULL,
  `position_id` int(11) DEFAULT NULL,
  `salary` int(11) DEFAULT NULL,
  `step` smallint(6) DEFAULT 1,
  `etype_id` smallint(6) DEFAULT NULL,
  `is_active` tinyint(2) NOT NULL DEFAULT 1,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=388 DEFAULT CHARSET=latin1;


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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_employee_type
--
CREATE TABLE `tbl_employee_type` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `type_desc` char(50) NOT NULL,
  `type_desc2` char(50) DEFAULT NULL,
  `type_id` tinyint(3) DEFAULT NULL,
  `isRegular` tinyint(2) DEFAULT NULL,
  `isTeaching` tinyint(2) NOT NULL,
  `isJobOrder` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`)
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
) ENGINE=InnoDB AUTO_INCREMENT=889 DEFAULT CHARSET=latin1;


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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;


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
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=latin1;


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
-- Structure for table: tbl_leave_type
--
CREATE TABLE `tbl_leave_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `leave_desc` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_message_connection
--
CREATE TABLE `tbl_message_connection` (
  `no` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `resource_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `session_id` text DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=441 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_messages
--
CREATE TABLE `tbl_messages` (
  `no` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from` int(10) unsigned NOT NULL,
  `to` int(10) unsigned NOT NULL,
  `text` text NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` int(11) DEFAULT 0,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=648 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_payroll
--
CREATE TABLE `tbl_payroll` (
  `no` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT current_timestamp(),
  `payroll_type` varchar(20) DEFAULT NULL,
  `period_from` date DEFAULT NULL,
  `period_to` date DEFAULT NULL,
  `etype_id` tinyint(4) DEFAULT NULL,
  `compensation` mediumtext DEFAULT NULL,
  `deduction` mediumtext DEFAULT NULL,
  `employer_share` mediumtext DEFAULT NULL,
  `signatories` mediumtext DEFAULT NULL,
  `campus_id` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_payroll_det
--
CREATE TABLE `tbl_payroll_det` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `payroll_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `compensation` mediumtext DEFAULT NULL,
  `deduction` mediumtext DEFAULT NULL,
  `employer-share` mediumtext DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_payroll_info
--
CREATE TABLE `tbl_payroll_info` (
  `no` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `payroll_info_type` varchar(50) NOT NULL,
  `payroll_info_name` varchar(100) NOT NULL,
  `etype_id` smallint(6) NOT NULL,
  `cam_id` smallint(6) NOT NULL,
  `isMandatory` int(1) DEFAULT 0,
  `isActive` int(1) NOT NULL,
  `payroll_order` int(11) DEFAULT 0,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_payroll_log
--
CREATE TABLE `tbl_payroll_log` (
  `payroll_no` char(9) NOT NULL DEFAULT '' COMMENT 'PN-000000',
  `payroll_code` char(15) DEFAULT NULL,
  `payroll_date` date NOT NULL,
  `payroll_startDate` date NOT NULL,
  `payroll_endDate` date NOT NULL,
  `etype_id` smallint(5) NOT NULL,
  PRIMARY KEY (`payroll_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_payroll_log_breakdown
--
CREATE TABLE `tbl_payroll_log_breakdown` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payroll_no` char(9) NOT NULL,
  `EmployeeID` varchar(10) NOT NULL,
  `payroll_info_no` int(11) NOT NULL,
  `value` varchar(12) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_payroll_related
--
CREATE TABLE `tbl_payroll_related` (
  `no` smallint(5) NOT NULL AUTO_INCREMENT,
  `payroll_info_no` smallint(5) NOT NULL,
  `employee_id` varchar(10) NOT NULL,
  `filter` smallint(1) DEFAULT NULL,
  `value` varchar(350) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=1386 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_position
--
CREATE TABLE `tbl_position` (
  `no` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `position_code` varchar(20) NOT NULL,
  `position_desc` varchar(50) NOT NULL,
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
  `access` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`priv_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_salary_grade
--
CREATE TABLE `tbl_salary_grade` (
  `no` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `sg_id` int(11) NOT NULL,
  `salary_grade` smallint(33) DEFAULT NULL,
  `step_increment` varchar(60) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=266 DEFAULT CHARSET=latin1;


--
-- Structure for table: tbl_salary_tranche
--
CREATE TABLE `tbl_salary_tranche` (
  `sg_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) DEFAULT NULL,
  `date` date NOT NULL,
  `remarks` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`sg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;


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
-- Structure for table: tbl_school_year
--
CREATE TABLE `tbl_school_year` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `campus_id` tinyint(5) NOT NULL,
  `date_start` date NOT NULL,
  `date_end` date DEFAULT NULL,
  `is_active` tinyint(2) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;


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
) ENGINE=InnoDB AUTO_INCREMENT=360 DEFAULT CHARSET=latin1 COMMENT='table for the employee side only';


--
-- Structure for event: evt_auto_approve_leave
--
CREATE DEFINER=`root`@`%` EVENT `evt_auto_approve_leave` ON SCHEDULE EVERY 3 HOUR STARTS '2021-03-02 09:15:59' ON COMPLETION PRESERVE DISABLE DO UPDATE tbl_emp_leave a
SET lv_status = 2
WHERE lv_status < 2 AND
	(SELECT 5 * 
	 	(DATEDIFF(CURDATE(), a.lv_dateof_filing) DIV 7) 
	 	+ MID('0123444401233334012222340111123400001234000123440', 7 * WEEKDAY(a.lv_dateof_filing) 
		+ WEEKDAY(CURDATE()) + 1, 1) + 1)
	-(SELECT COUNT(*) FROM tbl_event 
	WHERE dtr_code_id = '2'
	AND event_date BETWEEN a.lv_dateof_filing AND CURDATE())>= 5;


--
-- Data for table: tbl_campus
--
LOCK TABLES `tbl_campus` WRITE;
ALTER TABLE `tbl_campus` DISABLE KEYS;

INSERT INTO `tbl_campus` (`id`,`campus_name`,`campus_code`,`campus_address`,`campus_email`,`campus_telephone`) VALUES (1,'Calabanga','CAL','Calabanga, Camarines Sur 4405',NULL,NULL),(2,'Pasacao','PAS','Pasacao, Camarines Sur',NULL,NULL),(3,'Pili','PIL','San Jose, Pili, Camarines Sur',NULL,NULL),(4,'Sipocot','SIP','Impig, Sipocot, Camarines Sur 4408','cbsua.sipocot@yahoo.com','(054) 881-6681');

ALTER TABLE `tbl_campus` ENABLE KEYS;
UNLOCK TABLES;
COMMIT;

--
-- Data for table: tbl_cos_salary
--
LOCK TABLES `tbl_cos_salary` WRITE;
ALTER TABLE `tbl_cos_salary` DISABLE KEYS;

INSERT INTO `tbl_cos_salary` (`no`,`position_id`,`salary_type`,`salary`,`date_implemented`,`campus_id`) VALUES (1,156,'per Month',11914,'2018-07-03',4),(0,158,'per month',19895,'2020-07-01',4),(0,157,'per hour',200,'2020-01-01',4);

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
-- Data for table: tbl_employee_type
--
LOCK TABLES `tbl_employee_type` WRITE;
ALTER TABLE `tbl_employee_type` DISABLE KEYS;

INSERT INTO `tbl_employee_type` (`id`,`type_desc`,`type_desc2`,`type_id`,`isRegular`,`isTeaching`,`isJobOrder`) VALUES (1,'Permanent','Teaching',1,1,1,0),(2,'Permanent','Non-Teaching',2,1,0,0),(3,'Casual',NULL,2,0,0,0),(4,'Temporary',NULL,1,0,1,0),(5,'Contract of Service',NULL,5,0,1,1),(6,'Job Order',NULL,6,0,0,1),(7,'Project-Based',NULL,7,0,0,1);

ALTER TABLE `tbl_employee_type` ENABLE KEYS;
UNLOCK TABLES;
COMMIT;

--
-- Data for table: tbl_position
--
LOCK TABLES `tbl_position` WRITE;
ALTER TABLE `tbl_position` DISABLE KEYS;

INSERT INTO `tbl_position` (`no`,`position_code`,`position_desc`,`salary_grade`,`etype_id`) VALUES (1,'INST1','Instructor I',12,1),(2,'INST2','Instructor II',13,1),(3,'INST3','Instructor III',14,1),(4,'AP1','Assistant Professor I',15,1),(5,'AP2','Assistant Professor II',16,1),(6,'AP3','Assistant Professor III',17,1),(7,'AP4','Assistant Professor IV',18,1),(8,'APRO1','Associate Professor I',19,1),(9,'APRO2','Associate Professor II',20,1),(10,'APRO3','Associate Professor III',21,1),(11,'APRO4','Associate Professor IV',22,1),(12,'APRO5','Associate Professor V',23,1),(13,'PROF1','Professor I',24,1),(14,'PROF2','Professor II',25,1),(15,'PROF3','Professor III',26,1),(16,'PROF4','Professor IV',27,1),(17,'PROF5','Professor V',28,1),(18,'PROF6','Professor VI',29,1),(19,'UNIPROF','College Professor',30,1),(20,'ADA1','Administrative Aide I',1,2),(21,'ADA2','Administrative Aide II',2,2),(22,'ADA3','Administrative Aide III',3,2),(23,'ADA4','Administrative Aide IV',4,2),(24,'ADA5','Administrative Aide V',5,2),(25,'ADA6','Administrative Aide VI',6,2),(26,'ADAS1','Administrative Assistant I',7,2),(27,'ADAS2','Administrative Assistant II',8,2),(28,'ADAS3','Administrative Assistant III',9,2),(29,'ADAS4','Administrative Assistant IV',10,2),(30,'ADAS5','Administrative Assistant V',11,2),(31,'ADAS6','Administrative Assistant VI',12,2),(32,'SADAS1','Senior Administrative Assistant I',13,2),(33,'SADAS2','Senior Administrative Assistant II',14,2),(34,'SADAS3','Senior Administrative Assistant III',15,2),(35,'SADAS4','Senior Administrative Assistant IV',16,2),(36,'SADAS5','Senior Administrative Assistant V',18,2),(37,'ADOF1','Administrative Officer I',10,2),(38,'ADOF2','Administrative Officer II',11,2),(39,'ADOF3','Administrative Officer III',14,2),(40,'ADOF4','Administrative Officer IV',15,2),(41,'ADOF5','Administrative Officer V',18,2),(42,'SADOF','Supervising Administrative Officer',22,2),(43,'CADOF','Chief Administrative Officer',24,2),(44,'A1','Accountant I',12,2),(45,'A2','Accountant II',16,2),(46,'A3','Accountant III',19,2),(47,'A4','Accountant IV',22,2),(53,'NURS1','Nurse I',11,2),(54,'NURS2','Nurse II',15,2),(55,'NURS3','Nurse III',17,2),(56,'NURS4','Nurse IV',19,2),(57,'NURS5','Nurse V',20,2),(58,'NURS6','Nurse VI',22,2),(59,'NURS7','Nurse VII',24,2),(60,'CL1','College Librarian I',13,2),(61,'CL2','College Librarian II',15,2),(62,'CL3','College Librarian III',18,2),(63,'CL4','College Librarian IV',22,2),(64,'CL5','College Librarian V',24,2),(65,'LIBA','Librarian Aide',2,2),(66,'LIB1','Librarian I',11,2),(67,'LIB2','Librarian II',15,2),(68,'LIB3','Librarian III',18,2),(69,'LIB4','Librarian IV',22,2),(70,'LIB5','Librarian V',24,2),(71,'R1','Registrar I',11,2),(72,'R2','Registrar II',15,2),(73,'R3','Registrar III',18,2),(74,'R4','Registrar IV',22,2),(75,'R5','Registrar V',24,2),(76,'UNISEC1','University Secretary I',28,2),(77,'UNISEC2','University Secretary II',29,2),(78,'SUCVP1','SUC Vice-President I',25,2),(79,'SUCVP2','SUC Vice-President II',26,2),(80,'SUCVP3','SUC Vice-President III',27,2),(81,'SUCVP4','SUC Vice-President IV',28,2),(82,'SUCPRES1','SUC President I',27,2),(83,'SUCPRES2','SUC President II',28,2),(84,'SUCPRES3','SUC President III',29,2),(85,'SUCPRES4','SUC President IV',30,2),(86,'GUIDC1','Guidance Counselor I',11,2),(87,'GUIDC2','Guidance Counselor II',12,2),(88,'GUIDC3','Guidance Counselor III',13,2),(89,'GCOOR1','Guidance Coordinator I',14,2),(90,'GCOOR2','Guidance Coordinator II',15,2),(91,'GCOOR3','Guidance Coordinator III',16,2),(92,'SECG1','Security Guard I',3,2),(93,'SECG2','Security Guard II',5,2),(94,'SECG3','Security Guard III',8,2),(95,'ATY1','Attorney I',16,2),(96,'ATY2','Attorney II',18,2),(97,'ATY3','Attorney III',21,2),(98,'ATY4','Attorney IV',23,2),(99,'ATY5','Attorney V',25,2),(100,'ATY6','Attorney VI',26,2),(101,'SL1','School Librarian I',11,2),(102,'SL2','School Librarian II',12,2),(103,'SL3','School Librarian III',13,2),(112,'BS1','Board Secretary I ',14,2),(113,'BS2','Board Secretary II',17,2),(114,'BS3','Board Secretary III',20,2),(115,'BS4','Board Secretary IV',22,2),(116,'BS5','Board Secretary V',24,2),(117,'PDO1','Project Development Officer I',8,2),(118,'PDO2','Project Development Officer II',11,2),(119,'PDO3','Project Development Officer III',18,2),(120,'PDO4','Project Development Officer IV',22,2),(121,'PDO5','Project Development Officer V',24,2),(122,'ARC1','Architect I',12,2),(123,'ARC2','Architect II',16,2),(124,'ARC3','Architect III',19,2),(125,'ARC4','Architect IV',22,2),(126,'ARC5','Architect V',24,2),(127,'ENG1','Engineer I',12,2),(128,'ENG2','Engineer II',16,2),(129,'ENG3','Engineer III',19,2),(130,'ENG4','Engineer IV',22,2),(131,'ENG5','Engineer V',24,2),(132,'DENT1','Dentist I',14,2),(133,'DENT2','Dentist II',17,2),(134,'DENT3','Dentist III',20,2),(135,'DENT4','Dentist IV',23,2),(136,'DENT5','Dentist V',24,2),(137,'DENT6','Dentist VI',26,2),(138,'DENT7','Dentist VII',28,2),(139,'MDOF1','Medical Officer I',16,2),(140,'MDOF2','Medical Officer II',18,2),(141,'MDOF3','Medical Officer III',21,2),(142,'MDOF4','Medical Officer IV',23,2),(143,'MDOF5','Medical Officer V',25,2),(144,'FAWK1','Farm Worker I',2,2),(145,'FAWK2','Farm Worker II',4,2),(146,'AK1','Animal Keeper I',4,2),(147,'AK2','Animal Keeper II',6,2),(148,'AK3','Animal Keeper III',9,2),(149,'WCHM1','Watchman I',2,2),(150,'WCHM2','Watchman II',4,2),(151,'WCHM3','Watchman III',7,2),(152,'DORMG1','Dormitory Manager I',9,2),(153,'DORMG2','Dormitory Manager II',11,2),(154,'DORMG3','Dormitory Manager III',15,2),(155,'DORMG4','Dormitory Manager IV',18,2),(156,'JO','Administrative Aide',0,6),(157,'COS','Instructor',0,5),(158,'PROG','Programmer',0,7);

ALTER TABLE `tbl_position` ENABLE KEYS;
UNLOCK TABLES;
COMMIT;

--
-- Data for table: tbl_salary_grade
--
LOCK TABLES `tbl_salary_grade` WRITE;
ALTER TABLE `tbl_salary_grade` DISABLE KEYS;

INSERT INTO `tbl_salary_grade` (`no`,`sg_id`,`salary_grade`,`step_increment`) VALUES (1,3,1,'10510,10602,10695,10789,10884,10982,11076,11173'),(2,3,2,'11200,11293,11386,11480,11575,11671,11767,11864'),(3,3,3,'11914,12013,12112,12212,12313,12414,12517,12620'),(4,3,4,'12674,12778,12884,12990,13097,13206,13315,13424'),(5,3,5,'13481,13606,13705,13818,13932,14047,14163,14280'),(6,3,6,'14340,14459,14578,14699,14820,14942,15066,15190'),(7,3,7,'15254,15380,15507,15635,15765,15895,16026,16158'),(8,3,8,'16282,16433,16585,16739,16895,17051,17209,17369'),(9,3,9,'17473,17627,17781,17937,18095,18253,18413,18575'),(10,3,10,'18718,18883,19048,19215,19384,19567,19725,19898'),(11,3,11,'20179,20437,20698,20963,21231,21502,21777,22055'),(12,3,12,'22149,22410,22674,22942,23212,23486,23763,24043'),(13,3,13,'24224,24510,24799,25091,25387,25686,25989,26296'),(14,3,14,'26494,26806,27122,27442,27766,28093,28424,28759'),(15,3,15,'29010,29359,29713,30071,30432,30799,31170,31545'),(16,3,16,'31765,32147,32535,32926,33323,33724,34130,34541'),(17,3,17,'34781,35201,35624,36053,36487,36927,37371,37821'),(18,3,18,'38085,38543,39007,39477,39952,40433,40920,41413'),(19,3,19,'42099,42730,43371,44020,44680,45350,46030,46720'),(20,3,20,'47037,47742,48457,49184,49921,50669,51428,52199'),(21,3,21,'52554,53341,54141,54952,55776,56612,57460,58322'),(22,3,22,'58717,59597,60491,61397,62318,63252,64200,65162'),(23,3,23,'65604,66587,67585,68598,69627,70670,71730,72805'),(24,3,24,'73299,74397,75512,76644,77793,78959,80143,81344'),(25,3,25,'82439,83674,84928,86201,87493,88805,90136,91487'),(26,3,26,'92108,93488,94889,96312,97755,99221,100708,102217'),(27,3,27,'102910,104453,106019,107608,109221,110858,112519,114210'),(28,3,28,'114981,116704,118453,120229,122031,123860,125716,127601'),(29,3,29,'128467,130392,132346,134330,136343,138387,140461,142566'),(30,3,30,'143534,145685,147869,150085,152335,154618,156935,159288'),(31,3,31,'198168,201615,205121,208689,212318,216011,219768,223590'),(32,3,32,'233857,238035,242288,246618,251024,255509,260074,264721'),(33,3,33,'289401,298083'),(35,1,1,'9478,9568,9660,9753,9846,9949,10036,10132'),(36,1,2,'10159,10255,10351,10449,10547,10647,10747,10848'),(37,1,3,'10883,10985,11089,11193,11298,11405,11512,11621'),(38,1,4,'11658,11767,11878,11990,12103,12217,12333,12448'),(39,1,5,'12488,12644,12725,12844,12965,13087,13211,13335'),(40,1,6,'13378,13504,13630,13759,13889,14020,14152,14285'),(41,1,7,'14331,14466,14602,14740,14878,15018,15159,15303'),(42,1,8,'15368,15519,15670,15823,15978,16133,16291,16450'),(43,1,9,'16512,16671,16830,16992,17155,17319,17485,17653'),(44,1,10,'17730,17900,18071,18245,18420,18634,18775,18955'),(45,1,11,'19077,19286,19496,19709,19925,20142,20362,20585'),(46,1,12,'20651,20870,21091,21315,21540,21769,21999,22232'),(47,1,13,'22328,22564,22804,23045,23289,23536,23786,24037'),(48,1,14,'24141,24396,24655,24916,25180,25447,25717,25989'),(49,1,15,'26192,26489,26790,27094,27401,27712,28027,28344'),(50,1,16,'28417,28740,29066,29396,29729,30066,30408,30752'),(51,1,17,'30831,31183,31536,31893,32255,32622,32991,33366'),(52,1,18,'33452,33831,34215,34603,34996,35393,35795,36201'),(53,1,19,'36409,36857,37312,37771,38237,38709,39186,39670'),(54,1,20,'39768,40259,40755,41258,41766,42281,42802,43330'),(55,1,21,'43439,43974,44517,45066,45621,46183,46753,47329'),(56,1,22,'47448,48032,48625,49224,49831,50445,51067,51697'),(57,1,23,'51826,52466,53112,53767,54430,55101,55781,56468'),(58,1,24,'56610,57308,58014,58730,59453,60187,60928,61679'),(59,1,25,'61971,62735,63508,64291,65083,65885,66698,67520'),(60,1,26,'67690,68524,69369,70224,71090,71967,72855,73751'),(61,1,27,'73937,74849,75771,76705,77651,78608,79577,80567'),(62,1,28,'80760,81756,82764,83784,84817,85862,86921,87993'),(63,1,29,'88214,89301,90402,91516,92644,93786,94943,96113'),(64,1,30,'96354,97543,98745,99962,101195,102442,103705,104984'),(65,1,31,'117086,118623,120180,121758,123356,124975,126616,128278'),(66,1,32,'135376,137174,138996,140843,142714,144610,146531,148478'),(67,1,33,'160924,165752'),(68,2,1,'9981,10072,10165,10258,10352,10453,10543,10640'),(69,2,2,'10667,10761,10856,10952,11049,11147,11245,11345'),(70,2,3,'11387,11488,11589,11691,11795,11899,12004,12110'),(71,2,4,'12155,12262,12371,12480,12591,12702,12814,12927'),(72,2,5,'12975,13117,13206,13322,13440,13559,13679,13799'),(73,2,6,'13851,13973,14096,14221,14347,14474,14602,14731'),(74,2,7,'14785,14916,15048,15181,15315,15450,15587,15725'),(75,2,8,'15818,15969,16121,16275,16430,16586,16744,16903'),(76,2,9,'16986,17142,17299,17458,17618,17780,17943,18108'),(77,2,10,'18217,18385,18553,18724,18896,19095,19244,19421'),(78,2,11,'19620,19853,20088,20326,20567,20811,21058,21307'),(79,2,12,'21387,21626,21868,22113,22361,22611,22864,23120'),(80,2,13,'23257,23517,23780,24047,24315,24587,24863,25141'),(81,2,14,'25290,25573,25859,26149,26441,26737,27036,27339'),(82,2,15,'27565,27887,28214,28544,28877,29214,29557,29902'),(83,2,16,'30044,30396,30751,31111,31474,31843,32215,32592'),(84,2,17,'32747,33131,33518,33909,34306,34707,35113,35524'),(85,2,18,'35693,36111,36532,36960,37392,37829,38272,38719'),(86,2,19,'39151,39685,40227,40776,41333,41898,42470,43051'),(87,2,20,'43250,43841,44440,45047,45662,46285,46917,47559'),(88,2,21,'47779,48432,49094,49764,50443,51132,51831,52539'),(89,2,22,'52783,53503,54234,54975,55726,56487,57258,58040'),(90,2,23,'58310,59106,59913,60732,61561,62402,63255,64118'),(91,2,24,'64416,65296,66187,67092,68008,68937,69878,70832'),(92,2,25,'71476,72452,73441,74444,75461,76491,77536,78595'),(93,2,26,'78960,80039,81132,82240,83363,84502,85657,86825'),(94,2,27,'87229,88420,89628,90852,92093,93351,94625,95925'),(95,2,28,'96363,97679,99013,100366,101736,103126,104534,105962'),(96,2,29,'106454,107908,109382,110875,112390,113925,115481,117058'),(97,2,30,'117601,119208,120836,122486,124159,125855,127573,129316'),(98,2,31,'152325,154649,157008,159404,161836,164305,166812,169357'),(99,2,32,'177929,180700,183513,186372,189274,192221,195215,198255'),(100,2,33,'215804,222278'),(101,4,1,'11068,11160,11254,11348,11443,11538,11635,11732'),(102,4,2,'11761,11851,11942,12034,12126,12219,12313,12407'),(103,4,3,'12466,12562,12658,12756,12854,12952,13052,13152'),(104,4,4,'13214,13316,13418,13521,13625,13729,13835,13941'),(105,4,5,'14007,14115,14223,14332,14442,14553,14665,14777'),(106,4,6,'14847,14961,15076,15192,15309,15426,15545,15664'),(107,4,7,'15738,15859,15981,16104,16227,16352,16477,16604'),(108,4,8,'16758,16910,17063,17217,17372,17529,17688,17848'),(109,4,9,'17975,18125,18277,18430,18584,18739,18896,19054'),(110,4,10,'19233,19394,19556,19720,19884,20051,20218,20387'),(111,4,11,'20754,21038,21327,21619,21915,22216,22520,22829'),(112,4,12,'22938,23222,23510,23801,24096,24395,24697,25003'),(113,4,13,'25232,25545,25861,26181,26506,26834,27166,27503'),(114,4,14,'27755,28099,28447,28800,29156,29517,29883,30253'),(115,4,15,'30531,30909,31292,31680,32072,32469,32871,33279'),(116,4,16,'33584,34000,34421,34847,35279,35716,36159,36606'),(117,4,17,'36942,37400,37863,38332,38807,39288,39774,40267'),(118,4,18,'40637,41140,41650,42165,42688,43217,43752,44294'),(119,4,19,'45269,46008,46759,47522,48298,49086,49888,50702'),(120,4,20,'51155,51989,52838,53700,54577,55468,56373,57293'),(121,4,21,'57805,58748,59707,60681,61672,62678,63701,64741'),(122,4,22,'65319,66385,67469,68570,69689,70827,71983,73157'),(123,4,23,'73811,75015,76240,77484,78749,80034,81340,82668'),(124,4,24,'83406,84767,86151,87557,88986,90439,91915,93415'),(125,4,25,'95083,96635,98212,99815,101444,103100,104783,106493'),(126,4,26,'107444,109197,110980,112791,114632,116503,118404,120337'),(127,4,27,'121411,123393,125407,127454,129534,131648,133797,135981'),(128,4,28,'137195,139434,141710,144023,146373,148763,151191,153658'),(129,4,29,'155030,157561,160132,162746,165402,168102,170845,173634'),(130,4,30,'175184,178043,180949,183903,186904,189955,193055,196206'),(131,4,31,'257809,262844,267978,273212,278549,283989,289536,295191'),(132,4,32,'307365,313564,319887,326338,332919,339633,346483,353470'),(133,4,33,'388096,399739'),(134,6,1,'12034,12134,12236,12339,12442,12545,12651,12756'),(135,6,2,'12790,12888,12987,13087,13187,13288,13390,13493'),(136,6,3,'13572,13677,13781,13888,13995,14101,14210,14319'),(137,6,4,'14400,14511,14622,14735,14848,14961,15077,15192'),(138,6,5,'15275,15393,15511,15630,15750,15871,15993,16115'),(139,6,6,'16200,16325,16450,16577,16704,16832,16962,17092'),(140,6,7,'17179,17311,17444,17578,17713,17849,17985,18124'),(141,6,8,'18251,18417,18583,18751,18920,19091,19264,19438'),(142,6,9,'19552,19715,19880,20046,20214,20382,20553,20725'),(143,6,10,'21205,21382,21561,21741,21923,22106,22291,22477'),(144,6,11,'23877,24161,24450,24742,25038,25339,25643,25952'),(145,6,12,'26052,26336,26624,26915,27210,27509,27811,28117'),(146,6,13,'28276,28589,28905,29225,29550,29878,30210,30547'),(147,6,14,'30799,31143,31491,31844,32200,32561,32927,33297'),(148,6,15,'33575,33953,34336,34724,35116,35513,35915,36323'),(149,6,16,'36628,37044,37465,37891,38323,38760,39203,39650'),(150,6,17,'39986,40444,40907,41376,41851,42332,42818,43311'),(151,6,18,'43681,44184,44694,45209,45732,46261,46796,47338'),(152,6,19,'48313,49052,49803,50566,51342,52130,52932,53746'),(153,6,20,'54251,55085,55934,56796,57673,58564,59469,60389'),(154,6,21,'60901,61844,62803,63777,64768,65774,66797,67837'),(155,6,22,'68415,69481,70565,71666,72785,73923,75079,76253'),(156,6,23,'76907,78111,79336,80583,81899,83235,84594,85975'),(157,6,24,'86742,88158,89597,91059,92545,94057,95592,97152'),(158,6,25,'98886,100500,102140,103808,105502,107224,108974,110753'),(159,6,26,'111742,113565,115419,117303,119217,121163,123140,125150'),(160,6,27,'126267,128329,130423,132552,134715,136914,139149,141420'),(161,6,28,'142683,145011,147378,149784,152228,154714,157239,159804'),(162,6,29,'161231,163863,166537,169256,172018,174826,177679,180579'),(163,6,30,'182191,185165,188187,191259,194380,197553,200777,204054'),(164,6,31,'268121,273358,278697,284140,289691,295349,301117,306999'),(165,6,32,'319660,326107,332682,339392,346236,353218,360342,367609'),(166,6,33,'403620,415728'),(167,7,1,'12517,12621,12728,12834,12941,13049,13159,13268'),(168,7,2,'13305,13406,13509,13613,13718,13823,13929,14035'),(169,7,3,'14125,14234,14343,14454,14565,14676,14790,14903'),(170,7,4,'14993,15109,15224,15341,15459,15577,15698,15818'),(171,7,5,'15909,16032,16155,16279,16404,16530,16657,16784'),(172,7,6,'16877,17007,17137,17269,17402,17535,17670,17806'),(173,7,7,'17899,18037,18176,18315,18455,18598,18740,18884'),(174,7,8,'18998,19170,19343,19518,19694,19872,20052,20233'),(175,7,9,'20340,20509,20681,20854,21029,21204,21382,21561'),(176,7,10,'22190,22376,22563,22752,22942,23134,23327,23522'),(177,7,11,'25439,25723,26012,26304,26600,26901,27205,27514'),(178,7,12,'27608,27892,28180,28471,28766,29065,29367,29673'),(179,7,13,'29798,30111,30427,30747,31072,31400,31732,32069'),(180,7,14,'32321,32665,33013,33366,33722,34083,34449,34819'),(181,7,15,'35097,35475,35858,36246,36638,37035,37437,37845'),(182,7,16,'38150,38566,38987,39413,39845,40282,40725,41172'),(183,7,17,'41508,41966,42429,42898,43373,43854,44340,44833'),(184,7,18,'45203,45706,46216,46731,47254,47783,48318,48860'),(185,7,19,'49835,50574,51325,52088,52864,53652,54454,55268'),(186,7,20,'55799,56633,57482,58344,59221,60112,61017,61937'),(187,7,21,'62449,63392,64351,65325,66316,67322,68345,69385'),(188,7,22,'69963,71029,72113,73214,74333,75471,76627,77801'),(189,7,23,'78455,79659,80884,82133,83474,84836,86220,87628'),(190,7,24,'88410,89853,91320,92810,94325,95865,97430,99020'),(191,7,25,'100788,102433,104105,105804,107531,109286,111070,112883'),(192,7,26,'113891,115749,117639,119558,121510,123493,125508,127557'),(193,7,27,'128696,130797,132931,135101,137306,139547,141825,144140'),(194,7,28,'145427,147800,150213,152664,155155,157689,160262,162877'),(195,7,29,'164332,167015,169740,172511,175326,178188,181096,184052'),(196,7,30,'185695,188726,191806,194937,198118,201352,204638,207978'),(197,7,31,'273278,278615,284057,289605,295262,301028,306908,312902'),(198,7,32,'325807,332378,339080,345918,352894,360011,367272,374678'),(199,7,33,'411382,423723'),(200,8,1,'13000,13109,13219,13329,13441,13553,13666,13780'),(201,8,2,'13819,13925,14032,14140,14248,14357,14468,14578'),(202,8,3,'14678,14792,14905,15020,15136,15251,15369,15486'),(203,8,4,'15586,15706,15827,15948,16071,16193,16318,16443'),(204,8,5,'16543,16671,16799,16928,17057,17189,17321,17453'),(205,8,6,'17553,17688,17824,17962,18100,18238,18379,18520'),(206,8,7,'18620,18763,18907,19053,19198,19346,19494,19644'),(207,8,8,'19744,19923,20104,20285,20468,20653,20840,21029'),(208,8,9,'21129,21304,21483,21663,21844,22026,22210,22396'),(209,8,10,'23176,23370,23565,23762,23961,24161,24363,24567'),(210,8,11,'27000,27284,27573,27865,28161,28462,28766,29075'),(211,8,12,'29165,29449,29737,30028,30323,30622,30924,31230'),(212,8,13,'31320,31633,31949,32269,32594,32922,33254,33591'),(213,8,14,'33843,34187,34535,34888,35244,35605,35971,36341'),(214,8,15,'36619,36997,37380,37768,38160,38557,38959,39367'),(215,8,16,'39672,40088,40509,40935,41367,41804,42247,42694'),(216,8,17,'43030,43488,43951,44420,44895,45376,45862,46355'),(217,8,18,'46725,47228,47738,48253,48776,49305,49840,50382'),(218,8,19,'51357,52096,52847,53610,54386,55174,55976,56790'),(219,8,20,'57347,58181,59030,59892,60769,61660,62565,63485'),(220,8,21,'63997,64940,65899,66873,67864,68870,69893,70933'),(221,8,22,'71511,72577,73661,74762,75881,77019,78175,79349'),(222,8,23,'80003,81207,82432,83683,85049,86437,87847,89281'),(223,8,24,'90078,91548,93043,94562,96105,97674,99268,100888'),(224,8,25,'102690,104366,106069,107800,109560,111348,113166,115012'),(225,8,26,'116040,117933,119858,121814,123803,125823,127876,129964'),(226,8,27,'131124,133264,135440,137650,139897,142180,144501,146859'),(227,8,28,'148171,150589,153047,155545,158083,160664,163286,165951'),(228,8,29,'167432,170166,172943,175766,178634,181550,184513,187525'),(229,8,30,'189199,192286,195425,198615,201856,205151,208499,211902'),(230,8,31,'278434,283872,289416,295069,300833,306708,312699,318806'),(231,8,32,'331954,338649,345478,352445,359553,366804,374202,381748'),(232,8,33,'419144,431718'),(233,5,1,'11551,11647,11745,11843,11942,12042,12143,12244'),(234,5,2,'12276,12369,12464,12560,12657,12754,12852,12950'),(235,5,3,'13019,13119,13220,13322,13424,13527,13631,13736'),(236,5,4,'13807,13914,14020,14128,14236,14345,14456,14567'),(237,5,5,'14641,14754,14867,14981,15096,15212,15329,15446'),(238,5,6,'15524,15643,15763,15884,16007,16129,16253,16378'),(239,5,7,'16458,16585,16713,16841,16970,17101,17231,17364'),(240,5,8,'17505,17663,17823,17984,18146,18310,18476,18643'),(241,5,9,'18763,18920,19078,19238,19399,19561,19725,19890'),(242,5,10,'20219,20388,20558,20731,20903,21079,21254,21432'),(243,5,11,'22316,22600,22889,23181,23477,23778,24082,24391'),(244,5,12,'24495,24779,25067,25358,25653,25952,26254,26560'),(245,5,13,'26754,27067,27383,27703,28028,28356,28688,29025'),(246,5,14,'29277,29621,29969,30322,30678,31039,31405,31775'),(247,5,15,'32053,32431,32814,33202,33594,33991,34393,34801'),(248,5,16,'35106,35522,35943,36369,36801,37238,37681,38128'),(249,5,17,'38464,38922,39385,39854,40329,40810,41296,41789'),(250,5,18,'42159,42662,43172,43687,44210,44739,45274,45816'),(251,5,19,'46791,47530,48281,49044,49820,50608,51410,52224'),(252,5,20,'52703,53537,54386,55248,56125,57016,57921,58841'),(253,5,21,'59353,60296,61255,62229,63220,64226,65249,66289'),(254,5,22,'66867,67933,69017,70118,71237,72375,73531,74705'),(255,5,23,'75359,76563,77788,79034,80324,81635,82967,84321'),(256,5,24,'85074,86462,87874,89308,90766,92248,93753,95283'),(257,5,25,'96985,98568,100176,101811,103473,105162,106879,108623'),(258,5,26,'109593,111381,113200,115047,116925,118833,120772,122744'),(259,5,27,'123839,125861,127915,130003,132125,134281,136473,138701'),(260,5,28,'139939,142223,144544,146903,149300,151738,154215,156731'),(261,5,29,'158131,160712,163335,166001,168710,171464,174262,177107'),(262,5,30,'178688,181604,184568,187581,190642,193754,196916,200130'),(263,5,31,'262965,268101,273338,278676,284120,289669,295327,301095'),(264,5,32,'313512,319835,326285,332865,339577,346426,353413,360539'),(265,5,33,'395858,407734');

ALTER TABLE `tbl_salary_grade` ENABLE KEYS;
UNLOCK TABLES;
COMMIT;


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;

