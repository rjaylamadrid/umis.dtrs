<?php

use Ratchet\MessageComponentInterface;
use Ratchet\ConnectionInterface;

use Model\Message;

class Chat implements MessageComponentInterface {
    protected $clients;
    private $msgTo;
    private $msgFrom;
    private $users;
    private $onlineUsers;
    private $user;
    
    public function __construct() {
        $this->clients = new \SplObjectStorage;
        $this->msgTo = [];
        $this->msgFrom = [];
        $this->users = [];
        $this->onlineUsers = [];
        $this->user = '';
    }

    public function onOpen(ConnectionInterface $conn) {
        // if (!$this->user) {
            $this->clients->attach($conn);
            $this->users[$conn->resourceId] = $conn;
            $ids = [];
            foreach($this->users as $user) {
                $ids[] = $user->resourceId;
            }
            echo "someone connected\n".$conn->resourceId;
            print_r($ids);
        // }
    }

    public function onMessage(ConnectionInterface $conn, $msg) {
        $data = json_decode($msg);
        $messages_object = new Message();
        switch ($data->command) {

            case "active":
                $result["command"] = "active";
                // $this->user = $data->user;
                $this->onlineUsers[$conn->resourceId] = $data->user;
                $employees = $messages_object->getAllEmployeeData();
                $index = 0;
                foreach($employees as $employee){
                    if(array_search($employee["no"],$this->onlineUsers) == null){
                        $employee['status'] = "inactive";
                        $result["online_users"][$index] = ["status" => "inactive", 'no' => $employee["no"]];
                    }else{
                        $employee['status'] = "active";
                        $result["online_users"][$index] = ["status" => "active", 'no' => $employee["no"]];
                    }
                    $index++;
                }
                $msg = json_encode($result);
                foreach ($this->clients as $client) {
                    $client->send($msg);
                }
                break;

            case "unseen":
                $result["command"] = "unseen";
                $this->onlineUsers[$conn->resourceId] = $data->user;
                $employees = $messages_object->getAllEmployeeData();
                $index = 0;
                foreach($employees as $employee){
                    if($this->onlineUsers[$conn->resourceId] <> $employee["no"]){
                        $messages_object->setFrom($employee["no"]);
                        $messages_object->setTo($this->onlineUsers[$conn->resourceId]);
                        $unseen = $messages_object->countUnseenMessageData();
                        $result['unseen_msg'][$index] = ['unseen' => $unseen[0]['cnt_unseen'], 'no' => $employee["no"]];
                    }
                    $index++;
                }
                $result['index'] = $index;
                $msg = json_encode($result);
                $this->users[$conn->resourceId]->send($msg);
                break;

            case "subscribe":
                $result["command"] = "subscribe";
                $this->msgFrom[$conn->resourceId] = $data->from;
                $this->msgTo[$conn->resourceId] = $data->to;
                                                                                                                                                                                             
                $messages_object->setFrom($data->from);
                $messages_object->setTo($data->to);
                $result['employee'] = $messages_object->getSelectEmployeeData();
                $result['messages'] = $messages_object->getAllMessagesData();
                $msg = json_encode($result);
                $messages_object->setFrom($data->to);
                $messages_object->setTo($data->from);
                $messages_object->setStatus(0);
                $messages_object->updateMessageStatusData();
                $this->users[$conn->resourceId]->send($msg);
                break;

            case "message":
                $result["command"] = "message";
                if (isset($this->msgFrom[$conn->resourceId]) && isset($this->msgTo[$conn->resourceId])) {
                    $messages_object->setFrom($data->from);
                    $messages_object->setTo($data->to);
                    $messages_object->setText($data->text);
                    date_default_timezone_set('Asia/Manila');
                    $messages_object->setCreatedOn(date("Y-m-d h:i:s"));
                    if(array_search($data->to, $this->onlineUsers) == null){
                        $messages_object->setStatus(1);
                    }else{
                        foreach ($this->msgFrom as $id=>$from) {
                            if ($data->to == $from) {
                                if($this->msgTo[$id] == $data->from){
                                    $messages_object->setStatus(0);
                                    break;
                                }else{
                                    $messages_object->setStatus(1);
                                }
                            }else{
                                $messages_object->setStatus(1);
                            }
                        }
                    }
                    $messages_object->saveMessage();
                    if(array_search($data->to, $this->onlineUsers) <> null){
                        $result['message'] = $messages_object->getLastMessagesData(); 
                        $msg = json_encode($result);
                        
                        foreach ($this->onlineUsers as $id=>$ol) {
                            if ($this->msgTo[$conn->resourceId] == $ol) {
                                $this->users[$id]->send($msg);
                            }
                        }
                    }

                }
                break;
            
            case "unseenTo":
    
                $this->users[$conn->resourceId]->send($msg);
        
                break;
            default:
                break;

        }
    }

    public function onClose(ConnectionInterface $conn) {
        // if (!in_array($this->user, $this->users)) {
            $this->clients->detach($conn);
            unset($this->users[$conn->resourceId]);
            unset($this->msgTo[$conn->resourceId]);
            unset($this->msgFrom[$conn->resourceId]);
            echo "someone has disconnected";
        // }
    }

    public function onError(ConnectionInterface $conn, \Exception $e) {
        echo "An error has occurred: {$e->getMessage()}\n";
        $conn->close();
    }
}
