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
	poll.poll1, poll.poll1_short, poll.poll1_long,
	poll.poll2, poll.poll2_short, poll.poll2_long,
	poll.poll3, poll.poll3_short, poll.poll3_long
	FROM Weekly_Reports_Program_Information pi,
	Weekly_Reports_Decile_Information di, Weekly_Reports_Poll poll
	where pi.projectcode = '#session.project_code#' and di.projectcode like '#session.project_code#'
	and poll.projectcode ='#session.project_code#'

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
<cfset poll2 = #poll2#>
<cfset poll2_short=#poll2_short#>
<cfset poll2_long = #poll2_long#>
<cfset poll3 = #poll3#>
<cfset poll3_short=#poll3_short#>
<cfset poll3_long = #poll3_long#>
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



<div class="main" align="center"> 
		<strong>Project Information (<cfoutput>#session.project_code#</cfoutput>)</strong>
			<p align="center">
				<div>
				<div class="bigquestion">Program Name: <cfoutput>#Trim(program_name)#</cfoutput> <br>
				</div>
				<div class="bigquestion">Are there Speakers: <cfif speaker EQ 1>Yes<CFELSE>No</cfif><br>
				</div>
				<div class="bigquestion">Is there CI Data: <cfif ci EQ 1>Yes<CFELSE>No</cfif><br>
				</div>
				<div class="bigquestion">Polling Questions? <cfif polling EQ 1>Yes<CFELSE>No</cfif>
				</div>
				</div>
				<div style="<cfif polling NEQ 1>display: none;</cfif>margin-left:1em;" id="pollinglayer">
					<div class="question">
						Polling Questions #1? <cfif poll1 EQ 1>Yes<CFELSE>No</cfif>
					</div>
					<div style="<cfif poll1 NEQ 1>display: none;</cfif>margin-left:1em;">
						Poll 1 Short Question: <cfoutput>#Trim(poll1_short)#</cfoutput><br>
						Poll 1 Full Question: <cfoutput>#Trim(poll1_long)#</cfoutput>
					</div>

					<div class="question">
						Polling Questions #2: <cfif poll1 EQ 2>Yes<CFELSE>No</cfif>
					</div>
					<div style="<cfif poll2 NEQ 1>display: none;</cfif>margin-left:1em;">
						Poll 2 Short Question: <cfoutput>#Trim(poll2_short)#</cfoutput><br>
						Poll 2 Full Question: <cfoutput>#Trim(poll2_long)#</cfoutput>
					</div>

					<div class="question">
						Polling Questions #3: <cfif poll1 EQ 3>Yes<CFELSE>No</cfif>
					</div>
					<div style="<cfif poll3 NEQ 1>display: none;</cfif>margin-left:1em;">
						Poll 3 Short Question: <cfoutput>#Trim(poll3_short)#</cfoutput><br>
						Poll 3 Full Question: <cfoutput>#Trim(poll3_long)#</cfoutput>
					</div>
				</div>
				<div style="" id="decilelayer">
					<div style="" id="" class="bigquestion">
						Decile 1: <cfif d1 EQ 1>Yes<cfelse>No</cfif>
					</div>
					<div style="<cfif d1 NEQ 1>display: none;</cfif>margin-left:1em;">
						Decile 1 Name: <cfoutput>#Trim(d1_name)#</cfoutput><br>
						Decile 1 Location:
							<cfoutput query="qdecile_column_name">
							<cfif #id# EQ #d1_location#>#decile_column_name#</cfif>
							</cfoutput>
					</div>

					<div style="" id="" class="bigquestion">
						Decile 2: <cfif d2 EQ 1>Yes<cfelse>No</cfif>
					</div>
					<div style="<cfif d2 NEQ 1>display: none;</cfif>margin-left:1em;">
						Decile 2 Name: <cfoutput>#Trim(d2_name)#</cfoutput><br>
						Decile 2 Location:
							<cfoutput query="qdecile_column_name">
							<cfif #id# EQ #d2_location#>#decile_column_name#</cfif>
							</cfoutput>
					</div>

					<div style="" id="" class="bigquestion">
						Decile 3: <cfif d3 EQ 1>Yes<cfelse>No</cfif>
					</div>
					<div style="<cfif d3 NEQ 1>display: none;</cfif>margin-left:1em;">
						Decile 3 Name: <cfoutput>#Trim(d3_name)#</cfoutput><br>
						Decile 3 Location:
							<cfoutput query="qdecile_column_name">
							<cfif #id# EQ #d3_location#>#decile_column_name#</cfif>
							</cfoutput>
					</div>
				</div>
<div class="bigquestion">
Screener1: <cfif s1 EQ 1>Yes<CFELSE>No</cfif>
</div>
<div style="<cfif s1 NEQ 1>display: none;</cfif>margin-left:1em;" id="s1layer">
Screener1 Name: <cfoutput>#Trim(s1_name)#</cfoutput> <br>
</div>
<div class="bigquestion">
Screener2: <cfif s2 EQ 1>Yes<CFELSE>No</cfif>
</div>
<div style="<cfif s2 NEQ 1>display: none;</cfif>margin-left:1em;" id="s2layer">
Screener2 Name: <cfoutput>#Trim(s2_name)#</cfoutput> <br>
</div>
<div class="bigquestion">
Screener3: <cfif s3 EQ 1>Yes<CFELSE>No</cfif>
</div>
<div style="<cfif s3 NEQ 1>display: none;</cfif>margin-left:1em;" id="s3layer">
Screener3 Name: <cfoutput>#Trim(s3_name)#</cfoutput><br>
</div>

<div class="bigquestion">
Screener4: <cfif s4 EQ 1>Yes<CFELSE>No</cfif>
</div>
<div style="<cfif s4 NEQ 1>display: none;</cfif>margin-left:1em;" id="s4layer">
Screener4 Name: <cfoutput>#Trim(s4_name)#</cfoutput><br>
</div>
<div class="bigquestion">
Screener5: <cfif s5 EQ 1>Yes<CFELSE>No</cfif>
</div>
<div style="<cfif s5 NEQ 1>display: none;</cfif>margin-left:1em;" id="s5layer">
Screener5 Name: <cfoutput>#Trim(s5_name)#</cfoutput><br>
</div>
<div class="bigquestion">
Screener6: <cfif s6 EQ 1>Yes<CFELSE>No</cfif>
</div>
<div style="<cfif s6 NEQ 1>display: none;</cfif>margin-left:1em;" id="s6layer">
Screener6 Name: <cfoutput>#Trim(s6_name)#</cfoutput><br>
</div>
<div class="bigquestion">
Screener7: <cfif s7 EQ 1>Yes<CFELSE>No</cfif>
</div>
<div style="<cfif s7 NEQ 1>display: none;</cfif>margin-left:1em;" id="s7layer">
Screener7 Name: <cfoutput>#Trim(s7_name)#</cfoutput><br>
</div>
<div class="bigquestion">
Screener8: <cfif s8 EQ 1>Yes<CFELSE>No</cfif>
</div>
<div style="<cfif s8 NEQ 1>display: none;</cfif>margin-left:1em;" id="s8layer">
Screener8 Name: <cfoutput>#Trim(s8_name)#</cfoutput><br>
</div>
<div class="bigquestion">
Screener9: <cfif s9 EQ 1>Yes<CFELSE>No</cfif>
</div>
<div style="<cfif s9 NEQ 1>display: none;</cfif>margin-left:1em;" id="s9layer">
Screener9 Name: <cfoutput>#Trim(s9_name)#</cfoutput><br>
</div>
<div class="bigquestion">
Screener10: <cfif s10 EQ 1>Yes<CFELSE>No</cfif>
</div>
<div style="<cfif s10 NEQ 1>display: none;</cfif>margin-left:1em;" id="s10layer">
Screener10 Name: <cfoutput>#Trim(s10_name)#</cfoutput><br>
</div>


<div class="bigquestion">
User5: <cfif u5 EQ 1>Yes<CFELSE>No</cfif>
</div>
<div style="<cfif u5 NEQ 1>display: none;</cfif>margin-left:1em;" id="u5layer">
User 5 Name: <cfoutput>#Trim(u5_name)#</cfoutput><br>
</div>

<div class="bigquestion">Prime Specialty: <cfif prime_specialty EQ 1>Yes<CFELSE>No</cfif></div>

<div class="bigquestion">Menum: <cfif menum EQ 1>Yes<CFELSE>No</cfif></div>

<div class="bigquestion">Moderator: <cfif moderator EQ 1>Yes<CFELSE>No</cfif></div>

<div class="bigquestion">DB Match: <cfif db_match EQ 1>Yes<CFELSE>No</cfif></div>

<div class="bigquestion">
Territory 1 Name: <cfif terr1 EQ 1>Yes<CFELSE>No</cfif>
</div>
<div style="<cfif terr1 NEQ 1>display: none;</cfif>margin-left:1em;" id="terr1layer">
Territory 1 Name: <cfoutput>#Trim(terr1_name)#</cfoutput> <br>
</div>

<div class="bigquestion">
Territory 2 Name: <cfif terr2 EQ 1>Yes<CFELSE>No</cfif>
</div>
<div style="<cfif terr2 NEQ 1>display: none;</cfif>margin-left:1em;" id="terr2layer">
Territory 2 Name: <cfoutput>#Trim(terr2_name)#</cfoutput> <br>
</div>

<div class="bigquestion">
Territory 3 Name: <cfif terr3 EQ 1>Yes<CFELSE>No</cfif>
</div>
<div style="<cfif terr3 NEQ 1>display: none;</cfif>margin-left:1em;" id="terr3layer">
Territory 3 Name: <cfoutput>#Trim(terr3_name)#</cfoutput> <br>
</div>

<div class="bigquestion">
Territory 4 Name: <cfif terr4 EQ 1>Yes<CFELSE>No</cfif>
</div>
<div style="<cfif terr4 NEQ 1>display: none;</cfif>margin-left:1em;" id="terr4layer">
Territory 4 Name: <cfoutput>#Trim(terr4_name)#</cfoutput> <br>
</div>

<div class="bigquestion">
Territory 5 Name: <cfif terr5 EQ 1>Yes<CFELSE>No</cfif>
</div>
<div style="<cfif terr5 NEQ 1>display: none;</cfif>margin-left:1em;" id="terr5layer">
Territory 5 Name: <cfoutput>#Trim(terr5_name)#</cfoutput> <br>
</div>

<div class="bigquestion">
Territory 6 Name: <cfif terr6 EQ 1>Yes<CFELSE>No</cfif>
</div>
<div style="<cfif terr6 NEQ 1>display: none;</cfif>margin-left:1em;" id="terr6layer">
Territory 6 Name: <cfoutput>#Trim(terr6_name)#</cfoutput> <br>
</div>

<div class="bigquestion">
Territory 7 Name: <cfif terr7 EQ 1>Yes<CFELSE>No</cfif>
</div>
<div style="<cfif terr7 NEQ 1>display: none;</cfif>margin-left:1em;" id="terr7layer">
Territory 7 Name: <cfoutput>#Trim(terr7_name)#</cfoutput> <br>
</div>

<div class="bigquestion">
Territory 8 Name: <cfif terr8 EQ 1>Yes<CFELSE>No</cfif>
</div>
<div style="<cfif terr8 NEQ 1>display: none;</cfif>margin-left:1em;" id="terr8layer">
Territory 8 Name: <cfoutput>#Trim(terr8_name)#</cfoutput> <br>
</div>

				</div>

				</p>
				<p align="center">
					<FORM>
					<INPUT type="button" value=" Weekly Report Setup " onClick="location.href='rpt_weeklyReportsSetup.cfm'">
					</FORM>
				</P>
				</form>
</div>
<cfelse>
<div class="main">
Records Do Not exist for <cfoutput>#session.project_code#</cfoutput>. <br><br>
Would you like to <a href="rpt_weeklyReportsSetup_add.cfm">add</a> information for code <cfoutput>#session.project_code#</cfoutput>?
</div>
</cfif>
</div>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

