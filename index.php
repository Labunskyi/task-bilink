<?php
include_once 'libs/Payments.php';

$payments_on_date = $payments->getPayments('2017-11-08');

$create_payment = $payments->createPayment(200, 3);

$create_report = $payments->createReport('2019-10-01');



include_once 'templates/index.php';

?>
