 <link rel="stylesheet" type="text/css" media="all" href="/includes/styles/schedule.css" title="tas" />
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="PMS ADMINISTRATION" showCalendar="0">

<br><br>
   <table width="100%" border="1" cellspacing="0" cellpadding="8" align="center" frame="below" frame="rhs">
      <tr>
	    <td align="left" valign="top" nowrap>

		<strong>Table Maintenance</strong><br><br>

         <!--- <li><a href="dsp_CancelCI.cfm"><u>Cancel Future Meetings</u></a></li><br><br> --->

        <!--- <li><a href="/admin/tableMaint/admin_add_Clients.cfm"><u>Add New Clients</u></a></li><br><br> --->
		<li><a href="PIW_db.cfm"><u>PIW Database Stats</u></a></li><br><br>


	        <li><a href="/admin/tableMaint/admin_add_products.cfm"><u>Add New Products</u></a></li><br><br>


	        <li><a href="/admin/tableMaint/admin_add_meeting_type.cfm"><u>Add New Meeting Types</u></a></li><br><br>


	      <li><a href="/admin/tableMaint/dsp_Phidlookup.cfm"><u>Master Database Address Maintenance</u></a></li><br><br>


	     <li><a href="/admin/tableMaint/dsp_faxlookup.cfm"><u>Master Database Fax Maintenance</u></a></li><br><br>


	      <li><a href="/admin/tableMaint/dsp_adminCreative.cfm"><u>Healthcare Discussions Document Maintenance</u></a></li><br><br>

	        <li><a href="/admin/HCD/index.cfm"><u>Healthcare Discussions Confirmation Emails</u></a></li>
	</td>


	    <td align="left" valign="top" nowrap><strong>Rosters</strong><br><br>


         <li><a href="Rosters/dsp_repUpdate.cfm"><u>Rep Update</u></a></li><br><br>

       <li><a href="dsp_repUpdConfig.cfm"><u>Rep Update Configuration Admin</u></a></li><br><br>


		<li><a href="/admin/rosters/roster_certificates.cfm"><u>Medsite Certificates</u></a></li><br><br>


		<li><a href="/admin/rosters/roster_conf_roster.cfm"><u>Conference Company Rosters</u></a></li><br><br>


		<li><a href="/admin/rosters/roster_recruit_roster.cfm"><u>Recruiter Attendance Rosters</u></a></li><br><br>


		<li><a href="/admin/rosters/roster_close_roster.cfm?a=1"><u>Close/Cancel Meetings</u></a></li><br><br>


		<li><a href="/admin/rosters/roster_cert_issue.cfm"><u>Upload Certificate Issuance Data</u></a></li><br><br>

		<li><a href="/admin/rosters/roster_cert_redeem.cfm"><u>Upload Certificate Redemption Data</u></a></li><br><br>

	 <li><a href="/admin/rosters/rep_update_exception.cfm"><u>Rep Update Exception Report</u></a></li><br><br>

	  <li><a href="/admin/wklyreports/rpt_weeklyReportsSetup.cfm"><u>Weekly Reports Setup</u></a></li>

	</td>
	    <td align="left" valign="top" nowrap>
		<strong style="font-size:12px;">Scheduling</strong><br><br>

       <li><a href="unavailable.cfm"><u>Speakers/Moderators Availability</u></a></li><br><br>

	   <li><a href="/admin/Speaker/index.cfm"><u>Override Non-Speakers</u></a></li><br><br><br><br>


	   <li><a href="/admin/IT/IT_SpecialRequest.cfm"><u><font color="red">Special Requests</font></u></a></li><br><br>

	   </td>
      <td align="left" valign="top" nowrap>
	   <strong style="font-size:12px;">Projects</strong><br><br>

         <li><a href="Series/index.cfm"><u>Maintain Program Series</u></a></li><br><br>

       <li><a href="/admin/Project_status_update.cfm"><u>Update Program Status</u></a></li><br><br>
   </td>

</tr>
   </table>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">