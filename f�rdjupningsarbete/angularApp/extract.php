<?php
	$url = "http://systemetapi.se/product.json?type=Alkoholfritt,%20Vatten&order_by=price&order=ASC";
	$data = file_get_contents($url);
	echo $data;
?>