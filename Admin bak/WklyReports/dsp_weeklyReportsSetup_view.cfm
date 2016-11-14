<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="View Weekly Reports" showCalendar="0">

<script>
	function showhide(id){
		if (document.getElementById)
		{
			obj = document.getElementById(id);
			if (obj.style.display == "none")
			{
				obj.style.display = "";
			}
			else
			{
				obj.style.display = "none";
			}
		}
	}
</script>

<CFQUERY DATASOURCE="#application.WeeklyRptDSN#" NAME="qMasterRow">
	SELECT pi.program_name, pi.speaker_info_exist, pi.ci_data_exist , pi.polling_data_exist,
		di.decile1_exist, di.decile1_name, di.decile1_location_number,
		di.decile2_exist, di.decile2_name, di.decile2_location_number,
		di.decile3_exist, di.decile3_name, di.decile3_location_number,
		p.poll1, p.poll1_short, p.poll1_long, p.poll1_type, p.poll1_nchoices,
		p.poll1_resp1, p.poll1_resp2, p.poll1_resp3, p.poll1_resp4, p.poll1_resp5, p.poll1_resp6, p.poll1_resp7,
		p.poll2, p.poll2_short, p.poll2_long, p.poll2_type, p.poll2_nchoices,
		p.poll2_resp1, p.poll2_resp2, p.poll2_resp3, p.poll2_resp4, p.poll2_resp5, p.poll2_resp6, p.poll2_resp7,
		p.poll3, p.poll3_short, p.poll3_long, p.poll3_type, p.poll3_nchoices,
		p.poll3_resp1, p.poll3_resp2, p.poll3_resp3, p.poll3_resp4, p.poll3_resp5, p.poll3_resp6, p.poll3_resp7,
		p.poll4, p.poll4_short, p.poll4_long, p.poll4_type, p.poll4_nchoices,
		p.poll4_resp1, p.poll4_resp2, p.poll4_resp3, p.poll4_resp4, p.poll4_resp5, p.poll4_resp6, p.poll4_resp7,
		p.poll5, p.poll5_short, p.poll5_long, p.poll5_type, p.poll5_nchoices,
		p.poll5_resp1, p.poll5_resp2, p.poll5_resp3, p.poll5_resp4, p.poll5_resp5, p.poll5_resp6, p.poll5_resp7
	FROM Weekly_Reports_Program_Information pi,
		Weekly_Reports_Decile_Information di, 
		Weekly_Reports_Poll p
	where pi.projectcode = '#session.project_code#' and di.projectcode like '#session.project_code#'
		and p.projectcode ='#session.project_code#'
</CFQUERY>

<CFQUERY DATASOURCE="#application.WeeklyRptDSN#" NAME="qMasterQueryRow">
SELECT qe.s1, qe.s2, qe.s3, qe.s4, qe.s5, qe.s6, qe.s7, qe.s8, qe.s9,qe.s10,
qe.u5, qe.prime_specialty, qe.menum, qe.moderator, qe.db_match, qe.terr1,
qe.terr2, qe.terr3, qe.terr4, qe.terr5, qe.terr6, qe.terr7, qe.terr8,
ql.s1_name , ql.s2_name, ql.s3_name, ql.s4_name, ql.s5_name, ql.s6_name,
ql.s7_name, ql.s8_name, ql.s9_name, ql.s10_name, ql.u5_name, ql.terr1_name,
ql.terr2_name, ql.terr3_name, ql.terr4_name, ql.terr5_name, ql.terr6_name,
ql.terr7_name, ql.terr8_name
FROM Weekly_Reports_Query_Labels ql, Weekly_Reports_Query_Exists qe
where ql.projectcode = qe.projectcode
and qe.projectcode = '#session.project_code#'
</CFQUERY>

<cfif qMasterRow.RecordCount>
<cfoutput query="qMasterRow">
<cfset d1 = #decile1_exist#>
<cfset d1_name = #decile1_Name#>
<cfset d1_location = #decile1_location_number#>

