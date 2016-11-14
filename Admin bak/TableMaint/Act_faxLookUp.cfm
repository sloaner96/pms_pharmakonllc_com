<cfset Error = ArrayNew(1)>

<!--- Error Check the Forms --->
 <cfif Len(Trim(form.faxno)) EQ 0>
   <cfset X = ArrayAppend(Error, "You must enter the fax number in the form.")>
 </cfif>

 <cfif Not ISDefined("form.FaxAuthorized")>
   <cfset X = ArrayAppend(Error, "you must select a status")>
 </cfif>

<cfif ArrayLen(Error) EQ 0>
<!--- Invoke Shipto Address --->

	<cfinvoke component="addressCleanUp" method="updatePhysicianFaxEmail">
	   <cfinvokeargument name="Phid"    value="#trim(form.PHID)#">
	   <cfinvokeargument name="faxNo"    value="#Replacelist(trim(form.faxno), '/,\,(,),-,., ,~,+', '')#">
	   <cfinvokeargument name="FaxStatus"    value="#trim(form.faxAuthorized)#">
	</cfinvoke>
	
	<cfif Form.FaxAuthorized EQ 1>
	  <cfset FaxStatus = "Authorized to Send Faxes">
	<cfelseif Form.FaxAuthorized EQ 0>
	  <cfset FaxStatus = "NOT Authorized to Send Faxes">
	</cfif>
	
	<cfset Msg = "#Trim(Session.first_Name)# #Trim(Session.last_Name)# Updated the Fax Information of Phid (#Form.Phid#) to #form.faxno# with a status of #FaxStatus#">
	<cf_AuditLog action="FAX LKUP" message="#Msg#" Status="OK" User="#Session.UserID#">

<cflocation url="Dsp_FaxLookup.cfm" addtoken="no">
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
