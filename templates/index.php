 <?php
if (isset($payments_on_date)) {
	if ($payments_on_date != '[]') {
		print_r($payments_on_date);
	} else {
		echo 'No payments in such day';
	}
}
?>