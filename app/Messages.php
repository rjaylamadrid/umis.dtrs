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

    public function updateStatus(){
        $message_object = new Message();
        $messages_object->setStatus($this->data['status']);
        $messages_object->setFrom($this->data['from']);
        $messages_object->updateMessageStatusData();
        echo json_encode($data);
    }
} 