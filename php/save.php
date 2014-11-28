
<?php

$url = $_POST["url"];
if (strpos($url, "youtube") == 0) {
	echo "Not a valid URL";
	die();
}

$fp = fopen("playlist.txt", "a+");

if (flock($fp, LOCK_EX)) {
    fwrite($fp, $url . "\n");
    fflush($fp);
    flock($fp, LOCK_UN);
} else {
    echo "Couldn't get the lock!";
}

fclose($fp);
echo "Thank you!";

?>

