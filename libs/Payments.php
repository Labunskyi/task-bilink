<?php
include_once "./config.php";

class Payments 
{
	private $connection;
	
	function __construct() {
		$this->connection = new PDO ('mysql:host='.HOST.'; dbname='.DB_NAME.';charset=utf8', USER, PASSWORD);
	}
	
	// create a single payment
	
	public function createPayment($amount, $paymentSystemId) {
		
		if ( !is_numeric($amount) || $amount < 0 || !$paymentSystemId || $paymentSystemId < 0){
            return false;
        } else {
			$this->query = "INSERT INTO payments (`amount`, `payment_system_id`)
				VALUES ('$amount', '$paymentSystemId')"; 
				
			$result = $this->connection->query($this->query) ;
			return true;
		}
	}
	
	// get all payments by single date
	
	public function getPayments($payDate) {
		try {
			$this->query = "SELECT payments.id, payments.amount, payments.payment_system_id, payments.payment_date, payment_systems.name
			FROM payments 
			INNER JOIN payment_systems ON payments.payment_system_id = payment_systems.id 
			WHERE DATE(payments.payment_date) = '$payDate' ORDER BY payments.id ASC";
			
			$result = $this->connection->query($this->query) ;
			
			$data = array ();
				while ($row = $result->fetch(PDO::FETCH_OBJ) ) {
					$data[] = $row;
				}
			return json_encode($data);
		} catch(Exception $e) {
            throw new Exception($e->getMessage());
        }
	}
	
	// create a report by single day
	
	public function createReport($reportDate) {
		
		$data = $this->getPeymentsByPaySystem($reportDate);
		if (!(empty($data))) {
			foreach ($data as $date) {
				$payment_system_id = $date['id'];
				$amount = $date['amount'];
				$commission = $date['commission'];
				$total_commission = $amount * $commission * 0.01;
				
				$this->query = "INSERT INTO payment_reports (`date`, `payment_system_id`, `amount`, `commission`)
					VALUES ('$reportDate', '$payment_system_id', '$amount', '$total_commission') ON DUPLICATE KEY UPDATE
					`payment_system_id` = '$payment_system_id', `amount` = '$amount', `commission` = '$total_commission'"; 
					
				$result = $this->connection->query($this->query) ;
				
			}
			return true;
		} 
		return false;
	}
	
	// get payments by pay system
	
	private function getPeymentsByPaySystem($reportDate) {
		
		$this->query = "select * from (select * from payments where date(payment_date) = '$reportDate' group by payment_system_id) as x right join payment_systems on x.payment_system_id = payment_systems.id";	
		$result = $this->connection->query($this->query) ;
			
		$data = array ();
			while ($row = $result->fetch(PDO::FETCH_ASSOC) ) {
				$data[] = $row;
			}
		return $data;
	}
	
	
}

$payments = new Payments();
