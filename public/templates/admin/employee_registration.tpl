{extends file="layout.tpl"}
{block name="content"}
<div class="my-3 my-md-5">
    <div class="container center align-content-center">     
        <div class="page-header">
            <h1 class="page-title"><?php echo "Register Employee "//. ucfirst ($frm['a']); ?></h1>
        </div>
        <div class="row row-cards row-deck">
        <div class="col-sm-10 m-auto">
            <div class="card ">
                <div class="card-header">
                    <h1 class="card-title">Register Employee</h1>
                    <div class="d-flex col-md-10">
                        <div class="ml-auto">
                            <a href="/employees" class="form-control">Cancel</a>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <form class="user ml-5 mr-5" method="post" action="" enctype="multipart/form-data">
                        <div class="row">
                            <div class="col-sm-3">
                                <div class="form-group label-floating">
                                <label class="form-label">First Name</label>
                                <input type="text" required class="form-control" name="emp[FirstName]" value="">
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <label class="form-label">Middle Name</label>
                                <input type="text" class="form-control" name="emp[MiddleName]" value="">
                            </div>
                            <div class="col-sm-4 mb-sm-0">
                                <div class="form-group label-floating">
                                    <label class="form-label">Last Name</label>
                                    <input type="text" required class="form-control" name="emp[LastName]" value="">
                                </div>
                            </div>
                            <div class="col-sm-2">
                                <div class="label-floating">
                                    <label class="form-label">Extension Name</label>
                                    <input type="text" class="form-control" name="emp[ExtName]" value="">
                                </div>
                            </div>
                            <div class="col-sm-6 mb-sm-0">
                                <div class="form-group label-floating">
                                    <label class="form-label">Email Address</label>
                                    <input required type="email" required class="form-control" name="emp[EmailAddress]" value="">
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="label-floating">
                                    <label class="form-label">Contact Number</label>
                                    <input class="form-control bfh-phone" type="tel" name="emp[CellphoneNo]" value="">
                                </div>
                            </div>
                            <div class="col-sm-5 mb-3 mb-sm-0">
                                <div class="form-group label-floating">
                                    <label class="form-label">Birthday</label>
                                    <input type="date" class="form-control" name="emp[BirthDate]" max="<?php echo $date_now; ?>">
                                </div>
                            </div>
                            <div class="col-sm-7">
                                <div class="form-group label-floating">
                                    <label class="form-label">Birthplace</label>
                                    <input type="text" class="form-control" name="emp[BirthPlace]">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group label-floating">
                                    <label class="form-label" for="gender">Gender</label>
                                    <select required class="selectpicker form-control" data-style="btn btn-success btn-round" name="emp[Gender]">
                                        <option value="" selected="true" disabled>Gender</option>
                                        <option value="Male">Male</option>
                                        <option value="Female">Female</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <label class="form-label" for="civil_stat">Marital Status</label>
                                <select required class="selectpicker form-control" data-style="btn btn-success btn-round" name="emp[MaritalStatus]">
                                    <option value="" selected="true" disabled>Civil Status</option>
                                    <option value="Single">Single</option>
                                    <option value="Married">Married</option>
                                    <option value="Widowed">Widowed</option>
                                    <option value="Separated">Separated</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <label class="form-label form-label-main">EMPLOYMENT</label>
                                <div class="ml-auto">
                                    <div class="custom-controls-stacked">
                                        <label class="custom-control custom-radio custom-control-inline">
                                            <input type="radio" class="custom-control-input" name="example-radios" value="option2">
                                            <div class="custom-control-label">New Employee</div>
                                        </label>
                                        <label class="custom-control custom-radio custom-control-inline">
                                            <input type="radio" class="custom-control-input" name="example-radios" value="option2">
                                            <div class="custom-control-label">Old Employee</div>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <hr style="width: 100%; margin: 5px 1px;">
                            <div class="col-lg-3 col-md-12 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Employee ID No.</label>
                                    <input type="text" class="form-control" name="employee_status[employee_id]" value="">
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-12 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Schedule</label>
                                    <select class="form-control" name="">
                                        <option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        </div>
    </div>
</div>
{/block}