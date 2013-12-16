<?
    require_once "configuration.php";
    
    $connection_string = sprintf("host=%s port=%d dbname=%s user=%s password=%s",$config["host"],$config["port"],$config["database"],$config["user"],$config["pass"]);
    $conn = pg_connect($connection_string);