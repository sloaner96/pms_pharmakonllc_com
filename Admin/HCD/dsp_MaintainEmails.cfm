<!--- Initialize Component --->
   <cfobject name="ConfirmEmails" component="pms.com.ConfirmEmails">
   
<!--- Get Unapproved Letters --->  
    <cfset unapproved = confirmEmails.getUnApprovedConfirms()> 
<!--- Get Approved Letters --->  
    <cfset approved = confirmEmails.getApprovedConfirms()> 
	
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Create/Edit Confirmation Emails" showCalendar="0">
  <table border="0" cellpadding="2" cellspacing="0" width="100%">
    <tr>
       <td align="right"><a href="dsp_AddEmail.cfm">Create New Confirmation Letter >></a></td>
    </tr>
  </table>
  <table border="0" cellpadding="2" cellspacing="0" width="100%">
      <tr class="highlight">
         <td><strong>Unapproved Confirmation Letters</strong></td>
      </tr>
	  <tr>
	    <td>
		  <table border="0" cellpadding="4" cellspacing="1" width="100%" bgcolor="#eeeeee">
             <cfif unapproved.recordcount GT 0>  
			   <tr bgcolor="#777777">
			     <td><strong style="color:#ffffff;">Project Code</strong></td>
				 <td><strong style="color:#ffffff;">Title</strong></td>
				 <td><strong style="color:#ffffff;">Date Created</strong></td>
				 <td><strong style="color:#ffffff;">Test Email Sent</strong></td>
			   </tr>
			 <cfoutput query="unapproved">
				 <tr bgcolor="##ffffff">
	               <td><a href="dsp_EditEmails.cfm?CID=#unapproved.ConfirmID#">#unapproved.ProjectCode#</a> <a href="" onclick="window.open('dsp_previewEmail.cfm?CID=#unapproved.ConfirmID#');">[PREVIEW]</a></td>
				   <td>#unapproved.ConfirmTitle#</td>
				   <td>#DateFormat(unapproved.DateAdded, 'MM/DD/YYYY')# at #TimeFormat(unapproved.DateAdded, 'HH:MM TT')#</td>
				   <td><cfif unapproved.TestEmailSent NEQ "">#DateFormat(unapproved.TestEmailSent, 'MM/DD/YYYY')# at #TimeFormat(unapproved.TestEmailSent, 'HH:MM TT')#<cfelse>Not Sent</cfif></td>
	             </tr>
			 </cfoutput>
			<cfelse>
			    <tr bgcolor="#ffffff">
				  <td><strong style="color:#777777;">There are currently no unapproved confirmation Emails</strong></td>
				</tr>
			</cfif>
			 
          </table>           
		</td>
	  </tr>
	  <tr>
	    <td>&nbsp;</td>
	  </tr>
	  <tr class="highlight">
         <td><strong>Approved Confirmation Letters</strong></td>
      </tr>
	  <tr>
	    <td>
		  <cfif approved.recordcount GT 0>
			  <table border="0" cellpadding="4" cellspacing="1" width="100%" bgcolor="#eeeeee">
	               <tr bgcolor="#777777">
				     <td><strong style="color:#ffffff;">Project Code</strong></td>
					 <td><strong style="color:#ffffff;">Title</strong></td>
					 <td><strong style="color:#ffffff;">Date Created</strong></td>
					 <td><strong style="color:#ffffff;">Test Email Sent</strong></td>
					 <td><strong style="color:#ffffff;">Date Approved</strong></td>
					 
				   </tr>
				  <cfoutput query="approved">
					 <tr bgcolor="##ffffff">
		               <td><a href="dsp_previewEmail.cfm?CID=#approved.ConfirmID#">#approved.ProjectCode#</a></td>
					   <td>#approved.ConfirmTitle#</td>
					   <td>#DateFormat(approved.DateAdded, 'MM/DD/YYYY')# at #TimeFormat(approved.DateAdded, 'HH:MM TT')#</td>
					   <td><cfif approved.TestEmailSent NEQ "">#DateFormat(approved.TestEmailSent, 'MM/DD/YYYY')# at #TimeFormat(unapproved.TestEmailSent, 'HH:MM TT')#<cfelse>Not Sent</cfif></td>
					   <td><cfif approved.ApprovalDate NEQ "">#DateFormat(approved.ApprovalDate, 'MM/DD/YYYY')# at #TimeFormat(approved.ApprovalDate, 'HH:MM TT')#<br>By #Approved.ApprovedName#</cfif></td>
		             </tr>
				  </cfoutput>
	          </table>
		  <cfelse>
		     <table border="0" cellpadding="4" cellspacing="0" width="100%">
                <tr>
                   <td><strong style="color:#777777;">There are no Approved Confirmation Emails</strong></td>
                </tr>
             </table>           	  
		  </cfif>           
		</td>
	  </tr>
   </table>                      
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">