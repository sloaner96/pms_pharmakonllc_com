<!--- 
	*****************************************************************************************
	Name:		reportpiw.cfm
	
	Function:	Pulls data for PIW into a printable "document"
	History:	9/25/01 LB
				10/12/01 TJS -added "NOT ISDEFINED" in beginning 
								for cases of reference from piw6.cfm"
	
	*****************************************************************************************
--->
<HTML>
<HEAD>
<TITLE>PIW Report</TITLE>
<LINK REL=stylesheet HREF="piw1style1.css" TYPE="text/css">		
<CFIF IsDefined("form.project_code")><cfset session.project_code = form.project_code>
<CFELSEIF IsDefined("URL.project_code")><cfset session.project_code = URL.project_code>
</CFIF>
</HEAD>
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qpiw">
	SELECT c.corp_value, l.client_name, p.account_exec, p.account_supr, 
			p.product, p.client_code, p.guide_writer, p.guide_topic, p.proj_program_start, 
			p.recruit_start, p.program_start, p.program_end, p.call_inbound, 
			p.call_outbound, r.recruiter_name, p.recruiting_company_phone, 
			o.conf_company_name, p.helpline, p.include_survey, p.survey_comp, 
			p.prog_participants, p.num_meetings, p.participant_target, 
			p.participant_recruit, p.attendee_comp_type, p.attendee_comp, 
			p.survey_comp_type, p.prog_length_hr, p.prog_length_min, p.special_notes, 
			p.target_audience, p.cme_accredited, p.cme_org, p.guidebook_include, 
			p.letter_confirmation, p.letter_thankyou, p.letter_fyessheet, 
			p.letter_faxinfosheet, p.letter_other, p.letter_other_description, 
			p.guidebook_to_recruiter, p.speaker_notes, b.cost_per_attendee, 
			b.direct_mail_costs, b.additional_costs, b.finance_notes, 
			b.client_ap_Contact, b.client_ap_phone_fax, b.billing_schedule, 
			re.summary_weekly, re.summary_monthly, re.summary_other, 
			re.summary_other_descrip, re.vm_mgrs, re.vm_reps, re.vm_other, re.vm_other_descrip,
			re.email_mgrs, re.email_reps, re.email_other, re.email_other_descrip,
			re.client_toll_free, re.special_report, cr.moderator_guide_date, cr.admin_materials_date, 
			cr.guidebook_date, cr.components_date, cr.guidebook_new, 
			cr.guidebook_revised, cr.guidebook_charts, cr.revise_wording, 
			cr.revise_charts, cr.new_charts, cr.special_instructions,  
			rc.rep_nom, rc.pa_ok, rc.np_ok, rc.other_ok, rc.other_description, 
			rc.direct_mailers_info, rc.recruit_mailings_info, rc.additional_info, 
			rc.market_drug_info, rc.market_drug_script, ro.roster_notes, 
			p.meeting_type, p.promo_direct_mail, p.promo_direct_mail_date, 
			p.promo_rep_nom, p.promo_rep_nom_date, p.promo_fax, p.promo_fax_date, 
			p.promo_other, p.promo_other_date, promo_other_descrip, 
			m.meeting_type_value, p.meeting_other_notes
 		FROM  corp c, piw p, clients l, recruiter r, conference_company o,  
				billing_info b, report_info re, creative_info cr, 
				recruiting_info rc, roster_info ro, meeting_type m 
		WHERE p.project_code = '#session.project_code#' 
			AND p.corp_id *= c.corp_id 
			AND p.client *= l.id 
			AND p.recruiting_company *= r.id 
			AND p.conference_company *= o.ID 
			AND b.project_code = '#session.project_code#' 
			AND re.project_code = '#session.project_code#' 
			AND cr.project_code = '#session.project_code#' 
			AND rc.project_code = '#session.project_code#' 
			AND ro.project_code = '#session.project_code#' 
			AND p.meeting_type *= m.meeting_type
</cfquery>

<!--- save client_code from query above --->
<cfset session.client_code = qpiw.client_code>

