<!---
*********************************************************************************
	PIWprojectsdetail.cfm
		Validates the project code selections made by the user.	
history:
	lb11/06/2001 - initial code.
	bj12/14/2001 - revised overall logic
	
*********************************************************************************
--->	
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Project Initiation Form - Project Code Details" showCalendar="0">

<script LANGUAGE=JAVASCRIPT>
function checkOut() 
//shows a confirm dialog box when the "submit" button is hit
{
	a = (confirm("By hitting Submit, you will create a new client code and project code(s). Do you wish to continue?"));
   	if (a == true)
		return true;
	else
		return false;
	}

</script>

<cfif isdefined("form.caller")>
	<cfset caller = #form.caller#>
	<cfset action = "ADD">
<cfelse>
	<cfset caller = "PIWprojects.cfm?corp=#form.corp#&client=#form.client#&product=#form.product#&meeting_type=#form.meeting_type#&contact_name=#form.contact_name#&contact_add=#form.contact_add#&contact_add2=#form.contact_add2#&contact_city=#form.contact_city#&contact_state=#form.contact_state#&contact_zip=#form.contact_zip#&contact_phone=#form.contact_phone#&contact_fax=#form.contact_fax#&contact_email=#form.contact_email#">
	<cfset action = "NEW">
</cfif>
<!--- <cfif IsDefined("form.meeting_type")> --->
<cfif isdefined("form.corp")>
	<!--- fetch the matching client code ifo if it exists --->
	<cfset cc = "#trim(form.corp)##trim(form.client)##trim(form.product)#">
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="qcc_one">
		EXEC GET_ONE_CLIENT_CODE '#cc#'
	</CFQUERY>
	
	<!--- if this is a new client code or if the user wants to add a new project code to this client code --->
	<CFIF qcc_one.recordcount EQ 0 OR action EQ "ADD">
		<!--- Pull name for created_by --->
		<CFQUERY DATASOURCE="#session.login_dbs#" NAME="qcreated_by" USERNAME="#session.login_dbu#" PASSWORD="#session.login_dbp#">
			SELECT first_name, last_name FROM user_id WHERE rowid = #session.userinfo.rowid#
		</CFQUERY>	
	
		<!--- Pull selling company names for select box --->
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="qcorp">
			SELECT corp_id, corp_value, corp_description, corp_abbrev
			FROM corp WHERE corp_abbrev = '#form.corp#' 
		</CFQUERY>	
		
		<!--- Pull client names for select box --->
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="qclient">
			SELECT id, client_abbrev, client_name
			FROM clients WHERE client_abbrev = '#form.client#' 
		</CFQUERY>	
		
		<!--- Pull product types for select boxes --->
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="qproducts">
			SELECT product_id, product_description, product_code
			FROM products WHERE product_code = '#form.product#' and client_abbrev = '#form.client#' 
		</CFQUERY>		
		<cfoutput>
			<TABLE ALIGN="center" BORDER="0" CELLPADDING="0" CELLSPACING="5" WIDTH="500">
			<tr><td colspan="2" align="center">Below are the details of your program. If correct, hit the <b><i>Continue</i></b> button.<br>If changes need to be made, hit the <b><i>Edit</i></b> button.</td></tr>
			<tr><td></td></tr>
			<tr><td align="right"><b>Client Code:</b></td><td>#cc#</td></tr>
			<tr><td align="right"><b>Selling Company:</b></td><td>#qcorp.corp_value#</td></tr>
			<tr><td align="right"><b>Client:</b></td><td>#qclient.client_name#</td></tr>
			<tr><td align="right"><b>Product:</b></td><td>#qproducts.product_description#</td></tr>
			<tr><td align="right"><b>Contact:</b></td><td>#form.contact_name#</td></tr>
			<tr><td align="right"><b>Address:</b></td><td>#form.contact_add#</td></tr>
			<cfif form.contact_add2 NEQ "">
				<tr><td align="right"></b></td><td>#form.contact_add2#</td></tr>
			</cfif>
			<tr><td align="right"><b></b></td><td>#form.contact_city#, #form.contact_state# #form.contact_zip#</td></tr>
			<tr><td align="right"><b>Contact Phone:</b></td><td>#form.contact_phone#</td></tr>
			<tr><td align="right"><b>Fax:</b></td><td>#form.contact_fax#</td></tr>
			<tr><td align="right"><b>Email:</b></td><td>#form.contact_email#</td></tr>
			<tr><td colspan=2 bgcolor="##eeeeee">The following meeting types will be added...</font></td></tr>
			
				<cfloop from="1" to="#ListLen(form.meeting_type)#" index="i">
					<cfset project_code = #cc#&#ListGetAt(form.meeting_type, i)#>
					<tr>
						<td align=right><font color=blue><b>#ListGetAt(form.meeting_type, i)#</b></font></td>
						<!--- Pull meeting types for check boxes --->
						<CFQUERY DATASOURCE="#application.projdsn#" NAME="qmeeting_types">
							SELECT meeting_type_description	FROM meeting_type WHERE meeting_type_value = '#ListGetAt(form.meeting_type, i)#'
						</CFQUERY>	
						<cfif qmeeting_types.recordcount GT 0>
							<td><font color=blue>#qmeeting_types.meeting_type_description#</font></td>
						<cfelse>
							<td>&nbsp;&nbsp;</td>
						</cfif>
					</tr>
				</cfloop>
			<tr><td>&nbsp;</td></tr>
			<form action="piwprojectsaction.cfm?corp=#form.corp#&client=#form.client#&product=#form.product#&meeting_type=#form.meeting_type#&contact_name=#form.contact_name#&contact_add=#form.contact_add#&contact_add2=#form.contact_add2#&contact_city=#form.contact_city#&contact_state=#form.contact_state#&contact_zip=#form.contact_zip#&contact_phone=#form.contact_phone#&contact_fax=#form.contact_fax#&contact_email=#form.contact_email#&clientcode=#cc#&project_code=#project_code#" method="post">
			<TR>
				<td align="right">
					<INPUT TYPE="submit" NAME="submit" VALUE="Continue" onClick="return checkOut();">&nbsp;&nbsp;
				</td>
				</form>
				
				<td align="left">
					&nbsp;&nbsp;<INPUT TYPE="button" NAME="edit" value=" Edit " onclick="javascript:history.back(-1);">
				</td>
			</TR>
			</table>
		</cfoutput>
	<cfelse>
		<cfoutput>
		&nbsp;&nbsp;&nbsp;<b><font color="Red">This client <i>#cc#</i> already exists. Please select another client and product.</font></b><br>
		<INPUT TYPE="button" NAME="edit" value="   Back   " onclick="javascript:history.back(-1);"></cfoutput>
	</cfif>
<cfelse>
	<TABLE ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="90%">
	<tr><td>An error occured while attempting to process your request.  Please click the CONTINUE button to try again.</td></tr>	
	<tr>
		<cfoutput>
		<td>
		<form action="dsp_addProject.cfm" method="post">
		<INPUT TYPE="submit" NAME="continue" value="  Continue  ">
		</form>
		</td>
		</cfoutput>
	</tr>
	</table>
</cfif>	
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
