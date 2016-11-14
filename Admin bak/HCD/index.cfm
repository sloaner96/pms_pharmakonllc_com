<!---
    $Id: ,v 1.0 2005/11/21 rsloan Exp $
    Copyright (c) 2005 Pharmakon, LLC.

    Description: This is the main landing page for Healthcare Discussions Email Confirmation Pages and 
        
--->
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="HealthCare Discussions Admin" showCalendar="0">
 <table border="0" cellpadding="4" cellspacing="0" width="100%">
    <tr class="highlight">
        <td><strong>Confirmation Emails</strong></td>
    </tr>
	<tr>
	    <td>
	       <table border="0" cellpadding="4" cellspacing="0">
              <tr>
                 <td></td>
				 <td><a href="dsp_ViewApproved.cfm">View Approved Email Confirmation Letters</a></td>
              </tr>
			  <tr>
                 <td></td>
				 <td><a href="dsp_MaintainEmails.cfm">Create/Edit Email Confirmation Letters</a></td>
              </tr>
			  <tr>
                 <td></td>
				 <td><a href="dsp_ApproveEmails.cfm">Approve inProcess Email Confirmation Letters</a></td>
              </tr> 
			  <!--- <tr>
                 <td></td>
				 <td><a href="dsp_SendEmails.cfm">Manually Send Approved Email Confirmation Letters</a></td>
              </tr>  --->
			  
           </table>            
	    </td>
	</tr>
	<!--- 
	<tr class="highlight">
        <td><strong>Reports</strong></td>
    </tr>
	<tr>
	  <td>
	    <table border="0" cellpadding="4" cellspacing="0">
          <tr>
             <td></td>
			 <td><a href="reports/">Logins by Date Range Report</a></td>
          </tr>
		  <tr>
             <td></td>
			 <td><a href="reports/">Logins by Product Report</a></td>
          </tr>
		  <tr>
             <td></td>
			 <td><a href="reports/">Logins by PHID Report</a></td>
          </tr>
		  <tr>
             <td></td>
			 <td><a href="reports/">Logins by No PHID Report</a></td>
          </tr>
		  <tr>
             <td></td>
			 <td><a href="reports/">Downloads by Date Range Report</a></td>
          </tr>
		  <tr>
             <td></td>
			 <td><a href="reports/">Downloads by Product Report</a></td>
          </tr>
		  <tr>
             <td></td>
			 <td><a href="reports/">Downloads by PHID Report</a></td>
          </tr>
		</table>
	  </td>		  	  
   </tr>
    --->
 </table>           
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
