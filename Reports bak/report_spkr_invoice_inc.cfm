<cfoutput query='ExceptionQuery' group="spkrid">
		
	<cfif CallingQuery EQ "AdditionalSpeakers">
		<cfset iTheSpeakerID = #ExceptionQuery.spkrid#>
	<cfelse>
		<cfset iTheSpeakerID = #ExceptionQuery.modspkrid#>
	</cfif>
	
	<cfset OutputArray[x] = "<table width='35%' cellpadding='0' cellspacing='0' border='0'><tr><td style='border-top: solid 1px ##000000; border-left: solid 1px ##000000; border-right: solid 1px ##000000; font-size: 15pt;'><i><strong>Date Needed:</strong></i></td>">
	<cfset x = #x# + 1>
	
	<cfset OutputArray[x] = "</tr><tr><td style='border-bottom: solid 1px ##000000; border-left: solid 1px ##000000; border-right: solid 1px ##000000; font-size: 12pt;' align='right'><strong>#DateFormat(newdate, 'mm/dd/yyyy')#</strong></td></tr></table><br><br>">
	<cfset x = #x# + 1>
		
	<cfscript>
		projName = ProjectName.getProjName(ProjCode='#ExceptionQuery.project_code#');
	</cfscript>
	
	<cfset OutputArray[x] = "<table width='100%' cellpadding='0' cellspacing='0' border='0'><tr><td style='border: solid 1px ##000000; font-size: 18pt;'><center><i><strong>#projname# Invoice</strong></i></center></td>">
	<cfset x = #x# + 1>
	
	<cfset OutputArray[x] = "</tr></table><br><br><table width='100%' cellpadding='0' cellspacing='0' border='0'><tr><td><center><i><strong>C. Beck LLC</strong></i></center></td></tr><tr><td><center><i><strong>Fax To: <u>Zeffernee Wilson</u></strong></i></center></td></tr>">
	<cfset x = #x# + 1>
	
	<cfset OutputArray[x] = "<tr><td><center><i><strong>Fax Number: <u>888-397-0761</u> &nbsp; &nbsp; Phone Number: <u>800-932-4786 ext. 212</u></strong></i></center></td></tr></table><br><br>">
	<cfset x = #x# + 1>
	
	<CFQUERY DATASOURCE="#application.SpeakerDSN#" NAME='getSpeaker'>
		SELECT firstname, lastname, middleinitial, ss
		FROM spkr_table
		WHERE speaker_id = #iTheSpeakerID#
	</CFQUERY>
	
	<CFQUERY DATASOURCE="#application.SpeakerDSN#" NAME='getSpkrAddress'>
		SELECT mailtoadd_1, mailtoadd_2, mailtoadd_3, mailtocity, mailtostate, mailtozip
		FROM address
		WHERE owner_id = #iTheSpeakerID#
	</CFQUERY>

<!----Begin Speaker Address Table----->		
	<cfset OutputArray[x] = "<table width='100%' cellpadding='0' cellspacing='0' border='0'><tr><td width='50%' style='border-top: solid 2px ##000000; padding-top: 5px; font-size: 14pt;'><i><strong>Speaker Information</strong></i></td>">
	<cfset x = #x# + 1>
	
	<cfset OutputArray[x] = "<td width='50%' style='border-top: solid 2px ##000000; padding-top: 5px; font-size: 14pt;'><i><strong>Meeting Code</strong></i></td></tr><tr>">
	<cfset x = #x# + 1>
		
	<cfset OutputArray[x] = "<td width='50%'><i><strong>Name:&nbsp;&nbsp;&nbsp;&nbsp; </strong></i><strong>#trim(getSpeaker.firstname)#<cfif #getSpeaker.middleinitial# NEQ ''> #trim(getSpeaker.middleinitial)#</cfif> #trim(getSpeaker.lastname)# </strong></td>">
	<cfset x = #x# + 1>
	
	<cfset OutputArray[x] = "<td width='50%' style='font-size: 14pt;'>#getMeetings.project_code#</td></tr><tr><td width='50%'><i><strong>Address: &nbsp;</strong></i><strong>#getSpkrAddress.mailtoadd_1#</strong></td><td width='50%'>&nbsp;</td></tr>">
	<cfset x = #x# + 1>
	
	<cfif #getSpkrAddress.mailtoadd_2# NEQ ''>
		<cfset OutputArray[x] = "<tr><td width='50%'><i><strong>Address: &nbsp;</strong></i><strong>#getSpkrAddress.mailtoadd_2#</strong></td><td width='50%'>&nbsp;</td></tr>">
		<cfset x = #x# + 1>
	</cfif>
		
	<cfif #getSpkrAddress.mailtoadd_3# NEQ ''>
		<cfset OutputArray[x] = "<tr><td width='50%'><i><strong>Address: </strong></i><strong>#getSpkrAddress.mailtoadd_3#</strong></td><td width='50%'>&nbsp;</td></tr>">
		<cfset x = #x# + 1>
	</cfif>
		
	<cfset OutputArray[x] = "<tr><td width='50%'><i><strong>City:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </strong></i><strong> #getSpkrAddress.mailtocity#</strong></td><td width='50%' style='font-size: 14pt;'><i><strong>Speaker Social Security Number</strong></i></td></tr>">
	<cfset x = #x# + 1>
	
	<cfset OutputArray[x] = "<tr><td width='50%' style='padding-bottom: 5px; border-bottom: solid 2px ##000000;'><i><strong>State:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </strong></i><strong> #getSpkrAddress.mailtostate#</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><i>Zip: </i></strong>&nbsp;<strong>#getSpkrAddress.mailtozip#</strong></td>">
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
	
		<cfset OutputArray[x] = "<tr><td width='10%'>&nbsp;</td><td width='26%'><center>#DateFormat(ExceptionQuery.add_meeting_date, 'm/d/yyyy')#</center></td>">
		<cfset x = #x# + 1>
		
		<cfscript>
			CivilianTime = oCivTime.toCivilian(BeginMilitary='#ExceptionQuery.start_time#',EndMilitary='#ExceptionQuery.end_time#');
		</cfscript>
		
		<cfset OutputArray[x] = "<td width='26%'><center>#CivilianTime[1]#:#CivilianTime[2]# #CivilianTime[3]# EST</center></td>">
		<cfset x = #x# + 1>
			
		<cfset _code = Left(#getMeetings.project_code#, 5)>
		
		<CFQUERY DATASOURCE="#application.SpeakerDSN#" NAME='getHonoFee'>
			SELECT fee 
			FROM speaker_clients
			WHERE rowid = #ExceptionQuery.spkr_client_rowid#
		</CFQUERY>
		
		<cfset OutputArray[x] = "<td width='28%'><center>#DollarFormat(getHonoFee.fee)#</center></td><td width='10%'>&nbsp;</td></tr>">
		<cfset x = #x# + 1>
		
		<cfset honoTotal = #honoTotal# + #getHonoFee.fee#>

	</cfoutput>
	
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
	
	<cfset OutputArray[x] = "<tr><td colspan='4' style='border-bottom: solid 1px ##000000;'>&nbsp;</td></tr></table><p style='font-size: 12px;'><strong>#DateFormat(Now(), 'dddd, mmmm dd, yyyy')#</strong></p>">
	<cfset x = #x# + 1>
<!----EndOffice Use Only Table---->

	<cfset OutputArray[x] = "<p>&nbsp;</p>">
	<cfset x = #x# + 1>
</cfoutput>

