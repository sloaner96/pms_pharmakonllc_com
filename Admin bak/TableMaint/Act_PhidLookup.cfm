<cfset Error = ArrayNew(1)>

<!--- Error Check the Forms --->
<cfif IsDefined("ShipAddressStatus")>
  <cfif form.ShipAddressStatus EQ 1>
	  <cfif Len(trim(form.ShipAddr1)) EQ 0>
	    <cfset tmp = ArrayAppend(Error, "You must include the <b>Address 1</b> in the Ship-To address")>
	  </cfif>
	  <cfif Len(trim(form.ShipCity)) EQ 0>
	    <cfset tmp = ArrayAppend(Error, "You must include the <b>City</b> in the Ship-To address")>
	  </cfif>
	  <cfif Len(trim(form.ShipState)) EQ 0>
	    <cfset tmp = ArrayAppend(Error, "You must include the <b>State</b> in the Ship-To address")>
	  </cfif>
	  <cfif Len(trim(form.ShipZipCode)) EQ 0>
	    <cfset tmp = ArrayAppend(Error, "You must include the <b>ZipCode</b> in the Ship-To address")>
	  </cfif>
  </cfif>
</cfif>

<cfif IsDefined("AddressStatus")>
  <cfif form.AddressStatus EQ 1>
	  <cfif Len(trim(form.Addr1)) EQ 0>
	    <cfset tmp = ArrayAppend(Error, "You must include the <b>Address 1</b> in the Secondary address")>
	  </cfif>
	  <cfif Len(trim(form.City)) EQ 0>
	    <cfset tmp = ArrayAppend(Error, "You must include the <b>City</b> in the Secondary address")>
	  </cfif>
	  <cfif Len(trim(form.State)) EQ 0>
	    <cfset tmp = ArrayAppend(Error, "You must include the <b>State</b> in the Secondary address")>
	  </cfif>
	  <cfif Len(trim(form.ZipCode)) EQ 0>
	    <cfset tmp = ArrayAppend(Error, "You must include the <b>ZipCode</b> in the Secondary address")>
	  </cfif>
  </cfif>
</cfif>
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Phid Lookup" showCalendar="0">
 
<cfif ArrayLen(Error) EQ 0>
<!--- Invoke Shipto Address --->
<cfif IsDefined("ShipAddressStatus")>
	<cfinvoke component="pms.com.addressCleanUp" method="updatePhysicianShipTo">
	   <cfinvokeargument name="Phid"    value="#trim(form.PHID)#">
	   <cfinvokeargument name="Addr1"   value="#trim(form.ShipAddr1)#">
	   <cfinvokeargument name="Addr2"   value="#trim(form.ShipAddr2)#">
	   <cfinvokeargument name="City"    value="#trim(form.ShipCity)#">
	   <cfinvokeargument name="State"   value="#trim(form.ShipState)#">
	   <cfinvokeargument name="ZipCode" value="#trim(form.ShipZipCode)#">
	   <cfinvokeargument name="Status"  value="#Form.ShipAddressStatus#">
	</cfinvoke>
	<cfset Msg = "#Trim(Session.userinfo.first_Name)# #Trim(Session.userinfo.last_Name)# Updated the Shipping address of Phid (#Form.Phid#) to #form.ShipAddr1# #form.ShipAddr2# #form.ShipCity# #form.ShipState# #form.ShipZipCode# and a status of #Form.ShipAddressStatus#">
	<cfmodule template="#Application.tagpath#/ctags/AuditLog.cfm" action="ADDR LKUP" message="#Msg#" Status="OK" User="#Session.userinfo.rowid#">
</cfif>


<!--- Invoke Other Address --->
<cfif IsDefined("AddressStatus")>
	<cfinvoke component="pms.com.addressCleanUp" method="updatePhysicianAddr">
	   <cfinvokeargument name="Phid"    value="#Trim(form.Phid)#">
	   <cfinvokeargument name="Addr1"   value="#Trim(form.Addr1)#">
	   <cfinvokeargument name="Addr2"   value="#Trim(form.Addr2)#">
	   <cfinvokeargument name="City"    value="#Trim(form.City)#">
	   <cfinvokeargument name="State"   value="#Trim(form.State)#">
	   <cfinvokeargument name="ZipCode" value="#Trim(form.ZipCode)#">
	   <cfinvokeargument name="Status"  value="#form.AddressStatus#">
	</cfinvoke>
	
	<cfset Msg = "#Session.userinfo.first_Name# #Session.userinfo.last_Name# Updated the Address of Phid (#Form.Phid#) to #form.Addr1# #form.Addr2# #form.City# #form.State# #form.ZipCode# and a status of #Form.AddressStatus#">
	<cfmodule template="#Application.tagpath#/ctags/AuditLog.cfm" action="ADDR LKUP" message="#Msg#" Status="OK" User="#Session.userinfo.rowid#">
</cfif>

<cflocation url="Dsp_PHIDLookup.cfm" addtoken="no">
<cfelse>
<cfoutput>
  <strong style="color:##ff0000;font-size:14px;font-family:arial;">Error! You did not fill out the form properly. Please check the error below.</strong>
  <cfloop index="X" from="1" to="#ArrayLen(Error)#">
    <li style="color:##660000;font-size:11px;font-family:arial;">#Error[X]#</li>
  </cfloop>
  </cfoutput>
  <br>
  <p><a href="javascript:history.back();">Click Here</a> to go back and correct this</p>
</cfif>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm"> 