<!--- 
	*****************************************************************************************
	Name:		reportbillingsheet.cfm
	
	Function:	Pulls data for billing sheet into a printable "document"
	History:	10/18/01
	
	*****************************************************************************************
--->


<HTML>
	<HEAD>
	<TITLE>Billing Sheet Report</TITLE>
		<LINK REL=stylesheet HREF="piw1style1.css" TYPE="text/css">		
		
	<CFIF IsDefined("form.project_code")><cfset session.project_code = form.project_code></CFIF>
			
	</HEAD>

	<!--- pulls info for header --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qheader">
SELECT c.corp_value, l.client_name, p.account_exec, p.account_supr, p.product, p.project_code, b.cost_per_attendee, b.additional_costs, b.finance_notes, b.client_ap_contact, b.client_ap_phone_fax, b.billing_schedule
FROM  corp c, piw p, clients l, billing_info b  
WHERE p.project_code = '#session.project_code#' AND p.corp_id *= c.corp_id AND p.client *= l.id AND b.project_code = '#session.project_code#'
</cfquery>

<!--- pulls info for program info --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qprogram_info">
SELECT pr.program_id, m.meeting_type_value, pr.honoraria_amt, pr.honoraria_type, pr.rate_amt, pr.rate_type, pr.note  
FROM  program_info pr, meeting_type m  
WHERE pr.project_code = '#session.project_code#' AND pr.program_id *= m.meeting_type
</cfquery>

<!--- pulls info for speaker honoraria --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qspeaker_honoraria">
SELECT sh.program_id, m.meeting_type_value, sh.rate_amt, sh.note  
FROM  speaker_honoraria sh, meeting_type m  
WHERE sh.project_code = '#session.project_code#' AND sh.program_id *= m.meeting_type
</cfquery>

<!--- pulls info for other --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qother">
SELECT o.charge_type, oc.type_name1, o.cost_amt, o.sell_amt, o.note, o.cost_rate, o.sell_rate  
FROM  other_charges o, other_charges_type oc
WHERE o.project_code = '#session.project_code#' AND o.charge_type *= oc.type_id1
</cfquery>


 <!--- get info from the notes table --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qgetnotes">
	select n.note_type, n.note_data, n.entry_date, n.entry_time, n.entry_userid, n.rowid, n.subject
	from piw_notes n
	where n.project_code = '#session.project_code#'
</cfquery>

			
	<BODY>
	<cfif IsDefined("report")>&nbsp;
	<cfelse>
	<p align="center"><b><font color="Navy">Below is the detail from your Billing Sheet. Please print a copy for your files.</font></b></p>
	</cfif>
	
	<table width="70%" border="0" cellspacing="0" cellpadding="5" align="center">
	<cfoutput query="qheader">
	<tr BGCOLOR="##CCCC99">
	<td colspan="4"><font size="2"><b><font color="Navy">Billing Sheet Header Information</font></b></font></td>
	</tr>
	
	<tr BGCOLOR="##fbf9eb">
		<th><b>Project Code:</b></th><td colspan="2">#session.project_code#</td>
	</tr>
	<tr>
		<th><b>Selling Corporation:</b></th><td colspan="2">#corp_value#</td>
	</tr>
	<cfif qheader.account_exec NEQ "">
	<cfset ae = qheader.account_exec>
	<cfelse>
	<cfset ae = 0></cfif>
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qAE">
		SELECT repfirstname, replastname
		FROM sales_reps
		WHERE sales_reps.ID = #ae#
</cfquery>
	<tr BGCOLOR="##fbf9eb">
		<th><b>Account Executive:</b></th><td colspan="2">#qAE.repfirstname#&nbsp;#qAE.replastname#</td>
	</tr>
	<cfif qheader.account_supr NEQ "">
	<cfset as = qheader.account_supr>
	<cfelse>
	<cfset as = 0></cfif>
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="qaccount_supr">
		SELECT repfirstname, replastname
		FROM sales_reps
		WHERE sales_reps.ID = #as#
