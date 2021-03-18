<div class="card">
    <div class="card-body">
        <form action="" method="POST">
            <input type="hidden" name="payroll[payroll_type]" value="1">
            <input type="hidden" name="payroll[emp_type]" value="1">
            <input type="hidden" name="action" value="init_{$tab}">
            <div class="row">
                <div class="col-md-4">
                    <div class="input-group">
                        <span class="input-group-prepend">
                        <span class="input-group-text">From</span>
                        </span>
                        <input type="date" name="payroll[date_from]" class="form-control text-right" id="date_from">
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="input-group">
                        <span class="input-group-prepend">
                        <span class="input-group-text">To</span>
                        </span>
                        <input type="date" name="payroll[date_to]" class="form-control text-right" id="date_to">
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="float-right">
                        <button type="submit" class="btn btn-primary">
                            {if $tab == 'payroll'}Download{else}Initialize{/if}
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>