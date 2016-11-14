<!---
    $Id: ,v 1.0 2006/03/16 rsloan Exp $
    Copyright (c) 2006 Pharmakon, LLC.

    Description:
        
    Parameters:
        
    Usage:
        
    Documentation:
        
    Based on:
        
--->
<cfparam name="url.type" default="HTML">

<cfif Not IsDefined("Form.Project")>
	<cfset StartThisMonth = "#Month(now())#/1/#Year(now())#">
	<cfset EndThisMonth   = "#Month(now())#/#DaysInMonth(StartThisMonth)#/#Year(now())#">
	<cfset getUsers = request.reports.GetEmailsSentByUser(StartThisMonth, EndThisMonth)> 
<cfelse>	
   <cfif Len(trim(form.startdate)) GT 0>
      <cfset StartThisMonth =  Trim(form.startdate)>
   <cfelse> 
	 <cfset StartThisMonth = "#Month(now())#/1/#Year(now())#">
   </cfif>	
   
   <cfif Len(trim(form.enddate)) GT 0>
      <cfset EndThisMonth   = DateFormat(CreateODBCDATE(Trim(form.enddate)), 'MM/DD/YYYY')>
   <cfelse>
      <cfset EndThisMonth   = "#Month(now())#/#DaysInMonth(StartThisMonth)#/#Year(now())#">
   </cfif>
   
   <cfif Len(Trim(form.Project)) GT 0>
	<cfset getUsers = request.reports.GetEmailsSentByUser(StartThisMonth, EndThisMonth, trim(form.Project))> 
   <cfelse>
     <cfset getUsers = request.reports.GetEmailsSentByUser(StartThisMonth, EndThisMonth)>  
   </cfif>	
</cfif>

<cfset getProjects = request.reports.getActiveConfirms()>