<cfset d2 = #decile2_exist#>
<cfset d2_name = #decile2_Name#>
<cfset d2_location = #decile2_location_number#>

<cfset d3 = #decile3_exist#>
<cfset d3_name = #decile3_Name#>
<cfset d3_location = #decile3_location_number#>

<cfset program_name = #program_name#>

<cfset speaker = #speaker_info_exist#>
<cfset ci = #ci_data_exist#>
<cfset polling = #polling_data_exist#>

<cfset poll1 = #poll1#>
<cfset poll1_short=#poll1_short#>
<cfset poll1_long = #poll1_long#>
<cfset poll1_type=#poll1_type#>
<cfset poll1_nchoices=#poll1_nchoices#>
<cfset poll1_resp1 =#poll1_resp1#>
<cfset poll1_resp2 =#poll1_resp2#>
<cfset poll1_resp3 =#poll1_resp3#>
<cfset poll1_resp4 =#poll1_resp4#>
<cfset poll1_resp5 =#poll1_resp5#>
<cfset poll1_resp6 =#poll1_resp6#>
<cfset poll1_resp7 =#poll1_resp7#>
<cfset poll2 = #poll2#>
<cfset poll2_short=#poll2_short#>
<cfset poll2_long = #poll2_long#>
<cfset poll2_type=#poll2_type#>
<cfset poll2_nchoices=#poll2_nchoices#>
<cfset poll2_resp1 =#poll2_resp1#>
<cfset poll2_resp2 =#poll2_resp2#>
<cfset poll2_resp3 =#poll2_resp3#>
<cfset poll2_resp4 =#poll2_resp4#>
<cfset poll2_resp5 =#poll2_resp5#>
<cfset poll2_resp6 =#poll2_resp6#>
<cfset poll2_resp7 =#poll2_resp7#>
<cfset poll3 = #poll3#>
<cfset poll3_short=#poll3_short#>
<cfset poll3_long = #poll3_long#>
<cfset poll3_type=#poll3_type#>
<cfset poll3_nchoices=#poll3_nchoices#>
<cfset poll3_resp1 =#poll3_resp1#>
<cfset poll3_resp2 =#poll3_resp2#>
<cfset poll3_resp3 =#poll3_resp3#>
<cfset poll3_resp4 =#poll3_resp4#>
<cfset poll3_resp5 =#poll3_resp5#>
<cfset poll3_resp6 =#poll3_resp6#>
<cfset poll3_resp7 =#poll3_resp7#>
<cfset poll4 = #poll4#>
<cfset poll4_short=#poll4_short#>
<cfset poll4_long = #poll4_long#>
<cfset poll4_type=#poll4_type#>
<cfset poll4_nchoices=#poll4_nchoices#>
<cfset poll4_resp1 =#poll4_resp1#>
<cfset poll4_resp2 =#poll4_resp2#>
<cfset poll4_resp3 =#poll4_resp3#>
<cfset poll4_resp4 =#poll4_resp4#>
<cfset poll4_resp5 =#poll4_resp5#>
<cfset poll4_resp6 =#poll4_resp6#>
<cfset poll4_resp7 =#poll4_resp7#>
<cfset poll5 = #poll5#>
<cfset poll5_short=#poll5_short#>
<cfset poll5_long = #poll5_long#>
<cfset poll5_type=#poll5_type#>
<cfset poll5_nchoices=#poll5_nchoices#>
<cfset poll5_resp1 =#poll5_resp1#>
<cfset poll5_resp2 =#poll5_resp2#>
<cfset poll5_resp3 =#poll5_resp3#>
<cfset poll5_resp4 =#poll5_resp4#>
<cfset poll5_resp5 =#poll5_resp5#>
<cfset poll5_resp6 =#poll5_resp6#>
<cfset poll5_resp7 =#poll5_resp7#>
</cfoutput>

