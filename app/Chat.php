<?php

use Ratchet\MessageComponentInterface;
use Ratchet\ConnectionInterface;

use Model\Message;
use Model\MessageConnection;

class Chat implements MessageComponentInterface {
    protected $clients;
    private $receiver;
    private $usersConnected;
    private $users;
    
    public function __construct() {
        $this->clients = new \SplObjectStorage;
        $this->users = [];
        $this->receiver = [];
        $this->usersConnected = [];
    }

    public function onOpen(ConnectionInterface $conn) {
        $this->clients->attach($conn);
        
        $uriQuery = $conn->httpRequest->getUri()->getQuery();
        $uriQueryArr = explode('&',$uriQuery);
        $userId = explode('=',$uriQueryArr[1]);

        $this->users[$conn->resourceId] = $conn;
        $this->usersConnected[$conn->resourceId] = $userId[1];
        $this->receiver[$conn->resourceId] = null;

        echo "someone connected [user_id = ". $this->usersConnected[$conn->resourceId]." | resourceID = ". $conn->resourceId ."]\n";
        foreach ($this->usersConnected as $user){
            $OL_users[] =  $user;
        }
        $result = [];
        $result["command"] = "login_user";
        $result["users"] = $OL_users; 
        $msg = json_encode($result);
        foreach ($this->clients as $client) {
            $client->send($msg);
        }
    }

    public function onMessage(ConnectionInterface $conn, $msg) {
        $data = json_decode($msg);
        $messages_object = new Message();
        switch ($data->command) {

            case "subscribe":
                $this->sender[$conn->resourceId] = $data->sender_id;
                $this->receiver[$conn->resourceId] = $data->receiver_id;
                break;

            case "message":
                $result["command"] = "message";
                $isOnline = false;
                $isFocus = false;
                if (isset($this->sender[$conn->resourceId]) && isset($this->receiver[$conn->resourceId])) {
                    if(array_search($this->receiver[$conn->resourceId], $this->usersConnected) == null){
                        $isOnline = false;
                    }else{
                        $isOnline = true;
                        foreach($this->usersConnected as $id=>$from){
                        echo "resourceId[". $id. "] receiver[" . $from . "]\n";
                            if($from == $data->to){
                                if($this->receiver[$id] == $data->from){
                                    $isFocus = true;
                                    break;
                                }else{
                                    $isFocus = false;
                                }
                            }else{
                                $isFocus = false;
                            }
                        } 
                    }
                    if($isOnline){
                        if($isFocus){
                            $data->status = 0;
                        }else{
                            $data->status = 1;
                        }
                    }else{
                        $data->status = 1;
                    }
                    $msg = json_encode($data);
                    if($isOnline){
                        foreach ($this->usersConnected as $id=>$receiver) {
                            if($data->to == $receiver){
                                echo "send to: ". $id ." \n";
                                $this->users[$id]->send($msg);
                            }
                        }
                    }
                }
                break;

        }
    }

    public function onClose(ConnectionInterface $conn) {
        echo "someone has disconnected [user_id = ". $this->usersConnected[$conn->resourceId]." | resourceID = ". $conn->resourceId ."]\n";
        $this->clients->detach($conn);
        $user_id = $this->usersConnected[$conn->resourceId];
        unset($this->users[$conn->resourceId]);
        unset($this->usersConnected[$conn->resourceId]);
        unset($this->receiver[$conn->resourceId]);
        $result = [];
        $result["command"] = "logout_user";
        $result["user_id"] = $user_id;
        $msg = json_encode($result);
        foreach ($this->clients as $client) {
            $client->send($msg);
        }
    }

    public function onError(ConnectionInterface $conn, \Exception $e) {
        echo "An error has occurred: {$e->getMessage()}\n";
        $conn->close();
    }
}
