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
                        <input type="radio" class="custom-control-input" name="q34a" value="Yes" checked="">
                        <span class="custom-control-label">Yes</span>
                        </label>
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="q34a" value="No">
                        <span class="custom-control-label">No</span>
                        </label>
                    </div>
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
                        <input type="radio" class="custom-control-input" name="q34b" value="Yes" checked="">
                        <span class="custom-control-label">Yes</span>
                        </label>
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="q34b" value="No">
                        <span class="custom-control-label">No</span>
                        </label>
                    </div>
                    <input type="text" class="form-control" placeholder="Username">
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
                        <input type="radio" class="custom-control-input" name="q35a" value="Yes" checked="">
                        <span class="custom-control-label">Yes</span>
                        </label>
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="q35a" value="No">
                        <span class="custom-control-label">No</span>
                        </label>
                    </div>
                    <input type="text" class="form-control" placeholder="Username">
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
                        <input type="radio" class="custom-control-input" name="q35b" value="Yes" checked="">
                        <span class="custom-control-label">Yes</span>
                        </label>
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="q35b" value="No">
                        <span class="custom-control-label">No</span>
                        </label>
                    </div>
                    <input type="text" class="form-control" placeholder="Username">
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
                        <input type="radio" class="custom-control-input" name="q36" value="Yes" checked="">
                        <span class="custom-control-label">Yes</span>
                        </label>
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="q36" value="No">
                        <span class="custom-control-label">No</span>
                        </label>
                    </div>
                    <input type="text" class="form-control" placeholder="Username">
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
                        <input type="radio" class="custom-control-input" name="q37" value="Yes" checked="">
                        <span class="custom-control-label">Yes</span>
                        </label>
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="q37" value="No">
                        <span class="custom-control-label">No</span>
                        </label>
                    </div>
                    <input type="text" class="form-control" placeholder="Username">
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
                        <input type="radio" class="custom-control-input" name="q38a" value="Yes" checked="">
                        <span class="custom-control-label">Yes</span>
                        </label>
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="q38a" value="No">
                        <span class="custom-control-label">No</span>
                        </label>
                    </div>
                    <input type="text" class="form-control" placeholder="Username">
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
                        <input type="radio" class="custom-control-input" name="q38b" value="Yes" checked="">
                        <span class="custom-control-label">Yes</span>
                        </label>
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="q38b" value="No">
                        <span class="custom-control-label">No</span>
                        </label>
                    </div>
                    <input type="text" class="form-control" placeholder="Username">
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
                        <input type="radio" class="custom-control-input" name="q39" value="Yes" checked="">
                        <span class="custom-control-label">Yes</span>
                        </label>
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="q39" value="No">
                        <span class="custom-control-label">No</span>
                        </label>
                    </div>
                    <input type="text" class="form-control" placeholder="Username">
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
                        <input type="radio" class="custom-control-input" name="q40a" value="Yes" checked="">
                        <span class="custom-control-label">Yes</span>
                        </label>
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="q40a" value="No">
                        <span class="custom-control-label">No</span>
                        </label>
                    </div>
                    <input type="text" class="form-control" placeholder="Username">
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
                            <input type="radio" class="custom-control-input" name="q40b" value="Yes" checked="">
                            <span class="custom-control-label">Yes</span>
                        </label>
                        <label class="custom-control custom-radio custom-control-inline">
                            <input type="radio" class="custom-control-input" name="q40b" value="No">
                            <span class="custom-control-label">No</span>
                        </label>
                    </div>
                    <input type="text" class="form-control" placeholder="Username">
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
                        <input type="radio" class="custom-control-input" name="q40c" value="Yes" checked="">
                        <span class="custom-control-label">Yes</span>
                        </label>
                        <label class="custom-control custom-radio custom-control-inline">
                        <input type="radio" class="custom-control-input" name="q40c" value="No">
                        <span class="custom-control-label">No</span>
                        </label>
                    </div>
                    <input type="text" class="form-control" placeholder="Username">
                {/if}
            </td>
        </tr>
    </table>
</div>