<cfoutput query="qMasterQueryRow">
<cfset s1 = #s1#>
<cfset s1_name = #s1_name#>
<cfset s2 = #s2#>
<cfset s2_name = #s2_name#>
<cfset s3 = #s3#>
<cfset s3_name = #s3_name#>
<cfset s4 = #s4#>
<cfset s4_name = #s4_name#>
<cfset s5 = #s5#>
<cfset s5_name = #s5_name#>
<cfset s6 = #s6#>
<cfset s6_name = #s6_name#>
<cfset s7 = #s7#>
<cfset s7_name = #s7_name#>
<cfset s8 = #s8#>
<cfset s8_name = #s8_name#>
<cfset s9 = #s9#>
<cfset s9_name = #s9_name#>
<cfset s10 = #s10#>
<cfset s10_name = #s10_name#>

<cfset u5=#u5#>
<cfset u5_name = #u5_name#>

<cfset prime_specialty=#prime_specialty#>
<cfset menum = #menum#>
<cfset moderator = #moderator#>
<cfset db_match = #db_match#>

<cfset terr1 = #terr1#>
<cfset terr2 = #terr2#>
<cfset terr3 = #terr3#>
<cfset terr4 = #terr4#>
<cfset terr5 = #terr5#>
<cfset terr6 = #terr6#>
<cfset terr7 = #terr7#>
<cfset terr8 = #terr8#>
<cfset terr1_name = #terr1_name#>
<cfset terr2_name = #terr2_name#>
<cfset terr3_name = #terr3_name#>
<cfset terr4_name = #terr4_name#>
<cfset terr5_name = #terr5_name#>
<cfset terr6_name = #terr6_name#>
<cfset terr7_name = #terr7_name#>
<cfset terr8_name = #terr8_name#>
</cfoutput>

<CFQUERY DATASOURCE="#application.WeeklyRptDSN#" NAME="qdecile_column_name">
	SELECT id,decile_column_name
	FROM Weekly_Reports_Decile_Column_Names
