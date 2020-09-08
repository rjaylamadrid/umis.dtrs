<div class="content">
    <table>
        <tr>
            <td colspan="1"><img src="http://dtrs.com/assets/img/cbsua_logosmall.png" width="50px" height="50px"></td>
            <td colspan="5" style="font-size: 7px;">Republic of the Philippines<br/>
                <b>CENTRAL BICOL STATE UNIVERSITY OF AGRICULTURE</b><br/>
                Impig, Sipocot, Camarines Sur 4408<br/>
                Website: www.cbsua.edu.ph<br/>
                Email Address: cbsua.sipocot@yahoo.com<br/>
                Telephone: (054) 881-6681<br/>
            </td>
        </tr>
        <br/>
        <tr>
            <td colspan="6" style="text-align: center;"><h1>DAILY TIME RECORD</h1></td>
        </tr>
        <br/>
        <tr>
            <td colspan="6">NAME: {$employee.first_name} {$employee.last_name} ({$employee.employee_id})</td>
        </tr>
        <br/>
        <tr>
            <td colspan="6">BRANCH: Admin<br/>
                For the month of July, 2020<br/>
                Official hours for arrival ( Regular Days 23 )<br/>
                and departure ( Saturdays 4 )<br/></td>
        </tr>
    </table>
    <table class="table">
        <thead>
            <tr class="border">
                <th rowspan="2" style="width: 7%;">DAY</th>
                <th colspan="2">MORNING</th>
                <th colspan="2">AFTERNOON</th>
                <th colspan="2">OVERTIME</th>
                <th rowspan="2">ABS</th>
                <th rowspan="2" style="width: 8%;">UT</th>
            </tr>
            <tr class="border">    
                <td>IN</td>
                <td>OUT</td>
                <td>IN</td>
                <td>OUT</td>
                <td>IN</td>
                <td>OUT</td>
            </tr>
        </thead>
        <tbody>
            {foreach $attendance['attn'] as $attn}
            {if $attn.attn}
            {$attn = $attn.attn}
            <tr class="border">
                <td><b>{$attn.date|trim|date_format:"%d"}</b></td>
                <td>{$attn.am_in|substr:0:-1|trim}</td>
                <td>{$attn.am_out|substr:0:-1|trim}</td>
                <td>{$attn.pm_in|substr:0:-1|trim}</td>
                <td>{$attn.pm_out|substr:0:-1|trim}</td>
                <td>{$attn.ot_in|substr:0:-1|trim}</td>
                <td>{$attn.ot_out|substr:0:-1|trim}</td>
                <td></td>
                <td>{$attn.late + $attn.undertime}</td>
            </tr>
            {else}
                {if $attn.date|date_format:"w" == 0 || $attn.date|date_format:"w" == 6}
            <tr class="border">
                <td><b>{$attn.date|trim|date_format:"%d"}</b></td>
                <td colspan="8" style="letter-spacing: 10px;">{$attn.date|trim|date_format:"%A"|upper}</td>
            </tr>
                {else}
                <tr class="border"><td><b>{$attn.date|trim|date_format:"%d"}</b></td>
                <td> : </td>
                <td> : </td>
                <td> : </td>
                <td> : </td>
                <td>   </td>
                <td>   </td>
                <td> 0.00 </td>
                <td> 0 </td>
            </tr>
                {/if}
            {/if}
            {/foreach}
            <tr class="border">
                <td colspan="7" style="text-align: left;">TOTAL HOURS: <b>{$attendance.total}</b> OVERTIME: <b>0.00</b></td>
                <td>0.00</td>
                <td>{$attendance.ut}</td>
            </tr>
            <tr class="no-border">
                <td colspan="9" style="text-align: justify;">         I CERTIFY on my honor that the above is a true and correct report of the hours of work performed, record of which was made daily at the time of arrival and departure from office.<br /><br /></td>
            </tr>
            <tr class="no-border">
                <td></td>
                <td colspan="7" style="border-bottom: 1px solid black;"></td>
                <td></td>
            </tr>
            <tr class="no-border">
                <td colspan="9"><br/>Signature<br/>
                    <div style="text-align: left; margin-left: 20px;">          Verified as to prescribed office hours.<br/><br/><br/><br/><br/></div>
                </td>
            </tr>
            <tr class="no-border">
                <td></td>
                <td colspan="3" style="border-bottom: 1px solid black;"></td>
                <td></td>
                <td colspan="3" style="border-bottom: 1px solid black;"></td>
                <td></td>
            </tr>
        </tbody>
    </table>
</div>