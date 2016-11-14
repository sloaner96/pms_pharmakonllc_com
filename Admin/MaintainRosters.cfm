<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Roster Maintenance Admin" showCalendar="0">
<table border="0" cellpadding="4" cellspacing="0" width="100%">
 <tr>
	<td><ul><li></ul></td> 
	<td><a href="/admin/rosters/LoadRosters.cfm">Load Rosters</a></td>
	<td>Allows comma or tab delimited file to be upload to database.</td>
  </tr> 
  <tr>
    <td><ul><li></ul></td>  
    <td><a href="dsp_repUpdConfig.cfm">Rep Update Configuration Admin</a></td>
    <td>Configure Rep Update Stored Procedures.</td>
  </tr>
  <tr bgcolor="#eeeeee">
	<td><ul><li></ul></td>    
	<td><a href="/admin/rosters/dsp_repUpdate.cfm">Rep Update</a></td>
	<td>This application will take data from various client tables, and update rep info in the roster table.</td>
  </tr>
  <tr>
	<td><ul><li></ul></td>   
	<td><a href="/admin/rosters/roster_certificates.cfm">Medsite Certificates</a></td>
	<td>Generates comma delimited text file for each Pharmakon company.</td>
  </tr>
  <tr bgcolor="#eeeeee">
	<td><ul><li></ul></td>   
	<td><a href="/admin/rosters/roster_conf_roster.cfm">Conference Company Rosters</a></td>
	<td>Generates comma delimited text file roster for each meeting.</td>
  </tr>
  <tr>
	<td><ul><li></ul></td>    
	<td><a href="/admin/rosters/roster_recruit_roster.cfm">Recruiter Attendance Rosters</a></td>
	<td>Generates comma delimited text file roster for the given dates and recruiter.</td>
  </tr>
  <tr bgcolor="#eeeeee">
	<td><ul><li></ul></td>   
	<td><a href="/admin/rosters/roster_close_roster.cfm?a=1">Close/Cancel Meetings</a></td>
	<td>Sets meeting status to 'Closed' or 'Cancelled'.</td>
  </tr>
  <tr>
	<td><ul><li></ul></td>   
	<td><a href="/admin/rosters/roster_cert_issue.cfm">Upload Certificate Issuance Data</a></td>
	<td>Loads certificate issuance data into the roster database.</td>
  </tr>
  <tr bgcolor="#eeeeee">
	<td><ul><li></ul></td>    
	<td><a href="/admin/rosters/roster_cert_redeem.cfm">Upload Certificate Redemption Data</a></td>
	<td>Loads certificate redemption data into the roster database.</td>
  </tr>
  <tr>
	<td><ul><li></ul></td>   
  	<td><a href="/admin/rosters/rep_update_exception.cfm">Rep Update Exception Report</a></td>
  	<td>View a list of MeetingCodes that need Rep Information provided by the Rep Update Application.</td>
  </tr>
</table>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
