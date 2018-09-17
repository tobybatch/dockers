<?php
# php -f dbtest.php

$DATABASE_URL = $argv[1];

if (strpos($DATABASE_URL, 'mysql') === 0) {
    $url = parse_url($DATABASE_URL);
    $dbscheme = $url['scheme'];
    $dbhost = $url['host'];
    $dbuser = $url['user'];
    $dbpass = $url['pass'];
    $dbname = substr($url['path'], 1);

    $connection = new PDO("mysql:dbname=$dbname;host=$dbhost", $dbuser, $dbpass);
    $stmt = $connection->query("SHOW TABLES");
    echo $stmt->rowCount();
    exit;
}
elseif (strpos($DATABASE_URL, 'sqlite') === 0) {
    $connection = new PDO("$DATABASE_URL");
    $stmt = $connection->query("SELECT  `name` FROM sqlite_master WHERE `type`='table' ORDER BY name");
    echo $stmt->rowCount();
    exit;
}

die('Unknown SQL scheme');

