<?php
include_once 'libs/Payments.php';

$payments_on_date = $payments->getPayments('2017-11-07');

$create_payment = $payments->createPayment(200, 3);

$create_report = $payments->createReport('2019-10-02');



include_once 'templates/index.php';

?>
