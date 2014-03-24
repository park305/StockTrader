<?php

$capital = 10000;
$transcost = 5;
$return = .03;

for($i=0;$i<12;$i++) {

$newcap = ($capital+ ($capital * $return)) - ($transcost*2);
$capital = $newcap;
}

print $capital;

?>