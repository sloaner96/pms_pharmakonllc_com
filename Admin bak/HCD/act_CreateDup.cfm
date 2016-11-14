<!---
    $Id: ,v 1.0 2000/00/00 rsloan Exp $
    Copyright (c) 2005 Pharmakon, LLC.

    Description:
        
    Parameters:
        
    Usage:
        
    Documentation:
        
    Based on:
        
--->
<!--- Initialize Component --->
   <cfobject name="ConfirmEmails" component="pms.com.ConfirmEmails">
   
<!--- Validate submitted Data --->
    <cfset Error = ArrayNew(1)>
	<cfset Warning = ArrayNew(1)>
	
	<!--- Check for ProgramID --->  
	<cfif Not IsDefined("form.PID")>
	   <cfset x = ArrayAppend(Error, "Error! There was no program selected! Please select a program and resubmit your request.")>
	<cfelse>
	   <cfif Len(trim(form.PID)) EQ 0>
	         <cfset x = ArrayAppend(Error, "Error! There was no program selected! Please select a program and resubmit your request.")>      
	   </cfif>
	</cfif>
	
	<!--- Check for the ID To Copy --->
	<cfif Len(trim(form.CopyID)) EQ 0>
	   <cfset x = ArrayAppend(Error, "Error! There was no program to copy from selected! Please select a program and resubmit your request.")>
	</cfif>
	
	<!--- Check if a Title was passed --->
	 <cfif Len(Trim(form.EmailTitle)) EQ 0>
	        <cfset x = ArrayAppend(Error, "Error! You did not enter a title! Please enter a title and resubmit your request.")>  
	 </cfif>
	 
	 <!--- Check if begin date was passed --->
	 <cfif Len(Trim(form.begin_date)) EQ 0>
	        <cfset x = ArrayAppend(Error, "Error! You did not enter a Begin Date for this confirmation! Please enter a begin date and resubmit your request.")>  
	 </cfif>
	 
	<!--- Check if end date was passed --->
	 <cfif Len(Trim(form.end_date)) EQ 0>
	        <cfset x = ArrayAppend(Error, "Error! You did not enter an End Date for this confirmation! Please enter a end date and resubmit your request.")>  
	 </cfif>
	
	<!--- Validated that there is no email Program with this Program Code --->
	 <cfif Not IsDefined("form.confirmWarning")> 
		<!--- check if an email already exists for this program Code, warn the user that continuing will inactivate the existing Project_Code --->
		  <cfset DupCheck  = ConfirmEmails.getProjConfirmations(Trim(form.PID))>
		  
		  <cfif DupCheck.Recordcount GT 0>
		        <cfset x = ArrayAppend(Warning, "Warning! The Program Code (#form.PID#) already has a Confirmation Email in place. By continuing you will inactivate the existing record.")>  
		 </cfif>
     </cfif>
  <cfif Arraylen(Error) EQ 0 and ArrayLen(Warning) EQ 0>    	 
   <!--- No Errors, get existing confirmation email and create the Duplicate --->
      <!--- Pull Existing based on CopyID --->
	    <cfset GetDup  = ConfirmEmails.getConfirmations(Trim(form.CopyID))>
	  
	  <!--- Create Record from Existing --->
	  <cfinvoke component="pms.com.ConfirmEmails" method="InsertConfirm" returnvariable="AddEmail">
	    <cfinvokeargument name="Title"        value="#Trim(form.EmailTitle)#">
	    <cfinvokeargument name="projectCode"  value="#Trim(form.PID)#">
	    <cfinvokeargument name="StartDate"    value="#CreateODBCDate(form.begin_date)#">
	    <cfinvokeargument name="EndDate"      value="#CreateODBCDate(form.end_date)#">
	    <cfinvokeargument name="CreatedBy"    value="#Session.Userinfo.rowID#">
	  </cfinvoke>
      
	  <cfinvoke component="pms.com.ConfirmEmails" method="UpdateEmail">
		  <cfinvokeargument name="ConfirmID"    value="#AddEmail#">
		  <cfinvokeargument name="Title"        value="#form.EmailTitle#">
		  <cfinvokeargument name="StartDate"    value="#createODBCDate(form.begin_date)#">
		  <cfinvokeargument name="EndDate"      value="#createODBCDate(form.end_date)#">
		  <cfinvokeargument name="FromEmail"    value="#Trim(GetDup.FromAddress)#">
		  <cfinvokeargument name="Subject"      value="#Trim(GetDup.ConfirmSubject)#">
		  <cfinvokeargument name="MsgContent"   value="#trim(GetDup.ConfirmText)#">
		  <cfinvokeargument name="UpdatedBy"    value="#Session.UserInfo.rowID#">
	  </cfinvoke>
	  
	   <cfif IsDefined("Form.ConfirmWarning")>
	    <cfset UpdInactive  = ConfirmEmails.UpdInActive(Trim(form.PID), AddEmail, Session.Userinfo.rowID)>
	  </cfif>

	  <cflocation URL="dsp_EditEmails.cfm?CID=#AddEmail#" addtoken="NO">
	  <cfabort>
	  
  <cfelse>
        <!--- If Problems show the Error and a link to go back --->
        <cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Create a New Confirmation Emails" showCalendar="1">
		 <br>
		<!--- If data is not correct show error and allow them to go back to the dsp_addEmail Screen --->
		<cfoutput>
			<cfif ArrayLen(Error) GT 0>
				<table border="0" cellpadding="4" cellspacing="0" width="100%">
				    <tr>
					   <td>An error was discovered while attempting to add your record.</td>
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
			<cfelseif ArrayLen(Warning) GT 0>
			    <form name="warning" action="act_Createnew.cfm" method="POST">
				   <input type="hidden" name="PID" value="#form.PID#">
				   <input type="hidden" name="CopyID" value="#form.CopyID#">
				   <input type="hidden" name="EmailTitle" value="#form.EmailTitle#">
				   <input type="hidden" name="begin_date" value="#form.begin_date#">
				   <input type="hidden" name="end_date" value="#form.end_Date#">
				   <input type="hidden" name="confirmWarning" value="true">
				   
				    <table border="0" cellpadding="4" cellspacing="0" width="100%">
					    <tr>
						  <td>&nbsp;</td>
						</tr>
					  <cfloop index="w" from="1" to="#ArrayLen(Warning)#"> 
						<tr>
					       <td><strong style="color:##CC0000;">#Warning[w]#</strong></td>
					    </tr>
					  </cfloop>
					  <tr>
					    <td><input type="button" name="retreat" value="<< Go Back" onclick="javascript:history.back(-1);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="submit" value="Click here to Acknowledge and Continue >>"></td>
					  </tr>
					</table>
				</form>
			</cfif>
		</cfoutput>
		<cfmodule template="#Application.tagpath#/ctags/footer.cfm"> 
  </cfif>