<cfif URL.Type EQ "HTML">
	<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="HealthcareDiscussions User report" showCalendar="1">
	<br>
	  <div align="right" style="padding-bottom:5px;"><a href="dsp_HCDReports.cfm"><< Back to Reports Home</a></div>
	   <cfoutput>
	      <cfform name="filterfrm" action="dsp_hcdByUser.cfm" method="POST">
		   
		   <table border="0" cellpadding="8" cellspacing="0" width="80%">
		    <tr>
		       <td width="50%">
			     
			      <table border="0" cellpadding="3" cellspacing="0">
		            <tr>
		              <td><strong>Filter By Project:</strong></td>
		              <td><select name="project">
					        <option value="">-- ALL --</option>
							<cfloop query="getProjects">
							   <option value="#Trim(getProjects.projectCode)#" <cfif IsDefined("form.project")><cfif form.project EQ Trim(getProjects.projectCode)>Selected</cfif></cfif>>#Trim(getProjects.projectCode)#</option>
							</cfloop>
						  </select>
					  </td>
			        </tr>
		          </table>
			   </td>
			   <td width="50%">
			      <table border="0" cellpadding="3" cellspacing="0">
		            <tr>
		              <td><strong>Event Start Date:</strong></td>
		              <td><cfmodule template="#Application.tagpath#/ctags/calInput.cfm"
							          inputname="startdate"
									  htmlID="begindate"
									  FormValue="#StartThisMonth#"
									  imgid="begindatebtn"></td>
			        </tr>
					<tr>
		              <td><strong>Event End Date:</strong></td>
		              <td><cfmodule template="#Application.tagpath#/ctags/calInput.cfm"
							          inputname="enddate"
									  htmlID="enddate"
									  FormValue="#EndThisMonth#"
									  imgid="enddatebtn"></td>
			        </tr>
		          </table>
			   </td>
			   <td><input type="submit" name="submit" value="Filter"></td>
		    </tr>
		   </table> 
		  </cfform> 
		</cfoutput>  
		   <cfif getUsers.recordcount GT 0>
			 <div align="right" style="padding-bottom:5px;"><a href="dsp_HCDByUser.cfm?type=Excel&<cfif IsDefined("form.project")><cfif Len(trim(form.project)) GT 0>Project=#trim(form.project)#&</cfif></cfif>Start=#StartThisMonth#&End=#EndThisMonth#" target="_blank"><img src="/Images/excelico.gif" alt="Download as Excel" width="16" height="16" border="0" align="middle" hspace="2">Download as Excel</a></div> 
		   </cfif>
		   <table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="#e7e7e7">
	        <cfif getUsers.recordcount GT 0>
			       
				 <cfoutput query="getUsers" group="ProjectCode">
				    <cfset ProjectAttend = 0>
				    <cfset ProjectLogin  = 0>
				    <cfset ProjectDwnld  = 0>
					<cfset ProjectTotal  = 0>
					
				    <tr bgcolor="##99cccc">
					  <td colspan="5"><strong>#getUsers.ProjectCode#</strong></td>
					</tr>
					
					<cfoutput group="eventDateTime">
					  <cfset MtgAttend = 0>
				      <cfset MtgLogin  = 0>
				      <cfset MtgDwnld  = 0>
					  <cfset MtgTotal  = 0>
					  <tr bgcolor="##969696">
					     <td colspan="5"><strong style="color:##ffffff;">#DateFormat(getUsers.EventDateTime, 'MM/DD/YYYY')# #TimeFormat(getUsers.EventDateTime, 'hh:mm tt')#</strong></td>
					  </tr>
					  <tr bgcolor="##dde7d3">
					     <td>Participant</td>
					     <td>Last Email Sent (Times Sent)</td>
					     <td>Attended</td>
					     <td>Logged In</td>
					     <td>Downloaded Guide</td>
		               </tr>
						<cfoutput>
						  <cfset MtgTotal = MtgTotal + 1> 
						  <cfif getUsers.Attended NEQ "">
						     <cfif getUsers.Attended EQ 0>
						        <cfset MtgAttend = MtgAttend + 1>
						     </cfif>
						  </cfif>
						  <cfif getUsers.LoggedIN GT 0>
				             <cfset MtgLogin  = MtgLogin  + 1>
						  </cfif>
						  <cfif getUsers.FileDownload GT 0>
				             <cfset MtgDwnld  = MtgDwnld  + 1>
						  </cfif>
						  <tr <cfif getUsers.currentrow MOD(2) EQ 0>bgcolor="##ffffff"<cfelse>bgcolor="##eeeeee"</cfif>>
						     
						     <td>#getUsers.firstname# #getUsers.lastname#</td>
						     <td>#DateFormat(getUsers.DateSent, 'MM/DD/YYYY')# (#getUsers.TimesSent#)</td>
						     <td><cfif getUsers.Attended NEQ ""><cfif getUsers.Attended EQ 0><strong style="color:##00cc00;">YES</strong><cfelseif getUsers.Attended EQ 1><strong style="color:##cc0000;">CANCELLED</strong><cfelseif getUsers.Attended EQ 2><strong style="color:##cc0000;">No Show</strong><cfelseif getUsers.Attended EQ 5><strong style="color:##cc0000;">MTG CANCELLED</strong></cfif><cfelse><em style="color:##acacac;">Future Mtg</em></cfif></td>
							 <td><cfif getUsers.LoggedIN EQ 0><strong style="color:##cc0000;">NO</strong><cfelse><strong style="color:##00cc00;">YES</strong></cfif></td>
						     <td><cfif getUsers.FileDownload EQ 0><strong style="color:##cc0000;">NO</strong><cfelse><strong style="color:##00cc00;">YES</strong></cfif></td>
			              </tr>
						</cfoutput>
						<tr bgcolor="##ffffff" >
					      <td align="right" colspan="2"><strong>MEETING TOTALS:</strong></td>
						  <td align="center">#MtgAttend# / #MtgTotal#</td>
						  <td align="center">#MtgLogin# / #MtgTotal#</td>
						  <td align="center">#MtgDwnld# / #MtgTotal#</td>
					    </tr>
						<cfset ProjectAttend = ProjectAttend + MtgAttend>
				        <cfset ProjectLogin  = ProjectLogin + MtgLogin>
				        <cfset ProjectDwnld  = ProjectDwnld + MtgDwnld>
						<cfset ProjectTotal   = ProjectTotal + MtgTotal>
					</cfoutput>
					<tr bgcolor="##eeeeee">
					      <td align="right" colspan="2"><strong>PROJECT TOTALS:</strong></td>
						  <td align="center"><strong>#ProjectAttend# / #ProjectTotal#</strong></td>
						  <td align="center"><strong>#ProjectLogin# / #ProjectTotal#</strong></td>
						  <td align="center"><strong>#ProjectDwnld# / #ProjectTotal#</strong></td>
					</tr>
					<tr bgcolor="##ffffff">
					   <td colspan="5">&nbsp;</td>
					</tr>
				 </cfoutput>
			   <cfelse>
			     <tr bgcolor="#ffffff">
				   <td align="center"><strong style="color:#707070;">There are currently no records for the criteria you selected.</strong></td>
				 </tr>
			   </cfif>
	       </table>            
	                      
	<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
<cfelse>
  EXCEL
</cfif>