</cfquery>
	<tr>
		<th><b>Account Supervisor:</b></th><td colspan="2">#qaccount_supr.repfirstname#&nbsp;#qaccount_supr.replastname#</td>
	</tr>
	<tr BGCOLOR="##fbf9eb">
		<th><b>Client:</b></th><td colspan="2">#client_name#</td>
	</tr>
	<tr>
		<th><b>Product:</b></th><td colspan="2">#product#</td>
	</tr>
	 <tr BGCOLOR="##fbf9eb">
		<th><b>Cost Per Attendee:</b></th><td colspan="2">#cost_per_attendee#</td>
	</tr>
	<!--- <tr>
		<th><b>Direct Mail Costs:</b></th><td>#direct_mail_costs#</td>
	</tr> --->
	<tr BGCOLOR="##fbf9eb">
		<th><b>Additional Upfront Costs:</b></th><td colspan="2">#additional_costs#</td>
	</tr>
	<tr>
		<th><b>Notes to Finance:</b></th><td colspan="2">#finance_notes#</td>
	</tr>
	<tr BGCOLOR="##fbf9eb">
		<th><b>Client AP Contact:</b></th><td colspan="2">#client_ap_contact#</td>
	</tr>
	<tr>
		<th><b>AP Phone/Fax ##:</b></th><cfif #len(trim(client_ap_phone_fax))# EQ 10><td colspan="2">(#Left(client_ap_phone_fax,3)#)#Mid(client_ap_phone_fax,4,3)#-#Mid(client_ap_phone_fax,7,11)#</td><cfelse><td colspan="2">#client_ap_phone_fax#</td></cfif>
	</tr>
	<tr BGCOLOR="##fbf9eb">
		<th><b>Schedule for Billing Client:</b></th><td colspan="2">#billing_schedule#</td>
	</tr>
	</cfoutput>	
	<tr BGCOLOR="#CCCC99">
	<td colspan="4"><font size="2"><b><font color="Navy">Program Information</font></b></font></td>
	</tr>
	 <tr BGCOLOR="#fbf9eb">
		<th>&nbsp;</th><td><b>Honoraria</b></td><td><b>Rate</b></td>
	</tr>
	 <cfoutput query="qprogram_info">
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="qhonoraria_type">
		SELECT honoraria_name
		FROM honoraria_type
		WHERE honoraria_id = #honoraria_type#
</cfquery>
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qrate_type">
		SELECT honoraria_name
		FROM honoraria_type
		WHERE honoraria_id = #rate_type#
</cfquery>
	<tr>
		<th><b>#meeting_type_value#:</b></th>
		<td>#DecimalFormat(honoraria_amt)#&nbsp;&nbsp;#qhonoraria_type.honoraria_name#</td>
		<td>#DecimalFormat(rate_amt)#&nbsp;&nbsp;#qrate_type.honoraria_name#</td>
	</tr>
	</cfoutput>
	<tr BGCOLOR="#CCCC99">
	<td colspan="4"><font size="2"><b><font color="Navy">Speaker Honoraria</font></b></font></td>
	</tr>
	<tr BGCOLOR="#fbf9eb">
		<th>&nbsp;</th><td><b>Rate/Speaker</b></td><td><b>Instructions</b></td>
	</tr>
	<cfoutput query="qspeaker_honoraria">
	<tr>
	<th><b>#meeting_type_value#:</b></th>		<td>#DecimalFormat(rate_amt)#</td><td>#note#</td>
	</tr>
	</cfoutput>
	<tr BGCOLOR="#CCCC99">
	<td colspan="4"><font size="2"><b><font color="Navy">Other Charges</font></b></font></td>
	</tr>
	 <tr BGCOLOR="#fbf9eb">
		<th>&nbsp;</th><td><b>Cost</b></td><td><b>Sell</b></td>
	</tr>
	 <cfoutput query="qother">
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="qcost_type">
		SELECT type_name
		FROM po_markup_type
		WHERE type_id = #cost_rate#
</cfquery>
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qsell_type">
		SELECT type_name
		FROM po_markup_type
		WHERE type_id = #sell_rate#
</cfquery>
	<tr>
		<th><b>#type_name1#:</b></th>
		<td>#DecimalFormat(cost_amt)#&nbsp;&nbsp;#qcost_type.type_name#</td>
		<td>#DecimalFormat(sell_amt)#&nbsp;&nbsp;#qsell_type.type_name#</td>
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
	  </script></b></td>
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
	  </script></b></td>
	  <form action="PIWEdit.cfm">
	  <td><INPUT  TYPE="submit" NAME="submit" VALUE="Back to Select"></form>
	</td>
  </tr>
  </cfif>
	
		</table>	 	
	</BODY>
	</HTML>
		

