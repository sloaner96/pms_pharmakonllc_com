<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="PMS ADMINISTRATION" showCalendar="0">
<br>
  <table border="0" cellpaddding="4" cellspacing="0" width="100%">
      <tr>
	    <td class="highlight"><strong style="font-size:12px;">Table Maintenance</strong></td>
	  </tr>
<!--- 	  <tr>
         <td><li><a href="dsp_LoadRosters.cfm">Load Rosters</a></td>
      </tr> --->
	  <tr>
         <td><li><a href="dsp_CancelCI.cfm">Cancel Future Meetings</a></td>
      </tr>
	   <tr>
         <td><li><a href="/admin/tableMaint/admin_add_Clients.cfm">Add New Clients</a></td>
	    </tr>
		<tr>
	         <td><li><a href="/admin/tableMaint/admin_add_products.cfm">Add New Products</a></td>
	    </tr>
		<tr>
	         <td><li><a href="/admin/tableMaint/admin_add_meeting_type.cfm">Add New Meeting Types</a></td>
	    </tr>
		<tr>
	         <td><li><a href="/admin/tableMaint/dsp_Phidlookup.cfm">Master Database Address Maintenance</a></td>
	    </tr>
		<tr>
	         <td><li><a href="/admin/tableMaint/dsp_faxlookup.cfm">Master Database Fax Maintenance</a></td>
	    </tr>
		<tr>
	         <td><li><a href="/admin/tableMaint/dsp_adminCreative.cfm">Healthcare Discussions Document Maintenance</a></td>
	    </tr>
		<tr>
	         <td><li><a href="/admin/HCD/index.cfm">Healthcare Discussions Confirmation Emails</a></td>
	    </tr>
		
	  <tr>
	    <td>&nbsp;</td>
	  </tr>	
	  <tr>
	    <td class="highlight"><strong style="font-size:12px;">Rosters</strong></td>
	  </tr>
<!--- 	  <tr>
         <td><li><a href="dsp_LoadRosters.cfm">Load Rosters</a></td>
      </tr> --->
	  <tr>
         <td><li><a href="/Rosters/dsp_repUpdate.cfm">Rep Update</a></td>
      </tr>
	  
<!--- 	  <tr>
         <td><li><a href="dsp_CIUpdate.cfm">WebEvents Update</a></td>
      </tr> --->
	  <tr>
         <td><li><a href="dsp_repUpdConfig.cfm">Rep Update Configuration Admin</a></td>
      </tr>
	  <tr>
		<td><li><a href="/admin/rosters/roster_certificates.cfm">Medsite Certificates</a></td>
	  </tr>
	  <tr>
		<td><li><a href="/admin/rosters/roster_conf_roster.cfm">Conference Company Rosters</a></td>
	  </tr>
	  <tr>
		<td><li><a href="/admin/rosters/roster_recruit_roster.cfm">Recruiter Attendance Rosters</a></td>
	  </tr>
	  <tr> 
		<td><li><a href="/admin/rosters/roster_close_roster.cfm?a=1">Close/Cancel Meetings</a></td>
	  </tr>
	  <tr> 
		<td><li><a href="/admin/rosters/roster_cert_issue.cfm">Upload Certificate Issuance Data</a></td>
	  </tr>
	  <tr>  
		<td><li><a href="/admin/rosters/roster_cert_redeem.cfm">Upload Certificate Redemption Data</a></td>
	  </tr>
	  <tr>  
	  	<td><li><a href="/admin/rosters/rep_update_exception.cfm">Rep Update Exception Report</a></td>
	 </tr>
 <tr>
	    <td>&nbsp;</td>
	  </tr>	
	  <tr>
	    <td class="highlight"><strong style="font-size:12px;">Scheduling</strong></td>
	  </tr>
	  <tr>
	    <td>&nbsp;</td>
	  </tr>
	    <tr>
         <td><li><a href="unavailable.cfm">Speakers/Moderators Scheduling</a></td>
      </tr>
	  <tr>
	    <td class="highlight"><strong style="font-size:12px;">Projects</strong></td>
	  </tr>
	  <tr>
         <td><li><a href="Series/index.cfm">Maintain Program Series</a></td>
      </tr>
	  <tr>
         <td><li><a href="/admin/Project_status_update.cfm">Update Program Status</a></td>
      </tr>
	  <tr>
	    <td>&nbsp;</td>
	  </tr>
	  <tr>
	    <td class="highlight"><strong style="font-size:12px;">Reports</strong></td>
	  </tr>
	  <tr>
         <td><li><a href="WklyReports/rpt_WeeklyReportsSetup.cfm">Weekly Reports Setup</a></td>
      </tr>
	  <!--- <tr>
	    <td><a href="/dbmove.cfm">Load Series</a></td>
	  </tr> --->
   </table>          
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">