<!---
    $Id: ,v 1.0 2000/00/00 rsloan Exp $
    Copyright (c) 2005 Pharmakon, LLC.

    Description:
        
    Parameters:
        
    Usage:
        
    Documentation:
        
    Based on:
        
--->

<!--- Check submitted data --->
  <cfset Error = ArrayNew(1)>

  <cfif Len(Trim(form.ConfirmID)) EQ 0>
      <cfset x = ArrayAppend(Error, "Error! There was no ID Passed We could not save the text. Please Contact IT.")>
  </cfif>
  
  <cfif Len(Trim(form.EmailTitle)) EQ 0>
      <cfset x = ArrayAppend(Error, "Error! There was no Title Entered! Please enter a title and resubmit your request.")>
  </cfif>
  
  <cfif Len(Trim(form.begin_date)) EQ 0>
      <cfset x = ArrayAppend(Error, "Error! There was no begin date entered! Please enter a begin date and resubmit your request.")>
  </cfif>
  
  <cfif Len(Trim(form.end_date)) EQ 0>
      <cfset x = ArrayAppend(Error, "Error! There was no end date entered! Please enter a end date and resubmit your request.")>
  </cfif>
  
  <cfif Len(Trim(form.EmailFrom)) EQ 0>
      <cfset x = ArrayAppend(Error, "Error! There was no email from address! Please enter a email from address and resubmit your request.")>
  </cfif>
  
  <cfif Len(Trim(form.EmailSubject)) EQ 0>
      <cfset x = ArrayAppend(Error, "Error! There was no email subject! Please enter a email subject and resubmit your request.")>
  </cfif>
  
  <cfif Len(Trim(form.EmailText)) EQ 0>
      <cfset x = ArrayAppend(Error, "Error! There was no email content! Please enter a email content and resubmit your request.")>
  </cfif>

<cfif ArrayLen(Error) EQ 0>
	<!--- update data --->
	<cfinvoke component="pms.com.ConfirmEmails" method="UpdateEmail">
	  <cfinvokeargument name="ConfirmID"    value="#form.ConfirmID#">
	  <cfinvokeargument name="Title"        value="#form.EmailTitle#">
	  <cfinvokeargument name="StartDate"    value="#createODBCDate(form.begin_date)#">
	  <cfinvokeargument name="EndDate"      value="#createODBCDate(end_date)#">
	  <cfinvokeargument name="FromEmail"      value="#Trim(form.EmailFrom)#">
	  
	  <cfinvokeargument name="Subject"      value="#Trim(form.EmailSubject)#">
	  <cfinvokeargument name="MsgContent"   value="#trim(form.EmailText)#">
	  <cfinvokeargument name="UpdatedBy"    value="#Session.UserInfo.rowID#">
	</cfinvoke>
	
	<cflocation url="dsp_EditEmails.cfm?CID=#form.ConfirmID#" addtoken="NO">
	<cfabort>
</cfif>
<!--- show errors --->
 
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Create a New Confirmation Emails" showCalendar="1">
 <br>
<!--- If data is not correct show error and allow them to go back to the dsp_addEmail Screen --->
<cfoutput>
	<cfif ArrayLen(Error) GT 0>
		<table border="0" cellpadding="4" cellspacing="0" width="100%">
		    <tr>
			   <td>An error was discovered while attempting to update your record.</td>
			</tr>
		  <cfloop index="i" from="1" to="#ArrayLen(Error)#"> 
			<tr>
		       <td><li><strong style="color:##CC0000;">#Error[i]#</strong></li></td>
		    </tr>
		  </cfloop>
		  <tr>
		    <td><a href="##" onclick="javascript:history.back(-1);">Click here</a> to go back and correct these errors.</td>
		  </tr>
		</table>           
	</cfif>
</cfoutput>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">