<?php

use Model\Employee;
use Model\Message;

use Database\DB;

use Controllers\MessagesController;

class Messages extends MessagesController {
    
    public function __construct () {
        parent::__construct();
    }
    
    public function index() {
        $message_object = new Message();
        $this->view->display ('admin/messages',['employees' => $message_object->getAllEmployeeData(), 'emp_user' => $this->user['employee_id']]);
    }

    public function do_action (){
        try {
            $this->{$this->data['action']} ();
        } catch (\Throwable $th) {
            $this->index();
        } 
    }

    public function getSelectedEmp() {
        $msgTo = $this->data['msgTo'];
        $result['employee'] = DB::fetch_all ("SELECT first_name, last_name, employee_picture, email_address FROM tbl_employee WHERE no = $msgTo");
        echo json_encode($result);
    }

    public function getMessages() {
        $msgTo = $this->data['msgTo'];
        $msgFrom = $this->data['msgFrom'];
        $result['messages'] = DB::fetch_all ("SELECT * FROM tbl_messages WHERE `from` = $msgFrom AND `to` = $msgTo OR `from` = $msgTo AND `to` = $msgFrom");
        echo json_encode($result);
    }

    public function uMessages() {
        $msgTo = $this->data['msgTo'];
        $msgFrom = $this->data['msgFrom'];
        $result['messages'] = DB::fetch_all ("SELECT * FROM tbl_messages WHERE `from` = $msgFrom AND `to` = $msgTo OR `from` = $msgTo AND `to` = $msgFrom");
        echo json_encode($result);
    }

    public function addNewMessage() {
        unset($this->data['action']);
        $id = DB::insert ("INSERT INTO tbl_messages VALUES(null,".$this->data['from'].",".$this->data['to'].",'".$this->data['text']."','".$this->data['date']."','".$this->data['time']."')");
        echo json_encode($this->data['date_time']);
        
    }
} 