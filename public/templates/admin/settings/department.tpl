
<div class="row row-cards row-deck">
    <div class="col-12">
    <a href="javascript:AddDepartment();" data-bs-toggle="modal" data-bs-target="#AddDepartment" class="ml-auto btn btn-primary mb-3"><i class="fe fe-plus"></i> Add Department</a>
        <div class="card">
            <div class="table-responsive">
                <table style=" font-family:  Arial;" class="table table-hover card-table table-vcenter text-nowrap datatable dataTable no-footer" id="tbl-positions">
                    <thead>
                        <tr>
                            <th>Department Code</th>
                            <th>Department name</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                {foreach from=$department item=departments}
                        <tr>
                            <td>{$departments.department_code}</td>
                            <td>{$departments.department_desc   }</td>
                            <td class="float-right"><a href="#" class="icon" aria-expanded="false"><i class="fe fe-edit"></i></td>
                        </tr>
                {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
{include file="admin/modal/update_dept_modal.tpl"}

<script>
    require (['datatables'], function () {
        $("#tbl-positions").DataTable();
    })
</script>
