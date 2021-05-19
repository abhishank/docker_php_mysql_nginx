<?php
echo "<pre>";
//mysql connection test
$servername = "mysql";
$username = "root";
$password = "root";
$dbname = "fe_db";

try {
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    // set the PDO error mode to exception
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    echo "Mysql Connected successfully";
} catch (PDOException $e) {
    echo "Connection failed: " . $e->getMessage();
    print_r($e->errorInfo);
}

//Elastic connection test
echo "<br><br><br>";
//curl -X GET "elasticsearch:9200/_cluster/health"
$user_agent = 'Mozilla HotFox 1.0';
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, "http://elasticsearch:9200/");
curl_setopt($ch, CURLOPT_USERAGENT, $user_agent);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
curl_setopt($ch, CURLOPT_HEADER, 0);
curl_setopt($ch, CURLOPT_NOBODY, 0);
curl_setopt($ch, CURLOPT_TIMEOUT, 30);
$res = curl_exec($ch);
curl_close($ch);
echo "Elastic response" . PHP_EOL;
var_dump($res);

//php details
phpinfo();
