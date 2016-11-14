<CFIF IsDefined("form.project_code")><cfset session.project_code = form.project_code>
<CFELSEIF IsDefined("URL.project_code")><cfset session.project_code = URL.project_code>
</CFIF>
<html>
<head>
<title>
<cfoutput>#session.project_code#</cfoutput>
</title>
</head>

<CFQUERY DATASOURCE="#application.projdsn#" NAME="qPiw">
	SELECT c.corp_value, l.client_name, p.account_exec, p.account_supr, 
			p.product, p.client_code, p.guide_writer, p.guide_topic, p.proj_program_start, 
			p.recruit_start, p.program_start, p.program_end, p.call_inbound, 
			p.call_outbound, r.recruiter_name, p.recruiting_company_phone, 
			o.conf_company_name, p.helpline, p.include_survey, p.survey_comp, 
			p.prog_participants, p.num_meetings, p.participant_target, 
			p.participant_recruit, p.attendee_comp_type, p.attendee_comp, 
			p.survey_comp_type, p.prog_length_hr, p.prog_length_min, p.special_notes, 
			p.target_audience, p.cme_accredited, p.cme_org, p.guidebook_include, 
			p.letter_confirmation, p.letter_thankyou, p.letter_factsheet, 
			p.letter_faxinfosheet, p.letter_other, p.letter_other_description, 
			p.guidebook_to_recruiter, p.speaker_notes, b.cost_per_attendee, 
			b.direct_mail_costs, b.additional_costs, b.finance_notes, 
			b.client_ap_contact, b.client_ap_phone_fax, b.billing_schedule, 
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
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qgetnotes">
	select  DISTINCT n.rowid,n.project_code, n.note_type, n.note_data, n.entry_date, n.entry_time, n.entry_userid,  n.subject
		from piw_notes n
		where n.project_code = '#session.project_code#'
</cfquery>

<cfset DateNow = #DateFormat(Now(),"yyyymmdd")#> 

<CF_HTML2PDF3 
myHTMLDOC="C:\CFusionMX\ghtmldoc.exe" 
myPDFPath= "C:\Inetpub\wwwroot\pms.pharmakonllc.com\cgi-bin\pdf\piw\piwreports"
myPDF= "#session.project_code#_#DateNow#.pdf"
myOptions="--no-toc --no-title
--footer -D1 "
>



<cfoutput>
<table align="center"><tr><td><b><h3><font color="Navy">
PIW INFORMATION WORKSHEET FOR PROJECT CODE:</h3></b></font></td></tr></table>
<table align="center"><tr><td><h1>#session.project_code#</h1></td></tr></table>
<br><Br><Br>
<FONT FACE="tahoma" SIZE="-1">
<table width="700" border="1" cellspacing="0" cellpadding="5" align="center">
<tr><td colspan="2" bgcolor="##dddddd"><h2>Creative Services Information</h2></td></tr>
<tr><td width="150"><b>Initial Submission Date to Creative Services Dept for the Following:</b></td><td width="550">
<cfif qPiw.moderator_guide_date NEQ "">*Moderator Discussion Guide&nbsp;#DateFormat(qPiw.moderator_guide_date, "mm/dd/yyyy")#<br></cfif>
<cfif qPiw.admin_materials_date NEQ "">*Admin Materials&nbsp;#DateFormat(qPiw.admin_materials_date, "mm/dd/yyyy")#<br></cfif>
<cfif qPiw.guidebook_date NEQ "">*Participant Guidebook&nbsp;#DateFormat(qPiw.guidebook_date, "mm/dd/yyyy")#<br></cfif>
<cfif qPiw.components_date NEQ "">*Components&nbsp;#DateFormat(qPiw.components_date, "mm/dd/yyyy")#</cfif>&nbsp;
</tr>

<tr><td><b>Guidebook Instructions:</b></td><td>

<cfif qPiw.guidebook_new EQ 1>new</cfif>
	<cfif qPiw.guidebook_revised EQ 1>
		<cfif qPiw.guidebook_new EQ 1>,&nbsp;</cfif>revised</cfif>
	<cfif qPiw.guidebook_charts EQ 1>
	<cfif qPiw.guidebook_revised EQ 1 or qPiw.guidebook_new EQ 1>,&nbsp;</cfif>charts from client
	</cfif>&nbsp;
</td></tr>

<tr><td><b>Revisions on Guidebook:</b></td><td>
<cfif qPiw.revise_wording EQ 1>update wording</cfif>
<cfif qPiw.revise_charts EQ 1><cfif qPiw.revise_wording EQ 1>,&nbsp;</cfif>revisions on charts</cfif>
<cfif qPiw.new_charts EQ 1><cfif qPiw.revise_wording EQ 1 or qPiw.revise_charts EQ 1>,&nbsp;</cfif>creation of new charts</cfif>&nbsp;
</td></tr>
<tr><td><b>Special Instructions for Creative Services</b></td><td>#qPiw.special_instructions#<br></td></tr>
</table>
</font>
</cfoutput>
</CF_HTML2PDF3> 
<cfoutput> 
<cflocation addtoken="no" url="pdf\piw\piwreports\#session.project_code#_#DateNow#.pdf">
</cfoutput>
