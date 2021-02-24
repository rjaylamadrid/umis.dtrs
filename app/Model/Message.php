<?php
namespace Model;

use Database\DB;

class Message {
    private $no;
	private $from;
	private $to;
	private $text;
	private $created_on;
	private $user;
	private $status;


	public function setNo($no){$this->no = $no;}
	function getNo(){return $this->no;}

	function setFrom($from){$this->from = $from;}
	function getFrom(){return $this->from;}

    function setTo($to){$this->to = $to;}
    function getTo(){return $this->to;}

	function setText($text){$this->text = $text;}
	function getText(){return $this->text;}

	function setCreatedOn($created_on){$this->created_on = $created_on;}
	function getCreatedOn(){return $this->created_on;}

	function setStatus($status){$this->status = $status;}
	function getStatus(){return $this->status;}

	public function __construct () {
        
    }

	function saveMessage()
	{
        DB::insert ("INSERT INTO tbl_messages VALUES(null,".$this->from.",".$this->to.",'".$this->text."','".$this->created_on."',".$this->status.")");
	}

    function getAllMessagesData()
	{
		return $messages =  DB::fetch_all ("SELECT * FROM tbl_messages WHERE `from` = ".$this->from." AND `to` = ".$this->to."  OR `from` = ".$this->to."  AND `to` = ".$this->from);
	}

	function getLastMessagesData()
	{
		return $messages =  DB::fetch_all ("SELECT * FROM tbl_messages WHERE `from` = ".$this->from." AND `to` = ".$this->to."  OR `from` = ".$this->to."  AND `to` = ".$this->from." ORDER BY no DESC LIMIT 1");
	}

    function getAllEmployeeData()
	{
		return $employees = DB::fetch_all ("SELECT a.no, first_name, last_name, employee_picture, email_address, campus_name FROM tbl_employee a, tbl_employee_status b, tbl_campus c WHERE a.no = b.employee_id AND b.campus_id = c.id AND b.is_active = 1 ORDER BY c.id ASC");
	}

    function getSelectEmployeeData()
	{
		return $employee = DB::fetch_all ("SELECT no, first_name, last_name, employee_picture, email_address FROM tbl_employee WHERE no = ".$this->to);
	}

	function countUnseenMessageData()
	{
		return $unseen =  DB::fetch_all ("SELECT COUNT(`status`) AS cnt_unseen FROM tbl_messages WHERE `from` = ".$this->from."  AND `to` = ".$this->to." AND `status` = 1 ");
	}

	function cntUnseenMsg()
	{
		//$employees = DB::fetch_all ("SELECT a.no FROM tbl_employee a, tbl_employee_status b, tbl_campus c WHERE a.no = b.employee_id AND b.campus_id = c.id AND b.is_active = 1 ORDER BY c.id ASC");
		$employees = $this->getAllEmployeeData();
		$index = 0;
		foreach($employees as $employee ){
			$result[$index] = DB::fetch_all ("SELECT `from`, SUM(`status`) AS cnt_unseen FROM tbl_messages WHERE `from` = ". $employee['no'] . " AND `to` = ". $this->from . " GROUP BY `from`");
			if($result[$index] == []){
				$result[$index][0] = ['from' => $employee['no'], 'cnt_unseen' => 0];
			}else{

			}
			$index++;
		}
		$result[$index] = DB::fetch_all ("SELECT SUM(`status`) AS tlt_unseen FROM tbl_messages WHERE `to` = ". $this->from);
		return $result;
		//return $unseen =  DB::fetch_all ("SELECT COUNT(`status`) AS cnt_unseen FROM tbl_messages WHERE `from` = ".$this->from. " AND `status` = 1 ");
	}

	function updateMessageStatusData()
	{
		return $result = DB::update ("UPDATE tbl_messages SET `status` = ".$this->status." WHERE `from` = ".$this->from." AND `to` = ".$this->to);
	}

	function getRecentConvoData() {
		return $result = DB::fetch_all("SELECT * FROM tbl_messages a, tbl_employee b, (SELECT `to`, MAX(`created_on`) `created_on` FROM tbl_messages WHERE `from` = ".$this->from." GROUP BY `to`) c WHERE a.to = c.to AND a.created_on = c.created_on AND a.to = b.no AND a.from = ".$this->from." GROUP BY a.to ORDER BY a.created_on DESC");
	}
}