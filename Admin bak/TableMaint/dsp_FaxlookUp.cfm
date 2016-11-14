
<cfinclude template="#Application.TagPath#/includes/libraries/PhoneFormat.cfm">

<cfif Not IsDefined("session.AddressCleanUp")>
    <cfobject component="pms.com.AddressCleanup" name="Session.AddressCleanUp">
    <cfset Request.AddressCleanUp = Session.AddressCleanUp>
 <cfelse>
    <cfset Request.AddressCleanUp = Session.AddressCleanUp>
 </cfif> 

<cfset getStates = Request.AddressCleanUp.getStates()>

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Lookup Physician Fax" showCalendar="0">
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
		      <cfform name="UpdateAddr" action="act_FaxLookup.cfm" method="POST" passthrough="onload='this.focus();'">
			    <input type="hidden" name="PHID" value="#ThisPhid#">
			            <table border="0" cellpadding="5" cellspacing="0" width="100%" class="PhidLookupTable">  
	
						   <tr>
						      <td><hr noshade size="1"></td>
						   </tr>	 
						   <tr class="PhidLookupTable">
						      <td bgcolor="##eeeeee">Your search returned the following information.<br>
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
						   <tr bgcolor="##eeeeee" class="PhidLookupTable">
						     <td><strong>Shipping Information:</strong></td>
						   </tr>
						   <tr>
						     <td>#Trim(getPhysicianShipTo.Shipaddr1)#<br><cfif getPhysicianShipTo.ShipAddr2 NEQ "">#Trim(getPhysicianShipTo.ShipAddr2)#<br></cfif>#Trim(getPhysicianShipTo.ShipCity)#, #Trim(getPhysicianShipto.ShipState)# #Trim(getPhysicianShipTo.shipZip)#</td>
						   </tr>
						   <tr bgcolor="##eeeeee" class="PhidLookupTable">
						     <td><strong>Office Information:</strong></td>
						   </tr>
						   <tr>
						     <td>#Trim(getPhysicianAddr.Address1)#<br><cfif getPhysicianAddr.Address2 NEQ "">#Trim(getPhysicianAddr.Address2)#<br></cfif>#Trim(getPhysicianAddr.City)#, #Trim(getPhysicianAddr.State)# #Trim(getPhysicianAddr.Zip)#</td>
						   </tr>
						   <tr>
						      <td>&nbsp;</td>
						   </tr>
						   <tr>
						      <td class="PhidLookupTableShipTo"><strong style="color:##ffffff;">Fax Info</strong></td>
						   </tr>
						   <tr>
						     <td>
							    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                   <tr class="PhidLookupTable">
								      <td><strong>Fax Number:</strong></td>
									  <td width="80%"><input type="text" name="faxno" value="<cfif getPhysicianContact.faxno NEQ "">#PhoneFormat(trim(replaceList(getPhysicianContact.faxno, '/,|,\,-,(,.,)','')), '(xxx) xxx-xxxx')#</cfif>" size="15" maxlength="20"></td>
								   </tr>
								   <tr class="PhidLookupTable">
								     <td><strong>Status:</strong></td>
									 <td width="80%">Authorized to Fax&nbsp;<input type="radio" name="FaxAuthorized" value="1" <cfif getPhysicianContact.faxauthorized EQ 1>checked</cfif>>&nbsp;&nbsp;&nbsp;&nbsp;NOT Authorized to Fax&nbsp;<input type="radio" name="FaxAuthorized" value="0" <cfif getPhysicianContact.faxauthorized EQ 0>checked</cfif>>&nbsp;&nbsp;<cfif getPhysicianContact.authorizeddate NEQ ""><br><em>Status Set on: #DateFormat(getPhysicianContact.authorizeddate, 'MM/DD/YYYY')# at #TimeFormat(getPhysicianContact.authorizeddate, 'hh:mm tt')#</em></cfif></td>
								   </tr>
                                </table>           
							 </td>
						   </tr>
					       <tr>
						     <td align="center"><input type="Submit" name="Submit" value="Save & Continue >>"></td>
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
				      <td colspan=2><cfinclude template="PhidLookupFormFax.cfm"> </td>
				   </tr>
				 </table>
			  </cfif>
			  
	    
	   <br><br><br><br>   
   </cfoutput>       
 <cfelse>
	  <cfinclude template="PhidLookupFormFax.cfm"> 
 </cfif>         
<cfmodule template="#Application.tagpath#/ctags/footer.cfm"> 