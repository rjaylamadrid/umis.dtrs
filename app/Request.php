<?php

class Request extends \Controllers\RequestController {
    public function index () {
        $this->view->display ("admin/request", ["requests" => $this->get_all ()]);
    }

    public function status ($status) {
        $this->status = $status;
        return $this;
    }

    public function response ($response) {
        $this->response = $response;
        return $this;
    }
}