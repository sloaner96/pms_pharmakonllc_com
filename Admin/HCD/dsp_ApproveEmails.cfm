<!---
    $Id: ,v 1.0 2000/00/00 rsloan Exp $
    Copyright (c) 2005 Pharmakon, LLC.

    Description:
        
    Parameters:
        
    Usage:
        
    Documentation:
        
    Based on:
        
--->
<cfparam name="URL.E" default="0" type="numeric">


<cfobject name="ConfirmEmails" component="pms.com.ConfirmEmails">
<cfset unapproved = ConfirmEmails.getUnApprovedConfirms()>

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Approve Confirmation Email" showCalendar="0">
  <div align="right"><a href="index.cfm"><< Back to Confirmation Home</a></div>
  <cfif url.E EQ 99>
    <strong>There was a problem approving this Confirmation Email, Please contact IT.</strong>
  </cfif>
  <table border="0" cellpadding="4" cellspacing="0">
	 <tr>
	     <td>Below you will find Confirmation Emails awating approval. For reliability and security purposes, users who created a confirmation email, may not approve the same confirmation email.</td>
	 </tr>
	 <tr>
	   <td>
	      <table border="0" cellpadding="4" cellspacing="1" width="100%">
            <tr class="highlight">
               <td><strong>Project Code</strong></td>
			   <td><strong>Title</strong></td>
			   <td><strong>Start Date</strong></td>
			   <td><strong>Created By</strong></td>
			   <td align="center"><strong>Approval</strong></td>
            </tr>
			<cfoutput query="unapproved">
			  <tr <cfif unapproved.currentrow MOD(2) EQ 0>bgcolor="##eeeeee"</cfif>>
			     <td><a href="dsp_previewEmail.cfm?CID=#unapproved.ConfirmID#" target="_Blank">#unapproved.ProjectCode#</a></td>
				 <td>#unapproved.ConfirmTitle#</td>
				 <td>#DateFormat(unapproved.StartDate, 'MM/DD/YYYY')#</td>
				 <td>#unapproved.CreatedByName# on #DateFormat(unapproved.DateAdded, 'MM/DD/YYYY')#</td>
				 <td align="center"><cfif unapproved.TestEmailSent EQ ""><strong style="color:##778899;">You must send a test email first</strong><cfelse><cfif Session.Userinfo.rowid NEQ unapproved.CreatedBy><a href="act_approveEmails.cfm?CID=#unapproved.ConfirmID#"><strong>APPROVE</strong></a><cfelse><strong style="color:##CC0000;">You can not approve this.</strong></cfif></cfif></td>
			  </tr>
			</cfoutput>
          </table>           
	   </td>
	 </tr>
  </table>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">  
