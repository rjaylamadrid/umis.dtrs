<?php

use Ratchet\MessageComponentInterface;
use Ratchet\ConnectionInterface;

use Model\Message;
use Model\MessageConnection;

class Chat implements MessageComponentInterface {
    protected $clients;
    private $msgTo;
    private $msgFrom;
    private $users;
    private $onlineUsers;
    
    public function __construct() {
        $this->clients = new \SplObjectStorage;
        $this->msgTo = [];
        $this->msgFrom = [];
        $this->users = [];
        $this->onlineUsers = [];
    }

    public function onOpen(ConnectionInterface $conn) {

        $this->clients->attach($conn);
        $this->users[$conn->resourceId] = $conn;
        
        $uriQuery = $conn->httpRequest->getUri()->getQuery();
        $uriQueryArr = explode('&',$uriQuery);

        $sesionId = explode('=',$uriQueryArr[0]);
        $userId = explode('=',$uriQueryArr[1]);
        $this->onlineUsers[$conn->resourceId] = $userId[1];

        $msgConnObject = new MessageConnection();
        $msgObject = new Message();

        $msgConnObject->setResourceId($conn->resourceId);
        $msgConnObject->setUserId($userId[1]);
        $msgConnObject->setSesionId($sesionId[1]);
        $msgConnObject->deleteMessageConnection();
        $msgConnObject->saveMessageConnection();

        echo "someone connected\n".$conn->resourceId;
        $result["command"] = "contacts_recents";

        $msgObject->setFrom($userId[1]);

        $result["contacts"] = $msgObject->getAllEmployeeData();
        $result["recents"] = $msgObject->getRecentConvoData();
        $msg = json_encode($result);
        $this->users[$conn->resourceId]->send($msg);
        $result = [];
        $result["command"] = "active_users";
        $result["users"] = $msgConnObject->getAllUserIdData();
        $msg = json_encode($result);
        foreach ($this->clients as $client) {
            $client->send($msg);
        }
        $result = [];
        $result["command"] = "msg_unseen";
        $result["unseen"] = $msgObject->cntUnseenMsg();
        $msg = json_encode($result);
        $this->users[$conn->resourceId]->send($msg);
    }

    public function onMessage(ConnectionInterface $conn, $msg) {
        $data = json_decode($msg);
        $messages_object = new Message();
        switch ($data->command) {

            // case "active":
            //     $result["command"] = "active";
            //     $this->onlineUsers[$conn->resourceId] = $data->user;
            //     $employees = $messages_object->getAllEmployeeData();
            //     $index = 0;
            //     foreach($employees as $employee){
            //         if(array_search($employee["no"],$this->onlineUsers) == null){
            //             $employee['status'] = "inactive";
            //             $result["online_users"][$index] = ["status" => "inactive", 'no' => $employee["no"]];
            //         }else{
            //             $employee['status'] = "active";
            //             $result["online_users"][$index] = ["status" => "active", 'no' => $employee["no"]];
            //         }
            //         $index++;
            //     }
            //     $msg = json_encode($result);
            //     foreach ($this->clients as $client) {
            //         $client->send($msg);
            //     }
            //     break;
            case "recents":
                $result["command"] = "contacts_recents";
                $msgConnObject = new MessageConnection();
                $msgObject = new Message();

                $msgObject->setFrom($data->user_id);

                $result["contacts"] = $msgObject->getAllEmployeeData();
                $result["recents"] = $msgObject->getRecentConvoData();
                $msg = json_encode($result);
                $this->users[$conn->resourceId]->send($msg);
                $result = [];
                $result["command"] = "active_users";
                $result["users"] = $msgConnObject->getAllUserIdData();
                $msg = json_encode($result);
                foreach ($this->clients as $client) {
                    $client->send($msg);
                }
                break;

            case "msg_unseen":
                $result["command"] = "msg_unseen";
                $msgObject = new Message();
                $msgObject->setFrom($data->user_id);
                $result["unseen"] = $msgObject->cntUnseenMsg();
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
                    $result['message'] = $messages_object->getLastMessagesData(); 
                    $msg = json_encode($result);
                    
                    foreach ($this->onlineUsers as $id=>$ol) {
                        if ($this->msgTo[$conn->resourceId] == $ol) {
                            $this->users[$id]->send($msg);
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
        
        $this->clients->detach($conn);
        unset($this->users[$conn->resourceId]);
        unset($this->msgTo[$conn->resourceId]);
        unset($this->msgFrom[$conn->resourceId]);
        unset($this->onlineUsers[$conn->resourceId]);
        $uriQuery = $conn->httpRequest->getUri()->getQuery();
        $uriQueryArr = explode('&',$uriQuery);
        $userId = explode('=',$uriQueryArr[1]);
        $msgConnObject = new MessageConnection();
        $msgConnObject->setUserId($userId[1]);
        $msgConnObject->deleteMessageConnection();
        echo "someone has disconnected";
        $result = [];
        $result["command"] = "active_users";
        $result["users"] = $msgConnObject->getAllUserIdData();
        $msg = json_encode($result);
        foreach ($this->clients as $client) {
            $client->send($msg);
            print_r("ok");
        }
    }

    public function onError(ConnectionInterface $conn, \Exception $e) {
        echo "An error has occurred: {$e->getMessage()}\n";
        $conn->close();
    }
}
