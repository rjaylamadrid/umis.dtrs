<?php
namespace Controllers;

use Database\DB;

class RequestController extends Controller {
    protected $status = 0;
    protected $response = 0;

    protected function get_all () {
        return DB::fetch_all ("SELECT *, CONCAT(b.last_name,'".","." ',b.first_name,' ',b.middle_name) AS EmpName FROM tbl_emp_leave a, tbl_employee b, tbl_employee_status c WHERE a.emp_id = b.employee_id AND a.lv_status = ? AND a.response = ? AND b.employee_id = c.employee_id AND c.campus_id = ? ORDER BY a.lv_dateof_filing DESC", [$this->status, $this->response, $this->user['campus_id']]);
    }
}