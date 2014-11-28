
<?php

$fp = fopen("playlist.txt", "r+");

if (flock($fp, LOCK_EX)) {
    $contents = fread($fp, filesize("playlist.txt"));
    fflush($fp);
    flock($fp, LOCK_UN);
    echo $contents;
    ftruncate($fp, 0);
}

fclose($fp);

?>

