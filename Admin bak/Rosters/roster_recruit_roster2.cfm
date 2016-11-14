<!--------------------------------------------------------------------
-- roster_recruit_roster2.cfm
-- Ben Jurevicius - 06252003
--
-- Pulls roster data based on the dates and recruiter selected in roster_recruit_roster.cfm
--
-- This program has basic 2 steps:
-- 1) pull and tabluate all the data by meetingcode.
-- 2) generate recruiter roster in CV format.
--
-----------------------------------------------------------------------
--->

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Recruiter Attendance Rosters - Pull Data" showCalendar="0">

<cfset ary_meetings = ArrayNew(2)>
<cfset sSource = "">
<CFSWITCH EXPRESSION="#URL.a#">
<!--- Step #1 --->
<CFCASE VALUE="1">
	<cfif #form.recruiter# EQ "Blitz"><cfset sSource = "BLZW"></cfif>
	<cfif #form.recruiter# EQ "Synergy"><cfset sSource = "SYN"></cfif>
	<cfif #form.recruiter# EQ "Prairie"><cfset sSource = "Prairie"></cfif>
	<cfif #form.recruiter# EQ "Med Con"><cfset sSource = "Med Con"></cfif>
	<cfif #form.recruiter# EQ "HealthStream"><cfset sSource = "HealthStream"></cfif>
	<!--- Pull appropriate row for the selected project code --->
	<CFQUERY DATASOURCE="#application.rosterDSN#"  NAME="q1">
		select meetingcode, apptdate, count(meetingcode) as cnt from roster
			where apptdate between '#form.begin_date#' and '#form.end_date#' and (source LIKE '#sSource#%' or source LIKE '#form.recruiter#')
			group by meetingcode, apptdate
			order by meetingcode, apptdate
	</CFQUERY>
	<!--- save q1 results in array --->
	<cfoutput query="q1">
		<cfset ary_meetings[#q1.currentrow#][1] = #trim(q1.meetingcode)#>
		<cfset ary_meetings[#q1.currentrow#][2] = #trim(q1.apptdate)#>
		<cfset ary_meetings[#q1.currentrow#][3] = #q1.cnt#>
		<!--- get number of attended --->
		<CFQUERY DATASOURCE="#application.rosterDSN#"  NAME="q1a">
			select count(attended) as attends from roster
				where apptdate between '#form.begin_date#' and '#form.end_date#'
					and meetingcode = '#trim(q1.meetingcode)#'
					and attended = 0
		</CFQUERY>
		<cfset ary_meetings[#q1.currentrow#][4] = #q1a.attends#>
		<!--- get number of non-attended --->
		<CFQUERY DATASOURCE="#application.rosterDSN#"  NAME="q1b">
			select count(attended) as nonattends from roster
				where apptdate between '#form.begin_date#' and '#form.end_date#'
					and meetingcode = '#trim(q1.meetingcode)#'
					and (attended <> 0 or attended is null)
		</CFQUERY>
		<cfset ary_meetings[#q1.currentrow#][5] = #q1b.nonattends#>
	</cfoutput>

	<table border="0" cellpadding="3" cellspacing="1" align="center">
	<cfoutput>
	<tr>
		<td colspan=6><b>Attendance results for <u>#form.recruiter#</u> by meeting for dates: #form.begin_date# - #form.end_date#</b></td>
	</tr>
	</cfoutput>
	<tr class="header">
		<td><b>Appt. Date</b></td>
		<td><b>Meeting Code</b></td>
		<td><b>Invitees</b></td>
		<td><b>Attendees</b></td>
		<td><b>Non-Attendees</b></td>
		<td>&nbsp;</td>
	</tr>
	<cfset m_grand_tot = 0>
	<cfset a_grand_tot = 0>
	<cfset b_grand_tot = 0>
	<cfset c_grand_tot = 0>
	<cfset showrate = 0>
	<cfloop index="x" from="1" to="#ArrayLen(ary_meetings)#">
		<cfoutput>
		<tr <cfif x MOD(2) EQ 1>bgcolor="##eeeeee"</cfif>>
			<td>#DateFormat(ary_meetings[x][2], "mm/dd/yyyy")#</b></td>
			<td>#ary_meetings[x][1]#</b></td>
			<td>#ary_meetings[x][3]#</b></td>
			<td>#ary_meetings[x][4]#</b></td>
			<td>#ary_meetings[x][5]#</b></td>
			<cfset m_grand_tot = m_grand_tot + 1>
			<cfset a_grand_tot = a_grand_tot + #ary_meetings[x][3]#>
			<cfset b_grand_tot = b_grand_tot + #ary_meetings[x][4]#>
			<cfset c_grand_tot = c_grand_tot + #ary_meetings[x][5]#>
			<td>&nbsp;</td>
		</tr>
		</cfoutput>
	</cfloop>
	<cfoutput>
	<tr>
		<td width=50>&nbsp;</td>
		<td>&nbsp;</td>
		<td colspan=5 align=right><b>========================================</b></td>
	</tr>
	<cfset showrate = (#b_grand_tot# / #a_grand_tot#) * 100>
	<tr>
		<td width=50>&nbsp;</td>
		<td align=right><b>Total </b></td>
		<td><b>#m_grand_tot# Meetings</b></td>
		<td><b>#a_grand_tot#</b></td>
		<td><b>#b_grand_tot#</b></td>
		<td><b>#c_grand_tot#</b></td>
		<td><b>#numberFormat(showrate, "000.0000")# % Show rate</b></td>
	</tr>
	</cfoutput>
	</table>
	<FORM NAME="step1" ACTION="" METHOD="post">
	<table>
	<cfoutput>
	<tr>
		<td width=50>&nbsp;</td>
		<TD ALIGN="right"><input TYPE="Button"  NAME="run" VALUE="Create Recruiter Attendance Rosters" onClick="action = 'roster_recruit_roster2.cfm?a=2&bd=#form.begin_date#&ed=#form.end_date#&r=#sSource#&re=#form.recruiter#&#Rand()#'; submit();"></TD>
		<td align="right"><input TYPE="Button"  NAME="cancel" VALUE="Cancel" onClick="action = 'roster_recruit_roster.cfm'; submit();"></td>
	</tr>
	</cfoutput>
	<tr height=20><td colspan=3>&nbsp;</td></tr>
	</table>
	</form>

</CFCASE>
<!--- step #2 --->
<CFCASE VALUE="2">

	<FORM NAME="step2" ACTION="roster_certificates2.cfm?a=3&#Rand()#" METHOD="post">
	<table>
	<tr>
		<td width=50>&nbsp;</td>
		<td colspan=2 align=center><h5><font color="green">Creating recruiter rosters, please wait... </font></h5><br><br></td>
	</tr>
	<tr height=20><td colspan=3>&nbsp;</td></tr>
	</table>
	</form>

	<cfoutput>
	<META HTTP-EQUIV="refresh" CONTENT="3; URL=roster_recruit_roster2.cfm?a=3&bd=#url.bd#&ed=#url.ed#&r=#url.r#&re=#url.re#&#Rand()#">
	</cfoutput>
</cfcase>
<!--- step #3 --->
<CFCASE VALUE="3">
	<!--- Pull invitees by meeting code --->
	<CFQUERY DATASOURCE="#application.rosterDSN#"  NAME="q3">
		select firstname, middlename, lastname, office_addr1, office_addr2, office_city, office_state, office_zipcode, prime_specialty,
			decile, cet_phone, office_phone, apptdate, appttime, attended, meetingcode, menum, project,
			guidebook, user1, user2, user3, user4, user5, user6
			from roster
			where apptdate between '#URL.bd#' and '#URL.ed#' and (source LIKE '#url.r#%' or source LIKE '#url.re#')
			order by apptdate, meetingcode, lastname, firstname
	</CFQUERY>

	<!--- set up some variables --->
	<cfset m_grand_tot = 0>
	<cfset a_grand_tot = 0>
	<cfset sGuideBook = "">
	<cfset ThisMeeting = "">
	<cfset LastMeeting = "">
	<cfset fname = "">
	<cfset sComma = ",">
	<cfset sSlash = "/">
	<cfset sNull = "">
	<cfset fpath = "C:\Users Shared Folders\RecruiterRosters\">
	<cfset sDate = "#dateFormat(url.ed, 'yyyymmdd')#">
	<!--- write column header record --->
	<cfset fname = #fpath# & #sDate# & #url.r# & ".CSV">
	<cffile action="write" file="#fname#" nameconflict="overwrite"
		output="FIRSTNAME,MIDDLENAME,LASTNAME,ADDRESS1,ADDRESS2,CITY,STATE,ZIPCODE,PRIME_SPECIALTY,DECILE,OFFICE_PHONE,CET_PHONE,APPTDATE,APPTTIME,STATUS,MEETINGCODE,MENUM,PROJECT,GUIDEBOOK,USER1,USER2,USER3,USER4,USER5,USER6">
	 <cfoutput query="q3">
		<cfset ThisMeeting = #q3.meetingcode#>
		<cfif ThisMeeting NEQ #LastMeeting#>
			<!--- increment meeting count --->
			<cfset LastMeeting = #ThisMeeting#>
			<cfset m_grand_tot = m_grand_tot + 1>
		</cfif>
		<cfif #q3.guidebook# EQ 0>
			<cfset sGuideBook = "YES">
		<cfelse>
			<cfset sGuideBook = "NO">
		</cfif>
		<cffile action="append" file="#fname#" nameconflict="overwrite"
				output="#trim(q3.firstname)#,#trim(q3.middlename)#,#trim(q3.lastname)#,#replace(trim(q3.office_addr1), sComma, sNull)#,#replace(trim(q3.office_addr2), sComma, sNull)#,#trim(q3.office_city)#,#trim(q3.office_state)#,#trim(q3.office_zipcode)#,#trim(q3.prime_specialty)#,#trim(q3.decile)#,#trim(q3.office_phone)#,#trim(q3.cet_phone)#,#dateFormat(q3.apptdate, 'mm/dd/yy')#,#trim(q3.appttime)#,#q3.attended#,#trim(q3.meetingcode)#,#trim(q3.menum)#,#trim(q3.project)#,#sGuideBook#,#q3.user1#,#trim(q3.user2)#,#q3.user3#,#replace(trim(q3.user4), sComma, sNull)#,#trim(q3.user5)#,#q3.user6#">
		 <!---increment invitee count --->
		<cfset a_grand_tot = a_grand_tot + 1>
	</cfoutput>
	<FORM NAME="step3" ACTION="" METHOD="post">
	<cfoutput>
	<table>
	<tr>
		<td width=50>&nbsp;</td>
		<TD colspan=2><h4><font color="green">Processing Complete!</font></h4></TD>
	</tr>
	<tr>
		<td width=50>&nbsp;</td>
		<TD colspan=2>Output data is located in <B>#fname#</B></b></TD>
	</tr>
	<tr>
		<td width=50>&nbsp;</td>
		<td colspan=2><b>Total Invitees: #a_grand_tot#</b></td>
	</tr>
	<tr>
		<td width=50>&nbsp;</td>
		<td colspan=2><b>Total Meetings: #m_grand_tot#</b></td>
	</tr>
	<tr height=20><td colspan=3>&nbsp;</td></tr>
	<tr>
		<td width=50>&nbsp;</td>
		<TD ALIGN="center"><input TYPE="Button"  NAME="finish" VALUE="Finished" onClick="action = 'roster_recruit_roster.cfm?&#Rand()#'; submit();"></TD>
	</tr>
	<tr height=20><td colspan=3>&nbsp;</td></tr>
	</table>
	</cfoutput>
	</form>
	</body>
</cfcase>

<!--- If no case is specified user is sent a processing error --->
<CFDEFAULTCASE>
	<cfoutput>
	<FORM NAME="cert2" ACTION="" METHOD="post">
	</cfoutput>
	<table>
	<tr>
		<td width=50>&nbsp;</td>
		<td colspan=3><h4><font color=red>A processing error has occurred!  Please try again...</font></h4></td>
	</tr>
	<tr height=20><td colspan=3>&nbsp;</td></tr>
	<tr>
		<td width=50>&nbsp;</td>
		<TD ALIGN="right"><input TYPE="Button"  NAME="tryagain" VALUE="Try Again" onClick="action = 'roster_recruit_roster.cfm'; submit();"></TD>
		<td>&nbsp;</td>
	</tr>
	<tr height=50><td colspan=3>&nbsp;</td></tr>
	</table>
	</form>
</CFDEFAULTCASE>
</CFSWITCH>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

