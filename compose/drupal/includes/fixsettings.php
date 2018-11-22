<?php

// Do this first while variable space is still clean.
$app_root = 'foo';
$site_path = 'bar';
require $argv[1];
$keys = array_diff(array_keys(get_defined_vars()), [ '_GET', '_POST', '_COOKIE', '_FILES', 'argv', 'argc', '_ENV', '_REQUEST', '_SERVER', 'app_root', 'site_path']);

$new_settings = [];
$settings_file = $argv[1];

$dbname = $argv[2];
$dbuser = $argv[3];
$dbpass = $argv[4];
$dbhost = $argv[5];

$mask = [
    'default' => [
        'default' => [
            'database' => $dbname,
            'username' => $dbuser,
            'password' => $dbpass,
            'host' => $dbhost,
            'port' => '',
            'driver' => 'mysql',
            'prefix' => '',
        ]
    ],
];

if (!isset($databases)) {
    $databases = [];
}
$databases = array_merge($databases, $mask);

$new_settings[] = "<?php" ;
$new_settings[] = "" ;
$new_settings[] = "// Variables" ;

foreach ($keys as $key) {
    $new_settings[] = '$' . $key . ' = ' . var_export($$key, true) . ";\n";
}
$new_settings[] = "// ini_sets\n";

$file = file_get_contents($argv[1]);
# print_r(array_keys(get_defined_vars()));';
$allline = str_replace("\n", '', $file);
$lines = explode("\n", str_replace(';', ";\n", $allline));
foreach ($lines as $line) {
    if (strpos($line, 'ini_set') === 0) {
        $new_settings[] = $line;
    }
}

copy($settings_file, basename($settings_file) . '.orig.php');
$fh = fopen($settings_file, 'w');
fwrite($fh, implode("\n", $new_settings));
fclose($fh);
