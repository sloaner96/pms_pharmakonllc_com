<!--- 
	*****************************************************************************************
	Name:		PIWClientEdit.cfm 3/11/05
	
	Function:	Allows editing of client information

	History:	rws031105 - Removed all embedded queries and moved them to cfc's	
	
	*****************************************************************************************
--->

<cfif IsDefined("URL.ClientCode")>
	<cfset ClientCode = URL.ClientCode>
<cfelseif IsDefined("form.client_code")>
    <cfset ClientCode = form.client_code>
</cfif>		  
<!--- 	<script src="validation.js" language="JavaScript"></script> 
	<script language="JavaScript">	
	function init(){
		//example define('field_1','num','Display','min','max');
		define('contact_name','string','Contact Name');
		define('contact_add','string','Contact Address');
		define('contact_city','string','Contact City');
		define('contact_state','string','Contact State');
		define('contact_zip','string','Contact Zip Code');
		define('contact_phone','string','Contact Phone');
		//define('ae','string','Account Executive');
		//define('as','string','Account Superviser');
	}
	</script>

	<!-- Rules explained in more detail at author's site: -->
	<!-- http://www.hagedesign.dk/scripts/js/validation/  OnLoad="init()" --> --->

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Edit Client Information" bodypassthrough="onload='init()'">
			
		
<!--- Pull selling company names for select box --->
<cfset qclient_info = request.project.getClientcode(clientcode)>		  

<cfoutput query="qclient_info">
	<CFSET url.client_code="#client_code#">
	<CFSET url.client_code_description="#client_code_description#">
	<CFSET url.contact_name="#product_manager#">
	<CFSET url.contact_add="#address1#">
	<CFSET url.contact_add2="#address2#">
	<CFSET url.contact_city="#city#">
	<CFSET url.contact_state="#state#">
	<CFSET url.contact_zip="#zipcode#">
	<CFSET url.contact_phone="#phone#">
	<CFSET url.contact_fax="#fax#">
	<CFSET url.contact_email="#email#">
</cfoutput>
	
<cfset qstates = request.util.getStates()>
<br>	
	<!--- Table containing input fields --->
		<TABLE ALIGN="center" BORDER=0 CELLPADDING="4" CELLSPACING="5" width="100%">						
		  <tr bgcolor="#444444">
	          <td><strong style="color:#ffffff;">Primary Contact Information:</strong></td>
          </tr>
		   <tr>
		      <td>
				<TABLE ALIGN="center" BORDER=0 CELLPADDING="0" CELLSPACING="5">						
					
					<cfform action="act_PIWClientEdit.cfm" method="post">
					 <cfoutput>
						<input type="hidden" value="#Trim(url.client_code)#" name="client_code"> 
						<tr>
							<td width=150 align="right"><b>Client Code Description:</b></td>
							<td width=* colspan="5"><font size="2">#url.client_code_description#</font></td>
						</tr>
						<tr>
							<td width=150 align="right"><SPAN CLASS="required"><b>Contact Name:</b></SPAN></td>
							<td width=150 colspan="5"><cfinput type="Text" name="contact_name" value="#url.contact_name#" size=20  required="yes"></td>
						</tr>
						<tr>
							<td width=150 align="right"><SPAN CLASS="required"><b>Address Line 1:</b></SPAN></td>
							<td width=150 colspan="5"><cfinput type="Text" name="contact_add" value="#url.contact_add#" size=20  required="yes"></td>			
						</tr>
						<tr>
							<td width=150 align="right"><b>Address Line 2:</b></td>
							<td width=150 colspan="5"><cfinput type="Text" name="contact_add2" value="#url.contact_add2#" size=20></td>						
						</tr>
						<tr>
							<td width=150 align="right"><SPAN CLASS="required"><b>City:</b></SPAN></td>
							<td><cfinput type="Text" name="contact_city" value="#url.contact_city#" size=20  required="yes"></td>
				
							<td align=right><SPAN CLASS="required"><b>State:</b></SPAN></td>
							<td><select name="contact_state">
									<option value="">(Select)</option>
									<cfloop query="qstates">
										<option value="#qstates.StateAbbr#" <cfif trim(url.contact_state) eq trim(qstates.StateAbbr)> Selected</cfif>>#qstates.StateAbbr#</option>
									</cfloop>
								</select>
							</td>
							
							<td align="right"><SPAN CLASS="required"><b>Zip:</b></SPAN></td>
							<td><cfinput type="Text" name="contact_zip" value="#Trim(url.contact_zip)#" size=5 required="yes"></td>
						</tr>
						<tr>
							<td align="right"><SPAN CLASS="required"><b>Phone:</b></SPAN></td>
							<td colspan="5"><SPAN class=required><cfinput type="Text" name="contact_phone" value="#Trim(url.contact_phone)#" size=15 passthrough="onKeypress='if ((event.keyCode < 48 || event.keyCode > 57) && (event.keyCode!=46)) event.returnValue = false;'" required="yes"></span></td>
						</tr>
						<tr>
							<td align="right"><b>Fax:</b></td>
							<td colspan="5"><input type="Text" name="contact_fax" value="#Trim(url.contact_fax)#" size=15 onKeypress="if ((event.keyCode < 48 || event.keyCode > 57) && (event.keyCode!=46)) event.returnValue = false;"></td>
						</tr>
						<tr>	
							<td align="right"><b>E-mail:</b></td>
							<td colspan="5"><input type="Text" name="contact_email" value="#Trim(url.contact_email)#" size=20 maxlength="80"></td>
						</tr>
						<tr>	
							<td colspan="6"><br><br></td>
						</tr>
						<tr> 
						  <td colspan="6" align="center">
						    <table border="0" cellpaddding="8" cellspacing="0">
                               <tr>
                                  <td colspan="2" align="left">
								    <img src="/Images/btn_back.gif" width="91" height="23" alt="" border="0" onclick="javascript:history.back();">
								</td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td colspan="2" align="center">	
								    <input type="image" name="submit" value="submit" src="/Images/btn_save.gif" onclick="validate(); return returnVal;">  
								</td>
                               </tr>
                            </table>           
						  </td>	
						</tr>
					  </cfoutput>
					</cfform>	
				 </TABLE>
			   </TD>
			</TR>
		  </TABLE>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">