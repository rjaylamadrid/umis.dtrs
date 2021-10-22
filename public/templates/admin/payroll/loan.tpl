<div class="row row-cards" id="attendance-content">
    <div class="col-md-6 col-lg-3">
        <div class="card">
            <div class="card-status bg-green"></div>
            <div class="card-header">
                <h3 class="card-title"><b>LIST</b> of Employees</h3>
            </div>
            <div id="employee-list" class="selectgroup selectgroup-vertical w-100 o-auto" style="max-height: 70vh;">
                {* <label class="selectgroup-item">
                    <input type="radio" name="employee_id" value="0" class="selectgroup-input" checked="" onclick="init_dtr (0);">
                    <span class="selectgroup-button" style="text-align: left;">Blank DTR</span>
                </label> *}
                {foreach $employees as $employee}
                <label class="selectgroup-item">
                    <input type="radio" name="employee_id" value="{$employee.employee_no}" class="selectgroup-input" onclick="init_dtr (this.value);">
                    <span class="selectgroup-button" style="text-align: left;padding-top:3px; padding-bottom:3px"><b>{$employee.last_name|upper}, {$employee.first_name|upper}</b></span>
                </label>
                {/foreach}
            </div>
        </div>
    </div>
    <div class="col-md-6 col-lg-9">
        <div class="card">
            <div class="card-body">
            </div>
        </div>
    </div>
</div>
