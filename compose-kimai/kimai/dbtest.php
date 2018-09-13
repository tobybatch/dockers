<?php
# php -f dbtest.php

$DATABASE_URL = $argv[1];

$url = parse_url($DATABASE_URL);

$dbscheme = $url['scheme'];
$dbhost = $url['host'];
$dbuser = $url['user'];
$dbpass = $url['pass'];
$dbname = substr($url['path'], 1);
$connection = new PDO("mysql:dbname=$dbname;host=$dbhost", $dbuser, $dbpass);

$stmt = $connection->query("SHOW TABLES");
echo $stmt->rowCount();

