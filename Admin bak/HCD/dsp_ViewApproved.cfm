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
   
<cfset getApproved = ConfirmEmails.getApprovedConfirms()>

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Approved Confirmation Letters" showCalendar="0">
	<table border="0" cellpadding="4" cellspacing="0" width="100%">
	   <tr>
	       <td>Below are confirmation emails that have been approved to be sent out.</td>
		   <td align="right"><a href="index.cfm"><< Back to Main</a></td>
	   </tr>
	</table><br>    
	<cfoutput>
		<table border="0" cellpadding="4" cellspacing="1" width="100%" bgcolor="##eeeeee">
		   <tr style="highlight">
		       <td colspan="4"><strong>Approved Confirmation Letters</strong></td>
		   </tr>
		   <cfif getApproved.recordcount GT 0>
		     <tr bgcolor="##777777">
			    <td><strong style="color:##fff;">Project Code</strong></td>
		        <td><strong style="color:##fff;">Title</strong></td>
				<td><strong style="color:##fff;">Approved</strong></td>
				<td><strong style="color:##fff;">Last Sent</strong></td>
		     </tr>
			 <cfloop query="getApproved">
			   <tr bgcolor="##ffffff">
			     <td><a href="dsp_previewEmail.cfm?CID=#getApproved.ConfirmID#">#getApproved.ProjectCode#</a></td>
		         <td>#getApproved.ConfirmTitle#</td>
				 <td>#DateFormat(getApproved.ApprovalDate, 'MM/DD/YYYY')#<br>by #ApprovedName#</td>
				 <td><cfif getApproved.LastRun NEQ "">#DateFormat(getApproved.LastRun, 'MM/DD/YYYY')#<cfelse><strong style="color:##CC0000;">NEVER</strong></cfif></td>
		       </tr>
			 </cfloop>
		   <cfelse>	 
		     <tr bgcolor="##ffffff">
		        <td style="color:##666666;">There are currently no approved confirmation letters.</td>
		     </tr>
		   </cfif>
		</table>    
	</cfoutput>       
<cfmodule template="#Application.tagpath#/ctags/footer.cfm"> 
