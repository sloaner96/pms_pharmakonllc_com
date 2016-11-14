<!--- 
	*****************************************************************************************
	Name:  report_weekly.cfm		
	Function:  shows meeting for a particular time period.  User can choose to eliminate columns.	
	History:	Matt Eaves -- Initial Code
	
	NOTE:  All data for this report is gathered and stored in 3 arrays 
	(Heading Cells, Data Cells, and Footer Cells).  Then the data is then turned into a list 
	and fed to the browser.  This allows for faster load times when writing to Excel.
	
	*****************************************************************************************
--->
<cfparam name="ReportType" default="DontShow">
<cfif isDefined("URL.report")>
	<cfif URL.report EQ "HTML">
		<cfset ReportType = "HTML">
	<cfelseif URL.report EQ "Excel">
		<cfset ReportType = "Excel">
	</cfif>	
</cfif>
<cfif Not IsDefined("URL.Report")>
   <cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Weekly Meeting Schedule" showCalendar="1">
<cfelse>
  <style type="text/css">
     td{
	   font-family: verdana, arial, tahoma;
	   font-size: 10px;
	 }
  </style>

</cfif>
<SCRIPT SRC="/includes/libraries/CallCal.js"></SCRIPT>
<script language="JavaScript">
function OpenHTMLReport()
{
	if(document.forms[0].begin_date.value == "" || document.forms[0].end_date.value == "")
	{
		alert("All Fields are Required")
		return false;
	}
	else
	{
		document.forms[0].action = "report_weekly.cfm?report=HTML";
		document.forms[0].submit();
	}
	
}

function OpenExcelReport()
{
	if(document.forms[0].begin_date.value == "" || document.forms[0].end_date.value == "")
	{
		alert("All Fields are Required")
		return false;
	}
	else
	{
		document.forms[0].action = "report_weekly.cfm?report=Excel";
		document.forms[0].submit();
	}
}
</script>	


<!---######################################
Beging Setting Data To Arrays
#######################################----->

