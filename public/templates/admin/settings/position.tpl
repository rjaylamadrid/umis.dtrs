<div class="row">
    <div class="col-lg-12">
        <div class="card">
            <div class="card-body">
                <form>
                    <div class="form-group form-inline m-0">
                        <select class="custom-select">
                            {foreach $emp_types as $type}
                                <option value="GET">{$type.etype_desc}</option> 
                            {/foreach}
                        </select>   
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="row row-cards row-deck">
    <div class="col-12">
        <div class="card">
            <div class="table-responsive">
                <table style=" font-family:  Arial;" class="table table-hover card-table table-vcenter text-nowrap datatable dataTable no-footer" id="tbl-positions">
                    <thead>
                        <tr>
                            <th>Code</th>
                            <th>Position Name</th>
                            <th>Salary Grade</th>
                            <th>Base Salary</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    {foreach $positions as $position}
                        <tr onclick='editposition({$position.position_code})'>
                            <td>{$position.position_code}</td>
                            <td>{$position.position_desc}</td>
                            <td>{$position.salary_grade}</td>
                            <td>{$position.salary}</td>
                            <td class="text-center"><div class="item-action dropdown">
                                <a href="javascript:void(0)" data-toggle="dropdown" class="icon" aria-expanded="false"><i class="fe fe-more-vertical"></i></a>
                                <div class="dropdown-menu dropdown-menu-right" x-placement="bottom-end" style="position: absolute; transform: translate3d(-181px, 20px, 0px); top: 0px; left: 0px; will-change: transform;">
                                    <a href="#" class="dropdown-item"><i class="dropdown-icon fe fe-edit"></i> Edit 
                                    </a>
                                    <a href="#" class="dropdown-item"><i class="dropdown-icon fe fe-trash"></i> Remove
                                    </a>
                                </div>
                            </td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script>
    require (['datatables'], function () {
        $("#tbl-positions").DataTable();
    })
</script>