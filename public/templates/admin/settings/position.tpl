<div class="col-md-12">
    <div class="row">
        <div class="col-md-9">
            <h4>Positions Offered</h4>
        </div>
        <div class="col-md-3">
            <button class="btn btn-primary col-md-12" data-toggle="modal" onclick="editposition()"><i class="fe fe-plus"></i>Add Position</button>
        </div>
    </div>
</div>
<div class="col-md-12 mt-3">
    <form action="" method="POST">
        <div class="row row-cards row-deck">
            <div class="col-12">
                <div class="card">
                    <div class="table-responsive">
                        <table class="table table-hover card-table table-vcenter text-nowrap datatable dataTable no-footer" id="employees">
                            <thead>
                                <tr>
                                    <th>Code</th>
                                    <th>Position Name</th>
                                    <th>Salary Grade</th>
                                    <th>Base Salary</th>
                                </tr>
                            </thead>
                            <tbody>
                            {foreach $var as $position}
                                <tr onclick='editposition({$position.position_code})'>
                                    <td>{$position.position_code}</td>
                                    <td>{$position.position_desc}</td>
                                    <td>{$position.salary_grade}</td>
                                    <td>{$position.salary}</td>
                                </tr>
                            {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
    </form>
</div>
<div class="modal fade margin-top-70" id="position-modal" role="dialog" tabindex="-1" style="margin-left:-50px;">
    <div class="modal-dialog" id="position" role="document" style="max-width: 500px;">
    </div>
</div>
<script type="text/javascript">
    require(['datatables', 'jquery'], function(datatable, $) {
        $(document).ready(function() {
            $('#employees').DataTable();
        });
    });

    require(['selectize', 'jquery'], function(selectize, $) {
        $(document).ready(function() {
            $('#select-beast').selectize({});
        });
    });
    require(['jquery'], function() {
        $(document).on('change', '#sgrade', function(e) {
            check_salary();
        });
    });

    function check_salary() {
        var salary_grade = $('#sgrade').val();
        salary_grade == '' ? $('#salary').attr('disabled', false) : $('#salary').attr('disabled', true);
        if (salary_grade > 0) {
            $.ajax({
                url: "query.php?type=employee&view=salary",
                data: {
                    'no':salary_grade,'position':''
                    },
                success: function(data) {
                    $('#salary').val(data);
                }
            });
        }
    }

    function editposition(code) {
        $.ajax({
            url: 'query.php?type=setting&show=edit_position',
            type: 'POST',
            data:{
                'code':code},
            success: function(data) {
                $('#position').html(data);
                check_salary();
                $('#position-modal').modal('show');
            }
        });
    }
</script>