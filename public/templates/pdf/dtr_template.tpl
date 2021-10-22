<div class="content">
    <table>
        <tr>
            <td colspan="1"><img src="http://dtrs.com/assets/img/cbsua_logosmall.png" width="40px" height="40px"></td>
            <td colspan="5" style="font-size: 7px;">Republic of the Philippines<br/>
                <b>CENTRAL BICOL STATE UNIVERSITY OF AGRICULTURE</b><br/>
                {$campus.campus_address}<br/>
                Website: www.cbsua.edu.ph<br/>
                Email Address: {$campus.campus_email}<br/>
                Telephone: {$campus.campus_telephone}<br/>
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
                For the month of {$month}<br/>
                Official hours for arrival ( Regular Days {$days} )<br/>
                and departure ( Saturdays {$sat} )<br/></td>
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
            {$attendance.abs = 0}
            {$attendance.ut = 0}
            {$attendance.total = 0}
            {foreach $daterange as $date}
                {if $attendance['attn'][$date|date_format:"%Y-%m-%d"]}
                    {$attn = $attendance['attn'][$date|date_format:"%Y-%m-%d"]}
                    <tr class="border">
                        <td><b>{$attn.date|date_format:"%d"}</b></td>
                        <td>{if $attn.am_in|count_characters > 5}{$attn.am_in|substr:0:-1|trim}{else}{$attn.am_in}{/if}</td>
                        <td>{if $attn.am_out|count_characters > 5}{$attn.am_out|substr:0:-1|trim}{else}{$attn.am_out}{/if}</td>
                        <td>{if $attn.pm_in|count_characters > 5}{$attn.pm_in|substr:0:-1|trim}{else}{$attn.pm_in}{/if}</td>
                        <td>{if $attn.pm_out|count_characters > 5}{$attn.pm_out|substr:0:-1|trim}{else}{$attn.pm_out}{/if}</td>
                        <td>{$attn.ot_in|substr:0:-1|trim}</td>
                        <td>{$attn.ot_out|substr:0:-1|trim}</td>
                        {$attendance.ut = $attendance.ut + ($attn.late + $attn.undertime)}
                        {$attendance.abs = $attendance.abs + $attn.is_absent}
                        {$attendance.total_days = $attendance.total_days + (1 - $attn.is_absent)}
                        {$attendance.total = $attendance.total + $attn.total_hours}
                        <td> {$attn.is_absent|string_format:"%.2f"} </td>
                        <td>{$attn.late + $attn.undertime}</td>
                    </tr>
                {else}
                    {if $date|date_format:"w" == 0 || $date|date_format:"w" == 6}
                        <tr class="border">
                            <td><b>{$date|date_format:"%d"}</b></td>
                            <td colspan="8" style="letter-spacing: 10px;">{$date|date_format:"%A"|upper}</td>
                        </tr>
                    {else}
                        <tr class="border"><td><b>{$date|date_format:"%d"}</b></td>
                        <td> : </td>
                        <td> : </td>
                        <td> : </td>
                        <td> : </td>
                        <td>  </td>
                        <td>  </td>
                        {$abs = "0.00"}
                        {if ($date >= $from) && ($date <= $to)}
                            {$attendance.abs = $attendance.abs + 1}
                            {$abs = "1.00"}
                        {/if}
                        <td> {$abs} </td>
                        <td> 0 </td>
                        </tr>
                    {/if}
                {/if}
            {/foreach}
            <tr class="border">
                <td colspan="7" style="text-align: left;">TOTAL DAYS: <b>{$attendance.total_days}</b> OVERTIME: <b>0.00</b></td>
                <td>{$attendance.abs|string_format:"%.2f"}</td>
                <td>{$attendance.ut}</td>
            </tr>
            <br/>
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