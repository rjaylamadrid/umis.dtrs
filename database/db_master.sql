-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.11-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for db_master
CREATE DATABASE IF NOT EXISTS `db_master` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `db_master`;

-- Dumping structure for table db_master.tbl_campus
CREATE TABLE IF NOT EXISTS `tbl_campus` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `campus_name` char(100) NOT NULL,
  `campus_code` varchar(30) NOT NULL,
  `campus_address` text DEFAULT NULL,
  `campus_telephone` tinytext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_department
CREATE TABLE IF NOT EXISTS `tbl_department` (
  `no` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `department_code` char(8) NOT NULL,
  `department_desc` varchar(50) DEFAULT NULL,
  `campus_id` tinyint(4) DEFAULT NULL,
  `is_project` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_dtr_code
CREATE TABLE IF NOT EXISTS `tbl_dtr_code` (
  `no` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `dtr_code` char(20) NOT NULL,
  `dtr_code_desc` char(255) NOT NULL,
  `payable` enum('0','1') NOT NULL DEFAULT '0',
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_employee
CREATE TABLE IF NOT EXISTS `tbl_employee` (
  `no` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` char(20) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `ext_name` varchar(5) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `birthplace` varchar(255) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `citizenship` varchar(50) DEFAULT NULL,
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
  `employee_picture` text DEFAULT NULL,
  `father_last_name` varchar(50) DEFAULT NULL,
  `father_first_name` varchar(50) DEFAULT NULL,
  `father_ext_name` varchar(5) DEFAULT NULL,
  `father_middle_name` varchar(50) DEFAULT NULL,
  `mother_last_name` varchar(50) DEFAULT NULL,
  `mother_first_name` varchar(50) DEFAULT NULL,
  `mother_middle_name` varchar(50) DEFAULT NULL,
  `spouse_last_name` varchar(50) DEFAULT NULL,
  `spouse_first_name` varchar(50) DEFAULT NULL,
  `spouse_ext_name` varchar(5) DEFAULT NULL,
  `spouse_middle_name` varchar(50) DEFAULT NULL,
  `spouse_work` varchar(50) DEFAULT NULL,
  `spouse_employer` varchar(255) DEFAULT NULL,
  `spouse_address` varchar(255) DEFAULT NULL,
  `spouse_telephone_no` varchar(20) DEFAULT NULL,
  `email_address` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`no`),
  UNIQUE KEY `EmployeeID` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_employee_dependent
CREATE TABLE IF NOT EXISTS `tbl_employee_dependent` (
  `no` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` char(20) DEFAULT NULL,
  `childname` varchar(100) DEFAULT NULL,
  `childbirth` date DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_employee_education
CREATE TABLE IF NOT EXISTS `tbl_employee_education` (
  `no` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` char(20) DEFAULT NULL,
  `level` enum('Elementary','Secondary','Vocational','College','Graduate Studies') NOT NULL,
  `school_name` varchar(100) DEFAULT NULL,
  `school_address` varchar(100) DEFAULT NULL,
  `school_degree` varchar(30) DEFAULT NULL,
  `year_graduated` varchar(4) DEFAULT NULL,
  `period_from` date DEFAULT NULL,
  `period_to` date DEFAULT NULL,
  `highest_level` varchar(50) DEFAULT NULL,
  `academic_honor` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_employee_eligibility
CREATE TABLE IF NOT EXISTS `tbl_employee_eligibility` (
  `no` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` char(20) DEFAULT NULL,
  `eligibility_name` varchar(100) DEFAULT NULL,
  `eligibility_rating` double DEFAULT 0,
  `eligibility_date_exam` date DEFAULT NULL,
  `eligibility_place_exam` char(255) DEFAULT NULL,
  `eligibility_license` char(20) DEFAULT NULL,
  `eligibility_validity` date DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_employee_employment
CREATE TABLE IF NOT EXISTS `tbl_employee_employment` (
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_employee_log
CREATE TABLE IF NOT EXISTS `tbl_employee_log` (
  `emp_id` char(20) NOT NULL,
  `action_id` int(11) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_employee_other
CREATE TABLE IF NOT EXISTS `tbl_employee_other` (
  `no` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(50) DEFAULT NULL,
  `other_skill` varchar(255) DEFAULT NULL,
  `other_recognition` varchar(255) DEFAULT NULL,
  `other_organization` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_employee_reference
CREATE TABLE IF NOT EXISTS `tbl_employee_reference` (
  `no` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` char(20) DEFAULT NULL,
  `reference_name` varchar(100) DEFAULT NULL,
  `reference_position` varchar(30) DEFAULT NULL,
  `reference_address` varchar(100) DEFAULT NULL,
  `reference_contact` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_employee_status
CREATE TABLE IF NOT EXISTS `tbl_employee_status` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` char(15) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `privilege` smallint(6) DEFAULT NULL,
  `sched_code` char(10) DEFAULT NULL,
  `department_id` char(8) DEFAULT NULL,
  `campus_id` int(11) NOT NULL,
  `active_status` tinyint(2) DEFAULT NULL,
  `date_start` date NOT NULL,
  `date_end` date DEFAULT NULL,
  `position_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_employee_training
CREATE TABLE IF NOT EXISTS `tbl_employee_training` (
  `no` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(50) DEFAULT NULL,
  `training_title` varchar(255) DEFAULT NULL,
  `training_from` date DEFAULT NULL,
  `training_to` date DEFAULT NULL,
  `training_hours` int(11) DEFAULT 0,
  `training_type` char(50) NOT NULL,
  `training_sponsor` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_employee_type
CREATE TABLE IF NOT EXISTS `tbl_employee_type` (
  `etype_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `etype_desc` char(100) NOT NULL,
  `isTeaching` tinyint(2) NOT NULL,
  `jo` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`etype_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_employee_update_request
CREATE TABLE IF NOT EXISTS `tbl_employee_update_request` (
  `update_request_id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` char(20) DEFAULT NULL,
  `update_request_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_request_date2` timestamp NULL DEFAULT NULL,
  `update_request_column` text DEFAULT NULL,
  `update_request_oldinfo` text DEFAULT NULL,
  `update_request_newinfo` text DEFAULT NULL,
  `update_request_type` tinyint(4) DEFAULT NULL,
  `update_request_status` tinyint(4) DEFAULT 0,
  `update_request_remarks` text DEFAULT NULL,
  `update_request_seen` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`update_request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_employee_voluntary_work
CREATE TABLE IF NOT EXISTS `tbl_employee_voluntary_work` (
  `no` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(50) DEFAULT NULL,
  `organization_name` varchar(255) DEFAULT NULL,
  `date_from` varchar(50) DEFAULT NULL,
  `date_to` varchar(50) DEFAULT NULL,
  `total_hours` int(11) DEFAULT 0,
  `organization_position` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_emp_leave
CREATE TABLE IF NOT EXISTS `tbl_emp_leave` (
  `leave_id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(50) NOT NULL,
  `lv_dateof_filing` date DEFAULT NULL,
  `lv_office` char(100) NOT NULL,
  `lv_type` char(100) NOT NULL,
  `lv_type_others` varchar(150) DEFAULT NULL,
  `lv_where` char(150) DEFAULT NULL,
  `lv_where_specific` varchar(150) DEFAULT NULL,
  `lv_commutation` char(15) NOT NULL,
  `lv_date_fr` date DEFAULT NULL,
  `lv_date_to` date DEFAULT NULL,
  `lv_no_days` int(11) NOT NULL,
  `emp_salary` char(50) NOT NULL,
  `lv_recommendation` char(150) DEFAULT NULL,
  `lv_status` int(1) unsigned zerofill DEFAULT 0,
  `lv_days_with_pay` int(11) DEFAULT NULL,
  `lv_days_without_pay` int(11) DEFAULT NULL,
  `lv_days_others` int(11) DEFAULT NULL,
  `lv_approved_others` char(150) DEFAULT NULL,
  `lv_disapproved_reason` char(150) DEFAULT NULL,
  `response` int(1) unsigned zerofill DEFAULT 0,
  `lv_date_requested` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`leave_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='table for the leave of employees';

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_emp_leave_grant
CREATE TABLE IF NOT EXISTS `tbl_emp_leave_grant` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` char(10) NOT NULL,
  `grant_code` char(50) NOT NULL,
  `grant_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='table for the Employee leave grant';

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_event
CREATE TABLE IF NOT EXISTS `tbl_event` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `event_name` char(255) DEFAULT NULL,
  `event_date` date DEFAULT NULL,
  `event_start` char(20) DEFAULT NULL,
  `event_end` char(20) DEFAULT NULL,
  `dtr_code_id` tinyint(3) DEFAULT NULL,
  `campus_id` tinyint(3) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_fingerprint
CREATE TABLE IF NOT EXISTS `tbl_fingerprint` (
  `fprint_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` char(20) DEFAULT NULL,
  `xml` text NOT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`fprint_id`),
  KEY `fprint_emp_id` (`employee_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_payroll_info
CREATE TABLE IF NOT EXISTS `tbl_payroll_info` (
  `no` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `payroll_info_type` varchar(50) NOT NULL,
  `payroll_info_name` varchar(100) NOT NULL,
  `etype_id` smallint(6) NOT NULL,
  `cam_id` smallint(6) NOT NULL,
  `isMandatory` int(1) DEFAULT 0,
  `isActive` int(1) NOT NULL,
  `payroll_order` int(11) DEFAULT 0,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_payroll_log
CREATE TABLE IF NOT EXISTS `tbl_payroll_log` (
  `payroll_no` char(9) NOT NULL DEFAULT '' COMMENT 'PN-000000',
  `payroll_code` char(15) DEFAULT NULL,
  `payroll_date` date NOT NULL,
  `payroll_startDate` date NOT NULL,
  `payroll_endDate` date NOT NULL,
  `etype_id` smallint(5) NOT NULL,
  PRIMARY KEY (`payroll_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_payroll_log_breakdown
CREATE TABLE IF NOT EXISTS `tbl_payroll_log_breakdown` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payroll_no` char(9) NOT NULL,
  `EmployeeID` varchar(10) NOT NULL,
  `payroll_info_no` int(11) NOT NULL,
  `value` varchar(12) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_payroll_related
CREATE TABLE IF NOT EXISTS `tbl_payroll_related` (
  `no` smallint(5) NOT NULL AUTO_INCREMENT,
  `payroll_info_no` smallint(5) NOT NULL,
  `employee_id` varchar(10) NOT NULL,
  `filter` smallint(1) DEFAULT NULL,
  `value` varchar(350) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_position
CREATE TABLE IF NOT EXISTS `tbl_position` (
  `no` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `position_code` varchar(20) NOT NULL,
  `position_desc` varchar(50) NOT NULL,
  `is_teaching` smallint(6) NOT NULL,
  `salary_grade` smallint(5) NOT NULL,
  `etype_id` tinyint(3) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_privilege
CREATE TABLE IF NOT EXISTS `tbl_privilege` (
  `priv_id` int(11) NOT NULL AUTO_INCREMENT,
  `priv_desc` varchar(150) NOT NULL,
  `priv_level` int(11) NOT NULL,
  PRIMARY KEY (`priv_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_salary_grade
CREATE TABLE IF NOT EXISTS `tbl_salary_grade` (
  `no` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `step_increment` varchar(60) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_schedule
CREATE TABLE IF NOT EXISTS `tbl_schedule` (
  `no` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sched_code` char(10) DEFAULT NULL,
  `weekday` enum('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday') DEFAULT NULL,
  `am_in` time DEFAULT NULL,
  `am_out` time DEFAULT NULL,
  `pm_in` time DEFAULT NULL,
  `pm_out` time DEFAULT NULL,
  PRIMARY KEY (`no`),
  KEY `SchedCode` (`sched_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_schedule_preset
CREATE TABLE IF NOT EXISTS `tbl_schedule_preset` (
  `preset_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sched_code` char(10) NOT NULL,
  `sched_day` char(10) NOT NULL,
  `sched_time` char(255) NOT NULL,
  PRIMARY KEY (`preset_id`),
  KEY `sched_code` (`sched_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_settings
CREATE TABLE IF NOT EXISTS `tbl_settings` (
  `no` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `keyword` char(255) NOT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table db_master.tbl_user_employee
CREATE TABLE IF NOT EXISTS `tbl_user_employee` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` char(11) NOT NULL,
  `employee_username` char(150) DEFAULT NULL,
  `employee_password` text NOT NULL,
  PRIMARY KEY (`no`),
  UNIQUE KEY `emp_id` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='table for the employee side only';

-- Data exporting was unselected.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
