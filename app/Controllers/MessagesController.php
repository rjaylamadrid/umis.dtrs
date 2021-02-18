<?php
namespace Controllers;

use Database\DB;


class MessagesController extends Controller {

    public function __construct () {
        parent::__construct();
    }

    public function getEmployees(){
        return DB::fetch_all ("SELECT a.no, first_name, last_name, employee_picture, email_address FROM tbl_employee a, tbl_employee_status b WHERE a.no = b.employee_id AND b.is_active = 1");
    }

    public function getConversation($id) {
        return DB::fetch_all ("SELECT first_name, last_name, employee_picture, email_address FROM tbl_employee  WHERE no = $id");
    }
}