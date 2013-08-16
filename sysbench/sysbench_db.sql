/* creating the schema for sysbench test */
DROP SCHEMA IF EXISTS `sysbench_test`;
CREATE SCHEMA `sysbench_test`;
USE `sysbench_test`;

/* creating table bench_config */
DROP TABLE IF EXISTS `bench_config`;
CREATE TABLE `bench_config` (
  `config_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/* creating table bench_runs */
DROP TABLE IF EXISTS `bench_runs`;
CREATE TABLE `bench_runs` (
  `run_id` int(11) NOT NULL AUTO_INCREMENT,
  `config_id` int(11) NOT NULL,
  `server` varchar(20) NOT NULL,
  `version` varchar(60) DEFAULT NULL,
  `run_date` datetime NOT NULL,
  PRIMARY KEY (`run_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*  creating table sysbench_run_iterations */
DROP TABLE IF EXISTS `sysbench_run_iterations`;
CREATE TABLE `sysbench_run_iterations` (
  `run_id` int(11) NOT NULL,
  `concurrency` int(11) NOT NULL,
  `iteration` int(11) NOT NULL,
  `tps` decimal(13,2) NOT NULL,
  `read_write_req_per_second` decimal(13,2) NOT NULL,
  `deadlocks_per_second` decimal(5,2) NOT NULL,
  `min_req_latency_ms` decimal(10,2) NOT NULL,
  `avg_req_latency_ms` decimal(10,2) NOT NULL,
  `max_req_latency_ms` decimal(10,2) NOT NULL,
  `95p_req_latency_ms` decimal(10,2) NOT NULL,
  PRIMARY KEY (`run_id`,`concurrency`,`iteration`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