<cfif ReportType EQ "HTML" OR ReportType EQ "Excel">

	<cfset B_Month = Month(form.begin_date)>
	<cfset B_Day = Day(form.begin_date)>
	<cfset B_Year = Year(form.begin_date)>
	<cfset E_Month = Month(form.end_date)>
	<cfset E_Day = Day(form.end_date)>
	<cfset E_Year = Year(form.end_date)>
	
	<cfset BeginingDate = CreateDate(Year(form.begin_date), Month(form.begin_date), Day(form.begin_date))>
	<cfset EndingDate = CreateDate(Year(form.end_date), Month(form.end_date), Day(form.end_date))>
	
	<!------Set Globals to determine what information is being displayed to user------>
	<cfset ReportColumns = ArrayNew(1)>
	<cfset ReportColumns[1] = #form.recruiter#>
	<cfset ReportColumns[2] = #form.conference#>
	<cfset ReportColumns[3] = #form.project#>
	<cfset ReportColumns[4] = #form.code#>
	<cfset ReportColumns[5] = #form.date#>
	<cfset ReportColumns[6] = #form.time#>
	<cfset ReportColumns[7] = #form.mod#>
	<cfset ReportColumns[8] = #form.modhono#>
	<cfset ReportColumns[9] = #form.spkr#>
	<cfset ReportColumns[10] = #form.spkrhono#>
	<cfset ReportColumns[11] = #form.attend#>
	<cfset ReportColumns[12] = #form.cis#>
	<cfset ReportColumns[13] = #form.srate#>
	<cfset ReportColumns[14] = #form.nsrate#>
	<cfset ReportColumns[15] = #form.clisten#>
	<cfset ReportColumns[16] = #form.clistenhono#>
	<cfset ReportColumns[17] = #form.mlisten#>
	<cfset ReportColumns[18] = #form.mlistenhono#>
	<cfset ReportColumns[19] = #form.additionalspkr#>
	<cfset ReportColumns[20] = #form.additionalspkrhono#>
	<cfset ReportColumns[21] = #form.trainees#>
	<cfset ReportColumns[22] = #form.traineeshono#>
	
	<!---Depending on what the user chooses to diplay, those headings will be stored in an array
	All array variable will be stored with the TD tags so the array can be converted to a list then
	spit out to the user.  This will save considerable time when writing to an Excel file---->
	<cfset HeadingCells = ArrayNew(1)>
	<cfset c = 0>
	
	<cfif #ReportColumns[1]# EQ 1>
		<cfset HeadingCells[c + 1] = "<td style='background-color: ##EEEEEE;'><strong>Recruiter</strong></td>">
		<cfset c = #c# + 1>
	</cfif>
	<cfif #ReportColumns[2]# EQ 1>
		<cfset HeadingCells[c + 1] = "<td style='background-color: ##EEEEEE;'><strong>Conference</strong></td>">
		<cfset c = #c# + 1>
	</cfif>
	<cfif #ReportColumns[3]# EQ 1>
		<cfset HeadingCells[c + 1] = "<td style='background-color: ##EEEEEE;'><strong>Project</strong></td>">
		<cfset c = #c# + 1>
	</cfif>
	<cfif #ReportColumns[4]# EQ 1>
		<cfset HeadingCells[c + 1] = "<td style='background-color: ##EEEEEE;'><strong>Meeting Code</strong></td>">
		<cfset c = #c# + 1>
	</cfif>
	<cfif #ReportColumns[5]# EQ 1>
		<cfset HeadingCells[c + 1] = "<td style='background-color: ##EEEEEE;'><strong>Date</strong></td>">
		<cfset c = #c# + 1>
	</cfif>
	<cfif #ReportColumns[6]# EQ 1>
		<cfset HeadingCells[c + 1] = "<td style='background-color: ##EEEEEE;'><strong>Time</strong></td>">
		<cfset c = #c# + 1>
	</cfif>
	<cfif #ReportColumns[7]# EQ 1>
		<cfset HeadingCells[c + 1] = "<td style='background-color: ##EEEEEE;'><strong>Moderator</strong></td>">
		<cfset c = #c# + 1>
	</cfif>
	<cfif #ReportColumns[8]# EQ 1>
		<cfset HeadingCells[c + 1] = "<td style='background-color: ##EEEEEE;'><strong>Moderator Honoraria</strong></td>">
		<cfset c = #c# + 1>
	</cfif>
	<cfif #ReportColumns[9]# EQ 1>
		<cfset HeadingCells[c + 1] = "<td style='background-color: ##EEEEEE;'><strong>Guest Speaker</strong></td>">
		<cfset c = #c# + 1>
	</cfif>
	<cfif #ReportColumns[10]# EQ 1>
		<cfset HeadingCells[c + 1] = "<td style='background-color: ##EEEEEE;'><strong>Speaker Honoraria</strong></td>">
		<cfset c = #c# + 1>
	</cfif>
	<cfif #ReportColumns[11]# EQ 1>
		<cfset HeadingCells[c + 1] = "<td style='background-color: ##EEEEEE;'><strong>Attends</strong></td>">
		<cfset c = #c# + 1>
	</cfif>
	<cfif #ReportColumns[12]# EQ 1>
		<cfset HeadingCells[c + 1] = "<td style='background-color: ##EEEEEE;'><strong>Cis</strong></td>">
		<cfset c = #c# + 1>
	</cfif>
	<cfif #ReportColumns[13]# EQ 1>
		<cfset HeadingCells[c + 1] = "<td style='background-color: ##EEEEEE;'><strong>Show Rate</strong></td>">
		<cfset c = #c# + 1>
	</cfif>
	<cfif #ReportColumns[14]# EQ 1>
		<cfset HeadingCells[c + 1] = "<td style='background-color: ##EEEEEE;'><strong>No Show Rate</strong></td>">
		<cfset c = #c# + 1>
	</cfif>
	<cfif #ReportColumns[15]# EQ 1>
		<cfset HeadingCells[c + 1] = "<td style='background-color: ##EEEEEE;'><strong>Speaker Listen-Ins</strong></td>">
		<cfset c = #c# + 1>
	</cfif>
	<cfif #ReportColumns[16]# EQ 1>
		<cfset HeadingCells[c + 1] = "<td style='background-color: ##EEEEEE;'><strong>Speaker Listen-In Honoraria</strong></td>">
		<cfset c = #c# + 1>
	</cfif>
	<cfif #ReportColumns[17]# EQ 1>
		<cfset HeadingCells[c + 1] = "<td style='background-color: ##EEEEEE;'><strong>Moderator Listen-Ins</strong></td>">
		<cfset c = #c# + 1>
	</cfif>
	<cfif #ReportColumns[18]# EQ 1>
		<cfset HeadingCells[c + 1] = "<td style='background-color: ##EEEEEE;'><strong>Moderator Listen-Ins Honoraria</strong></td>">
		<cfset c = #c# + 1>
	</cfif>
	<cfif #ReportColumns[19]# EQ 1>
		<cfset HeadingCells[c + 1] = "<td style='background-color: ##EEEEEE;'><strong>Additional Speaker</strong></td>">
		<cfset c = #c# + 1>
	</cfif>
	<cfif #ReportColumns[20]# EQ 1>
		<cfset HeadingCells[c + 1] = "<td style='background-color: ##EEEEEE;'><strong>Additional Speaker Honoraria</strong></td>">
		<cfset c = #c# + 1>
	</cfif>
	<cfif #ReportColumns[21]# EQ 1>
		<cfset HeadingCells[c + 1] = "<td style='background-color: ##EEEEEE;'><strong>Trainees</strong></td>">
		<cfset c = #c# + 1>
	</cfif>
	<cfif #ReportColumns[22]# EQ 1>
		<cfset HeadingCells[c + 1] = "<td style='background-color: ##EEEEEE;'><strong>Trainees Honoraria</strong></td>">
		<cfset c = #c# + 1>
	</cfif>
	

	<!--- Pull updated meeting times --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="meetingDT">
	SELECT m.meeting_code, m.use_type, m.project_code, m.year, m.month, m.day, m.rowid, m.start_time, m.end_time, m.attendees, m.cis, m.show, m.noshow, m.rowid, m.staff_id AS moderator_id, m.client_rowid AS moderator_client, m.status, s.staff_id AS speaker_id, s.client_rowid AS speaker_client, mt.firstname + ' ' + mt.lastname AS mod_name, mf.fee, cl.staff_id AS clisten_id, cl.client_rowid AS clisten_client, ml.staff_id AS mlisten_id, ml.client_rowid AS mlisten_client, asp.staff_id AS addspeaker_id, asp.client_rowid AS addspeaker_client, t.staff_id AS trainee_id, t.client_rowid AS trainee_client
	FROM PMSProd.dbo.schedule_meeting_time m, PMSProd.dbo.schedule_meeting_time s, speaker.dbo.spkr_table mt, speaker.dbo.speaker_clients mf, PMSProd.dbo.schedule_meeting_time cl, PMSProd.dbo.schedule_meeting_time ml, PMSProd.dbo.schedule_meeting_time asp, PMSProd.dbo.schedule_meeting_time t
	WHERE (m.meeting_date BETWEEN #BeginingDate# AND #EndingDate#) AND m.staff_type = 1 AND m.staff_id = mt.speaker_id AND m.staff_id = mf.owner_id AND m.status = 0 AND  
	(m.meeting_code *= s.meeting_code AND s.staff_type = 2)
	AND (m.meeting_code *= cl.meeting_code AND cl.staff_type = 6)
	AND (m.meeting_code *= ml.meeting_code AND ml.staff_type = 3)
	AND (m.meeting_code *= asp.meeting_code AND asp.staff_type = 5)
	AND (m.meeting_code *= t.meeting_code AND (t.staff_type = 4 OR t.staff_type = 7))
	ORDER BY m.meeting_date, m.start_time, addspeaker_id, mlisten_id, trainee_id, clisten_id
</CFQUERY>

<!--- <cfoutput query="meetingDT" group="meeting_code">
#meeting_code#&nbsp;&nbsp;#year#&nbsp;&nbsp;#month#&nbsp;&nbsp;#day#&nbsp;&nbsp;#start_time#&nbsp;&nbsp;#moderator_id#&nbsp;&nbsp;#speaker_id#<br>
</cfoutput><cfabort> --->

	
<!-----Create objects outside of loop in case any methods are called.  Although all three may not be needed, its less memory than
instantiating them everytime we call a method---->
	<cfscript>
		//Instantiate the objects outside of the loop
		ProjectName = createObject("component","pms.com.cfc_get_name");
		PIW = createObject("component","pms.com.cfc_get_piwinfo");
		oCivTime = createObject("component","pms.com.cfc_time_conversion");
	</cfscript>
	
<!----Global Variable for Totals----->				
	<cfset totalAttends = 0>
	<cfset totalCIS = 0>
	<cfset TotalShowRate = 0>
	<cfset TotalNoShowRate = 0>
	<cfset NumClientLis = 0>
	<cfset NumModLis = 0>
	<cfset TotalShowRecords = 0>
	<cfset TotalNoShowRecords = 0>
	<cfset TotalModeratorHono = 0>
	<cfset TotalSpeakerHono = 0>
	<cfset TotalClientListenHono = 0>
	<cfset TotalModListenHono = 0>
	<!--- <cfset TotalListenHono = 0> --->
	<cfset TotalAdditionalSpkrHono = 0>
	<cfset TotalTraineeHono = 0>
	
<!----The DataCells Array hold all information pulled from Database based on the users selections.  
The cfc's are created always, but their methods are only called when that data it requested by user--->
	<cfset DataCells = ArrayNew(1)>
	<cfset t = 0>
	
	

	<CFOUTPUT QUERY="meetingDT" group="meeting_code">
	
	<!--- #meeting_code# - <cfoutput group="trainee_id">#trainee_id#:</cfoutput><br></cfoutput><cfabort>
	<cfoutput> --->
	
			<cfset DataCells[t + 1] = "<tr>">
			<cfset t = #t# + 1>
			
			<cfif #ReportColumns[1]# EQ 1>
				<cfscript>
					Recruiter = PIW.getRecruiter(ProjCode="#meetingDT.project_code#");
				</cfscript>
				<cfset DataCells[t + 1] = "<td>#Recruiter#</td>">
				<cfset t = #t# + 1>
			</cfif>
			<cfif #ReportColumns[2]# EQ 1>
				<cfscript>
					Conference = PIW.getConference(ProjCode="#meetingDT.project_code#");
				</cfscript>
				<cfset DataCells[t + 1] = "<td>#Conference#</td>">
				<cfset t = #t# + 1>
			</cfif>
			<cfif #ReportColumns[3]# EQ 1>
				<cfscript>
					projName = ProjectName.getProjName(ProjCode="#meetingDT.project_code#");
				</cfscript>
				<cfset DataCells[t + 1] = "<td>#projName#</td>">
				<cfset t = #t# + 1>
			</cfif>
			<cfif #ReportColumns[4]# EQ 1>
				<cfset DataCells[t + 1] = "<td>#meetingDT.project_code#</td>">
				<cfset t = #t# + 1>
			</cfif>
			<cfif #ReportColumns[5]# EQ 1>
				<cfset DataCells[t + 1] = "<td>#meetingDT.month#/#meetingDT.day#/#meetingDT.year#</td>">
				<cfset t = #t# + 1>
			</cfif>
			<cfif #ReportColumns[6]# EQ 1>
				<!--- Set the starting time minutes --->
				<cfif Mid(meetingDT.start_time, 3, 2) EQ 50>
					<cfset start_min = 30>
				<cfelse>
					<cfset start_min = Mid(meetingDT.start_time, 3, 2)>
				</cfif>
		
				<!--- Convert meeting start time to Civilian Time --->
				<cfset TimeCreated = CreateTime(Left(meetingDT.start_time, 2),start_min,00)>
				<cfset CivilianTime = TimeFormat(TimeCreated,'h:mmtt')>
				
				<cfset DataCells[t + 1] = "<td>#CivilianTime#</td>">
				<cfset t = #t# + 1>
			</cfif>
			<cfif #ReportColumns[7]# EQ 1><!---Moderator Cell--->
				<!--- <cfscript>
					GetMod = PIW.getModSpker(cfcID="#meetingDT.moderator_id#");
				</cfscript> --->
				<cfset DataCells[t + 1] = "<td>#meetingDT.mod_name#</td>">
				<cfset t = #t# + 1>
			</cfif>
			<cfif #ReportColumns[8]# EQ 1><!---Moderator Honoraria Cell--->
				<!--- <cfscript>
					ModHono = PIW.getHonoraria(cfcRowID="#meetingDT.moderator_client#");
				</cfscript> --->
				<cfset DataCells[t + 1] = "<td>#DollarFormat(meetingDT.fee)#</td>">
				<cfset t = #t# + 1>
				<cfset TotalModeratorHono = #TotalModeratorHono# + #meetingDT.fee#>
			</cfif>
			<cfif #ReportColumns[9]# EQ 1><!---Speaker Cell--->
				<cfif trim(meetingDT.speaker_id) EQ "">
					<cfset speaker = 1>
				<cfelse>
					<cfset speaker = #meetingDT.speaker_id#>
				</cfif>
				<cfscript>
					GetSpkr = PIW.getModSpker(cfcID="#speaker#");
				</cfscript>
				<cfset DataCells[t + 1] = "<td>#GetSpkr#</td>">
				<cfset t = #t# + 1>
			</cfif>
			<cfif #ReportColumns[10]# EQ 1><!---Speaker Honoraria Cell--->
				<cfif trim(meetingDT.speaker_client) EQ "">
					<cfset sp_client = 0>
				<cfelse>
					<cfset sp_client = #meetingDT.speaker_client#>
				</cfif>
				<cfscript>
					SpeakerHono = PIW.getHonoraria(cfcRowID="#sp_client#");
				</cfscript>
				<cfset DataCells[t + 1] = "<td>#DollarFormat(SpeakerHono)#</td>">
				<cfset t = #t# + 1>
				<cfset TotalSpeakerHono = #TotalSpeakerHono# + #SpeakerHono#>
			</cfif>
			<cfif #ReportColumns[11]# EQ 1>
				<cfset DataCells[t + 1] = "<td>#meetingDT.attendees#</td>">
				<cfset t = #t# + 1>
			</cfif>
			<cfif #ReportColumns[12]# EQ 1>
				<cfset DataCells[t + 1] = "<td>#meetingDT.cis#</td>">
				<cfset t = #t# + 1>
			</cfif>
			<cfif #ReportColumns[13]# EQ 1>
				<cfscript>
					ShowRate = PIW.getRate(cfcValue="#meetingDT.show#");
				</cfscript>
				<cfset DataCells[t + 1] = "<td>#ShowRate#</td>">
				<cfset t = #t# + 1>
			</cfif>
			<cfif #ReportColumns[14]# EQ 1>
				<cfscript>
					NoShowRate = PIW.getRate(cfcValue="#meetingDT.noshow#");
				</cfscript>
				<cfset DataCells[t + 1] = "<td>#NoShowRate#</td>">
				<cfset t = #t# + 1>
			</cfif>
			<cfif #ReportColumns[15]# EQ 1><!---Client ListenIn--->
				<cfset clisten2 = ''>
				<!--- Need to loop this because there may be more than 1 client listen in --->
				<cfoutput group="clisten_id">
					<cfif trim(meetingDT.clisten_id) EQ "">
						<cfset clisten = 1>
					<cfelse>
						<cfset clisten = #meetingDT.clisten_id#>
					</cfif>
					<cfscript>
						GetClientListen = PIW.getModSpker(cfcID="#clisten#");
					</cfscript>
					<cfif GetClientListen NEQ 'N/A' AND GetClientListen NEQ 'ERR'>
						<cfset clisten2 = ListAppend(clisten2,#GetClientListen#,',')>
					<cfelse>
						<cfset clisten2 = #GetClientListen#>
					</cfif>
				</cfoutput>
				<cfset DataCells[t + 1] = "<td>#clisten2#</td>">
				<cfset t = #t# + 1>
			</cfif>
			<cfif #ReportColumns[16]# EQ 1><!---Client Listen Honoraria Cell--->
				<cfset clis_client2 = ''>
				<!--- Need to loop this because there may be more than 1 client listen in --->
				<cfoutput group="clisten_id">
					<cfif trim(meetingDT.clisten_client) EQ "">
						<cfset clis_client = 0>
					<cfelse>
						<cfset clis_client = #meetingDT.clisten_client#>
					</cfif>
					<cfscript>
						ClientListenHono = PIW.getHonoraria(cfcRowID="#clis_client#");
					</cfscript>
					<!--- <cfif ClientListenHono NEQ 0> --->
						<cfset clis_client2 = ListAppend(clis_client2,#DollarFormat(ClientListenHono)#,',')><!--- 
					<cfelse>
						<cfset clis_client2 = #DollarFormat(ClientListenHono)#>
					</cfif> --->
					<cfset TotalClientListenHono = #TotalClientListenHono# + #ClientListenHono#>
				</cfoutput>
				<cfset DataCells[t + 1] = "<td>#clis_client2#</td>">
				<cfset t = #t# + 1>
			</cfif>
			<cfif #ReportColumns[17]# EQ 1><!---Moderator ListenIn--->
				<cfset mlisten2 = ''>
				<!--- Need to loop this because there may be more than 1 mod listen in --->
				<cfoutput group="mlisten_id">
					<cfif trim(meetingDT.mlisten_id) EQ "">
						<cfset mlisten = 1>
					<cfelse>
						<cfset mlisten = #meetingDT.mlisten_id#>
					</cfif>
					<cfscript>
						GetModListen = PIW.getModSpker(cfcID="#mlisten#");
					</cfscript>
					<cfif GetModListen NEQ 'N/A' AND GetModListen NEQ 'ERR'>
						<cfset mlisten2 = ListAppend(mlisten2,#GetModListen#,',')>
					<cfelse>
						<cfset mlisten2 = #GetModListen#>
					</cfif>
				</cfoutput>
				<cfset DataCells[t + 1] = "<td>#mlisten2#</td>">
				<cfset t = #t# + 1>
			</cfif>
			<cfif #ReportColumns[18]# EQ 1><!---Mod Listen Honoraria Cell--->
				<cfset mlis_client2 = ''>
				<!--- Need to loop this because there may be more than 1 mod listen in --->
				<cfoutput group="mlisten_id">
					<cfif trim(meetingDT.mlisten_client) EQ "">
						<cfset mlis_client = 0>
					<cfelse>
						<cfset mlis_client = #meetingDT.mlisten_client#>
					</cfif>
					<cfscript>
						ModListenHono = PIW.getHonoraria(cfcRowID="#mlis_client#");
					</cfscript>
					<!--- <cfif ModListenHono NEQ 0> --->
						<cfset mlis_client2 = ListAppend(mlis_client2,#DollarFormat(ModListenHono)#,',')>
					<!--- <cfelse>
						<cfset mlis_client2 = #DollarFormat(ModListenHono)#>
					</cfif> --->
					<cfset TotalModListenHono = #TotalModListenHono# + #ModListenHono#>
				</cfoutput>
					<cfset DataCells[t + 1] = "<td>#mlis_client2#</td>">
					<cfset t = #t# + 1>
					
			</cfif>		
			<cfif #ReportColumns[19]# EQ 1><!---Additional Speakers--->
				<cfset addspeak2 = ''>
				<!--- Need to loop this because there may be more than 1 additional spkr --->
				<cfoutput group="addspeaker_id">
					<cfif trim(meetingDT.addspeaker_id) EQ "">
						<cfset addspeak = 1>
					<cfelse>
						<cfset addspeak = #meetingDT.addspeaker_id#>
					</cfif>
				<cfscript>
					GetAddSpeak = PIW.getModSpker(cfcID="#addspeak#");
				</cfscript>
					<cfif GetAddSpeak NEQ 'N/A' AND GetAddSpeak NEQ 'ERR'>
						<!--- <cfif GetAddSpeak NEQ addspeak2> --->
							<cfset addspeak2 = ListAppend(addspeak2,#GetAddSpeak#,',')>
						<!--- </cfif> --->
					<cfelse>
						<cfset addspeak2 = #GetAddSpeak#>
					</cfif>
				</cfoutput>
						<cfset DataCells[t + 1] = "<td>#addspeak2#</td>">
				<cfset t = #t# + 1>
			</cfif>
			<cfif #ReportColumns[20]# EQ 1><!---Additional Speaker Honoraria Cell--->
				<cfset addspeak_client2 = ''>
				<!--- Need to loop this because there may be more than 1 additional spkr --->
				<cfoutput group="addspeaker_id">
					<cfif trim(meetingDT.addspeaker_client) EQ "">
						<cfset addspeak_client = 0>
					<cfelse>
						<cfset addspeak_client = #meetingDT.addspeaker_client#>
					</cfif>
					<cfscript>
					AddSpeakHono = PIW.getHonoraria(cfcRowID="#addspeak_client#");
					</cfscript>
					<!--- <cfif AddSpeakHono NEQ 0> --->
						<cfset addspeak_client2 = ListAppend(addspeak_client2,#DollarFormat(AddSpeakHono)#,',')>
					<!--- <cfelse>
						<cfset addspeak_client2 = #DollarFormat(AddSpeakHono)#>
					</cfif> --->
				<cfset TotalAdditionalSpkrHono = #TotalAdditionalSpkrHono# + #AddSpeakHono#>		
				</cfoutput>
				<cfset DataCells[t + 1] = "<td>#addspeak_client2#</td>">
				<cfset t = #t# + 1>
			</cfif>
			
			<cfif #ReportColumns[21]# EQ 1><!---Trainees--->
				<cfset trainee_id2 = ''>
				<!--- Need to loop this because there may be more than 1 trainee --->
				<cfoutput group="trainee_id">
					<cfif trim(meetingDT.trainee_id) EQ "">
						<cfset t_id = 1>
					<cfelse>
						<cfset t_id = #meetingDT.trainee_id#>
					</cfif>
					<cfscript>
						Gett_id = PIW.getModSpker(cfcID="#t_id#");
					</cfscript>
					<cfif Gett_id NEQ 'N/A' AND Gett_id NEQ 'ERR'>
						<cfset trainee_id2 = ListAppend(trainee_id2,#Gett_id#,',')>
					<cfelse>
						<cfset trainee_id2 = #Gett_id#>
					</cfif>
				</cfoutput>
				<cfset DataCells[t + 1] = "<td>#trainee_id2#</td>">
				<cfset t = #t# + 1>
			</cfif>
			<cfif #ReportColumns[22]# EQ 1><!---Trainees Honoraria Cell--->
				<cfset trainee_hono2 = ''>
				<cfoutput group="trainee_id">
					<cfif trim(meetingDT.trainee_client) EQ "">
						<cfset t_client = 0>
					<cfelse>
						<cfset t_client = #meetingDT.trainee_client#>
					</cfif>
					<cfscript>
						TraineeHono = PIW.getHonoraria(cfcRowID="#t_client#");
					</cfscript>
					<!--- <cfif TraineeHono NEQ 0> --->
						<cfset trainee_hono2 = ListAppend(trainee_hono2,#DollarFormat(TraineeHono)#,',')>
					<!--- <cfelse>
						<cfset trainee_hono2 = #DollarFormat(TraineeHono)#> --->
					<!--- </cfif> --->
				<cfset TotalTraineeHono = #TotalTraineeHono# + #TraineeHono#>	
				</cfoutput>
				<cfset DataCells[t + 1] = "<td>#trainee_hono2#</td>">
				<cfset t = #t# + 1>
			</cfif>
		
			<cfset totalAttends = #totalAttends# + #meetingDT.attendees#>
			<cfset totalCis = #totalCis# + #meetingDT.cis#>
			
			<cfif isDefined("ShowRate")>
				<cfset TotalShowRate = #TotalShowRate# + #ShowRate#>
			<cfelse>
				<cfset TotalShowRate = 0>
			</cfif>
			
			<cfif isDefined("NoShowRate")>
				<cfset TotalNoShowRate = #TotalNoShowRate# + #NoShowRate#>
			<cfelse>
				<cfset TotalNoShowRate = 0>
			</cfif>
			
			<cfif isDefined("ShowRate")>
				<cfif #ShowRate# NEQ 0 AND #ShowRate# NEQ 0.00>
					<cfset TotalShowRecords = #TotalShowRecords# + 1>
				</cfif>
			</cfif>
			
			<cfif isDefined("NoShowRate")>
				<cfif #NoShowRate# NEQ 0 AND #NoShowRate# NEQ 0.00>
					<cfset TotalNoShowRecords = #TotalNoShowRecords# + 1>
				</cfif>
			</cfif>

			<cfset DataCells[t + 1] = "</tr>">
			<cfset t = #t# + 1>
<!----End Data Array----->
	</CFOUTPUT><!-----End Output of Query---->

<!----In order to avoid a Division by Zero error, need the two below checks----->	
	<cfif #TotalShowRecords# NEQ 0>
		<cfset AvgShowRate = #TotalShowRate#/#TotalShowRecords#>
	<cfelse>
		<cfset AvgShowRate = 0>
	</cfif>
	
	<cfif #TotalNoShowRecords# NEQ 0>
		<cfset AvgNoShowRate = #TotalNoShowRate#/#TotalNoShowRecords#>
	<cfelse>
		<cfset AvgNoShowRate = 0>
	</cfif>
	
	
<!------Beging Footer Array.  All Footer (totals) data is stored in this array----->
	<cfset FooterCells = ArrayNew(1)>
	<cfset q = 0>
	
	<cfif #ReportColumns[1]# EQ 1>
		<cfset FooterCells[q + 1] = "<td><strong>&nbsp;</strong></td>">
		<cfset q = #q# + 1>
	</cfif>
	<cfif #ReportColumns[2]# EQ 1>
		<cfset FooterCells[q + 1] = "<td><strong>&nbsp;</strong></td>">
		<cfset q = #q# + 1>
	</cfif>
	<cfif #ReportColumns[3]# EQ 1>
		<cfset FooterCells[q + 1] = "<td><strong>&nbsp;</strong></td>">
		<cfset q = #q# + 1>
	</cfif>
	<cfif #ReportColumns[4]# EQ 1>
		<cfset FooterCells[q + 1] = "<td><strong>&nbsp;</strong></td>">
		<cfset q = #q# + 1>
	</cfif>
	<cfif #ReportColumns[5]# EQ 1>
		<cfset FooterCells[q + 1] = "<td><strong>&nbsp;</strong></td>">
		<cfset q = #q# + 1>
	</cfif>
	<cfif #ReportColumns[6]# EQ 1>
		<cfset FooterCells[q + 1] = "<td><strong>&nbsp;</strong></td>">
		<cfset q = #q# + 1>
	</cfif>
	<cfif #ReportColumns[7]# EQ 1 OR #ReportColumns[7]# EQ 0><!---Show this cell always because it is a heading---->
		<cfset FooterCells[q + 1] = "<td style='background-color: ##EEEEEE;'><strong>Grand Total</strong></td>"><!---Moderator Cell--->
		<cfset q = #q# + 1>
	</cfif>
	<cfif #ReportColumns[8]# EQ 1>
		<cfset FooterCells[q + 1] = "<td style='background-color: ##EEEEEE;'><strong>#DollarFormat(TotalModeratorHono)#</strong></td>"><!----Moderator Hono Cell--->
		<cfset q = #q# + 1>
	</cfif>
	<cfif #ReportColumns[9]# EQ 1>
		<cfset FooterCells[q + 1] = "<td><strong>&nbsp;</strong></td>"><!----Speaker Cell--->
		<cfset q = #q# + 1>
	</cfif>
	<cfif #ReportColumns[10]# EQ 1>
		<cfset FooterCells[q + 1] = "<td style='background-color: ##EEEEEE;'><strong>#DollarFormat(TotalSpeakerHono)#</strong></td>"><!----Speaker Hono Cell--->
		<cfset q = #q# + 1>
	</cfif>
	<cfif #ReportColumns[11]# EQ 1>
		<cfset FooterCells[q + 1] = "<td style='background-color: ##EEEEEE;'><strong>#totalAttends#</strong></td>">
		<cfset q = #q# + 1>
	</cfif>
	<cfif #ReportColumns[12]# EQ 1>
		<cfset FooterCells[q + 1] = "<td style='background-color: ##EEEEEE;'><strong>#totalCis#</strong></td>">
		<cfset q = #q# + 1>
	</cfif>
	<cfif #ReportColumns[13]# EQ 1>
		<cfset FooterCells[q + 1] = "<td style='background-color: ##EEEEEE;'><strong>#DecimalFormat(AvgShowRate)#</strong></td>">
		<cfset q = #q# + 1>
	</cfif>
	<cfif #ReportColumns[14]# EQ 1>
		<cfset FooterCells[q + 1] = "<td style='background-color: ##EEEEEE;'><strong>#DecimalFormat(AvgNoShowRate)#</strong></td>">
		<cfset q = #q# + 1>
	</cfif>
	<cfif #ReportColumns[15]# EQ 1><!---Client Listen-In--->
		<cfset FooterCells[q + 1] = "<td>&nbsp;</td>">
		<cfset q = #q# + 1>
	</cfif>
	<cfif #ReportColumns[16]# EQ 1><!---Client Listen-In Hono--->
		<cfset FooterCells[q + 1] = "<td style='background-color: ##EEEEEE;'><strong>#DollarFormat(TotalClientListenHono)#</strong></td>">
		<cfset q = #q# + 1>
	</cfif>
	<cfif #ReportColumns[17]# EQ 1><!---Moderator Listen-In--->
		<cfset FooterCells[q + 1] = "<td>&nbsp;</td>">
		<cfset q = #q# + 1>
	</cfif>
	<cfif #ReportColumns[18]# EQ 1><!---Moderator Listen in Hono--->
		<cfset FooterCells[q + 1] = "<td style='background-color: ##EEEEEE;'><strong>#DollarFormat(TotalModListenHono)#</strong></td>">
		<cfset q = #q# + 1>
	</cfif>
	<cfif #ReportColumns[19]# EQ 1><!---Additional Speakers--->
		<cfset FooterCells[q + 1] = "<td>&nbsp;</td>">
		<cfset q = #q# + 1>
	</cfif>
	<cfif #ReportColumns[20]# EQ 1><!---Additional Speakers Hono--->
		<cfset FooterCells[q + 1] = "<td style='background-color: ##EEEEEE;'><strong>#DollarFormat(TotalAdditionalSpkrHono)#</strong></td>">
		<cfset q = #q# + 1>
	</cfif>
	<cfif #ReportColumns[21]# EQ 1><!---Trainees--->
		<cfset FooterCells[q + 1] = "<td>&nbsp;</td>">
		<cfset q = #q# + 1>
	</cfif>
	<cfif #ReportColumns[22]# EQ 1><!---Trainees Hono--->
		<cfset FooterCells[q + 1] = "<td style='background-color: ##EEEEEE;'><strong>#DollarFormat(TotalTraineeHono)#</strong></td>">
		<cfset q = #q# + 1>
	</cfif>
		<cfset FooterCells[q + 1] = "</TR><TR><TD COLSPAN='#ArrayLen(HeadingCells)#' STYLE='font-size: 13px; font-weight: bold; text-align: right;'>Total Meetings: #meetingDT.recordcount#</td>">
		<cfset q = #q# + 1>
<!-----End Footer Array----->

</cfif>
<!---##################################
End Setting Data To Arrays
#################################---->

<!---Beging Page Display---->

<cfif ReportType EQ "HTML">
	<TABLE ALIGN="left" BORDER="0" CELLPADDING="5" CELLSPACING="0">
		<TR>
			<TD COLSPAN="15" STYLE="font-size : medium;">
			Scheduled Meetings<br><B><CFOUTPUT>#form.begin_date# &mdash; #form.end_date#</CFOUTPUT></B>
			<BR><HR color="#3399FF"><BR>
			</TD> 
		</TR>
		<TR>
			<TD>
				<TABLE BORDER='0' CELLPADDING='2' CELLSPACING='1' bgcolor="#444444" width="100%">
					<TR bgcolor="#ffffff">
						<cfset temp = #ArrayToList(HeadingCells, " ")#>
						<cfoutput>#temp#</cfoutput>
						<!---------------
						<cfloop from="1" to="#ArrayLen(HeadingCells)#" index="j" step="1">
							<td><strong><cfoutput>#HeadingCells[j]#</cfoutput></strong></td>
						</cfloop>
						------------------->
					</TR bgcolor="#ffffff">
						<cfset temp2 = #ArrayToList(DataCells, " ")#>
						<cfoutput>#temp2#</cfoutput>
					<tr bgcolor="#ffffff">
						<cfset temp3 = #ArrayToList(FooterCells, " ")#>
						<cfoutput>#temp3#</cfoutput>
					</tr>
					<tr bgcolor="#ffffff">
						<td colspan="15" height="20">&nbsp;</td>
					</tr>
				</table>
			</td>
		</tr>
	</TABLE>


<cfelseif ReportType EQ "Excel">

	<!---Set Page Absolute Path for Temp file----->
	<!--- <cfset #report_path# = "C:\INETPUB\WWWROOT\pms.pharmakonllc.com\cgi-bin\temp\rpt_temp.htm"> --->

	
	<cffile action="write" file="#application.ReportPath#/rpt_temp.htm" nameconflict="overwrite" output="<html><head><title></title></head>">
	<cffile action="append" file="#application.ReportPath#/rpt_temp.htm" nameconflict="overwrite" output="<body>">
	<cffile action="append" file="#application.ReportPath#/rpt_temp.htm" nameconflict="overwrite" output="<TABLE BORDER='1'><TR><TD COLSPAN='#ArrayLen(HeadingCells)#'>Scheduled Meetings<br><B>#form.begin_date# to #form.end_date#</B></TD></TR><TR>">
		
	<cfset temp = #ArrayToList(HeadingCells, " ")#>
	
	<cffile action="append" file="#application.ReportPath#/rpt_temp.htm" nameconflict="overwrite" output="#temp#">
	<cffile action="append" file="#application.ReportPath#/rpt_temp.htm" nameconflict="overwrite" output="</TR>">
	
	<cfset temp2 = #ArrayToList(DataCells, " ")#>
	<cffile action="append" file="#application.ReportPath#/rpt_temp.htm" nameconflict="overwrite" output="#temp2#">

	<cfset temp3 = #ArrayToList(FooterCells, " ")#>
	<cffile action="append" file="#application.ReportPath#/rpt_temp.htm" nameconflict="overwrite" output="#temp3#">
	
	<cffile action="append" file="#application.ReportPath#/rpt_temp.htm" nameconflict="overwrite" output="</TR></TABLE>">
	<cfcontent type="application/vnd.ms-excel" deletefile="NO" file="#application.ReportPath#/rpt_temp.htm">
	
<!--- If no case is specified user is sent to data entry part of page --->
<cfelse>

<cfset beginingdate = Now()>
<cfset endingdate = #DateAdd("d", 7, Now())#>

	<CFQUERY DATASOURCE="#application.projdsn#" NAME="get_projectcode">
		SELECT project_code
		FROM piw
		ORDER BY project_code
	</CFQUERY>
	<FORM METHOD="post" onsubmit="window.open();">
	<TABLE ALIGN="Center" BORDER="0" CELLPADDING="3" CELLSPACING="0" WIDTH="100%">
	<TR> 
		<TD>	<!--- Table containing input fields --->
			<TABLE ALIGN="Center" BORDER="0" WIDTH="99%" CELLSPACING="1" CELLPADDING="10">
				<TR>
					<TD ALIGN="Center">
						<B>Begin Date:</B>&nbsp;&nbsp;&nbsp;&nbsp;
						<cfmodule template="#Application.tagpath#/ctags/calInput.cfm"
						          inputname="begin_date"
								  htmlID="begindate"
								  FormValue="#DateFormat(beginingdate, 'mm/dd/yyyy')#"
								  imgid="begindatebtn">
						 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<B>End Date:</B>&nbsp;&nbsp;&nbsp;&nbsp;
						<cfmodule template="#Application.tagpath#/ctags/calInput.cfm"
						          inputname="end_date"
								  htmlID="enddate"
								  FormValue="#DateFormat(endingdate, 'mm/dd/yyyy')#"
								  imgid="enddatebtn">
								    
					</TD>
				</TR>
				<TR>
					<TD ALIGN="center"><strong>Select data to appear in the report</strong></TD>
				</TR>
				<TR>
					<TD ALIGN="center">
						<table cellpadding="0" cellspacing="0" border="0" width="350px">
							<tr bgcolor="#cccc99">
								<td class="ReportText"><strong>Field</strong></td>
								<td class="RadioCell"><strong>Display</strong></td>
								<td class="RadioCell"><strong>Hide</strong></td>
							</tr>
							<tr>
								<td class="ReportText">Recruiter</td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="recruiter" value="1" checked></td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="recruiter" value="0"></td>
							</tr>
							<tr bgcolor="#eeeee">
								<td class="ReportText">Conference</td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="conference" value="1" checked></td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="conference" value="0"></td>
							</tr>
							<tr>
								<td class="ReportText">Project</td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="project" value="1" checked></td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="project" value="0"></td>
							</tr>
							<tr bgcolor="#eeeee">
								<td class="ReportText">Meeting Code</td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="code" value="1" checked></td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="code" value="0"></td>
							</tr>
							<tr>
								<td class="ReportText">Date</td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="date" value="1" checked></td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="date" value="0"></td>
							</tr>
							<tr bgcolor="#eeeee">
								<td class="ReportText">Time</td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="time" value="1" checked></td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="time" value="0"></td>
							</tr>
							<tr>
								<td class="ReportText">Moderator</td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="mod" value="1" checked></td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="mod" value="0"></td>
							</tr>
							<tr bgcolor="#eeeee">
								<td class="ReportText">Moderator Honoraria</td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="modhono" value="1" checked></td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="modhono" value="0"></td>
							</tr>
							<tr>
								<td class="ReportText">Speaker</td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="spkr" value="1" checked></td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="spkr" value="0"></td>
							</tr>
							<tr bgcolor="#eeeee">
								<td class="ReportText">Speaker Honoraria</td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="spkrhono" value="1" checked></td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="spkrhono" value="0"></td>
							</tr>
							<tr>
								<td class="ReportText">Attendees</td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="attend" value="1" checked></td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="attend" value="0"></td>
							</tr>
							<tr bgcolor="#eeeee">
								<td class="ReportText">Cis</td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="cis" value="1" checked></td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="cis" value="0"></td>
							</tr>
							<tr>
								<td class="ReportText">Show Rate</td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="srate" value="1" checked></td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="srate" value="0"></td>
							</tr>
							<tr bgcolor="#eeeee">
								<td class="ReportText">No Show Rate</td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="nsrate" value="1" checked></td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="nsrate" value="0"></td>
							</tr>
							<tr>
								<td class="ReportText">Client Listen-Ins</td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="clisten" value="1" checked></td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="clisten" value="0"></td>
							</tr>
							<tr bgcolor="#eeeee">
								<td class="ReportText">Client Listen-Ins Honoraria</td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="clistenhono" value="1" checked></td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="clistenhono" value="0"></td>
							</tr>
							<tr>
								<td class="ReportText">Moderator Listen-Ins</td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="mlisten" value="1" checked></td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="mlisten" value="0"></td>
							</tr>
							<tr bgcolor="#eeeee">
								<td class="ReportText">Moderator Listen-Ins Honoraria</td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="mlistenhono" value="1" checked></td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="mlistenhono" value="0"></td>
							</tr>
							<tr>
								<td class="ReportText">Additional Speakers</td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="additionalspkr" value="1" checked></td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="additionalspkr" value="0"></td>
							</tr>
							<tr bgcolor="#eeeee">
								<td class="ReportText">Additional Speakers Honoraria</td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="additionalspkrhono" value="1" checked></td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="additionalspkrhono" value="0"></td>
							</tr>
							<tr>
								<td class="ReportText">Trainees</td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="trainees" value="1" checked></td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="trainees" value="0"></td>
							</tr>
							<tr bgcolor="#eeeee">
								<td class="ReportText">Trainees Honoraria</td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="traineeshono" value="1" checked></td>
								<td class="RadioCell"><input class="RadioButton" type="radio" name="traineeshono" value="0"></td>
							</tr>
						</table>
					</TD>
				</TR>
				<tr>
					<td align="center"><strong>Include Training Meetings?</strong> <input class="RadioButton" type="radio" name="training" value="0" checked>No <input class="RadioButton" type="radio" name="training" value="1">Yes</td>
				</tr>
				<TR>
					<TD ALIGN="center">
						<INPUT TYPE="button"  VALUE="  Generate Report  " onclick="OpenHTMLReport()">
						&nbsp; &nbsp; &nbsp; &nbsp;
						<INPUT TYPE="button"  VALUE="  Generate Report in EXCEL " onclick="OpenExcelReport()">
					</TD>
				</TR>	
			</TABLE>
		</TD>
	</TR>
	</TABLE>
	</FORM>
</cfif>
<cfif Not IsDefined("URL.Report")>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
</cfif>