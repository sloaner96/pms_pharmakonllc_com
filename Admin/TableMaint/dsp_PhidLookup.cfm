
<cfinclude template="#Application.TagPath#/includes/libraries/PhoneFormat.cfm">

 <cfif Not IsDefined("session.AddressCleanUp")>
    <cfobject component="pms.com.AddressCleanup" name="Session.AddressCleanUp">
    <cfset Request.AddressCleanUp = Session.AddressCleanUp>
 <cfelse>
    <cfset Request.AddressCleanUp = Session.AddressCleanUp>
 </cfif> 

<cfset getStates = Request.AddressCleanUp.getStates()>

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Phid Lookup" showCalendar="0">
 

 <cfif IsDefined("form.Lookup")>
    <cfset ThisPhid = 0>
	
	<cfif Len(Trim(Form.Phid)) GT 0>
	    <cfset getPhysicianInfo = request.addressCleanUp.getPhysicianInfo(form.Phid)>
	    <cfset ThisPhid = form.Phid>
	<cfelseif Len(Trim(Form.Phid)) EQ 0>
	    <cfset getPhysicianInfo = request.addressCleanUp.getPhysicianInfoByName(form.lkupfname, form.lkuplname, form.lkupzip)>
	    <cfset ThisPhid = getPhysicianInfo.Phid>
	</cfif>   
	
	<cfif getPhysicianInfo.recordcount GT 0>
	  <cfset getPhysicianAddr = request.addressCleanUp.getPhysicianAddr(ThisPhid)>
	  <cfset getPhysicianShipTo = request.addressCleanUp.getPhysicianShipTo(ThisPhid)>
	  <cfset getPhysicianContact = request.addressCleanUp.getPhysicianPhone(ThisPhid)>
	</cfif>
	
	<cfoutput>
	     <cfif getPhysicianInfo.recordCount GT 0>
		      <cfform name="UpdateAddr" action="act_PHIDLookup.cfm" method="POST" passthrough="onload='this.focus();'">
			    <input type="hidden" name="PHID" value="#ThisPhid#">
			            <table border="0" cellpadding="5" cellspacing="0" class="PhidLookupTable" align="center">   
						   <tr class="PhidLookupTable">
						      <td bgcolor="##eeeeee">Your search returned the following information, as a resource you can <a href="http://zip4.usps.com/zip4/welcome.jsp" target="_Blank"><strong>click here</strong></a> to look up an address on the USPS website.<br>
							   <br>You Entered the following information:<br>
							     <cfif Form.Phid NEQ "">
								   PHID: <strong>#Form.Phid#</strong><br>
								 <cfelse>
								   Firstname: <strong>#form.lkupfname#</strong>
								   Lastname:  <strong>#form.lkuplname#</strong>
								   ZipCode:   <strong>#form.lkupzip#</strong>
								 </cfif>
							   </td>
						   </tr>
						   <tr>
						      <td><hr noshade size="1"></td>
						   </tr>
						   <tr class="PhidLookupTable">
					           <td><strong style="font-famly:tahoma, arial, verdana; Font-Size:14px;color:##990000;">#getPhysicianInfo.PHID#-#getPhysicianInfo.Firstname# #getPhysicianInfo.middlename# #getPhysicianInfo.lastname#</strong></td>
					       </tr>
						   <tr class="PhidLookupTable">
						      <td><strong>CET Phone Number:</strong> <cfif getPhysicianContact.cetphone NEQ "">#PhoneFormat(trim(replaceList(getPhysicianContact.cetphone, '/,|,\,-,(,.,)','')), "(xxx) xxx-xxxx")#</cfif></td>
						   </tr>
						   <tr class="PhidLookupTable">
						      <td><strong>Phone 1:</strong> <cfif getPhysicianContact.Phone1 NEQ "">#PhoneFormat(trim(replaceList(getPhysicianContact.phone1, '/,|,\,-,(,.,)','')), "(xxx) xxx-xxxx")#</cfif></td>
						   </tr>
						   <tr class="PhidLookupTable">
						      <td><strong>Phone 2:</strong> <cfif getPhysicianContact.Phone2 NEQ "">#PhoneFormat(trim(replaceList(getPhysicianContact.phone2, '/,|,\,-,(,.,)','')), "(xxx) xxx-xxxx")#</cfif></td>
						   </tr>
						   <tr class="PhidLookupTable">
						      <td><strong>Fax Number:</strong> <cfif getPhysicianContact.faxno NEQ "">#PhoneFormat(trim(replaceList(getPhysicianContact.faxno, '/,|,\,-,(,.,)','')), "(xxx) xxx-xxxx")#</cfif></td>
						   </tr>
						   <tr>
						      <td>&nbsp;</td>
						   </tr>
						   <tr>
						      <td class="PhidLookupTableShipTo"><strong style="color:##ffffff;">Ship-to Address</strong></td>
						   </tr>
						   <tr>
						      <td>
							    <table border="0" cellpadding="4" cellspacing="0" width="100%">
		                           <tr>
		                             <td width="11%"><strong>Address:</strong></td>
									 <td><input type="text" name="ShipAddr1" value="#Trim(getPhysicianShipTo.Shipaddr1)#" size="35" maxlength="255"></td>
		                           </tr>
								   <tr>
		                             <td width="11%"><strong>Address&nbsp;2:</strong></td>
									 <td><input type="text" name="ShipAddr2" value="#Trim(getPhysicianShipTo.ShipAddr2)#" size="35" maxlength="255"></td>
		                           </tr>
								   <tr>
		                              <td colspan="2">
									    <table border="0" cellpadding="1" cellspacing="0">
		                                  <tr>
		                                    <td><strong>City:</strong> <input type="text" name="ShipCity" value="#Trim(getPhysicianShipTo.ShipCity)#" size="25" maxlength="50"></td>
											<td>&nbsp;</td>
									        <td><strong>State:</strong> <select name="ShipState" style="background-color:##ffffff;">
											        <cfloop query="getStates">
													  <option value="#getStates.state#" <cfif Trim(getPhysicianShipto.ShipState) EQ Trim(getStates.state)>Selected</cfif>>#getStates.state#</option>
													</cfloop>
											      
												</select></td>
									        <td>&nbsp;</td>
											<td><strong>ZipCode:</strong> <input type="text" name="ShipZipCode" value="#Trim(getPhysicianShipTo.shipZip)#" size="10" maxlength="10"></td>
		                                  </tr> 
		                                </table>           
									  </td>
		                           </tr>
								   <tr>
		                             <td colspan="2"><strong>Status:</strong><input type="radio" name="ShipAddressStatus" value="0" <cfif getPhysicianShipTo.ShipaddrStatus EQ 0>Checked</cfif>> Bad Address&nbsp;&nbsp;&nbsp;<input type="radio" name="ShipAddressStatus" value="1"> Edit Address</td>
		                           </tr>
								   
		                        </table>           
							  </td>
						   </tr>
						   <tr>
						      <td class="PhidLookupTableOther"><strong style="color:##ffffff;">Office Address</strong></td>
						   </tr>
						   <tr>
						      <td>
							    <table border="0" cellpadding="4" cellspacing="0" width="100%">
		                           <tr>
		                             <td width="11%"><strong>Address:</strong></td>
									 <td><input type="text" name="Addr1" value="#Trim(getPhysicianAddr.Address1)#" size="35" maxlength="255"></td>
		                           </tr>
								   <tr>
		                             <td width="11%"><strong>Address&nbsp;2:</strong></td>
									 <td><input type="text" name="Addr2" value="#Trim(getPhysicianAddr.Address2)#" size="35" maxlength="255"></td>
		                           </tr>
								   <tr>
		                              <td colspan="2">
									    <table border="0" cellpadding="1" cellspacing="0">
		                                  <tr>
		                                    <td><strong>City:</strong> <input type="text" name="City" value="#Trim(getPhysicianAddr.City)#" size="25" maxlength="50"></td>
											<td>&nbsp;</td>
									        <td><strong>State:</strong> <select name="State" style="background-color:##ffffff;">
											      <cfloop query="getStates">
													  <option value="#getStates.state#" <cfif Trim(getPhysicianAddr.State) EQ Trim(getStates.state)>Selected</cfif>>#getStates.state#</option>
													</cfloop>
												</select></td>
									        <td>&nbsp;</td>
											<td><strong>ZipCode:</strong> <input type="text" name="ZipCode" value="#Trim(getPhysicianAddr.Zip)#" size="10" maxlength="10"></td>
		                                  </tr> 
		                                </table>           
									  </td>
		                           </tr>
								   <tr>
		                             <td colspan="2"><strong>Status:</strong><input type="radio" name="AddressStatus" value="0" <cfif getPhysicianAddr.addressstatus EQ 0>Checked</cfif>> Bad Address&nbsp;&nbsp;&nbsp;<input type="radio" name="AddressStatus" value="1"> Edit Address</td>
		                           </tr>
								   
		                        </table>           
							  </td>
						   </tr>
					       <tr>
						     <td><input type="Submit" name="Submit" value="Save & Continue >>"></td>
						   </tr>
						 </table>  
				   <a name="Edit" id="Edit" title="Edit"></a> 
				</cfform> 
			  <cfelse>
			     <table border="0" cellpadding="5" cellspacing="0" width="100%" class="PhidLookupTable">
				   <tr>
				      <td colspan="2" align="center"><strong style="font-size:14px; color:##cc0000;">Your search returned no matches search again.</strong></td>
				   </tr>
				   <tr>
				      <td colspan=2><cfinclude template="PhidLookupForm.cfm"> </td>
				   </tr>
				 </table>
			  </cfif>
			  
	    
	   <br><br><br><br>   
   </cfoutput>       
 <cfelse>
	  <cfinclude template="PhidLookupForm.cfm"> 
 </cfif>         
<cfmodule template="#Application.tagpath#/ctags/footer.cfm"> 