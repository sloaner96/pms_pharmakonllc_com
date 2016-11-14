<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="View Client Information">
<br>
<cfinclude template="/PMS/includes/libraries/FormatPhone.cfm">
<cflock scope="session" timeout="10" throwontimeout="NO">	  
	
	<cfif ISDefined("url.cc")>
	      <cfset Session.clientCode = url.cc>
	<cfelseif IsDefined("form.clientcode")>
		  <cfif form.clientCode NEQ "">
		       <cfset Session.clientCode = form.clientcode>
		  <cfelse>
		        <cfset session.clientCode = ""> 
		  </cfif>
	<cfelseif Not IsDefined("url.cc") and Not IsDefined("form.clientcode") and ISDefined("session.ClientCode")>
	      <cfset session.clientCode = session.ClientCode>  
	<cfelse>
	      <cfset session.clientCode = "">     
	</cfif>		
</cflock>
 
<cfoutput> 
			   <cfif session.ClientCode NEQ "">
			      <cfset getClient = request.Project.getClientCode(session.clientCode)>
					<table border="0" cellpadding="4" cellspacing="0" width="100%" bgcolor="##ffffff">						
	                   <tr bgcolor="##444444">
					     <td colspan="2"><strong style="color:##ffffff;">Primary Contact Information:</strong></td>
					   </tr>
					   <tr>
					      <td valign="top" width="10%"><strong>Client&nbsp;Info:</strong></td>
						  <td width="90%">#getClient.client_code#-#getClient.client_code_description#&nbsp;&nbsp;<a href="DSP_ClientEdit.cfm?ClientCode=#trim(GetClient.Client_Code)#">[EDIT]</a><br><br>
						      <cfif getClient.product_manager NEQ ""><em>Product Manager:</em> #getClient.product_manager#<br></cfif>
							  #getClient.address1#<br>
							  <cfif getClient.Address2 NEQ "">#getClient.address2#<br></cfif>
							  <cfif getClient.City NEQ "">#getClient.city#, #getClient.state# #getClient.zipcode#<br></cfif>
							  <cfif len(trim(getClient.phone)) GT 0>Phone: #FormatPhone(trim(getClient.phone))#<br></cfif>
							  <cfif len(trim(getClient.fax)) GT 0>Fax: #FormatPhone(trim(getClient.fax))#<br></cfif>
							  <cfif len(trim(getClient.email)) GT 0>Email: <a href="mailto:#getClient.email#">#getClient.email#</a><br></cfif>
						  </td>
					   </tr>
					   <tr>
					     <td colspan=2>&nbsp;</td>
					   </tr>
					   <cfset AdditionalContacts = request.Project.getClientContacts(session.clientCode)>
                       <tr bgcolor="##444444">
					     <td colspan="2"><strong style="color:##ffffff;">Additional Contacts:</strong></td>
					   </tr>
					   <cfif AdditionalContacts.recordcount GT 0>
						    <tr>
							   <td colspan="2">
							     <table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="##eeeeee">
                                   <tr bgcolor="##eeeee">
								      <td></td>
                                      <td><strong>Name</strong></td>
									  <td><strong>Title</strong></td>
									  <td><strong>Address</strong></td>
									  <td><strong>Contact Numbers</strong></td>
									  <td><strong>Email</strong></td>
                                   </tr>
								   <cfloop query="AdditionalContacts">
									   <tr bgcolor="##ffffff">
									      <td valign="top"><a href="Act_MaintainContact.cfm?action=Delete&ContactID=#AdditionalContacts.ContactID#" style="color:##ff0000;">[DELETE]</a></td>
	                                      <td valign="top"><a href="Dsp_EditClientContact.cfm?ContactID=#AdditionalContacts.ContactID#" title="Click to Edit">#AdditionalContacts.lastname#, #AdditionalContacts.Firstname#</a></td>
										  <td valign="top">#AdditionalContacts.Title#</td>
										  <td valign="top"><cfif AdditionalContacts.Addr1 NEQ "">#AdditionalContacts.Addr1#<br>
										      <cfif AdditionalContacts.addr2 NEQ "">#AdditionalContacts.Addr2#<br></cfif>
											  #AdditionalContacts.City#, #AdditionalContacts.State# #AdditionalContacts.ZipCode#</cfif>
										  </td>
										  <td valign="top">
										    <table border="0" cellpadding="0" cellspacing="0" width="100%">
										     <cfif AdditionalContacts.Phone NEQ "">
											  <tr>
										        <td valign="top">(P)</td>
												<td valign="top">#AdditionalContacts.Phone#</td>
										      </tr>
											 </cfif> 
											 <cfif AdditionalContacts.Fax NEQ "">
											   <tr>
											     <td valign="top">(F)</td>
												 <td valign="top">#AdditionalContacts.Fax#</td>
											   </tr>
											  </cfif> 
											  <cfif AdditionalContacts.mobile NEQ ""> 
											   <tr>
											     <td valign="top">(M)</td>
												 <td valign="top">#AdditionalContacts.Mobile#</td>
											   </tr>
											  </cfif> 
										   </table>           
										  </td>
										  <td valign="top"><cfif AdditionalContacts.Email NEQ ""><a href="mailto:#AdditionalContacts.Email#">#AdditionalContacts.Email#</a></cfif></td>
	                                   </tr>
								   </cfloop>
								   
                                 </table>           
							   </td>
							</tr>
							<tr align="center">
						      <td colspan="2"><a href="dsp_AddClientContact.cfm?cc=#Session.ClientCode#">Click to add another contact</a></td>
						    </tr>
					   <cfelse>
					     <tr align="center">
						   <td colspan="2">There are currently no additional contacts for this Client, <a href="dsp_AddClientContact.cfm?cc=#Session.ClientCode#">Click here to add one</a></td>
						 </tr>		
					   </cfif>
					</table>
				<cfelse>
				  <cfset getAllClients = request.Project.getClients()>
				   <form name="getClient" action="dsp_ClientView.cfm" method="POST">
					  	<table align="center" border="0" cellpadding="0" cellspacing="5">						
		                  <cfif Not IsDefined("form.Client")>
							   <tr>
							      <td><strong>Please Select a Client to View:</strong></td>
							   </tr>
							   <tr>
							     <td><select name="Client" onchange="javascript:form.submit();">
								       <option value=""></option>
									   <cfloop query="getAllClients">
									    <option value="#getAllClients.client_abbrev#">#getAllClients.client_name#</option>
									   </cfloop>
								     </select>
								 </td>
							   </tr>
						   <cfelse>
						      <cfset getClientsPrograms = request.Project.getClientPrograms(form.client)>
							  
							   <cfif getClientsPrograms.recordcount GT 0>
								   <tr>
								      <td><strong>Please Select a Program to View for #form.client#:</strong></td>
								   </tr>
								   <tr>
								     <td><select name="ClientCode" onchange="javascript:form.submit();">
										    <option value="">-- Select One --</option>
										   <cfloop query="getClientsPrograms">
										    <option value="#getClientsPrograms.client_code#">#getClientsPrograms.client_code_description#</option>
										   </cfloop>
									     </select>
									 </td>
								   </tr>  
							   <cfelse>
							      <tr>
								    <td>&nbsp;</td>
								  </tr>
							      <tr>
								     <td><strong style="color:##CC0000;">There are no Programs for this Client.</strong> <a href="dsp_ClientView.cfm">Click here</a> to view another client.</td>
								  </tr>	   
							   </cfif>
						   </cfif>
						</table>
				    </form>	
				</cfif>
</cfoutput>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">