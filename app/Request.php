<?php
use Controllers\RequestController;

class Request extends RequestController {
    public function index () {
        $this->view->display ("admin/request", ["requests" => $this->get_all (), "status" => $this->status, "response" => $this->response]);
    }

    public function status ($status) {
        $this->status = $status;
        return $this;
    }

    public function response ($response) {
        $this->response = $response;
        return $this;
    }

    public function get_requests ($status) {
        switch ($status) {
            case 'for-recommendation':
                $this->status(0)->response(1);
                break;
            case 'approved':
                $this->status(1)->response(1);
                break;
            case 'disapproved':
                $this->status(2)->response(1);
                break;
            default:
                header ("location: /request");
        }
        $this->index();
    }

    public function request_details ($id) {
        $request = $this->get_request($id);
        $this->view->display ("admin/request", ["request" => $request, "view" => "request"]);
    }
}