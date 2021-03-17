<div class="my-3 my-md-5">
    <div class="container">
        <div class="row row-cards row-deck">
            <div class="col-12">
                <div class="card">
                    <div class="table table-responsive">
                        <table style="font-size: 13px;" class="table table-bordered table-hover card-table table-vcenter text-wrap datatable dataTable no-footer ">
                            <thead class="thead-dark">
                                <tr>
                                    <th style="text-align: left;" colspan="4"><b>NAME: <br><u>{$user.last_name}, {$user.first_name} {$user.middle_name} </u></b></th>
                                    <th style="text-align: left;" colspan="6"><b>OFFICE: <br><u>{$office[0].department_desc}</u></b></th>
                                    <th style="text-align: left;" colspan="2"><b>FIRST DAY OF SERVICE: <br><u>{$office[0].date_start|date_format:"F d, Y"}</u></b></th>
                                </tr>
                                <tr  style="text-align: center;">
                                    <td style=" width: 12%;" rowspan="2">PERIOD</td>
                                    <td style=" width: 10%;" rowspan="2">PARTICULARS</td>
                                    <td colspan="4">VACATION LEAVE</td>
                                    <td colspan="4">SICK LEAVE</td>
                                    <td style="word-wrap: break-word; width: 15%;" rowspan="2">DATE AND ACTION TAKEN ON APPLICATION FOR LEAVE</td>
                                </tr>
                                <tr align="center">
                                    <td  style=" width: 5%;">Earned</td>
                                    <td  style=" width: 5%;">Abs/Und. W/P</td>
                                    <td  style=" width: 5%;">Balance</td>
                                    <td  style=" width: 5%;">Abs/Und. WOP</td>
                                    <td  style=" width: 5%;">Earned</td>
                                    <td  style=" width: 5%;">Abs/Und. W/P</td>
                                    <td  style=" width: 5%;">Balance</td>
                                    <td  style=" width: 5%;">Abs/Und. WOP</td>
                                </tr>
                            </thead>
                            <tbody>
                                    {for $i=0 to sizeof($changes)-1}
                                        <tr align="center">
                                            <td onclick="javascript:show_collapse({$i}, '.')">
                                            <span class="head{$i} fe fe-chevron-down"></span>
                                            <b>{$balance[$i]['date']|date_format:"F d, Y"}</b></td>
                                            <td>Leave Credits</td>
                                            <td>{$balance[$i]['vacation']|round:3}</td>
                                            <td>-</td>
                                            <td>{$balance[$i]['vacation']|round:3}</td>
                                            <td>-</td>
                                            <td>{$balance[$i]['sick']|round:3}</td>
                                            <td>-</td>
                                            <td>{$balance[$i]['sick']|round:3}</td>
                                            <td>-</td>
                                            <td>-</td>
                                        </tr>
                                        <div class="card-body collapse">
                                        {for $j=0 to sizeof($changes[$i])}
                                            <tr align="center" class="collapse {$i}">
                                                <td><b>{$changes[$i][$j].period|date_format:"F d, Y"}</b></td>
                                                <td>{$changes[$i][$j].particulars}</td>
                                                <td>{if $changes[$i][$j].v_earned}{$changes[$i][$j].v_earned|round:3}{else}-{/if}</td>
                                                <td>{if $changes[$i][$j].v_awp}{$changes[$i][$j].v_awp|round:3}{else}-{/if}</td>
                                                <td>{if $changes[$i][$j].v_bal}{$changes[$i][$j].v_bal|round:3}{else}-{/if}</td>
                                                <td>{if $changes[$i][$j].v_awop}{$changes[$i][$j].v_awop|round:3}{else}-{/if}</td>
                                                <td>{if $changes[$i][$j].s_earned}{$changes[$i][$j].s_earned|round:3}{else}-{/if}</td>
                                                <td>{if $changes[$i][$j].s_awp}{$changes[$i][$j].s_awp|round:3}{else}-{/if}</td>
                                                <td>{if $changes[$i][$j].s_bal}{$changes[$i][$j].s_bal|round:3}{else}-{/if}</td>
                                                <td>{if $changes[$i][$j].s_awop}{$changes[$i][$j].s_awop|round:3}{else}-{/if}</td>
                                                <td>{if $changes[$i][$j].action}{$changes[$i][$j].action}{else}-{/if}</td>
                                            </tr>
                                        {/for}
                                        </div>
                                    {/for}
                                <tr>
                                    <td colspan="1" align="center"><b></b></td>
                                    <td colspan="1" align="center"><b></b></td>
                                    <td colspan="2" align="center"><b>TOTAL VL CREDITS EARNED</b></td>
                                    <td colspan="1" align="center"><b></b></td>
                                    <td colspan="1" align="center"><b></b></td>
                                    <td colspan="2" align="center"><b>TOTAL SL CREDITS EARNED</b></td>
                                    <td colspan="1" align="center"><b></b></td>
                                    <td colspan="1" align="center"><b></b></td>
                                    <td colspan="1" align="center"><b></b></td>
                                </tr>
                                <tr>

                                    <td colspan="1" align="center"><b></b></td>
                                    <td colspan="1" align="center"><b></b></td>
                                    <td colspan="2" align="center"><b>OVERALL VL CREDITS<br></b></td>
                                    <td colspan="1" align="center"><b>{$balance[$balance|@count - 1]['vacation']|round:2}</b></td>
                                    <td colspan="1" align="center"><b></b></td>
                                    <td colspan="2" align="center"><b>OVERALL SL CREDITS<br></b></td>
                                    <td colspan="1" align="center"><b>{$balance[$balance|@count - 1]['sick']|round:2}</b></td>
                                    <td colspan="1" align="center"><b></b></td>
                                    <td colspan="1" align="center"><b></b></td>
                                    
                                </tr>
                            </tbody>
                            <tfoot>

                            </tfoot>
                        </table>
                        <br>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>