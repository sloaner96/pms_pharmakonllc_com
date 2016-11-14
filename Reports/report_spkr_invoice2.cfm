<!----------------------------
report_spkr_invoice.cfm

Merge letter that allows speaker invoices to be generated and exported to MS Word.  All HTML is stored 
in an array then converted to a list before it is exported to Word.  This allows for only one <cfile> tag.
This will keep load times down.
--------------------------------->
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Speaker Invoice" showCalendar="0">


<cfset B_Month = #Month(form.begin_date)#>
<cfset B_Day = #Day(form.begin_date)#>
<cfset B_Year = #Year(form.begin_date)#>
<cfset E_Month = #Month(form.end_date)#>
<cfset E_Day = #Day(form.end_date)#>
<cfset E_Year = #Year(form.end_date)#>

<cfset BeginingDate = CreateDate(Year(form.begin_date), Month(form.begin_date), Day(form.begin_date))>
<cfset EndingDate = CreateDate(Year(form.end_date), Month(form.end_date), Day(form.end_date))>

<cfset newdate = #DateAdd("d", 21, Now())#>
	
<CFQUERY DATASOURCE="#Application.projdsn#" NAME='getMeetings' USERNAME='#session.dbu#' PASSWORD='#session.dbp#'>
	SELECT project_code, speakerid, month, day, year, start_time, end_time, 
			staff_id, client_rowid, staff_type
	FROM ScheduleSpeaker
	WHERE (meeting_date BETWEEN #BeginingDate# AND #EndingDate#)
	AND status = 0 AND staff_type IN (2,5,6,7)
	ORDER BY staff_id
</CFQUERY>

<!--- <cfoutput query="getMeetings">
#project_code# - #staff_id#, #staff_type#, #client_rowid#<br>
</cfoutput><cfabort> --->

<!----The Next 3 querys are going to pull all of the rowids out of the exception tables and store the value in an array. 
Below when outputing the data, if any of the speakers are included in any of the exception tables, they will print out appropriately. 
Then the rowid will be deleted from the array. If a particular speaker is not present in the getMeetings query, their exception will not 
print in the report. So we print whatever rowids are still present (left overs) in the querys below.----->


<cfif getMeetings.recordcount>

	<cfscript>
		//Instantiate the objects outside of the loop
		ProjectName = createObject('component','pms.com.cfc_get_name');
		oCivTime = createObject('component','pms.com.cfc_time_conversion');
	</cfscript>
	
	<cfset OutputArray = ArrayNew(1)>
	<cfset x = 1>
	
	<cfset OutputArray[x] = "<html><head><title>Project Management System || Speaker Invoice Report</title></head><body>">
	<cfset x = #x# + 1>
	
	<cfoutput query='getMeetings' group="staff_id">
		
		<cfset OutputArray[x] = "<table width='35%' cellpadding='0' cellspacing='0' border='0'><tr><td style='border-top: solid 1px ##000000; border-left: solid 1px ##000000; border-right: solid 1px ##000000; font-size: 15pt;'><i><strong>Date Needed:</strong></i></td>">
		<cfset x = #x# + 1>
		
		<cfset OutputArray[x] = "</tr><tr><td style='border-bottom: solid 1px ##000000; border-left: solid 1px ##000000; border-right: solid 1px ##000000; font-size: 12pt;' align='right'><strong>#DateFormat(newdate, 'mm/dd/yyyy')#</strong></td></tr></table><br><br>">
		<cfset x = #x# + 1>
			
		<cfscript>
			projName = ProjectName.getProjName(ProjCode='#getMeetings.project_code#');
		</cfscript>
		
		<cfset OutputArray[x] = "<table width='100%' cellpadding='0' cellspacing='0' border='0'><tr><td style='border: solid 1px ##000000; font-size: 18pt;'><center><i><strong>#projname# Invoice</strong></i></center></td>">
		<cfset x = #x# + 1>
		
		<cfset OutputArray[x] = "</tr></table><br><br><table width='100%' cellpadding='0' cellspacing='0' border='0'><tr><td><center><i><strong>C. Beck LLC</strong></i></center></td></tr><tr><td><center><i><strong>Fax To: <u>Zeffernee Wilson</u></strong></i></center></td></tr>">
		<cfset x = #x# + 1>
		
		<cfset OutputArray[x] = "<tr><td><center><i><strong>Fax Number: <u>888-397-0761</u> &nbsp; &nbsp; Phone Number: <u>800-932-4786 ext. 212</u></strong></i></center></td></tr></table><br><br>">
		<cfset x = #x# + 1>
		
		<CFQUERY DATASOURCE="#application.SpeakerDSN#" NAME='getSpeaker'>
			SELECT firstname, lastname, middlename, ss
			FROM Speaker
			WHERE speakerid = #getMeetings.staff_id#
		</CFQUERY>
		
		<CFQUERY DATASOURCE="#application.SpeakerDSN#" NAME='getSpkrAddress'>
			SELECT add1, add2, add3, city, state, zipcode
			FROM SpeakerAddress
			WHERE speakerid = #getMeetings.staff_id#
		</CFQUERY>

<!----Begin Speaker Address Table----->		
		<cfset OutputArray[x] = "<table width='100%' cellpadding='0' cellspacing='0' border='0'><tr><td width='50%' style='border-top: solid 2px ##000000; padding-top: 5px; font-size: 14pt;'><i><strong>Speaker Information</strong></i></td>">
		<cfset x = #x# + 1>
		
		<cfset OutputArray[x] = "<td width='50%' style='border-top: solid 2px ##000000; padding-top: 5px; font-size: 14pt;'><i><strong>Meeting Code</strong></i></td></tr><tr>">
		<cfset x = #x# + 1>
			
		<cfset OutputArray[x] = "<td width='50%'><i><strong>Name:&nbsp;&nbsp;&nbsp;&nbsp; </strong></i><strong>#trim(getSpeaker.firstname)#<cfif #getSpeaker.middlename# NEQ ''> #trim(getSpeaker.middlename)#</cfif> #trim(getSpeaker.lastname)# </strong></td>">
		<cfset x = #x# + 1>
		
		<cfset OutputArray[x] = "<td width='50%' style='font-size: 14pt;'>#getMeetings.project_code#</td></tr><tr><td width='50%'><i><strong>Address: &nbsp;</strong></i><strong>#getSpkrAddress.add1#</strong></td><td width='50%'>&nbsp;</td></tr>">
		<cfset x = #x# + 1>
		
		<cfif #getSpkrAddress.add2# NEQ ''>
			<cfset OutputArray[x] = "<tr><td width='50%'><i><strong>Address: &nbsp;</strong></i><strong>#getSpkrAddress.add2#</strong></td><td width='50%'>&nbsp;</td></tr>">
			<cfset x = #x# + 1>
		</cfif>
			
		<cfif #getSpkrAddress.add3# NEQ ''>
			<cfset OutputArray[x] = "<tr><td width='50%'><i><strong>Address: </strong></i><strong>#getSpkrAddress.add3#</strong></td><td width='50%'>&nbsp;</td></tr>">
			<cfset x = #x# + 1>
		</cfif>
			
		<cfset OutputArray[x] = "<tr><td width='50%'><i><strong>City:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </strong></i><strong> #getSpkrAddress.city#</strong></td><td width='50%' style='font-size: 14pt;'><i><strong>Speaker Social Security Number</strong></i></td></tr>">
		<cfset x = #x# + 1>
		
		<cfset OutputArray[x] = "<tr><td width='50%' style='padding-bottom: 5px; border-bottom: solid 2px ##000000;'><i><strong>State:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </strong></i><strong> #getSpkrAddress.state#</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><i>Zip: </i></strong>&nbsp;<strong>#getSpkrAddress.zipcode#</strong></td>">
		<cfset x = #x# + 1>
				
		<cfset OutputArray[x] = "<td width='50%' style='font-size: 14pt; padding-bottom: 5px; border-bottom: solid 2px ##000000;'>#getSpeaker.ss#</td></tr></table><br><br><br>">
		<cfset x = #x# + 1>
<!----End Speaker Address Table----->

<!----Begin Meeting Fee Table---->				
		<cfset OutputArray[x] = "<table width='100%' cellpadding='3' cellspacing='5' border='0'>">
		<cfset x = #x# + 1>
		
		<cfset OutputArray[x] = "<tr><td width='10%'>&nbsp;</td><td width='26%' style='border-bottom: solid 1px ##000000;'><center><strong><i>Date</i></strong></center></td>">
		<cfset x = #x# + 1>
	
		<cfset OutputArray[x] = "<td width='26%' style='border-bottom: solid 1px ##000000;'><center><strong><i>Time</i></strong></center></td><td width='28%' style='border-bottom: solid 1px ##000000;'><center><strong><i>Fee per Meeting</i></strong></center></td><td width='10%'>&nbsp;</td></tr></table>">
		<cfset x = #x# + 1>
					
		<cfset OutputArray[x] = "<table width='100%' cellpadding='5' cellspacing='0' border='0' style='margin-top: 4px;'>">
		<cfset x = #x# + 1>
		
		<cfset honoTotal = 0> 
		<cfoutput><!---This is to group the speaker meetings if they have more than one---->
		
			<cfset OutputArray[x] = "<tr><td width='10%'>&nbsp;</td><td width='26%'><center>#getMeetings.month#/#getMeetings.day#/#getMeetings.year#</center></td>">
			<cfset x = #x# + 1>
			
			<cfscript>
				CivilianTime = oCivTime.toCivilian(BeginMilitary='#getMeetings.start_time#',EndMilitary='#getMeetings.end_time#');
			</cfscript>
			
			<cfset OutputArray[x] = "<td width='26%'><center>#CivilianTime[1]#:#CivilianTime[2]# #CivilianTime[3]# EST</center></td>">
			<cfset x = #x# + 1>
				
			<cfset _code = Left(#getMeetings.project_code#, 5)>
			
			<CFQUERY DATASOURCE="#application.SpeakerDSN#" NAME='getHonoFee'>
				SELECT fee 
				FROM speaker_clients
				WHERE rowid = #getMeetings.client_rowid#
			</CFQUERY>
			
			<cfset OutputArray[x] = "<td width='28%'><center>#DollarFormat(getHonoFee.fee)#</center></td><td width='10%'>&nbsp;</td></tr>">
            
			<cfif getHonoFee.fee NEQ ""> 
			   <cfset honoTotal = #honoTotal# + #getHonoFee.fee#>
		    <cfelse>
			   <cfset honoTotal = honoTotal + 0.00>
			</cfif>
		</cfoutput>
<!----Begin Three Exception Table Output. Note: Although there may be several speakers/moderators in the given time period, they 
will only be outputted if they are the PRIMARY speaker for another meeting in the given time period------>
		
		<!---Begin Additional Speakers-------->
		<!--- <CFQUERY DATASOURCE="#Application.projdsn#" NAME='getAdditionalSpeakers' USERNAME='#session.dbu#' PASSWORD='#session.dbp#'>
			SELECT ads.spkr_client_rowid as scr2, ads.add_meeting_date, smt.start_time, smt.end_time, ads.row_id
			FROM additional_speakers ads, ScheduleSpeaker smt
			WHERE spkrid = #getMeetings.speakerid# 
			AND (add_meeting_date BETWEEN #BeginingDate# AND #EndingDate#) 
			AND ads.meeting_rowid = smt.rowid
		</CFQUERY>
			
		<cfloop query="getAdditionalSpeakers">
			<cfset OutputArray[x] = "<tr><td width='10%'>&nbsp;</td><td width='26%'><center>#DateFormat(getAdditionalSpeakers.add_meeting_date, 'm/dd/yyyy')#</center></td>">
			<cfset x = #x# + 1>	
			
			<cfscript>
				CivilianTime2 = oCivTime.toCivilian(BeginMilitary='#getAdditionalSpeakers.start_time#',EndMilitary='#getAdditionalSpeakers.end_time#');
			</cfscript>
				
			<cfset OutputArray[x] = "<td width='26%'><center>#CivilianTime2[1]#:#CivilianTime2[2]# #CivilianTime2[3]# EST</center></td>">
			<cfset x = #x# + 1>
				
			<cfset _code = Left(#getMeetings.project_code#, 5)>
			
			<CFQUERY DATASOURCE="#application.SpeakerDSN#" NAME='getAdditionalHonoFee'>
				SELECT fee 
				FROM speaker_clients
				WHERE rowid = #getAdditionalSpeakers.scr2#
			</CFQUERY>
			
			<!---Delete this Additional Speaker from the Array, so they wont be outputted at the end---->
			<cfloop from="#ArrayLen(aAddSpeakersArray)#" to="1" index="p" step="-1">
				<cfif #aAddSpeakersArray[p]# EQ #getAdditionalSpeakers.row_id#>
					<cfset atemp = #ArrayDeleteAt(aAddSpeakersArray, p)#>
				</cfif>
			</cfloop>
				
			<cfset OutputArray[x] = "<td width='28%'><center>#DollarFormat(getHonoFee.fee)#</center></td><td width='10%'>&nbsp;</td></tr>">
			<cfset x = #x# + 1>
			
			<cfset honoTotal = #honoTotal# + #getHonoFee.fee#>
	
		</cfloop><!---End Additional Speakers Loop--->
		 
		<!------Need to add listen ins hono to the total------------->
		<CFQUERY DATASOURCE="#Application.projdsn#" NAME='getListenIns' USERNAME='#session.dbu#' PASSWORD='#session.dbp#'>
			SELECT li.spkr_client_rowid as scr3, li.add_meeting_date, smt.start_time, smt.end_time, li.row_id 
			FROM listen_ins li, ScheduleSpeaker smt
			WHERE li.modspkrid = #getMeetings.speakerid# 
			AND (li.add_meeting_date BETWEEN #BeginingDate# AND #EndingDate#) 
			AND li.meeting_rowid = smt.rowid
		</CFQUERY>
		
		<cfloop query="getListenIns">
			<cfset OutputArray[x] = "<tr><td width='10%'>&nbsp;</td><td width='26%'><center>#DateFormat(getListenIns.add_meeting_date, 'm/dd/yyyy')#</center></td>">
			<cfset x = #x# + 1>	
			
			<cfscript>
				CivilianTime2 = oCivTime.toCivilian(BeginMilitary='#getListenIns.start_time#',EndMilitary='#getListenIns.end_time#');
			</cfscript>
				
			<cfset OutputArray[x] = "<td width='26%'><center>#CivilianTime2[1]#:#CivilianTime2[2]# #CivilianTime2[3]# EST</center></td>">
			<cfset x = #x# + 1>
				
			<cfset _code = Left(#getMeetings.project_code#, 5)>
			
			<CFQUERY DATASOURCE="#application.SpeakerDSN#" NAME='getListenHonoFee'>
				SELECT fee 
				FROM speaker_clients
				WHERE rowid = #getListenIns.scr3#
			</CFQUERY>
			
			<!---Delete this Listener from the Array, so they wont be outputted at the end---->
			<cfloop from="#ArrayLen(aListenInArray)#" to="1" index="k" step="-1">
				<cfif #aListenInArray[k]# EQ #getListenIns.row_id#>
					<cfset atemp = #ArrayDeleteAt(aListenInArray, k)#>
				</cfif>
			</cfloop>
					
			<cfset OutputArray[x] = "<td width='28%'><center>#DollarFormat(getListenHonoFee.fee)#</center></td><td width='10%'>&nbsp;</td></tr>">
			<cfset x = #x# + 1>
			
			<cfset honoTotal = #honoTotal# + #getListenHonoFee.fee#>
	
		</cfloop><!---End Listen Ins Loop--->
		
		<!------Need to add training hono to the total------------->
		<CFQUERY DATASOURCE="#Application.projdsn#" NAME='getTrainees' USERNAME='#session.dbu#' PASSWORD='#session.dbp#'>
			SELECT t.spkr_client_rowid as scr4, t.add_meeting_date, smt.start_time, smt.end_time, t.row_id
			FROM training t, ScheduleSpeaker smt
			WHERE t.modspkrid = #getMeetings.speakerid# 
			AND (t.add_meeting_date BETWEEN #BeginingDate# AND #EndingDate#) 
			AND t.meeting_rowid = smt.rowid
		</CFQUERY>
		
		<cfloop query="getTrainees">
			<cfset OutputArray[x] = "<tr><td width='10%'>&nbsp;</td><td width='26%'><center>#DateFormat(getTrainees.add_meeting_date, 'm/dd/yyyy')#</center></td>">
			<cfset x = #x# + 1>	
			
			<cfscript>
				CivilianTime2 = oCivTime.toCivilian(BeginMilitary='#getTrainees.start_time#',EndMilitary='#getTrainees.end_time#');
			</cfscript>
				
			<cfset OutputArray[x] = "<td width='26%'><center>#CivilianTime2[1]#:#CivilianTime2[2]# #CivilianTime2[3]# EST</center></td>">
			<cfset x = #x# + 1>
				
			<cfset _code = Left(#getMeetings.project_code#, 5)>
			
			<CFQUERY DATASOURCE="#application.SpeakerDSN#" NAME='getTrainingHonoFee'>
				SELECT fee 
				FROM speaker_clients
				WHERE rowid = #getTrainees.scr4#
			</CFQUERY>
			
			<!---Delete this Trainee from the Array, so they wont be outputted at the end---->
			<cfloop from="#ArrayLen(aTraineesArray)#" to="1" index="m" step="-1">
				<cfif #aTraineesArray[m]# EQ #getTrainees.row_id#>
					<cfset atemp = #ArrayDeleteAt(aTraineesArray, m)#>
				</cfif>
			</cfloop>
					
			<cfset OutputArray[x] = "<td width='28%'><center>#DollarFormat(getTrainingHonoFee.fee)#</center></td><td width='10%'>&nbsp;</td></tr>">
			<cfset x = #x# + 1>
			
			<cfset honoTotal = #honoTotal# + #getTrainingHonoFee.fee#>
	
		</cfloop><!---End Training Loop--->
			--->
<!----End 3 Exception Table reporting.------------------->
		
		
		
		<cfset OutputArray[x] = "</table>">
		<cfset x = #x# + 1>
<!----End Meeting Fee Table---->

		<cfset OutputArray[x] = "<br><br><table width='100%' border='0' cellpadding='0' cellspacing='0'><tr><td width='75%' align='right' colspan='2' sytle='padding-right: 5px;'><strong>Total Amount Due:</strong></td>">
		<cfset x = #x# + 1>
		
		<cfset OutputArray[x] = "<td width='25%' align='left' colspan='2' sytle='padding-left: 5px;'><strong><em>#DollarFormat(honoTotal)#</em></strong></td></tr></table>">
		<cfset x = #x# + 1>

		
		<cfset OutputArray[x] = "<p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>">
		<cfset x = #x# + 1>

<!----Begin Office Use Only Table---->		
		<cfset OutputArray[x] = "<table width='100%' cellpadding='5' cellspacing='0' border='0'><tr><td colspan='4' style='border-top: solid 1px ##000000;'><strong>(Office Use only)</strong></td></tr>">
		<cfset x = #x# + 1>
		
		<cfset OutputArray[x] = "<tr><td align='right'><strong><i>Approved by: </i></strong></td><td>___________________</td><td align='right'><strong><i>Date: </i></strong></td><td>___________________</td></tr>">
		<cfset x = #x# + 1>
		
		<cfset OutputArray[x] = "<tr><td align='right'><strong><i>Check Number: </i></strong></td><td>___________________</td><td align='right'><strong><i>Paid Date: </i></strong></td><td>___________________</td></tr>">
		<cfset x = #x# + 1>
		
		<cfset OutputArray[x] = "<tr><td colspan='4' style='border-bottom: solid 1px ##000000;'>&nbsp;</td></tr></table><br><strong><font size='10px'>#DateFormat(Now(), 'dddd, mmmm dd,yyyy')#</font></strong>">
		<cfset x = #x# + 1>
<!----EndOffice Use Only Table---->
		<!--- This statement inserts a page break into the Word file --->
		<cfset OutputArray[x] = "<br clear='all' style='page-break-before:always;mso-break-type:section-break'>">
		<cfset x = #x# + 1>
			
	</cfoutput>
	
	<cfset OutputArray[x] = "</body></html>">
	
	<cfset temp = #ArrayToList(OutputArray, " ")#>
<!--- 	<cfset report_path = "E:\INETPUB\WWWROOT\projects\cgi-bin\temp\rpt_temp.doc"> --->
	<cffile action="write" file="#application.ReportPath#\rpt_temp.doc" nameconflict="overwrite" output="#temp#">
	<cfcontent type="application/msword" deletefile="NO" file="#application.ReportPath#\rpt_temp.doc">

<cfelse>
	<hr width="100%" style="color: #CC0000;" size="1px">
	<p>No matching records were found.</p>
	<br><br>
	<a href="report_spkr_invoice.cfm">Go Back</a>	
</cfif>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">


