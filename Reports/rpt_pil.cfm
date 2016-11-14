<!--- 
	*****************************************************************************************
	Name:		rpt_pil.cfm
	
	Function:	Project Information List, this list is a replica of the paper PIL form.
	History:	bj010802 - initial code
				bj013002 - added spreadsheet capability.	
	*****************************************************************************************
--->
<html>
<head>
<title>Project Information List - Report</title>
<LINK REL="stylesheet" HREF="stylePIL.css" TYPE="text/css">
</head>
<!--- set report number --->
<cfparam name="report_id" default="100">
<cfparam name="today" default="#dateFormat(Now(), 'mm/dd/yyyy')#">
<!--- get report paramaters --->
<cfquery DATASOURCE="#application.projdsn#" name="getp">
	Select r.report_id, r.report_title, r.report_columns, r.report_path, r.report_title_color, r.report_col_color, r.report_alt_color  
	from report_parms r
	where r.report_id = #report_id#
</cfquery> 

<!--- --->
<cfif isDefined("form.select_rpt")>
	<!--- get records for specified company --->
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="qpiw">			
		SELECT p.project_code, p.client_code, p.client, p.product, p.guide_topic, p.project_status,
				p.corp_id, p.target_audience, p.total_cert_honoraria, p.total_cash_honoraria,
				p.recruiting_company, p.recruiting_company_phone, p.conference_company,
				p.helpline, ps.status_code, p.meeting_type, p.guide_writer, 
				ps.status_description, cl.client_name, cr.guidebook_date	
		FROM piw p, project_status ps, clients cl, creative_info cr
		WHERE ps.status_code = p.project_status
			AND p.client = cl.id 
			AND cr.project_code = p.project_code
		<cfif form.select_rpt EQ 5>
			<!--- pull all records --->
			ORDER BY p.project_code
		<cfelse>
			<!--- pull specific records --->
			 AND p.corp_id = #form.select_rpt# ORDER BY p.client_code 
		</cfif>
	</CFQUERY>
	<!--- END QUERIES SECTION --->

	<cfif form.select_type EQ 1>
		<!--- display only version of report --->
		<body style="margin: 0; page: doublepage; page-break-after: right">
		<table cellspacing="2" cellpadding="0" border="0">
		<tr valign="top">
			<td colspan="12" class=tdheader><b>Project Information List - Report for 
				<cfif form.select_rpt EQ "1">C. Beck
				<cfelseif form.select_rpt EQ "2">Vista-Com
				<cfelseif form.select_rpt EQ "3">Group-Dynamics
				<cfelseif form.select_rpt EQ "4">Share-Com
				<cfelse> All Companies</b>
				</cfif>
			</td>
		</tr>
		<tr class=colheader>
		    <td width="63" class=colheader valign="bottom" nowrap align="center">Meeting Code</td>
		    <td width="120" class=colheader valign="bottom" nowrap align="center">Project Information</td>
	    	<td width="60" class=colheader valign="bottom" nowrap align="center">Client</td>
		    <td width="38" class=colheader valign="bottom" align="center">Meeting Type</td>
		    <td width="48" class=colheader valign="bottom" nowrap align="center">Guide Date</td>
	    	<td width="40" class=colheader valign="bottom" nowrap align="center">Mod. Contact</td>
		    <td width="15" class=colheader valign="bottom" nowrap align="center">Status</td>
		    <td width="75" class=colheader valign="bottom" nowrap align="center">Attendees</td>
	    	<td width="73" class=colheader valign="bottom" nowrap align="center">Honoraria</td>
		    <td width="80" class=colheader valign="bottom" nowrap align="center">Reporting</td>
		    <td width="67" class=colheader valign="bottom" nowrap align="center">Recruiter</td>
	    	<td width="67" class=colheader valign="bottom" nowrap align="center">Conference Phone</td>
		</tr>
		<tr><td colspan="12" width="900"><hr></td></tr>
		<cfoutput query="qpiw">
		<!--- vary the line shading for every other line --->
		<cfif qpiw.currentrow mod 2 EQ 0>
			<tr bgcolor="##f6f6f6" valign="top">
		<cfelse>
			<tr valign="top">
		</cfif>
			<td width="63" valign="top" nowrap align="center">#project_code#<br></td>
	    	<td width="220" valign="top" nowrap align="left">#product#<br>#guide_topic#</td>
		    <td width="60" valign="top" nowrap align="center">#client_name#<br></td>
			<cfif qpiw.meeting_type EQ "">
			    <td width="38" valign="top" align="center">N/A</td>
			<cfelse>
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="qmt">			
					SELECT meeting_type_value FROM meeting_type 
					WHERE meeting_type.meeting_type = #qpiw.meeting_type#
				</CFQUERY>
			    <td width="38" valign="top" align="center">#qmt.meeting_type_value#</td>
	    	</cfif>
			<td width="48" valign="top" nowrap align="center">#dateFormat(guidebook_date, "mm/dd/yy")#<br></td>
			<!--- guide writer info --->
			<cfif qpiw.guide_writer LT "300000">
				<td width="40" valign="top" nowrap align="center">TBD</td>
			<cfelse>		
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="qgw">			
					SELECT moderator_initials FROM moderator
					WHERE moderator.speakerid = #qpiw.guide_writer#
				</CFQUERY>
			    <td width="40" valign="top" nowrap align="center">#qgw.moderator_initials#<br></td>
			</cfif>
		    <td width="15" valign="top" nowrap align="center">#status_description#<br></td>
		    <td width="75" valign="top" nowrap align="center">#target_audience#<br></td>
	    	<td width="73" valign="top" nowrap align="left">$#numberFormat(total_cert_honoraria)# Cert<br>$#numberFormat(total_cash_honoraria)# Cash<br></td>
			<!--- recruiting company info --->
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="qrpt">			
				SELECT summary_weekly, summary_monthly, summary_other, vm_mgrs, vm_reps, vm_other
				FROM report_info
				WHERE report_info.project_code = '#qpiw.project_code#'
			</CFQUERY>
			<cfif qrpt.recordcount GT 0>
				<cfset strreport = "">
				<cfif qrpt.summary_monthly EQ 1><cfset strreport = "Monthly Summary<br>"></cfif>
				<cfif qrpt.summary_weekly EQ 1><cfset strreport = strreport & "Weekly Summary<br>"></cfif>
				<cfif qrpt.summary_other EQ 1><cfset strreport = strreport & "Other Reporting"></cfif>
				<cfset strvmx = "">
				<cfif qrpt.vm_mgrs EQ 1><cfset strvmx = "VMX Mgrs<br>"></cfif>
				<cfif qrpt.vm_reps EQ 1><cfset strvmx = strvmx & "VMX Reps<br>"></cfif>
				<cfif qrpt.vm_other EQ 1><cfset strvmx = strvmx & "VMX Other"></cfif>
				<td width="80" valign="top" nowrap align="center">#strreport#<br>#strvmx#</td>
			<cfelse>
			    <td width="80" valign="top" nowrap align="center">TBD</td>
			</cfif>
			<!--- recruiting company info --->
			<cfif qpiw.recruiting_company LT 1>
				<td width="67" valign="top" nowrap align="center">TBD</td>
			<cfelse>
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="qre">			
					SELECT recruiter_name FROM recruiter
					WHERE recruiter.id = #qpiw.recruiting_company#
				</CFQUERY>
				<td width="67" valign="top" nowrap align="left">#trim(qre.recruiter_name)#<br>#recruiting_company_phone#<br></td>
			</cfif>
			<!--- conferencing compnay info --->
			<cfif qpiw.conference_company LT 1>
		    	<td width="67" valign="top" nowrap align="center">TBD</td>
			<cfelse>
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="qcnf">			
					SELECT conf_company_name FROM conference_company
					WHERE conference_company.id = #qpiw.conference_company#
				</CFQUERY>
		    	<td width="67" valign="top" nowrap align="left">#trim(qcnf.conf_company_name)#<br>#helpline#<br></td>
			</cfif>
		</tr>
		</cfoutput>
		</table>
		</body>
	<cfelse>
		<!--- this is the spreadsheet version --->
		<body>
		<!--- determine which compnay was requested --->
		<cfif form.select_rpt EQ "1"><cfset scompany = "C. Beck">
		<cfelseif form.select_rpt EQ "2"><cfset scompany = "Vista-Com">
		<cfelseif form.select_rpt EQ "3"><cfset scompany = "Group-Dynamics">
		<cfelseif form.select_rpt EQ "4"><cfset scompany = "Share-Com">
		<cfelse><cfset scompany = "All Companies">
		</cfif>

		<!--- write the headings --->
		<cfoutput>
			<cffile action="write" file="#trim(getp.report_path)#" nameconflict="overwrite" output="<html><head><title></title></head>">
			<cffile action="append" file="#trim(getp.report_path)#" nameconflict="overwrite" output="<body><table border=1>">
			<cffile action="append" file="#trim(getp.report_path)#" nameconflict="overwrite" output="<tr bgcolor=#getp.report_title_color#><td colspan=#getp.report_columns#><font name=arial size=+2>#getp.report_title# as of #dateFormat(Now(), 'mm/dd/yyyy')# for #scompany#</font></td></tr>">
			<cffile action="append" file="#trim(getp.report_path)#" nameconflict="overwrite" 
					output="<tr bgcolor=#getp.report_col_color#><font name=arial><td><b>Meeting Code</b></td><td><b>Project Information</b></td><td><b>Client</b></td><td><b>Meeting Type</b></td><td><b>Guide Date</b></td><td><b>Mod. Contact</b></td><td><b>Status</b></td><td><b>Attendees</b></td><td><b>Honoraria</b></td><td><b>Reporting</b></td><td><b>Recruiter</b></td><td><b>Conference Phone</b></td></font></tr>">
		</cfoutput>
	
		<cfoutput query="qpiw">
			<!--- get the meeting type --->
			<cfif qpiw.meeting_type EQ "">
			    <cfset smeeting_type = "N/A">
			<cfelse>
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="qmt">			
					SELECT meeting_type_value FROM meeting_type 
					WHERE meeting_type.meeting_type = #qpiw.meeting_type#
				</CFQUERY>
			    <cfset smeeting_type = "#qmt.meeting_type_value#">
	    	</cfif>
			<!--- get guide writer --->
			<cfif qpiw.guide_writer LT "300000">
				<cfset sguide_writer = "TBD">
			<cfelse>		
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="qgw">			
					SELECT moderator_initials FROM moderator
					WHERE moderator.speakerid = #qpiw.guide_writer#
				</CFQUERY>
				<cfset sguide_writer = "#qgw.moderator_initials#">
			</cfif>

			<!--- recruiting company info --->
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="qrpt">			
				SELECT summary_weekly, summary_monthly, summary_other, vm_mgrs, vm_reps, vm_other
				FROM report_info
				WHERE report_info.project_code = '#qpiw.project_code#'
			</CFQUERY>
			<cfif qrpt.recordcount GT 0>
				<cfset strreport = "">
				<cfif qrpt.summary_monthly EQ 1><cfset strreport = "Monthly Summary<br>"></cfif>
				<cfif qrpt.summary_weekly EQ 1><cfset strreport = strreport & "Weekly Summary<br>"></cfif>
				<cfif qrpt.summary_other EQ 1><cfset strreport = strreport & "Other Reporting"></cfif>
				<cfset strvmx = "">
				<cfif qrpt.vm_mgrs EQ 1><cfset strvmx = "VMX Mgrs<br>"></cfif>
				<cfif qrpt.vm_reps EQ 1><cfset strvmx = strvmx & "VMX Reps<br>"></cfif>
				<cfif qrpt.vm_other EQ 1><cfset strvmx = strvmx & "VMX Other"></cfif>
				<cfset sreports = "#strreport#<br>#strvmx#">
			<cfelse>
			    <cfset sreports = "TBD">
			</cfif>

			<!--- recruiting company info --->
			<cfif qpiw.recruiting_company LT 1>
				<cfset srecruiter ="TBD">
			<cfelse>
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="qre">			
					SELECT recruiter_name FROM recruiter WHERE recruiter.id = #qpiw.recruiting_company#
				</CFQUERY>
				<cfset srecruiter = "#trim(qre.recruiter_name)#<br>#recruiting_company_phone#">
			</cfif>
			<!--- conferencing compnay info --->
			<cfif qpiw.conference_company LT 1>
		    	<cfset sconference = "TBD">
			<cfelse>
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="qcnf">			
					SELECT conf_company_name FROM conference_company
					WHERE conference_company.id = #qpiw.conference_company#
				</CFQUERY>
		    	<cfset sconference = "#trim(qcnf.conf_company_name)#<br>#helpline#">
			</cfif>
		   		
			<!--- --->				
			<!--- write data lines to spreadsheet --->		
			<cffile action="append" file="#trim(getp.report_path)#" nameconflict="overwrite" output="<tr bgcolor=#getp.report_alt_color#><td>#trim(qpiw.project_code)#</td><td>#trim(qpiw.product)#<br>#trim(qpiw.guide_topic)#</td><td>#trim(qpiw.client_name)#</td><td>#smeeting_type#</td><td>#dateFormat(qpiw.guidebook_date, "mm/dd/yy")#</td><td>#trim(sguide_writer)#</td><td>#trim(status_description)#</td><td>#trim(target_audience)#</td><td>$#numberFormat(total_cert_honoraria)# Cert<br>$#numberFormat(total_cash_honoraria)# Cash<br></td><td>#trim(sreports)#</td><td>#trim(srecruiter)#</td><td>#trim(sconference)#</td></tr>">
		
		</cfoutput>
		<cfoutput>
			<cffile action="append" file="#trim(getp.report_path)#" nameconflict="overwrite" output="</table></body></html>">
			<!--- display the file --->
			<cfcontent type="application/vnd.ms-excel" deletefile="NO" file="#trim(getp.report_path)#">
		</cfoutput>
		</body>
	</cfif>
<cfelse>
	An error occured while processing your request, please try again...
</cfif>
</html>
