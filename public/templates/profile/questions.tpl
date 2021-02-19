{$answer = json_decode($employee->other_info.answers)}
<div class="table-responsive mt-2" style="overflow-x: unset">
    <table class="table table-sm card-table table-borderless">
        <tr>
            <td>34.</td>
            <td style="width:70%">Are you related by consanguinity or affinity to the appointing or recommending authority, or to the chief bureau or office or to the person who has immediate supervision over you in the Office, Bureau or Department where you will be appointed,</td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td>a. within the third degree?</td>
            <td>
                {if $view == "update"}
                    <div class="custom-controls-stacked">
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="employeeinfo[question][q34a]" value="Yes" {if $answer->q34a == 'Yes'} Checked {/if}>
                        <span class="custom-control-label">Yes</span>
                        </label>
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="employeeinfo[question][q34a]" value="No" {if $answer->q34a == 'No'} Checked {/if}>
                        <span class="custom-control-label">No</span>
                        </label>
                    </div>
                {else}
                    <div>{$answer->q34a}</div>
                {/if}
            </td>
        </tr>
        <tr>
            <td></td>
            <td>b. within the fourth degree (for Local Government Unit - Career Employees)?</td>
            <td>
                {if $view == "update"}
                    <div class="custom-controls-stacked">
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="employeeinfo[question][q34b]" value="Yes" {if $answer->q34b == 'Yes'} Checked {/if}>
                        <span class="custom-control-label">Yes</span>
                        </label>
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="employeeinfo[question][q34b]" value="No" {if $answer->q34b == 'No'} Checked {/if}>
                        <span class="custom-control-label">No</span>
                        </label>
                    </div>
                    <input type="text" class="form-control" name="employeeinfo[question][q34Det]" value="{$answer->q34Det}" placeholder="Details">
                {else}
                    <div>{$answer->q34b}</div>
                    <div class="small text-muted">{$answer->q34Det}</div>
                {/if}
            </td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>35.</td>
            <td>a. Have you ever found guilty of any administrative offense?</td>
            <td>
                {if $view == "update"}
                    <div class="custom-controls-stacked">
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="employeeinfo[question][q35a]" value="Yes" {if $answer->q35a == 'Yes'} Checked {/if}>
                        <span class="custom-control-label">Yes</span>
                        </label>
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="employeeinfo[question][q35a]" value="No" {if $answer->q35a == 'No'} Checked {/if}>
                        <span class="custom-control-label">No</span>
                        </label>
                    </div>
                    <input type="text" class="form-control" name="employeeinfo[question][q35aDet]" value="{$answer->q35aDet}" placeholder="Details">
                {else}
                    <div>{$answer->q35a}</div>
                    <div class="small text-muted">{$answer->q35aDet}</div>
                {/if}
            </td>
        </tr>
        <tr>
            <td></td>
            <td>b. Have you been criminally charged before any court?</td>
            <td>
                {if $view == "update"}
                    <div class="custom-controls-stacked">
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="employeeinfo[question][q35b]" value="Yes" {if $answer->q35b == 'Yes'} Checked {/if}>
                        <span class="custom-control-label">Yes</span>
                        </label>
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="employeeinfo[question][q35b]" value="No" {if $answer->q35b == 'No'} Checked {/if}>
                        <span class="custom-control-label">No</span>
                        </label>
                    </div>
                    <input type="text" class="form-control mb-1" name="employeeinfo[question][q35bDate]" value="{$answer->q35bDate}" placeholder="Date Filed">
                    <input type="text" class="form-control" name="employeeinfo[question][q35bStat]" value="{$answer->q35bStat}" placeholder="Status of Case/s">
                {else}
                    <div>{$answer->q35b}</div>
                    <div class="small text-muted">Date: {$answer->q35bDate}</div>
                    <div class="small text-muted">Status: {$answer->q35bStat}</div>
                {/if}
            </td>
        </tr>
        <tr>
            <td>36.</td>
            <td>Have you ever been convicted of any crime or violation of any law, decree, ordinance or regulation by any court or tribunal?</td>
            <td>
                {if $view == "update"}
                    <div class="custom-controls-stacked">
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="employeeinfo[question][q36]" value="Yes" {if $answer->q36 == 'Yes'} Checked {/if}>
                        <span class="custom-control-label">Yes</span>
                        </label>
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="employeeinfo[question][q36]" value="No" {if $answer->q36 == 'No'} Checked {/if}>
                        <span class="custom-control-label">No</span>
                        </label>
                    </div>
                    <input type="text" class="form-control" name="employeeinfo[question][q36Det]" value="{$answer->q36Det}" placeholder="Details">
                {else}
                    <div>{$answer->q36}</div>
                    <div class="small text-muted">{$answer->q36Det}</div>
                {/if}
            </td>
        </tr>
        <tr>
            <td>37.</td>
            <td>Have you ever been separated from the service in any of the following modes: resignation, retirement, dropped from the rolls, dismissal, termination, end of term, finished contract or phased out (abolition) in the public or private sector?</td>
            <td>
                {if $view == "update"}
                    <div class="custom-controls-stacked">
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="employeeinfo[question][q37]" value="Yes" {if $answer->q37 == 'Yes'} Checked {/if}>
                        <span class="custom-control-label">Yes</span>
                        </label>
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="employeeinfo[question][q37]" value="No" {if $answer->q37 == 'No'} Checked {/if}>
                        <span class="custom-control-label">No</span>
                        </label>
                    </div>
                    <input type="text" class="form-control" name="employeeinfo[question][q37Det]" value="{$answer->q37Det}" placeholder="Details">
                {else}
                    <div>{$answer->q37}</div>
                    <div class="small text-muted">{$answer->q37Det}</div>
                {/if}
            </td>
        </tr>
        <tr>
            <td>38.</td>
            <td>a. Have you ever been a candidate in a national or local election held within the last year (except Barangay election)?</td>
            <td>
                {if $view == "update"}
                    <div class="custom-controls-stacked">
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="employeeinfo[question][q38a]" value="Yes" {if $answer->q38a == 'Yes'} Checked {/if}>
                        <span class="custom-control-label">Yes</span>
                        </label>
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="employeeinfo[question][q38a]" value="No" {if $answer->q38a == 'No'} Checked {/if}>
                        <span class="custom-control-label">No</span>
                        </label>
                    </div>
                    <input type="text" class="form-control" name="employeeinfo[question][q38aDet]" value="{$answer->q38aDet}" placeholder="Give the details">
                {else}
                    <div>{$answer->q38a}</div>
                    <div class="small text-muted">{$answer->q38aDet}</div>
                {/if}
            </td>
        </tr>
        <tr>
            <td></td>
            <td>b. Have you resigned from the government service during the three (3)-month period before the last election to promote/actively campaign for a national or local candidate?</td>
            <td>
                {if $view == "update"}
                    <div class="custom-controls-stacked">
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="employeeinfo[question][q38b]" value="Yes" {if $answer->q38b == 'Yes'} Checked {/if}>
                        <span class="custom-control-label">Yes</span>
                        </label>
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="employeeinfo[question][q38b]" value="No" {if $answer->q38b == 'No'} Checked {/if}>
                        <span class="custom-control-label">No</span>
                        </label>
                    </div>
                    <input type="text" class="form-control" name="employeeinfo[question][q38bDet]" value="{$answer->q38bDet}" placeholder="Give the details">
                {else}
                    <div>{$answer->q38b}</div>
                    <div class="small text-muted">{$answer->q38bDet}</div>
                {/if}
            </td>
        </tr>
        <tr>
            <td>39.</td>
            <td>Have you acquired the status of an immigrant or permanent resident of another country?</td>
            <td>
                {if $view == "update"}
                    <div class="custom-controls-stacked">
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="employeeinfo[question][q39]" value="Yes" {if $answer->q39 == 'Yes'} Checked {/if}>
                        <span class="custom-control-label">Yes</span>
                        </label>
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="employeeinfo[question][q39]" value="No" {if $answer->q39 == 'No'} Checked {/if}>
                        <span class="custom-control-label">No</span>
                        </label>
                    </div>
                    <input type="text" class="form-control" name="employeeinfo[question][q39Det]" value="{$answer->q39Det}" placeholder="Country">
                {else}
                    <div>{$answer->q39}</div>
                    <div class="small text-muted">{$answer->q39Det}</div>
                {/if}
            </td>
        </tr>
        <tr>
            <td>40.</td>
            <td>Pursuant to: (a) Indigenous People's Act (RA 8371); (b) Magna Carta for Disabled Persons (RA 7277); and (c) Solo Parents Welfare Act of 2000 (RA 8972) , please answer the following items:</td>
            <td></td>
        </tr>
        <tr>
            <td>a.</td>
            <td>Are you a member of any indigenous group?</td>
            <td>
                {if $view == "update"}
                    <div class="custom-controls-stacked">
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="employeeinfo[question][q40a]" value="Yes" {if $answer->q40a == 'Yes'} Checked {/if}>
                        <span class="custom-control-label">Yes</span>
                        </label>
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="employeeinfo[question][q40a]" value="No" {if $answer->q40a == 'No'} Checked {/if}>
                        <span class="custom-control-label">No</span>
                        </label>
                    </div>
                    <input type="text" class="form-control" name="employeeinfo[question][q40aDet]" value="{$answer->q40aDet}" placeholder="Please Specify">
                {else}
                    <div>{$answer->q40a}</div>
                    <div class="small text-muted">{$answer->q40aDet}</div>
                {/if}
            </td>
        </tr>
        <tr>
            <td>b.</td>
            <td>Are you a person with disability?</td>
            <td>
                {if $view == "update"}
                    <div class="custom-controls-stacked">
                        <label class="custom-control custom-radio custom-control-inline">
                            <input type="radio" class="custom-control-input" name="employeeinfo[question][q40b]" value="Yes" {if $answer->q40b == 'Yes'} Checked {/if}>
                            <span class="custom-control-label">Yes</span>
                        </label>
                        <label class="custom-control custom-radio custom-control-inline">
                            <input type="radio" class="custom-control-input" name="employeeinfo[question][q40b]" value="No" {if $answer->q40b == 'No'} Checked {/if}>
                            <span class="custom-control-label">No</span>
                        </label>
                    </div>
                    <input type="text" class="form-control" name="employeeinfo[question][q40bDet]" value="{$answer->q40bDet}" placeholder="Please Specify ID No">
                {else}
                    <div>{$answer->q40b}</div>
                    <div class="small text-muted">{$answer->q40bDet}</div>
                {/if}
            </td>
        </tr>
        <tr>
            <td>c.</td>
            <td>Are you a solo parent?</td>
            <td>
                {if $view == "update"}
                    <div class="custom-controls-stacked">
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="employeeinfo[question][q40c]" value="Yes" {if $answer->q40c == 'Yes'} Checked {/if}>
                        <span class="custom-control-label">Yes</span>
                        </label>
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="employeeinfo[question][q40c]" value="No" {if $answer->q40c == 'No'} Checked {/if}>
                        <span class="custom-control-label">No</span>
                        </label>
                    </div>
                    <input type="text" class="form-control" name="employeeinfo[question][q40cDet]" value="{$answer->q40cDet}" placeholder="Please Specify ID No">
                {else}
                    <div>{$answer->q40c}</div>
                    <div class="small text-muted">{$answer->q40cDet}</div>
                {/if}
            </td>
        </tr>
    </table>
</div>