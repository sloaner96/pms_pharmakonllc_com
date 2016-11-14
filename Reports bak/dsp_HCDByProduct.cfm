<!---
    $Id: ,v 1.0 2006/03/17 rsloan Exp $
    Copyright (c) 2006 Pharmakon, LLC.

    Description: This is a report to show the penetration rate by product
        
--->

<cfif not IsDefined("form.project")>
  <cfset StartThisMonth = "#Month(now())#/1/#Year(now())#">
  <cfset EndThisMonth   = "#Month(now())#/#DaysInMonth(StartThisMonth)#/#Year(now())#"> 
  <cfset getProjects = request.reports.getActiveConfirms()>
  <cfset getProducts = request.reports.GetEmailsSentByproduct(StartThisMonth, EndThisMonth)>
<cfelse>
  <cfset StartThisMonth = "#form.startdate#">
  <cfset EndThisMonth   = "#form.EndDate#"> 
  <cfset getProjects = request.reports.getActiveConfirms()> 
  <cfif Len(trim(form.project)) GT 0>
    <cfset getProducts = request.reports.GetEmailsSentByproduct(StartThisMonth, EndThisMonth, trim(form.project))>
  <cfelse>
    <cfset getProducts = request.reports.GetEmailsSentByproduct(StartThisMonth, EndThisMonth)>  
  </cfif>
</cfif>



<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="HealthcareDiscussions product report" showCalendar="1">
<br>
<div align="right" style="padding-bottom:5px;"><a href="dsp_HCDReports.cfm"><< Back to Reports Home</a></div>
   <cfoutput>
      <cfform name="filterfrm" action="dsp_hcdByProduct.cfm" method="POST">
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
	  </cfform> <br>
	  <table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="##e7e7e7">
		<tr class="highlight">
           <td valign="top"><strong>Product</strong></td>
		   <td valign="top"><strong>Take up PCT</strong></td>
		   <td valign="top"><strong>Attended</strong></td>
		   <td valign="top"><strong>Logged In</strong></td>
		   <td valign="top"><strong>Downloaded Guide</strong></td>
		   <td valign="top"><strong>Initial Emails Sent</strong></td>
		   <td valign="top"><strong>Secondary Reminder Email Sent</strong></td>
		   <td valign="top"><strong>Day Before Reminder Email Sent</strong></td>
		   <td valign="top"><strong>Day Before Thank-You Email Sent</strong></td>
        </tr>
		<cfloop query="getProducts">
		   <cfset getAttendCount = request.reports.getAttendedCount(StartThisMonth, EndThisMonth, GetProducts.ProjectCode)>
		   <cfset getTotalCI = request.reports.getTotalCI(StartThisMonth, EndThisMonth, GetProducts.ProjectCode)>
           <cfset getTotaleGuide = request.reports.getTotalEguide(StartThisMonth, EndThisMonth, GetProducts.ProjectCode)> 
		   <cfset PercentageEguide = ((getTotaleGuide.TotalEguide/getTotalCI.totalCI)*100)>
		  <tr bgcolor="##ffffff">
		    <td>#GetProducts.ProjectCode#</td>
			<td>#getTotaleGuide.TotalEguide#/#getTotalCI.TotalCI#  = #NumberFormat(PercentageEguide, "0.00")# %</td>
			<td>#GetAttendCount.AttendedProg#</td>
			<td>#GetProducts.LoggedIN#</td>
			<td>#GetProducts.FileDownload#</td>
			<td>#GetProducts.FirstEmailSent#</td>
			<td>#GetProducts.SecondEmailSent#</td>
			<td>#GetProducts.ThirdRemindSent#</td>
			<td>#GetProducts.ThirdThnkSent#</td>
		  </tr> 
		</cfloop>
      </table>           
	</cfoutput>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

