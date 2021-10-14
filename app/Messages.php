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
        $this->view->display ('admin/messages');
    }

    public function do_action (){
        try {
            $this->{$this->data['action']} ();
        } catch (\Throwable $th) {
            $this->index();
        } 
    }

    public function get_contacts(){
        $message_object = new Message();
        echo json_encode(['contacts' => $message_object->getContacts($this->data['user_id'])]);
    }

    public function get_recents(){
        $message_object = new Message();
        echo json_encode(['recents' => $message_object->getRecentConversation($this->data['user_id'])]);
    }

    public function get_unseen_msg(){
        $message_object = new Message();
        echo json_encode(['unseen' => $message_object->cntUnseenMessage($this->data['user_id'])]);
    }

    public function get_message_notif(){
        $message_object = new Message();
        echo json_encode(['message_notif' => $message_object->getMessageNotification($this->data['user_id'])]);
    }

    public function get_receiver_info(){
        $message_object = new Message();
        echo json_encode(['receiver_info' => $message_object->getReceiverInfo($this->data['receiver_id'])]);
    }

    public function get_conversation(){
        $message_object = new Message();
        echo json_encode(['conversation' => $message_object->getConversation($this->data['sender_id'], $this->data['receiver_id'])]);
    }

    public function update_msg_status(){
        $message_object = new Message();
        echo json_encode(['message_notif' => $message_object->updateMessageStatus($this->data['sender_id'], $this->data['receiver_id'])]);
    }

    public function add_new_message(){
        $message_object = new Message();
        $message_object->setFrom($this->data['from']);
        $message_object->setTo($this->data['to']);
        $message_object->setText($this->data['text']);
        $message_object->setCreatedOn(date("Y-m-d G:i:s"));
        $message_object->setStatus(1);
        $message_object->saveMessage();
        $message_object->updateMessageStatus($this->data['sender_id'], $this->data['receiver_id']);
        echo json_encode(['new_message' => $message_object->getLastMessagesData()]);
    }

    public function search_recents(){
        $message_object = new Message();
        echo json_encode(['recents' => $message_object->searchForRecents($this->data['user_id'], $this->data['search_data'])]);
    }

    public function search_contacts(){
        $message_object = new Message();
        echo json_encode(['contacts' => $message_object->searchForContacts($this->data['user_id'], $this->data['search_data'])]);
    }
} 