CREATE TABLE users (
    `id` int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `username` varchar(64) NOT NULL,
    `password` varchar(64) NOT NULL,
    `login_times` int NOT NULL DEFAULT 0,
    `online_time` int NOT NULL DEFAULT 0,
    `creatd_at` datetime,
    `last_mod` datetime,
    INDEX `idx_users_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

