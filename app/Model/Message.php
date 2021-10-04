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
		$check = DB::fetch_row("SELECT * FROM tbl_messages WHERE `from` =".$this->from." AND `to` =".$this->to."");
		if(empty($check)){
			DB::insert ("INSERT INTO tbl_messages VALUES(null,".$this->from.",".$this->to.",'".$this->text."','".$this->created_on."',".$this->status.")");
			DB::insert ("INSERT INTO tbl_messages VALUES(null,".$this->to.",".$this->from.",'".null."','".$this->created_on."',".$this->status.")");
		}else{
				$insert = DB::insert ("INSERT INTO tbl_messages VALUES(null,".$this->from.",".$this->to.",'".$this->text."','".$this->created_on."',".$this->status.")");	
		}
					
	}

	function getConversation($sender_id, $receiver_id)
	{
		return $messages =  DB::fetch_all ("SELECT * FROM tbl_messages WHERE `from` = ".$sender_id." AND `to` = ".$receiver_id."  OR `from` = ".$receiver_id."  AND `to` = ".$sender_id);
	}

	function getReceiverInfo($receiver_id){
		return $employee = DB::fetch_all ("SELECT no, first_name, last_name, employee_picture, email_address FROM tbl_employee WHERE no = ".$receiver_id);
	}

	function getLastMessagesData()
	{
		return $messages =  DB::fetch_all ("SELECT no, `from`, `to`, text, created_on, (SELECT employee_picture FROM tbl_employee WHERE no = ".$this->from.") AS employee_picture FROM tbl_messages WHERE `from` = ".$this->from." AND `to` = ".$this->to." ORDER BY no DESC LIMIT 1");
	}

	function getContacts($id){
		return $employees = DB::fetch_all ("SELECT a.no, first_name, last_name, employee_picture, email_address, campus_name FROM tbl_employee a, tbl_employee_status b, tbl_campus c WHERE a.no = b.employee_id AND b.campus_id = c.id AND b.is_active = 1 AND a.no <> ".$id." ORDER BY c.id ASC");
	}

	function cntUnseenMessage($id)
	{
		return $unseen =  DB::fetch_all ("SELECT `from`, SUM(`status`) AS `status` FROM tbl_messages WHERE `to` = ". $id ." GROUP BY `from`");
	}


	function updateMessageStatus($sender_id, $receiver_id)
	{
		$status = DB::update ("UPDATE tbl_messages SET `status` = 0 WHERE `from` = ".$sender_id." AND `to` = ".$receiver_id);
		if($status){
			return $result = DB::fetch_all ("SELECT SUM(`status`) AS tlt_unseen FROM tbl_messages WHERE `to` = ". $receiver_id);
		}else{
			return $result = DB::fetch_all ("SELECT SUM(`status`) AS tlt_unseen FROM tbl_messages WHERE `to` = ". $receiver_id);
		}
	}

	function getMessageNotification($user_id){
		return $result = DB::fetch_all ("SELECT SUM(`status`) AS tlt_unseen FROM tbl_messages WHERE `to` = ". $user_id);
	}
 
	function getRecentConversation($user_id) {
		// return $result = DB::fetch_all("SELECT b.no, a.from, a.to, employee_picture, first_name, last_name,(SELECT `from` FROM tbl_messages WHERE (`from`= a.`from` AND `to` = c.`to`) OR (`from`= c.`to` AND `to` =  a.`from`) ORDER BY created_on DESC LIMIT 1) as FromReply,(SELECT text FROM tbl_messages WHERE (`from`= a.`from` AND `to` = c.`to`) OR (`from`= c.`to` AND `to` =  a.`from`) ORDER BY created_on DESC LIMIT 1) as ReplyText FROM tbl_messages a,tbl_employee b,(SELECT `to`, MAX(`created_on`) `created_on` FROM tbl_messages WHERE `from` = ".$user_id." GROUP BY `to`) c WHERE a.to = c.to AND a.created_on = c.created_on AND a.to = b.no  AND a.from = ".$user_id." GROUP BY a.to ORDER BY a.created_on DESC");
		// return $result = DB::fetch_all("SELECT  b.no, a.from, a.to, employee_picture, first_name, last_name, text FROM tbl_messages a, tbl_employee b, (SELECT `to`, MAX(`created_on`) `created_on` FROM tbl_messages WHERE `from` = ". $user_id ." GROUP BY `to`) c WHERE a.to = c.to AND a.created_on = c.created_on AND a.to = b.no AND a.from = ". $user_id ." GROUP BY a.to ORDER BY a.created_on DESC");
		return $result = DB::fetch_all("SELECT b.no, a.from, a.to, employee_picture, first_name, last_name ,(SELECT `from` FROM tbl_messages WHERE (`from`= a.`from` AND `to` = c.`to`) OR (`from`= c.`to` AND `to` =  a.`from`) ORDER BY created_on DESC LIMIT 1) as FromReply,(SELECT text FROM tbl_messages WHERE (`from`= a.`from` AND `to` = c.`to`) OR (`from`= c.`to` AND `to` =  a.`from`) ORDER BY created_on DESC LIMIT 1) as ReplyText, (SELECT status FROM tbl_messages WHERE (`from`= a.`from` AND `to` = c.`to`) OR (`from`= c.`to` AND `to` =  a.`from`) ORDER BY created_on DESC LIMIT 1) as Status FROM tbl_messages a,tbl_employee b,(SELECT `to`, MAX(`created_on`) `created_on` FROM tbl_messages WHERE `from` = ".$user_id." GROUP BY `to`) c WHERE a.to = c.to AND a.created_on = c.created_on AND a.to = b.no  AND a.from = ".$user_id." GROUP BY a.to ORDER BY a.created_on DESC");
	
	}


	function searchForRecents($user_id, $search_data) {
		return $result = DB::fetch_all("SELECT  b.no, a.from, a.to, employee_picture, first_name, last_name, text FROM tbl_messages a, tbl_employee b, (SELECT `to`, MAX(`created_on`) `created_on` FROM tbl_messages WHERE `from` = ". $user_id ." GROUP BY `to`) c WHERE a.to = c.to AND a.created_on = c.created_on AND a.to = b.no AND a.from = ". $user_id ." AND CONCAT(first_name, ' ', last_name) LIKE '". $search_data ."%' GROUP BY a.to ORDER BY a.created_on DESC");
	}
	
	function searchForContacts($user_id, $search_data){
		return $result = DB::fetch_all ("SELECT a.no, first_name, last_name, employee_picture, email_address, campus_name FROM tbl_employee a, tbl_employee_status b, tbl_campus c WHERE a.no = b.employee_id AND b.campus_id = c.id AND b.is_active = 1 AND a.no <> ".$user_id." AND CONCAT(first_name, ' ', last_name) LIKE '". $search_data ."%' ORDER BY c.id ASC");
	}
}