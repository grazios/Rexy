DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
`id` int(11) NOT NULL,
  `provider` varchar(64) NOT NULL,
  `oauth_id` varchar(128) NOT NULL,
  `name` varchar(128) NOT NULL,
  `mail` varchar(128) NOT NULL,
  `photo` varchar(128) NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


ALTER TABLE `users`
 ADD PRIMARY KEY (`id`);

ALTER TABLE `users`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
