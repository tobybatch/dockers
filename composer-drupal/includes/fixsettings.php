<?php

$mask = [
    'default' => [
        'default' => [
            'database' => $argv[2],
            'username' => $argv[3],
            'password' => $argv[4],
            'host' => $argv[5],
            'port' => '',
            'driver' => 'mysql',
            'prefix' => '',
        ]
    ],
];

require $argv[1];
if (!isset($databases)) {
    $databases = [];
}
$databases = array_merge($databases, $mask);
unset($mask);
$keys = array_diff(array_keys(get_defined_vars()), [ '_GET', '_POST', '_COOKIE', '_FILES', 'argv', 'argc', '_ENV', '_REQUEST', '_SERVER']);

echo "<?php\n\n// Variables\n" ;

foreach ($keys as $key) {
    echo '$' . $key . ' = ' . var_export($$key, true) . ";\n";
}
echo "// ini_sets\n";

$file = file_get_contents($argv[1]);
# print_r(array_keys(get_defined_vars()));';
$allline = str_replace("\n", '', $file);
$lines = explode("\n", str_replace(';', ";\n", $allline));
foreach ($lines as $line) {
    if (strpos($line, 'ini_set') === 0) {
        echo $line . "\n";
    }
}