<!--- get info from the notes table --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qgetnotes">
	select n.note_type, n.note_data, n.entry_date, n.entry_time, n.entry_userid, n.rowid, n.subject
		from piw_notes n
		where n.project_code = '#session.project_code#'
</cfquery>
<BODY>
<table>
<tr>
	<td width=20>&nbsp;</td>
	<td>
		<cfoutput>
		<p align="left"><b><font color="Navy">Below is the detail from project: #session.project_code#. Click the <b><i>print</i></b> button for a hard copy.</font></b></p>
	  	<p align=right>
		<form action="piw1.cfm">
  		<INPUT  TYPE="submit" NAME="edit" VALUE="Edit This PIW"></form>
		</p>
		</cfoutput>
	</td>
</tr>
<td width=20>&nbsp;</td>
<td>
<table width="550" border="0" cellspacing="0" cellpadding="5" align="left">
<cfoutput query="qpiw">
	<!--- Contact info section --->
	<tr BGCOLOR="##99CCFF">
		<td colspan="2">
			<font size="2"><b><font color="Navy">Project Information Worksheet</font></b></font>
		</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th width=300><b>Client Code:</b></th>
		<td width=250>#client_code#</td>
	</tr>
	<tr>
		<th><b>Selling Corporation:</b></th>
		<td>#corp_value#</td>
	</tr>
	<cfif qpiw.account_exec NEQ "">
		<cfset ae = qpiw.account_exec>
	<cfelse>
		<cfset ae = 0>
	</cfif>
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="qAE">
		SELECT repfirstname, replastname FROM sales_reps WHERE sales_reps.ID = #ae#
	</cfquery>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Account Executive:</b></th>
		<td>#qAE.repfirstname#&nbsp;#qAE.replastname#</td>
	</tr>
	<cfif qpiw.account_supr NEQ "">
		<cfset as = qpiw.account_supr>
	<cfelse>
		<cfset as = 0>
	</cfif>
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="qaccount_supr">
		SELECT repfirstname, replastname FROM sales_reps WHERE sales_reps.ID = #as#
	</cfquery>
	<tr>
		<th><b>Account Supervisor:</b></th>
		<td>#qaccount_supr.repfirstname#&nbsp;#qaccount_supr.replastname#</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Client:</b></th>
		<td>#client_name#</td>
	</tr>
	<tr>
		<th><b>Product:</b></th>
		<td>#product#</td>
	</tr>
	<tr>
		<th><b>Guide Topic/Headline:</b></th>
		<td>#guide_topic#</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Recruit Start Date:</b></th>
		<td>#DateFormat(recruit_start, "mm/dd/yyyy")#</td>
	</tr>
	<tr>
		<th><b>Projected Program Start Date:</b></th>
		<td>#DateFormat(proj_program_start, "mm/dd/yyyy")#</td>
	</tr>
	<tr>
		<th><b>yesual Program Start Date:</b></th>
		<td>#DateFormat(program_start, "mm/dd/yyyy")#</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Program End Date:</b></th>
		<td>#DateFormat(program_end, "mm/dd/yyyy")#</td>
	</tr>
	<tr>
		<th><b>Recruiting Company:</b></th>
		<td>#recruiter_name#</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Recruiting Company Phone:</b></th>
		<cfif #len(trim(recruiting_company_phone))# EQ 10>
			<td>(#Left(recruiting_company_phone,3)#)#Mid(recruiting_company_phone,4,3)#-#Mid(recruiting_company_phone,7,11)#</td>
		<cfelse>
			<td>#recruiting_company_phone#</td>
		</cfif>	
	</tr>
	<tr>
		<th><b>Call In or Call Out Program:</b></th>
		<td>
			<cfif call_inbound EQ 1>call in</cfif>
			<cfif call_outbound EQ 1>call out</cfif>
		</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Conference Company:</b></th>
		<td>#conf_company_name#</td>
	</tr>
	<tr>
		<th><b>800## Helpline/Disconnect:</b></th>
		<cfif #len(trim(helpline))# EQ 10>
			<td>(#Left(helpline,3)#)#Mid(helpline,4,3)#-#Mid(helpline,7,11)#</td>
		<cfelse>
			<td>#helpline#</td>
		</cfif>	
	</tr>
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="qguidewriters">
		SELECT m.first_name, m.last_name, p.guide_writer
		FROM moderator m, piw p
		WHERE m.speakerid = p.guide_writer AND
		p.project_code = '#session.project_code#'
	</cfquery>
	<tr>
		<th><b>Guide Writer:</b></th>
		<td>#trim(qguidewriters.first_name)# #trim(qguidewriters.last_name)#</td>
	</tr>

	<CFQUERY DATASOURCE="#application.projdsn#" NAME="qmods">
		SELECT speakerid FROM  piw_moderators WHERE project_code = '#session.project_code#' 
	</cfquery>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Moderators(s):</b></th>
		<cfif #qmods.recordcount# GT 0>
			<td>
				<cfloop query="qmods">
					<!--- moderator info is kept in the speaker DB on AMADEUS --->
					<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="qminfo">
						SELECT firstname, lastname FROM  Speaker WHERE speakerid = #qmods.speakerid# 
					</cfquery>
					<cfif #qminfo.recordcount# GT 0>
						#trim(qminfo.firstname)#&nbsp;#trim(qminfo.lastname)#&nbsp;&nbsp;
					</cfif>
				</cfloop>
			</td>
		<cfelse>
			<td>(No moderators assigned)</td>		
		</cfif>
	</tr>
	<!--- end of Contact info section --->

	<!--- project/program section --->
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="meeting_type_code">
		SELECT c.meeting_type, m.meeting_type_value, meeting_type_description
		FROM client_proj c, meeting_type m
		WHERE c.client_proj = '#session.project_code#'
			AND m.meeting_type = c.meeting_type
		ORDER BY m.meeting_type_value
	</cfquery>
	<tr BGCOLOR="##99CCFF"><td colspan="2"><font size="2"><b><font color="Navy">Project/Program</font></b></font></td></tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Meeting Type:</b></th>
		<td>#meeting_type_code.meeting_type_value# - #meeting_type_code.meeting_type_description#<!--- #trim(meeting_type_value)# --->
			<cfif meeting_type EQ 99>&nbsp;&nbsp;*#meeting_other_notes#</cfif>
		</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Particpants Per Program:</b></th>
		<td>#prog_participants#</td>
	</tr>
	<tr>
		<th><b>## of Meetings per Project:</b></th>
		<td>#num_meetings#</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Meeting Participant Target:</b></th>
		<td>#participant_target#</td>
	</tr>
	<tr>
		<th><b>Meeting Participant Recruit:</b></th>
		<td>#participant_recruit#</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Length of Program:</b></th>
		<td>#prog_length_hr#
			<cfif prog_length_hr NEQ "">hrs</cfif>&nbsp;#prog_length_min#
			<cfif prog_length_min NEQ "">minutes</cfif>
		</td>
	</tr>
	<tr>
		<th><b>Special Notes:</b></th>
		<td>#special_notes#</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Target Audience:</b></th>
		<td>#target_audience#</td>
	</tr>
	<tr>
		<th><b>CME Accredited:</b></th>
		<td><cfif cme_accredited EQ 0>no</cfif><cfif cme_accredited EQ 1>yes</cfif></td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>CME Accredit Organization:</b></th>
		<td>#cme_org#</td>
	</tr>
	<tr>
		<th><b>Type of Promotion:</b></th>
		<td><cfif promo_direct_mail EQ 1>Direct Mail&nbsp;#DateFormat(promo_direct_mail_date, "mm/dd/yyyy")#<br></cfif>
			<cfif promo_rep_nom EQ 1>Rep Nomination&nbsp;#DateFormat(promo_rep_nom_date, "mm/dd/yyyy")#<br></cfif>
			<cfif promo_fax EQ 1>Fax&nbsp;#DateFormat(promo_fax_date, "mm/dd/yyyy")#<br></cfif>
			<cfif promo_other EQ 1>#promo_other_descrip#&nbsp;&nbsp;#DateFormat(promo_direct_mail_date, "mm/dd/yyyy")#<br></cfif>
		</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Other Materials to Be Included with Guidebook:</b></th>
		<td>#guidebook_include#</td>
	</tr>
	<tr>
		<th><b>Confirmation Letter:</b></th>
		<td><cfif letter_confirmation EQ 0>no</cfif><cfif letter_confirmation EQ 1>yes</cfif></td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Thank You Letter:</b></th>
		<td><cfif letter_thankyou EQ 0>no</cfif><cfif letter_thankyou EQ 1>yes</cfif></td>
	</tr>
	<tr>
		<th><b>Fyes Sheet:</b></th>
		<td><cfif letter_fyessheet EQ 0>no</cfif><cfif letter_fyessheet EQ 1>yes</cfif></td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Fax Info Sheet:</b></th>
		<td><cfif letter_faxinfosheet EQ 0>no</cfif><cfif letter_faxinfosheet EQ 1>yes</cfif></td>
	</tr>
	<tr>
		<th><b>Other:</b></th>
		<td><cfif letter_other EQ 0>none</cfif><cfif letter_other EQ 1>#letter_other_description#</cfif></td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Materials to Recruiter:</b></th>
		<td>#guidebook_to_recruiter#</td>
	</tr>
	<tr>
		<th><b>Speaker Names and Compensation:</b></th>
		<td>#speaker_notes#</td>
	</tr>
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="qattendee_comp_type">
		SELECT honoraria_name FROM honoraria_type WHERE honoraria_id = #qpiw.attendee_comp_type#
	</cfquery>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Attendee Honorarium Amt:</b></th>
		<td>$#decimalformat(qpiw.attendee_comp)#&nbsp;#qattendee_comp_type.honoraria_name#</td>
	</tr>
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="qsurvey_comp_type">
		SELECT honoraria_name FROM honoraria_type WHERE honoraria_id = #qpiw.survey_comp_type#
	</cfquery>
	<tr>
		<th><b>Survey Compensation:</b></th><td>$#decimalformat(survey_comp)#&nbsp;#qsurvey_comp_type.honoraria_name#</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Survey To Be Inlucded:</b></th><td><cfif include_survey EQ 0>no</cfif><cfif include_survey EQ 1>yes</cfif></td>
	</tr>
	<tr BGCOLOR="##99CCFF">
		<td colspan="2"><font size="2"><b><font color="Navy">Billing/Finance</font></b></font></td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Cost Per Attendee:</b></th>
		<td>#cost_per_attendee#</td>
	</tr>
	<tr>
		<th><b>Direct Mail Costs:</b></th>
		<td>#direct_mail_costs#</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Additional Upfront Costs:</b></th>
		<td>#additional_costs#</td>
	</tr>
	<tr>
		<th><b>Notes to Finance:</b></th>
		<td>#finance_notes#</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Client AP Contact:</b></th>
		<td>#client_ap_Contact#</td>
	</tr>
	<tr>
		<th><b>AP Phone/Fax ##:</b></th>
			<cfif #len(trim(client_ap_phone_fax))# EQ 10>
				<td>(#Left(client_ap_phone_fax,3)#)#Mid(client_ap_phone_fax,4,3)#-#Mid(client_ap_phone_fax,7,11)#</td>
			<cfelse>
				<td>#client_ap_phone_fax#</td>
			</cfif>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Schedule for Billing Client:</b></th>
		<td>#billing_schedule#</td>
	</tr>
	<!--- end bill/finance section --->
	
	<!--- reporting needs section --->
	<tr BGCOLOR="##99CCFF"><td colspan="2"><font size="2"><b><font color="Navy">Reporting Needs</font></b></font></td></tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Written Summary Reports:</b></th>
		<td><cfif summary_weekly EQ 1>weekly&nbsp;</cfif>
			<cfif summary_monthly EQ 1>monthly&nbsp;</cfif>
			<cfif summary_other EQ 1>#summary_other_descrip#</cfif>
		</td>
	</tr>
	<tr>
		<th><b>Voice Mail Reporting To:</b></th>
		<td><cfif vm_mgrs EQ 1>Managers&nbsp;</cfif>
			<cfif vm_reps EQ 1>Reps&nbsp;</cfif>
			<cfif vm_other EQ 1>Other:&nbsp;-&nbsp;#vm_other_descrip#</cfif>
		</td>
	</tr>
	<tr>
		<th><b>E-Mmail Reporting To:</b></th>
		<td><cfif email_mgrs EQ 1>Managers&nbsp;</cfif>
			<cfif email_reps EQ 1>Reps&nbsp;</cfif>
			<cfif email_other EQ 1>Other:&nbsp;-&nbsp;#email_other_descrip#</cfif>
		</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Client Toll Free ## for Moderators to Conduct VM:</b></th>
		<cfif #len(trim(client_toll_free))# EQ 10>
			<td>(#Left(client_toll_free,3)#)#Mid(client_toll_free,4,3)#-#Mid(client_toll_free,7,11)#</td>
		<cfelse><td>#client_toll_free#</td>
		</cfif>
	</tr>
	<tr>
		<th><b>Special Reporting:</b></th>
		<td>#special_report#</td>
	</tr>
	<!--- end of reporting needs information --->
	
	<!--- database info section --->
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="qdb">
		SELECT * FROM database_info WHERE project_code = '#session.project_code#'
	</cfquery>

	<tr BGCOLOR="##99CCFF"><td colspan="2"><font size="2"><b><font color="Navy">Database Information</font></b></font></td></tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Received Date:</b></th>
		<td>#dateFormat(qdb.received_date, "mm/dd/yy")#</td>
	</tr>
	<tr>
		<th><b>Received From:</b></th>
		<td>#trim(qdb.received_from)#</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>File:</b></th>
		<td>#trim(qdb.received_filename)#</td>
	</tr>
	<tr>
		<th><b>Requested Date:</b></th>
		<td>#dateFormat(qdb.requested_date)#</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Original Format:</b></th>
		<td>#qdb.original_format#</td>
	</tr>
	<tr>
		<th><b>Original Format Other:</b></th>
		<td>#qdb.original_format_other#</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Requested Format:</b></th>
		<td>#qdb.requested_format#</td>
	</tr>
	<tr>
		<th><b>Original Format Other:</b></th>
		<td>#qdb.original_format_other#</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Total Records:</b></th>
		<td>#qdb.total_records#</td>
	</tr>
	<tr>
		<th><b>Total Phone:</b></th>
		<td>#qdb.total_phone#</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Total No Phone:</b></th>
		<td>#qdb.total_nophone#</td>
	</tr>
	<tr>
		<th><b>Total Address:</b></th>
		<td>#qdb.total_addrs1#</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Total No Address:</b></th>
		<td>#qdb.total_noaddrs1#</td>
	</tr>
	<tr>
		<th><b>Total State:</b></th>
		<td>#qdb.total_state#</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Total No State:</b></th>
		<td>#qdb.total_nostate#</td>
	</tr>
	<tr>
		<th><b>Total Zip Codes:</b></th>
		<td>#qdb.total_zip#</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Total No Zip Codes:</b></th>
		<td>#qdb.total_nozip#</td>
	</tr>
	<tr>
		<th><b>Total ME Number:</b></th>
		<td>#qdb.total_menum#</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Total No ME Number:</b></th>
		<td>#qdb.total_nomenum#</td>
	</tr>
	<tr>
		<th><b>Total Decile:</b></th>
		<td>#qdb.total_decile#</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Total No Decile:</b></th>
		<td>#qdb.total_nodecile#</td>
	</tr>
	<tr>
		<th><b>Total Specialty:</b></th>
		<td>#qdb.total_specialty#</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Total No Specialty:</b></th>
		<td>#qdb.total_nospecialty#</td>
	</tr>
	<tr>
		<th><b>Total Sent:</b></th>
		<td>#qdb.total_sent#</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Send Date:</b></th>
		<td>#dateFormat(qdb.sent_date, "mm/dd/yy")#</td>
	</tr>
	<tr>
		<th><b>Send By:</b></th>
		<td>#trim(qdb.sent_by)#</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Send To:</b></th>
		<td>#trim(qdb.sent_to)#</td>
	</tr>
	<tr>
		<th><b>File Name Sent:</b></th>
		<td>#trim(qdb.sent_filename)#</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Notes:</b></th>
		<td>#trim(qdb.db_notes)#</td>
	</tr>
	<!--- end database info section --->
	
	<!--- creative services section --->
	<tr BGCOLOR="##99CCFF">
		<td colspan="2"><font size="2"><b><font color="Navy">Creative Services Information</font></b></font></td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Initial Submission Date to<br>Creative Services Dept for the Following:</b></th>
		<td><cfif moderator_guide_date NEQ "">*Moderator Discussion Guide&nbsp;#DateFormat(moderator_guide_date, "mm/dd/yyyy")#<br></cfif><cfif admin_materials_date NEQ "">*Admin Materials&nbsp;#DateFormat(admin_materials_date, "mm/dd/yyyy")#<br></cfif><cfif guidebook_date NEQ "">*Participant Guidebook&nbsp;#DateFormat(guidebook_date, "mm/dd/yyyy")#<br></cfif>
			<cfif components_date NEQ "">*Components&nbsp;#DateFormat(components_date, "mm/dd/yyyy")#</cfif>
		</td>
	</tr>
	<tr>
		<th><b>Guidebook Instructions:</b></th>
		<td><cfif guidebook_new EQ 1>new</cfif>
			<cfif guidebook_revised EQ 1>
				<cfif guidebook_new EQ 1>,&nbsp;</cfif>revised</cfif>
			<cfif guidebook_charts EQ 1>
			<cfif guidebook_revised EQ 1 or guidebook_new EQ 1>,&nbsp;</cfif>charts from client
			</cfif>
		</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Revisions on Guidebook:</b></th><td><cfif revise_wording EQ 1>update wording</cfif><cfif revise_charts EQ 1><cfif revise_wording EQ 1>,&nbsp;</cfif>revisions on charts</cfif><cfif new_charts EQ 1><cfif revise_wording EQ 1 or revise_charts EQ 1>,&nbsp;</cfif>creation of new charts</cfif></td>
	</tr>
	<tr>
		<th><b>Special Instructions for Creative Services:</b></th>
		<td>#special_instructions#</td>
	</tr>
	<tr BGCOLOR="##99CCFF">
		<td colspan="2"><b><font size="2"><font color="Navy">Recruiting Information</font></font></b></td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Allowed to participate in meetings:</b></th>
		<td><cfif rep_nom EQ 1>Physicians who call in from Rep Nominations<br></cfif>
			<cfif pa_ok EQ 1>Physician Assistants<br></cfif><cfif np_ok EQ 1>Nurse Pryesitioners<br></cfif>
			<cfif other_ok EQ 1>Other&nbsp;*#other_description#<br></cfif>
		</td>
	</tr>
	<tr>
		<th><b>What are guidelines for physicians who are generated from direct mailers?:</b></th>
		<td>#direct_mailers_info#</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>Will there be an initial recruitment mailing? Any subsequent mailings?:</b></th>
		<td>#recruit_mailings_info#</td>
	</tr>
	<tr>
		<th><b>General Market/Drug Info for Recruiter:</b></th>
		<td>#market_drug_info#</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th><b>General Market/Drug Info for <u>SCRIPT</u> for Recruiter:</b></th>
		<td>#market_drug_script#</td>
	</tr>
	<tr>
		<th><b>Additional Info for Recruiting:</b></th>
		<td>#additional_info#</td>
	</tr>
	<tr BGCOLOR="##99CCFF">
		<td colspan="2"><font size="2"><font color="Navy"><b>Additional Notes</b></font></font></td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<td colspan="2">#market_drug_info#</td>
	</tr>
	<!--- <tr BGCOLOR="##99CCFF">
	<td colspan="2"><font size="2"><font color="Navy"><b>Roster Special Notes</b></font></font></td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
	<td colspan="2">#roster_notes#</td>
	</tr> --->
	</cfoutput>
	<tr BGCOLOR="#99CCFF">
		<td colspan="2"><font size="2"><font color="Navy"><b>Project Moderators/Speakers</b></font></font></td>
	</tr>
	<tr BGCOLOR="#e5f6ff">
		<th><b>Assigned Moderators:</b></th>
		<td>
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="get_mod_id">
			SELECT speakerid FROM piw_moderators	WHERE project_code = '#session.project_code#';
		</CFQUERY>				
		<CFOUTPUT>
		<CFLOOP QUERY="get_mod_id">
			<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="get_name">
				SELECT firstname, lastname FROM Speaker WHERE speakerid = #get_mod_id.speakerid#
			</CFQUERY>
			<CFLOOP QUERY="get_name">
			
			#get_name.firstname# #get_name.lastname#<br>
			</CFLOOP>
		</CFLOOP>	
		</CFOUTPUT>
		</td>
	</tr>
	<tr>
		<th><b>Assigned Speakers:</b></th>
		<td>
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="get_spkr_id">
			SELECT speakerid FROM piw_speakers WHERE project_code = '#session.project_code#';
		</CFQUERY>		
		<CFOUTPUT>
		<CFLOOP QUERY="get_spkr_id">
			<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="get_name">
				SELECT firstname, lastname FROM Speaker WHERE speakerid = #get_spkr_id.speakerid#
			</CFQUERY>
			<CFLOOP QUERY="get_name">
				#get_name.firstname# #get_name.lastname#<br>
			</CFLOOP>
		</CFLOOP>	
		</CFOUTPUT>
		</td>
	</tr>
	
	<cfoutput query="qgetnotes">
	<!--- Pull user name --->
	<CFQUERY DATASOURCE="#session.login_dbs#" NAME="quser" USERNAME="#session.login_dbu#" PASSWORD="#session.login_dbp#">
		SELECT rowid, first_name, last_name
		FROM user_id
		WHERE rowid = #qgetnotes.entry_userid#
		ORDER BY last_name, first_name
		</CFQUERY>	
	<tr BGCOLOR="##e5f6ff">
		<td colspan="2">#note_data#&nbsp;&nbsp;<cfif qgetnotes.recordcount GT 0>(by&nbsp;</cfif>#quser.first_name#&nbsp;#quser.last_name#&nbsp;#DateFormat(entry_date, "mm/dd/yyyy")#<cfif qgetnotes.recordcount GT 0>)</cfif><br></td>
	</tr>
	</cfoutput>	
<cfif IsDefined("report")>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td><b><SCRIPT LANGUAGE="JavaScript">
	 		 <!-- Begin print button
	  		if (window.print) {
			  document.write('<form>'
			  + '<input type=button  name=print value="  Print  " '
			  + 'onClick="javascript:window.print()"></form>');
			  }
		  // End print button-->
		  </script></b>
		</td>
		<form action="index.cfm">
		<td>
			<INPUT  TYPE="submit" NAME="list" VALUE="Back to Project List"></form>
	  	</td>
	  	<form action="report_piw_search.cfm">
	  <td><INPUT  TYPE="submit" NAME="submit" VALUE="  Back  "></form>
	  </td>
  </tr>
<cfelse>
  <tr><td>&nbsp;</td></tr>
	<tr>
		<td><b><SCRIPT LANGUAGE="JavaScript">
		  <!-- Begin print button
		  if (window.print) {
		  document.write('<form>'
		  + '<input type=button  name=print value="  Print  " '
		  + 'onClick="javascript:window.print()"></form>');
		  }
		  // End print button-->
		  </script></b>
  		</td>
		<form action="index.cfm">
		<td>
			<INPUT  TYPE="submit" NAME="list" VALUE="Back to Project List"></form>
	  	</td>
			<form action="piw1.cfm">
	  	<td><INPUT  TYPE="submit" NAME="edit" VALUE="Edit This PIW"></form></td>
  </tr>
</cfif>
</table>		
</td></tr>
</table>
</BODY>
</HTML>
