<?php
namespace Model;

use Database\DB;

class MessageConnection {
    private $no;
	private $resource_id;
	private $user_id;
	private $name;
    private $session_id;

	public function setNo($no){$this->no = $no;}
	function getNo(){return $this->no;}

	function setResourceId($resource_id){$this->resource_id = $resource_id;}
	function getResourceId(){return $this->resource_id;}

    function setUserId($user_id){$this->user_id = $user_id;}
    function getUserId(){return $this->user_id;}

	function setName($first_name, $last_name){$this->name = $first_name. ' ' .$last_name;}
	function getName(){return $this->name;}

    function setSesionId($session_id){$this->session_id = $session_id;}
	function getSesionId(){return $this->session_id;}

	function saveMessageConnection()
	{
        return $result = DB::insert ("INSERT INTO tbl_message_connection VALUES(null,".$this->resource_id.",".$this->user_id.",'".$this->session_id."')");
	}

    function getAllEmployeeData()
	{
		return $employees = DB::fetch_all ("SELECT a.no, first_name, last_name, employee_picture, email_address, campus_name FROM tbl_employee a, tbl_employee_status b, tbl_campus c WHERE a.no = b.employee_id AND b.campus_id = c.id AND b.is_active = 1 ORDER BY c.id ASC");
	}

    function getUser()
	{
		return $user =  DB::fetch_all ("SELECT first_name, last_name FROM tbl_employee WHERE `no` = ".$this->user_id);
	}

    function getAllUserIdData()
	{
        $employees = $this->getAllEmployeeData();
		$index = 0;
		foreach($employees as $employee ){
			$result[$index] = DB::fetch_all ("SELECT user_id FROM tbl_message_connection WHERE user_id = ". $employee['no']);
			if($result[$index] == []){
				$result[$index]= ['no' => $employee['no'], 'active' => 0];
			}else{
                $result[$index]= ['no' => $employee['no'], 'active' => 1];
            }
			$index++;
		}
		return $result;
	}

	function deleteMessageConnection()
	{
		DB::delete ("DELETE FROM tbl_message_connection WHERE `user_id` = ".$this->user_id);
	}
}