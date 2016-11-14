<!--- 
	*****************************************************************************************
	Name:		report_mod_ind2.cfm		
	Function:	pulls individual speaker schedule - pulls current week until Friday after 3pm, 
				then pulls next week 	
	*****************************************************************************************
--->


		<HTML>
			<HEAD>
				<TITLE>Moderator Schedule</TITLE>
				
				<LINK REL=STYLESHEET HREF="PIW1STYLE.CSS" TYPE="TEXT/CSS">
				
				<STYLE>
					TD {
							font-family : Verdana, Geneva, Arial;
							font-size : xx-small;
							text-align: left;
							background-color: #FFFFFF;
						}
			
					.DAYS {
							font-family : Verdana, Geneva, Arial;
							font-size : xx-small;
							font-weight: bold;
							text-align: center;
						}
					.WEEKS {
							font-family : ArialBold;
							font-size : xx-small;
							text-align: center;
						}
				</STYLE>		
				
				<!--- ***** This is for testing purposes. Needs to equal user id 
				User name must go to speaker table and pull out speaker id. speaker id does not 
				match user id******--->
				<!--- <cfset session.mod_id = 5159> --->
				 <!--- *************************************************** --->
			</HEAD>
			
			<BODY BGCOLOR="FFFFFF" MARGINHEIGHT="0" MARGINWIDTH="0">
			<cfif session.mod_id LT 1>
				<strong>You do no have the correct permissions to view this report. For more information, 			contact IT.</strong>
			
			<cfelse>
				<!--- store today's date --->
				<cfset today = CreateODBCDate(Now())>
				<!--- store what day of the week it is...Sunday=1, Monday=2, tuesday=3, etc --->
				<cfset todayint = DayofWeek(#today#)>
				<!--- set what hour it is (1-23) --->
				<cfset todayhour = Hour(#today#)>
				<!--- if today Sun, set begin_date to today --->
				<cfif todayint EQ 1> 
					<cfset begin_date = #today#>
				<!--- if today is Sat., set begin_date to tomorrow --->	
				<cfelseif todayint EQ 7>
					<cfset begin_date = DateAdd("d",1,#today#)>
				<!--- if today is Fri. and after 3:00pm CT, set begin_date to Sun. --->
				<cfelseif todayint EQ 6 AND todayhour GTE 15>
					<cfset begin_date = DateAdd("d",2,#today#)>
				<!--- if today is mon, tues, wed, or thurs, set begin_date to previous Sun. --->		
				<cfelse>
					<cfset begin_date = DateAdd("d",-#todayint# + 1,#today#)>
				</cfif>
				
				
				<cfset end_date = DateAdd("d",6,#begin_date#)>
				
				
			<!--- get mod name --->
			<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetName">
				SELECT DISTINCT firstname, lastname
				FROM spkr_table
				WHERE speaker_id='#session.mod_id#' AND type='MOD'; 
			</CFQUERY>
			
			<cfoutput>
			<!--- Pull meetings with speaker name --->
			<CFQUERY DATASOURCE="#session.pdbs#" NAME="Getm" USERNAME="#session.pdbu#" PASSWORD="#session.pdbp#">
				SELECT m.project_code, m.start_time, m.end_time, m.year, m.month, m.day, m.meeting_date, m.speaker_id, s.lastname, s.firstname
				FROM PMSProd.dbo.schedule_meeting_time m, speaker.dbo.spkr_table s
				WHERE m.moderator_id = '#session.mod_id#' AND (m.meeting_date BETWEEN #begin_date# AND #end_date#)
					AND m.speaker_id *= s.speaker_id AND m.status = 0
				ORDER BY m.meeting_date, m.project_code					
			</CFQUERY>
			</cfoutput>
			<!--- <cfoutput query="Getm">test:#rowid#<br></cfoutput> --->
			
		<!--- set array to hold meetings --->
		<CFSET aGetm=ArrayNew(2)>
		<cfoutput query="Getm">
		<!--- 		<cfinvoke 
				component="pms.com.cfc_time_conversion" 
				method="toCivilian" 
				returnVariable="CivilianTime" 
				BeginMilitary="#start_time#"
				EndMilitary="#end_time#"
				>
				<cfscript>
				oCivTime = createObject("component","pms.com.cfc_time_conversion");
				TheTime = oCivTime.ConCatTime(#CivilianTime#);
				</cfscript> --->
		
		<cfset aGetm[CurrentRow][1] = CreateDate(#Getm.year#,#Getm.month#,#Getm.day#)>
		<cfset aGetm[CurrentRow][2] = #Getm.project_code#>
		<!--- <cfset aGetm[CurrentRow][3] = #TheTime#> --->
		<cfset aGetm[CurrentRow][3] = "testtime">
		<cfset aGetm[CurrentRow][4] = 0>
		<cfset aGetm[CurrentRow][5] = #Getm.firstname# & " " & #Getm.lastname#>
		</cfoutput>	
			
		<!--- set new array to hold moderator's 4 week schedule --->	
		<CFSET aMeetings=ArrayNew(2)>

		<cfset i = 1>
		<!--- set variable with the first day of the schedule --->
		<cfset xstart = DateFormat("#begin_date#", "m/d/yy")>
		
	<!--- outer loop through each day of the moderator's 4 week schedule --->
	<CFLOOP from="1" to="7" index="i">
		<!--- set the 1st cell with the date, set the other 4 with 0 just to hold place for now --->
		<cfset aMeetings[#i#][1] = DateFormat("#xstart#", "m/d/yy")>
		<cfset aMeetings[#i#][2] = 0>
		<cfset aMeetings[#i#][3] = 0>
		<cfset aMeetings[#i#][4] = 0>
		<cfset aMeetings[#i#][5] = 0>
		<cfset aMeetings[#i#][6] = DayofWeek(#xstart#)>
		<cfset aMeetings[#i#][7] = Week(#xstart#)>
				
			<!--- inner loop goes through meeting pulled from Getm query --->
			<cfloop from="1" to="#ArrayLen(aGetm)#" step="1" index="x">
				<!--- if day of schedule has a meeting scheduled on it, set 2nd through 5 cells with meeting info --->
				<cfif aMeetings[#i#][1] EQ DateFormat("#aGetm[x][1]#", "m/d/yy")>
					<cfset aMeetings[#i#][2] = #Evaluate("aGetm[x][2]")#>
					<cfset aMeetings[#i#][3] = #Evaluate("aGetm[x][3]")#>
					<cfset aMeetings[#i#][4] = #Evaluate("aGetm[x][4]")#>
					<cfset aMeetings[#i#][5] = #Evaluate("aGetm[x][5]")#>
					<!--- since one meeting had been found for this day, set another row in case more meetings are
					scheduled for this day --->
					<cfset i = i + 1>
					<cfset aMeetings[#i#][1] = DateFormat("#xstart#", "m/d/yy")>
					<cfset aMeetings[#i#][2] = 0>
					<cfset aMeetings[#i#][3] = 0>
					<cfset aMeetings[#i#][4] = 0>
					<cfset aMeetings[#i#][5] = 0>
					<cfset aMeetings[#i#][6] = DayofWeek(#xstart#)>
					<cfset aMeetings[#i#][7] = Week(#xstart#)>
				</cfif>
				</cfloop>
					<!--- set next row --->
					<cfset i = i + 1>
					<cfset xstart = DateAdd("d",1,#xstart#)>
				</cfloop>
				
		<!--- <cfloop from="1" to="#ArrayLen(aGetm)#" index="x" step="1">
			<cfoutput>#aGetm[x][1]#:</cfoutput>
		</cfloop> --->
	
<!--- Display schedule - most cfifs are for the table border --->		
<TABLE ALIGN="center" WIDTH="650" BORDER="0" CELLPADDING="2" CELLSPACING="0">
	<cfoutput>
	<tr>
		<th align="center" colspan="4"><strong><font size="3">Schedule for #GetName.firstname#&nbsp;#GetName.lastname#</font></strong></th>
	</tr>
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	</cfoutput>
	<tr>
		<td class="header" style="border-left: solid 1px #6699FF; border-top: solid 1px #6699FF;">&nbsp;</td>
		<td class="header" style="border-left: solid 1px #6699FF; border-top: solid 1px #6699FF;"><strong>Project Code</strong></td>
		<td class="header" style="border-left: solid 1px #6699FF; border-top: solid 1px #6699FF;"><strong>Meeting Times</strong></td>
		<td class="header" style="border-left: solid 1px #6699FF; border-top: solid 1px #6699FF; border-right: solid 1px #6699FF;"><strong>Speaker</strong></td>
	</tr>

	<!--- loop through 4 weeks --->
	<cfloop from="1" to="#ArrayLen(aMeetings)#" index="x" step="1">
	<!--- i saves the place of the previous row --->	
		<cfset i = x>
		<cfif i GTE 2><cfset i = i - 1></cfif> 
	
	<cfoutput>

		<!--- if day is sunday (1st day of week) put up a blue divider --->
		<cfif #aMeetings[x][6]# EQ 1>
	<tr>
		<td style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF; border-right: solid 1px ##6699FF;" class="header" colspan="4"><strong>Week #aMeetings[x][7]#</strong></td>
	</tr>
		</cfif>

	
	<tr>
	<!--- if this is not the first  array row... --->
	<cfif i GT 1>
		<!--- if current row's date does not match previous row's date, display it --->
		<cfif #aMeetings[x][1]# NEQ #aMeetings[i][1]#>
		<td style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">#aMeetings[x][1]#</td>
		<cfelse>
		<td style="border-left: solid 1px ##6699FF;">&nbsp;</td>
		</cfif>
	<!--- if this IS the first row, display the date --->	
	<cfelse>
		<td style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">#aMeetings[x][1]#</td>
	</cfif>
		
<!--- if there is a meeting scheduled... --->		
<cfif #aMeetings[x][2]# NEQ 0>
	<!--- if this is the first row, display meeting info --->
	<cfif i GT 1>
		<!--- if date of meeting is same as date of current row, display info --->
		<cfif #aMeetings[x][1]# EQ #aMeetings[i][1]#>
		<td style="border-left: solid 1px ##6699FF;"><strong>#aMeetings[x][2]#</strong>&nbsp;</td>
		<td style="border-left: solid 1px ##6699FF;"><strong>#aMeetings[x][3]#</strong>&nbsp;</td>
		<!--- <td style="border-left: solid 1px ##6699FF;"><strong>#aMeetings[x][4]#</strong></td> --->
		<td style="border-left: solid 1px ##6699FF; border-right: solid 1px ##6699FF;"><strong>#aMeetings[x][5]#</strong>&nbsp;</td>
		<!--- <td>#x# - #i#</td> --->
		<cfelse>
		<td style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>#aMeetings[x][2]#</strong>&nbsp;</td>
		<td style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>#aMeetings[x][3]#</strong>&nbsp;</td>
		<!--- <td style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>#aMeetings[x][4]#</strong></td> --->
		<td style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF; border-right: solid 1px ##6699FF;"><strong>#aMeetings[x][5]#</strong>&nbsp;</td>
		<!--- <td>#x# - #i##aMeetings[i][1]#</td> --->
		</cfif>
	<!--- if this is not first row, display meeting info (td borders differ from above) --->	
	<cfelse>
		<td style="border-left: solid 1px ##6699FF;"><strong>#aMeetings[x][2]#</strong>&nbsp;</td>
		<td style="border-left: solid 1px ##6699FF;"><strong>#aMeetings[x][3]#</strong>&nbsp;</td>
		<!--- <td style="border-left: solid 1px ##6699FF;"><strong>#aMeetings[x][4]#</strong></td> --->
		<td style="border-left: solid 1px ##6699FF; border-right: solid 1px ##6699FF;"><strong>#aMeetings[x][5]#</strong>&nbsp;</td>
		<!--- <td>#x# - #i#</td> --->
	</cfif>
<!--- if there are no meetings scheduled for this day... --->		
<cfelse>
	<!--- if first row, put up empty tds --->
	<cfif i GT 1>
		<cfif #aMeetings[x][1]# EQ #aMeetings[i][1]#>
		<td style="border-left: solid 1px ##6699FF;">&nbsp;</td>
		<td style="border-left: solid 1px ##6699FF;">&nbsp;</td>
		<!--- <td style="border-left: solid 1px ##6699FF;">&nbsp;</td> --->
		<td style="border-left: solid 1px ##6699FF; border-right: solid 1px ##6699FF;">&nbsp;</td>
		<cfelse>
		<td style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">&nbsp;</td>
		<td style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">&nbsp;</td>
		<!--- <td style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">&nbsp;</td> --->
		<td style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF; border-right: solid 1px ##6699FF;">&nbsp;</td>
		<!--- <td>&nbsp;</td> --->
		</cfif>
	<cfelse>
		<td style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">&nbsp;</td>
		<td style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">&nbsp;</td>
		<!--- <td style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">&nbsp;</td> --->
		<td style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF; border-right: solid 1px ##6699FF;">&nbsp;</td>
	</cfif>			
</cfif>
	</tr>
	</cfoutput>
		
	</cfloop>
	<tr>
		<td style="border-left: solid 1px #6699FF; border-bottom: solid 1px #6699FF;">&nbsp;</td>
		<td style="border-left: solid 1px #6699FF; border-bottom: solid 1px #6699FF;">&nbsp;</td>
		<td style="border-left: solid 1px #6699FF; border-bottom: solid 1px #6699FF;">&nbsp;</td>
		<!--- <td style="border-left: solid 1px #6699FF; border-bottom: solid 1px #6699FF;">&nbsp;</td> --->
		<td style="border-left: solid 1px #6699FF; border-bottom: solid 1px #6699FF; border-right: solid 1px #6699FF;">&nbsp;</td>
	</tr>
</table>			
	<cfoutput>#begin_date# AND #end_date#</cfoutput>		
			
</cfif>				
</BODY>
</HTML>
		

