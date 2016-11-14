<cfsilent>
<cfif Url.Action EQ "ADD">
   <cfset E = 0> 
	<!--- Error Check Form --->
	<cfif Len(Trim(form.firstname)) EQ 0>
	  <cfset e = 1>
	</cfif>
	
	<cfif Len(Trim(form.lastname)) EQ 0>
	  <cfset e = 2>
	</cfif>
	
	<cfif Len(Trim(form.phone)) EQ 0>
	  <cfset e = 3>
	</cfif>
	
	<cfif Len(Trim(form.email)) EQ 0>
	  <cfset e = 4>
	</cfif>
	
	<!--- Insert Contact --->
	  <cfinvoke component="pms.com.projectUpdate" method="AddSecondContact" returnvariable="AddContact">
		    <cfinvokeargument name="ClientCode" value="#Form.ClientCode#">
			<cfinvokeargument name="firstname" value="#Form.firstname#">
		   <cfinvokeargument name="lastname" value="#Form.lastname#">
		   <cfinvokeargument name="title" value="#Form.title#">
		   <cfinvokeargument name="phone" value="#Form.phone#">
		   <cfinvokeargument name="fax" value="#Form.fax#">
		   <cfinvokeargument name="email" value="#Form.email#">
		   <cfinvokeargument name="mobile" value="#Form.mobile#">
		   <cfinvokeargument name="Addr1" value="#Form.addr1#">
		   <cfinvokeargument name="addr2" value="#Form.addr2#">
		   <cfinvokeargument name="city" value="#Form.city#">
		   <cfinvokeargument name="state" value="#Form.state#">
		   <cfinvokeargument name="zipcode" value="#Form.zipcode#">
	  </cfinvoke>
	  
	<!--- Send Back to dsp_ClientView.cfm --->
	<cfif addcontact>
	  <cflocation url="dsp_ClientView.cfm?cc=#form.clientCode#" addtoken="No">
	<cfelse>
	  <cfset e = 5>
	</cfif>

<cfelseif url.Action EQ "Edit">
    <cfset E = 0> 
	<!--- Error Check Form --->
	<cfif Len(Trim(form.firstname)) EQ 0>
	  <cfset e = 1>
	</cfif>
	
	<cfif Len(Trim(form.lastname)) EQ 0>
	  <cfset e = 2>
	</cfif>
	
	<cfif Len(Trim(form.phone)) EQ 0>
	  <cfset e = 3>
	</cfif>
	
	<cfif Len(Trim(form.email)) EQ 0>
	  <cfset e = 4>
	</cfif>
	
	<!--- Insert Contact --->
	  <cfinvoke component="pms.com.projectUpdate" method="UpdateSecondContact" returnvariable="UpdateContact">
		    <cfinvokeargument name="ContactID" value="#Form.contactID#">
			<cfinvokeargument name="firstname" value="#Form.firstname#">
		   <cfinvokeargument name="lastname" value="#Form.lastname#">
		   <cfinvokeargument name="title" value="#Form.title#">
		   <cfinvokeargument name="phone" value="#Form.phone#">
		   <cfinvokeargument name="fax" value="#Form.fax#">
		   <cfinvokeargument name="email" value="#Form.email#">
		   <cfinvokeargument name="mobile" value="#Form.mobile#">
		   <cfinvokeargument name="Addr1" value="#Form.addr1#">
		   <cfinvokeargument name="addr2" value="#Form.addr2#">
		   <cfinvokeargument name="city" value="#Form.city#">
		   <cfinvokeargument name="state" value="#Form.state#">
		   <cfinvokeargument name="zipcode" value="#Form.zipcode#">
	  </cfinvoke>
	  
	<!--- Send Back to dsp_ClientView.cfm --->
	<cfif UpdateContact>
	  <cflocation url="dsp_ClientView.cfm?cc=#form.clientCode#" addtoken="No">
	<cfelse>
	  <cfset e = 5>
	</cfif>
	
<cfelseif url.Action EQ "DELETE">
  <cfif Not IsDefined("url.ContactID")>
    <cfset e = 6>
  </cfif>
  <cfif url.ContactID EQ "">
    <cfset e = 6>
  </cfif> 

	<!--- initialize the project --->
	<CFOBJECT COMPONENT="pms.com.projectUpdate"
	          NAME="projectUpdate">
   
   <cfset DeleteContact = ProjectUpdate.DeleteContact(url.ContactID)>
  
  <cflocation url="dsp_ClientView.cfm" addtoken="No">
</cfif>
</cfsilent>
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Add New Secondary Client Contact">
<br>
<cfif E EQ 1>
  <p><strong style="color:##cc0000;">Error! You must enter a Firstname for this contact</strong></p>
<cfelseif E EQ 2>
  <p><strong style="color:##cc0000;">Error! You must enter a Lastname for this contact</strong></p>
<cfelseif E EQ 3>
  <p><strong style="color:##cc0000;">Error! You must enter a Phonenumber for this contact</strong></p>
<cfelseif E EQ 4>
  <p><strong style="color:##cc0000;">Error! You must enter a Email Address for this contact</strong></p> 
<cfelseif E EQ 5>
  <p><strong style="color:##cc0000;">Error! There was an Error While Inserting this Contact. Please Contact IT.</strong></p>  
<cfelseif E EQ 6>
  <p><strong style="color:##cc0000;">Error! There was no Contact ID for this Contact. Please Contact IT.</strong></p>  
</cfif> 
<br>
<a href="javascript:history.go(-1);">Click Here</a> to go back and correct this problem.
<br><br>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">	