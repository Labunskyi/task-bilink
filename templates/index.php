 <?php
$x = (array)$payments_on_date;
if (empty($x)) {
	print_r($payments_on_date);
} else {
	echo 'No payments in such day';
}
?>