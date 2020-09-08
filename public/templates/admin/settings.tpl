{extends file="layout.tpl"}
{block name=content}
<div class="my-3 my-md-5">
    <div class="container">
        <div class="row">
          	<div class="col-md-3"><h3 class="page-title mb-5">System Settings</h3><div>
          	<div class="list-group list-group-transparent mb-0">
          		<a href="?a=settings&view=connection" class="list-group-item list-group-item-action d-flex align-items-center <?php echo $frm['view'] == 'connection' ? 'active' : ''; ?>"><span class="icon mr-3"><i class="fe fe-inbox"></i></span>Connection</a>
                <a href="?a=settings&view=sgrade" class="list-group-item list-group-item-action d-flex align-items-center <?php echo $frm['view'] == 'sgrade' ? 'active' : ''; ?>"><span class="icon mr-3"><i class="fe fe-send"></i></span>Salary Grade</a>
                <a href="?a=settings&view=payroll" class="list-group-item list-group-item-action d-flex align-items-center <?php echo $frm['view'] == 'payroll' ? 'active' : ''; ?>"><span class="icon mr-3"><i class="fe fe-send"></i></span>Payroll</a>
                <a href="?a=settings&view=position" class="list-group-item list-group-item-action d-flex align-items-center <?php echo $frm['view'] == 'position' ? 'active' : ''; ?>"><span class="icon mr-3"><i class="fe fe-send"></i></span>Position</a>
                <a href="?a=settings&view=wtax" class="list-group-item list-group-item-action d-flex align-items-center <?php echo $frm['view'] == 'wtax' ? 'active' : ''; ?>"><span class="icon mr-3"><i class="fe fe-send"></i></span>Withholding Tax</a>
          	</div>
        </div>
    </div>
    <div class="col-md-9">
        <div class="card">
          	<div class="card-body" id="setting">
          		<?php include 'settings/'.$frm['view'].'.php'; ?>
          	</div>
        </div>
    </div>
</div>
</div>
{/block}