</CFQUERY>
<div class="main" align="left"> 
	<cfoutput>
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td width="100"></td>
		<td align="right"><strong>Project ID:</strong></td>
		<td>#session.project_code#</strong></td>
	</tr>
	<tr>
		<div class="bigquestion">
		<td width="100"></td>
		<td align="right">Program Name:</td>
		<td>#Trim(program_name)#</td>
		</div>
	</tr>	
	</tr>
	<tr>
		<div class="bigquestion">
		<td width="100"></td>
		<td align="right">Are there Speakers:</td>
		<td><cfif speaker EQ 1>Yes<CFELSE>No</cfif></td>
		</div>
	</tr>
	<tr>
		<div class="bigquestion">
		<td width="100"></td>
		<td align="right">Is there CI Data:</td>
		<td><cfif ci EQ 1>Yes<CFELSE>No</cfif></td>
		</div>
	</tr>
	<tr>
		<div class="bigquestion">
		<td width="100"></td>
		<td align="right">Polling Questions? </td>
		<td><cfif polling EQ 1>Yes<CFELSE>No</cfif></td>
		</div>
	</tr>
	</table>			
	<div style="<cfif polling NEQ 1>display: none;</cfif>margin-left:1em;" id="pollinglayer">
	<table cellpadding="2" cellspacing="2">
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>
		<td align="right">Polling Questions 1?</td>
		<td><cfif poll1 EQ 1>Yes<CFELSE>No</cfif></td>
	</tr>
	<cfif poll1 EQ 1>
	<tr>
		<td width="100"></td>
		<td align="right">Poll 1 Short Question:</td>
		<td>#Trim(poll1_short)#</td>
	</tr>
	<tr>
		<td width="100"></td>
		<td align="right">Poll 1 Full Question:</td>
		<td>#Trim(poll1_long)#</td>
	</tr>
	</cfif>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>
		<td align="right">Polling Questions 2?</td>
		<td><cfif poll2 EQ 1>Yes<CFELSE>No</cfif></td>
	</tr>
	<cfif poll2 EQ 1>
	<tr>
		<td width="100"></td>
		<td align="right">Poll 2 Short Question:</td>
		<td>#Trim(poll2_short)#</td>
	</tr>
	<tr>
		<td width="100"></td>
		<td align="right">Poll 2 Full Question:</td>
		<td>#Trim(poll2_long)#</td>
	</tr>
	</cfif>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>
		<td align="right">Polling Questions 3?</td>
		<td><cfif poll3 EQ 1>Yes<CFELSE>No</cfif></td>
	</tr>
	<cfif poll3 EQ 1>
	<tr>
		<td width="100"></td>
		<td align="right">Poll 3 Short Question:</td>
		<td>#Trim(poll3_short)#</td>
	</tr>
	<tr>
		<td width="100"></td>
		<td align="right">Poll 3 Full Question:</td>
		<td>#Trim(poll3_long)#</td>
	</tr>
	</cfif>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>
		<td align="right">Polling Questions 4?</td>
		<td><cfif poll4 EQ 1>Yes<CFELSE>No</cfif></td>
	</tr>
	<cfif poll4 EQ 1>
	<tr>
		<td width="100"></td>
		<td align="right">Poll 4 Short Question:</td>
		<td>#Trim(poll4_short)#</td>
	</tr>
	<tr>
		<td width="100"></td>
		<td align="right">Poll 4 Full Question:</td>
		<td>#Trim(poll4_long)#</td>
	</tr>
	</cfif>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>
		<td align="right">Polling Questions 5?</td>
		<td><cfif poll5 EQ 1>Yes<CFELSE>No</cfif></td>
	</tr>
	<cfif poll5 EQ 1>
	<tr>
		<td width="100"></td>
		<td align="right">Poll 5 Short Question:</td>
		<td>#Trim(poll5_short)#</td>
	</tr>
	<tr>
		<td width="100"></td>
		<td align="right">Poll 5 Full Question:</td>
		<td>#Trim(poll5_long)#</td>
	</tr>
	</cfif>
	</div> <!--- end of polling section division --->
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>	
		<td align="right">Decile 1:</td>
		<td><cfif d1 EQ 1>Yes<cfelse>No</cfif></td>
	</tr>
	<cfif d1 EQ 1>
		<tr>
			<td width="100"></td>	
			<td align="right">Decile 1 Name:</td>
			<td>#Trim(d1_name)#</td>
		</tr>
		<tr>
			<td width="100"></td>	
			<td align="right">Decile 1 Location:</td>
			<td>
				<cfif #qdecile_column_name.id# EQ #d1_location#>#qdecile_column_name.decile_column_name#</cfif>
			</td>
		</tr>
	</cfif>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>	
		<td align="right">Decile 2:</td>
		<td><cfif d2 EQ 1>Yes<cfelse>No</cfif></td>
	</tr>
	<cfif d2 EQ 1>
	<tr>
		<td width="100"></td>	
		<td align="right">Decile 2 Name:</td>
		<td>#Trim(d2_name)#</td>
	</tr>
	<tr>
		<td width="100"></td>	
		<td align="right">Decile 2 Location:</td>
		<td>
			<cfif #qdecile_column_name.id# EQ #d2_location#>#qdecile_column_name.decile_column_name#</cfif>
		</td>
	</cfif>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>	
		<td align="right">Decile 3:</td>
		<td><cfif d3 EQ 1>Yes<cfelse>No</cfif></td>
	</tr>
	<cfif d3 EQ 1>
	<tr>
		<td width="100"></td>	
		<td align="right">Decile 3 Name:</td>
		<td>#Trim(d3_name)#</td>
	</tr>
	<tr>
		<td width="100"></td>	
		<td align="right">Decile 3 Location:</td>
		<td>
			<cfif #qdecile_column_name.id# EQ #d3_location#>#qdecile_column_name.decile_column_name#</cfif>
		</td>
	</tr>
	</cfif>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>	
		<td align="right">Screener1:</td>
		<td><cfif s1 EQ 1>Yes<CFELSE>No</cfif></td>
	</tr>
	<cfif s1 EQ 1>
		<tr>
			<td width="100"></td>	
			<td align="right">Screener1 Name:</td>
			<td>#Trim(s1_name)#</td>
		</tr>
	</cfif>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>	
		<td align="right">Screener2:</td>
		<td><cfif s2 EQ 1>Yes<CFELSE>No</cfif></td>
	</tr>
	<cfif s2 EQ 1>
		<tr>
			<td width="100"></td>	
			<td align="right">Screener2 Name:</td>
			<td>#Trim(s2_name)#</td>
		</tr>
	</cfif>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>	
		<td align="right">Screener3:</td>
		<td><cfif s3 EQ 1>Yes<CFELSE>No</cfif></td>
	</tr>
	<cfif s3 EQ 1>
		<tr>
			<td width="100"></td>	
			<td align="right">Screener3 Name:</td>
			<td>#Trim(s3_name)#</td>
		</tr>
	</cfif>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>	
		<td align="right">Screener4:</td>
		<td><cfif s4 EQ 1>Yes<CFELSE>No</cfif></td>
	</tr>
	<cfif s4 EQ 1>
		<tr>
			<td width="100"></td>	
			<td align="right">Screener4 Name:</td>
			<td>#Trim(s4_name)#</td>
		</tr>
	</cfif>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>	
		<td align="right">Screener5:</td>
		<td><cfif s5 EQ 1>Yes<CFELSE>No</cfif></td>
	</tr>
	<cfif s5 EQ 1>
		<tr>
			<td width="100"></td>	
			<td align="right">Screener5 Name:</td>
			<td>#Trim(s5_name)#</td>
		</tr>
	</cfif>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>	
		<td align="right">Screener6:</td>
		<td><cfif s6 EQ 1>Yes<CFELSE>No</cfif></td>
	</tr>
	<cfif s6 EQ 1>
		<tr>
			<td width="100"></td>	
			<td align="right">Screener6 Name:</td>
			<td>#Trim(s6_name)#</td>
		</tr>
	</cfif>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>	
		<td align="right">Screener7:</td>
		<td><cfif s7 EQ 1>Yes<CFELSE>No</cfif></td>
	</tr>
	<cfif s7 EQ 1>
		<tr>
			<td width="100"></td>	
			<td align="right">Screener7 Name:</td>
			<td>#Trim(s7_name)#</td>
		</tr>
	</cfif>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>	
		<td align="right">Screener8:</td>
		<td><cfif s8 EQ 1>Yes<CFELSE>No</cfif></td>
	</tr>
	<cfif s8 EQ 1>
		<tr>
			<td width="100"></td>	
			<td align="right">Screener8 Name:<?td>
			<td>#Trim(s8_name)#</td>
		</tr>
	</cfif>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>	
		<td align="right">Screener9:<?td>
		<td><cfif s9 EQ 1>Yes<CFELSE>No</cfif><?td>
	</tr>
	<cfif s9 EQ 1>
		<tr>
			<td width="100"></td>	
			<td align="right">Screener9 Name:</td>
			<td>#Trim(s9_name)#</td>
		</tr>
	</cfif>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>	
		<td align="right">Screener10:</td>
		<td><cfif s10 EQ 1>Yes<CFELSE>No</cfif></td>
	</tr>
	<cfif s10 EQ 1>
		<tr>
			<td width="100"></td>	
			<td align="right">Screener10 Name:</td>
			<td>#Trim(s10_name)#</td>
		</tr>
	</cfif>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>	
		<td align="right">User5:</td>
		<td><cfif u5 EQ 1>Yes<CFELSE>No</cfif></td>
	</tr>
	<cfif u5 EQ 1>
		<tr>
			<td width="100"></td>	
			<td align="right">User 5 Name:</td>
			<td>#Trim(u5_name)#</td>
		</tr>
	</cfif>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>	
		<td align="right">Prime Specialty:</td>
		<td><cfif prime_specialty EQ 1>Yes<CFELSE>No</cfif></td>
	</tr>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>	
		<td align="right">Menum:</td>
		<td><cfif menum EQ 1>Yes<CFELSE>No</cfif></td>
	</tr>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>	
		<td align="right">Moderator:</td>
		<td><cfif moderator EQ 1>Yes<CFELSE>No</cfif></td>
	</tr>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>	
		<td align="right">DB Match:</td>
		<td><cfif db_match EQ 1>Yes<CFELSE>No</cfif></td>
	</tr>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>		
		<td align="right">Territory 1 Rep:</td>
		<td><cfif terr1 EQ 1>Yes<CFELSE>No</cfif></td>
	</tr>
	<cfif terr1 EQ 1>
		<tr>
			<td width="100"></td>		
			<td align="right">Territory 1 Name:</td>
			<td>#Trim(terr1_name)#</td>
		</tr>
	</cfif>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>		
		<td align="right">Territory 2 Rep:</td>
		<td><cfif terr2 EQ 1>Yes<CFELSE>No</cfif></td>
	</tr>
	<cfif terr2 EQ 1>
		<tr>
			<td width="100"></td>		
			<td align="right">Territory 2 Name:</td>
			<td>#Trim(terr2_name)#</td>
		</tr>
	</cfif>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>		
		<td align="right">Territory 3 Rep:</td>
		<td><cfif terr3 EQ 1>Yes<CFELSE>No</cfif></td>
	</tr>
	<cfif terr3 EQ 1>
		<tr>
			<td width="100"></td>		
			<td align="right">Territory 3 Name:</td>
			<td>#Trim(terr3_name)#</td>
		</tr>
	</cfif>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>		
		<td align="right">Territory 4 Rep:</td>
		<td><cfif terr4 EQ 1>Yes<CFELSE>No</cfif></td>
	</tr>
	<cfif terr4 EQ 1>
		<tr>
			<td width="100"></td>		
			<td align="right">Territory 4 Name:</td>
			<td>#Trim(terr4_name)#</td>
		</tr>
	</cfif>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>		
		<td align="right">Territory 5 Rep:</td>
		<td><cfif terr5 EQ 1>Yes<CFELSE>No</cfif></td>
	</tr>
	<cfif terr5 EQ 1>
		<tr>
			<td width="100"></td>		
			<td align="right">Territory 5 Name:</td>
			<td>#Trim(terr5_name)#</td>
		</tr>
	</cfif>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>		
		<td align="right">Territory 6 Rep:</td>
		<td><cfif terr6 EQ 1>Yes<CFELSE>No</cfif></td>
	</tr>
	<cfif terr6 EQ 1>
		<tr>
			<td width="100"></td>		
			<td align="right">Territory 6 Name:</td>
			<td>#Trim(terr6_name)#</td>
		</tr>
	</cfif>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>		
		<td align="right">Territory 7 Rep:</td>
		<td><cfif terr7 EQ 1>Yes<CFELSE>No</cfif></td>
	</tr>
	<cfif terr7 EQ 1>
		<tr>
			<td width="100"></td>		
			<td align="right">Territory 7 Name:</td>
			<td>#Trim(terr7_name)#</td>
		</tr>
	</cfif>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>		
		<td align="right">Territory 8 Rep:</td>
		<td><cfif terr8 EQ 1>Yes<CFELSE>No</cfif></td>
	</tr>
	<cfif terr8 EQ 1>
		<tr>
			<td width="100"></td>		
			<td align="right">Territory 8 Name:</td>
			<td>#Trim(terr8_name)#</td>
		</tr>
	</cfif>
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>		
		<td colspan="2">
			<FORM>
				<INPUT type="button" value=" Weekly Report Setup " onClick="location.href='rpt_weeklyReportsSetup.cfm'">
			</FORM>
		</td>
	</tr>
	</cfoutput>
	</table>
	</div>
<cfelse>
	<table cellpadding="2" cellspacing="2">
	<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>		
		<td colspan="2">
			Records Do Not exist for <cfoutput>#session.project_code#</cfoutput>. <br><br>
			Click <a href="dsp_weeklyReportsSetup_add.cfm">HERE</a> to add information for code <cfoutput>#session.project_code#</cfoutput>?
		</td>
	</tr>
	</table>
</cfif>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

