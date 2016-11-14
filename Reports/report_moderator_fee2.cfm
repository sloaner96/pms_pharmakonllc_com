<!----------------------------
report_moderator_fee2.cfm

Merge letter that allows moderator invoices to be generated and exported to MS Word. 

--------------------------------->


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
	SELECT Distinct meeting_code, *
	FROM ScheduleSpeaker
	WHERE (meeting_date BETWEEN #BeginingDate# AND #EndingDate#)
	AND status = 0
	AND staff_id = #form.moderator#
</CFQUERY>

<!--- <CFQUERY DATASOURCE="#Application.projdsn#" NAME='getListenIns' USERNAME='#session.dbu#' PASSWORD='#session.dbp#'>
	SELECT l.meeting_rowid, l.spkr_client_rowid, smt.start_time, smt.end_time, 
	smt.project_code, l.add_meeting_date
	FROM listen_ins l, ScheduleSpeaker smt
	WHERE l.modspkrid = #form.moderator# 
	AND l.meeting_rowid = smt.rowid
	ORDER BY l.add_meeting_date
</CFQUERY> --->

<!--- <CFQUERY DATASOURCE="#Application.projdsn#" NAME='getTrainees' USERNAME='#session.dbu#' PASSWORD='#session.dbp#'>
	SELECT t.meeting_rowid, t.spkr_client_rowid, smt.start_time, smt.end_time, 
	smt.project_code, t.add_meeting_date
	FROM training t, ScheduleSpeaker smt
	WHERE t.modspkrid = #form.moderator# 
	AND t.meeting_rowid = smt.rowid
	ORDER BY t.add_meeting_date
</CFQUERY> --->

<cfif #getMeetings.recordcount#>

	<cfscript>
		oCivTime = createObject('component','pms.com.cfc_time_conversion');
	</cfscript>

	<CFQUERY DATASOURCE="#application.SpeakerDSN#" NAME='getModerator'>
		SELECT firstname, lastname, middlename, ss
		FROM Speaker
		WHERE speakerid = #form.moderator#
	</CFQUERY>
	
	<CFQUERY DATASOURCE="#application.SpeakerDSN#" NAME='getModAddress'>
		SELECT add1, add2, add3, city, state, zipcode
		FROM SpeakerAddress
		WHERE speakerid = #form.moderator#
	</CFQUERY>
	
	<CFQUERY DATASOURCE="#application.SpeakerDSN#" NAME='getModPhone'>
		SELECT phone1
		FROM phone_details
		WHERE speakerid = #form.moderator#
	</CFQUERY>

	
	<cfset OutputArray = ArrayNew(1)>
	<cfset x = 1>
	
	<cfset OutputArray[x] = "<html><head><title>Project Management System || Moderator Fee Statement</title></head><body>">
	<cfset x = #x# + 1>

	<cfoutput>
		
		<cfset OutputArray[x] = "<center><strong>Fee Statement</strong></center><p><strong>Date:</strong> &nbsp; #form.begin_date# &mdash; #form.end_date#</p>">
		<cfset x = #x# + 1>
		<cfset OutputArray[x] = "<p><strong>Name:</strong> &nbsp; #getModerator.firstname# #getModerator.lastname#</p><p><strong>SSN:</strong> &nbsp; #getModerator.ss#</p>">
		<cfset x = #x# + 1>
		<cfset OutputArray[x] = "<p><strong>Address:</strong><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#getModAddress.add1#<br>">
		<cfset x = #x# + 1>
		
		<cfif #getModAddress.add2# NEQ ''>
			<cfset OutputArray[x] = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#getModAddress.add2#<br>">
			<cfset x = #x# + 1>
		</cfif>
		<cfif #getModAddress.add3# NEQ ''>
			<cfset OutputArray[x] = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#getModAddress.add3#<br>">
			<cfset x = #x# + 1>
		</cfif>
			
		<cfset OutputArray[x] = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#getModAddress.city#, #getModAddress.state# #getModAddress.zipcode#</p><p><strong>Phone Number:</strong> &nbsp; #getModPhone.phone1#</p>">
		<cfset x = #x# + 1>
	
	</cfoutput>
	
	<cfset OutputArray[x] = "<table width='100%' cellpadding='0' cellspacing='0' border='1' bordercolor='##CCCCCC'><tr><td><strong>Date</strong></td><td><strong>Meeting Code</strong></td><td><strong>Fee Amount</strong></td></tr>">
	<cfset x = #x# + 1>
	
	<cfset TotalHonoFees = 0>
		
		<!----Out Primary Meetings------->
		<cfoutput query="getMeetings">
		
			<CFQUERY DATASOURCE="#application.SpeakerDSN#" NAME='getHonoFee'>
				SELECT fee 
				FROM speaker_clients
				WHERE rowid = #getMeetings.mod_client_rowid#
			</CFQUERY>
			
			<cfscript>
				CivilianTime = oCivTime.toCivilian(BeginMilitary='#getMeetings.start_time#',EndMilitary='#getMeetings.end_time#');
			</cfscript>
			
			<cfset HonoFees = 0>
			
			<cfif #getHonoFee.recordcount#>
				<cfif #getHonoFee.fee# NEQ ''>
					<cfset TotalHonoFees = #TotalHonoFees# + #getHonoFee.fee#>
					<cfset HonoFees = #getHonoFee.fee#>
				<cfelse>
					<cfset TotalHonoFees = #TotalHonoFees# + 0>
					<cfset HonoFees = "N/A">
				</cfif>
			<cfelse>
				<cfset TotalHonoFees = #TotalHonoFees# + 0>
				<cfset HonoFees = "N/A">
			</cfif>
			
			<cfset OutputArray[x] = "<tr><td>#getMeetings.month#/#getMeetings.day#/#getMeetings.year#</td><td>#getMeetings.project_code# #CivilianTime[1]##CivilianTime[2]#</td><td>">
			<cfset x = #x# + 1>
			
			<cfif #HonoFees# EQ "N/A">
				<cfset OutputArray[x] = "#HonoFees#">
				<cfset x = #x# + 1>
			<cfelse>
				<cfset OutputArray[x] = "#DollarFormat(HonoFees)#">
				<cfset x = #x# + 1>
			</cfif>
			
			<cfset OutputArray[x] = "</td></tr>">
			<cfset x = #x# + 1>
			
		</cfoutput>
		
		<!-----Output Listen In Meetings-------->
		<!--- <cfoutput query="getListenIns">
		
			<CFQUERY DATASOURCE="#application.SpeakerDSN#" NAME='getHonoFee'>
				SELECT fee 
				FROM speaker_clients
				WHERE rowid = #getListenIns.spkr_client_rowid#
			</CFQUERY>
			
			<cfscript>
				CivilianTime = oCivTime.toCivilian(BeginMilitary='#getListenIns.start_time#',EndMilitary='#getListenIns.end_time#');
			</cfscript>
			
			<cfset HonoFees = 0>
			
			<cfif #getHonoFee.recordcount#>
				<cfif #getHonoFee.fee# NEQ ''>
					<cfset TotalHonoFees = #TotalHonoFees# + #getHonoFee.fee#>
					<cfset HonoFees = #getHonoFee.fee#>
				<cfelse>
					<cfset TotalHonoFees = #TotalHonoFees# + 0>
					<cfset HonoFees = "N/A">
				</cfif>
			<cfelse>
				<cfset TotalHonoFees = #TotalHonoFees# + 0>
				<cfset HonoFees = "N/A">
			</cfif>
			
			<cfset OutputArray[x] = "<tr><td>#DateFormat(getListenIns.add_meeting_date, 'm/d/yyyy')#</td><td>#getListenIns.project_code# #CivilianTime[1]##CivilianTime[2]#</td><td>">
			<cfset x = #x# + 1>
			
			<cfif #HonoFees# EQ "N/A">
				<cfset OutputArray[x] = "#HonoFees#">
				<cfset x = #x# + 1>
			<cfelse>
				<cfset OutputArray[x] = "#DollarFormat(HonoFees)#">
				<cfset x = #x# + 1>
			</cfif>
			
			<cfset OutputArray[x] = "</td></tr>">
			<cfset x = #x# + 1>
			
		</cfoutput>
		
		<!-----Output Trainee Meetings-------->
		<cfoutput query="getTrainees">
		
			<CFQUERY DATASOURCE="#application.SpeakerDSN#" NAME='getHonoFee'>
				SELECT fee 
				FROM speaker_clients
				WHERE rowid = #getTrainees.spkr_client_rowid#
			</CFQUERY>
			
			<cfscript>
				CivilianTime = oCivTime.toCivilian(BeginMilitary='#getTrainees.start_time#',EndMilitary='#getTrainees.end_time#');
			</cfscript>
			
			<cfset HonoFees = 0>
			
			<cfif #getHonoFee.recordcount#>
				<cfif #getHonoFee.fee# NEQ ''>
					<cfset TotalHonoFees = #TotalHonoFees# + #getHonoFee.fee#>
					<cfset HonoFees = #getHonoFee.fee#>
				<cfelse>
					<cfset TotalHonoFees = #TotalHonoFees# + 0>
					<cfset HonoFees = "N/A">
				</cfif>
			<cfelse>
				<cfset TotalHonoFees = #TotalHonoFees# + 0>
				<cfset HonoFees = "N/A">
			</cfif>
			
			<cfset OutputArray[x] = "<tr><td>#DateFormat(getTrainees.add_meeting_date, 'm/d/yyyy')#</td><td>#getTrainees.project_code# #CivilianTime[1]##CivilianTime[2]#</td><td>">
			<cfset x = #x# + 1>
			
			<cfif #HonoFees# EQ "N/A">
				<cfset OutputArray[x] = "#HonoFees#">
				<cfset x = #x# + 1>
			<cfelse>
				<cfset OutputArray[x] = "#DollarFormat(HonoFees)#">
				<cfset x = #x# + 1>
			</cfif>
			
			<cfset OutputArray[x] = "</td></tr>">
			<cfset x = #x# + 1>
			
		</cfoutput> --->
		
		<cfset OutputArray[x] = "<tr><td align='right' colspan='2'><strong>Total&nbsp; &nbsp;</strong></td><td><cfoutput>#DollarFormat(TotalHonoFees)#</cfoutput></td></tr></table></body></html>">
		
		<cfset temp = #ArrayToList(OutputArray, " ")#>
	
		<!--- <cfset report_path = "E:\INETPUB\WWWROOT\projects\cgi-bin\temp\rpt_temp.doc"> --->
		<cffile action="write" file="#application.ReportPath#\rpt_temp.doc" nameconflict="overwrite" output="#temp#">
		<cfcontent type="application/msword" deletefile="NO" file="#application.ReportPath#\rpt_temp.doc">
		
<cfelse>
	<img src="images/projman_logo.gif" border="0">
	<hr width="100%" style="color: #CC0000;" size="1px">
	<p>No matching records were found.</p>
	<br><br>
	<a href="report_moderator_fee.cfm">Go Back</a>	
</cfif>



