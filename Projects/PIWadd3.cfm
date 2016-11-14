<!---
*********************************************************************************
	PIWadd3.cfm
		Validates the project code selections made by the user.	
history:
	lb110601 - initial code.
	bj121401 - revised overall logic
	bj040302 - added client abbreviation to product name search query.
*********************************************************************************
--->	
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Add New Project Code - Project Code Details" showCalendar="0">

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
	<cfset caller = "PIWadd2.cfm?corp=#form.corp#&client=#form.client#&product=#form.product#&meeting_type=#form.meeting_type#&contact_name=#form.contact_name#&contact_add=#form.contact_add#&contact_add2=#form.contact_add2#&contact_city=#form.contact_city#&contact_state=#form.contact_state#&contact_zip=#form.contact_zip#&contact_phone=#form.contact_phone#&contact_fax=#form.contact_fax#&contact_email=#form.contact_email#">
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
		<TABLE ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="100%">
			<tr>
			<td>	
				<TABLE ALIGN="center" BORDER="0" CELLPADDING="4" CELLSPACING="5" WIDTH="500">
				<tr>
				  <td colspan="2" align="center">Below are the details of your program. If correct, hit the <b><i>Continue</i></b> button.<br>If changes need to be made, hit the <b><i>Edit</i></b> button.</td></tr>
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
				<tr><td align="right"><b>Contact Phone:</b></td>
				<td>
				
				<cfif  Len(Trim(form.contact_phone)) EQ 10>
								(#Left(form.contact_phone, 3)#) #Mid(form.contact_phone, 4, 3)# - #Mid(form.contact_phone, 6,4)# 
								<CFELSE>
								#trim(form.contact_phone)#
								</cfif>
				</td></tr>
				<tr><td align="right"><b>Fax:</b></td>
				<td>
				<cfif  Len(Trim(form.contact_fax)) EQ 10>
								(#Left(form.contact_fax, 3)#) #Mid(form.contact_fax, 4, 3)# - #Mid(form.contact_fax, 6,4)# 
								<CFELSE>
								#trim(form.contact_fax)#
								</cfif>
				</td></tr>
				<tr><td align="right"><b>Email:</b></td><td>#form.contact_email#</td></tr>
				<tr><td colspan=2 class=highlight><strong>The following meeting types will be added...</strong></td></tr>
				   <tr>
				     <td colspan="2">
					   <table border="0" cellpadding="3" cellspacing="0">

					<cfloop from="1" to="#ListLen(form.meeting_type)#" index="i">
						<cfset project_code = #cc#&#ListGetAt(form.meeting_type, i)#>
						<tr <cfif i MOD(2) EQ 0>bgcolor="##eeeeee"</cfif>>
							<td valign="top"><font color="<cfif isdefined("form.CloneProject")>##993300<cfelse>blue</cfif>"><b>#ListGetAt(form.meeting_type, i)#</b></font></td>
							<!--- Pull meeting types for check boxes --->
							<CFQUERY DATASOURCE="#application.projdsn#" NAME="qmeeting_types">
								SELECT meeting_type_description	FROM meeting_type WHERE meeting_type_value = '#ListGetAt(form.meeting_type, i)#'
							</CFQUERY>	
							<cfif qmeeting_types.recordcount GT 0>
							  <cfif isdefined("form.CloneProject")>
							  	<CFQUERY DATASOURCE="#application.projdsn#" NAME="getClone">
									SELECT cp.client_proj, cp.description, cp.client_code, cp.rowid
                                    FROM client_proj cp
									Where rowID = #form.CloneProject#
									</CFQUERY>	
							  </cfif>		
								<td valign="top"><font color="<cfif isdefined("form.CloneProject")>##993300<cfelse>blue</cfif>">#qmeeting_types.meeting_type_description#</font> <cfif isdefined("form.CloneProject")></td><td>(Clone content from #getClone.client_proj#-#getClone.description#)</cfif></td>
							<cfelse>
								<td>&nbsp;&nbsp;</td>
							</cfif>
						</tr>
					</cfloop>
					   </table>           
					 </td>
				   </tr>
				<tr><td colspan="2">&nbsp;</td></tr>
				<cfif isdefined("form.CloneProject")>
				  <cfset CloneFrom = getClone.client_proj>
				<cfelse>
				  <cfset CloneFrom = 0>
				</cfif>
				<form action="PIWadd4.cfm?corp=#form.corp#&client=#form.client#&product=#form.product#&meeting_type=#form.meeting_type#&contact_name=#form.contact_name#&contact_add=#form.contact_add#&contact_add2=#form.contact_add2#&contact_city=#form.contact_city#&contact_state=#form.contact_state#&contact_zip=#form.contact_zip#&contact_phone=#form.contact_phone#&contact_fax=#form.contact_fax#&contact_email=#form.contact_email#&clientcode=#cc#&CloneFrom=#trim(CloneFrom)#&Series=#Form.Series#&project_code=project_code" method="post">
				<TR>
					<td align="right">
						<INPUT TYPE="submit" NAME="submit" VALUE="Continue" onClick="return checkOut();">&nbsp;&nbsp;
					</td>
					</form>
					<form action="#caller#" method="post">
					<td align="left">
						&nbsp;&nbsp;<INPUT TYPE="submit" NAME="edit" value=" Edit ">
					</td>
				</TR>
				</FORM>
				</table>
			</td></tr>
		</table>
		</cfoutput>
	<cfelse>
		<cfoutput>
		&nbsp;&nbsp;&nbsp;<b><font color="Red">This client <i>#cc#</i> already exists. Please select another client and product.</font></b><br>
		<form action="PIWprojects.cfm?corp=#form.corp#&client=#form.client#&product=#form.product#&contact_name=#form.contact_name#&contact_add=#form.contact_add#&contact_add2=#form.contact_add2#&contact_city=#form.contact_city#&contact_state=#form.contact_state#&contact_zip=#form.contact_zip#&contact_phone=#form.contact_phone#&contact_fax=#form.contact_fax#&contact_email=#form.contact_email#" method="post">&nbsp;&nbsp;&nbsp;<INPUT TYPE="submit" NAME="edit" value="   Back   ">
		</FORM></cfoutput>
	</cfif>
<cfelse>
	<TABLE BGCOLOR="##000080" ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="90%">
	<TR><TD CLASS="tdheader">Project Initiation Form - Project Code Details</TD></TR>
	<tr><td>An error occured while attempting to process your request.  Please click the CONTINUE button to try again.</td></tr>	
	<tr>
		<cfoutput>
		<td>
		<form action="PIWadd.cfm?#Rand()#" method="post">
		<INPUT TYPE="submit" NAME="continue" value="  Continue  ">
		</form>
		</td>
		</cfoutput>
	</tr>
	</table>
</cfif>	
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
