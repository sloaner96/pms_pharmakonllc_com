<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<LINK REL=stylesheet HREF="piw1style1.css" TYPE="text/css">
</head>

<body>
<table cellpadding="5" cellspacing="0" width="95%">
	
	<tr BGCOLOR="#99CCFF">
		<td><font size="2"><font color="Navy"><b>Assigned Project Speakers</b></font></font></td>
	</tr>
	<tr BGCOLOR="#e5f6ff">
		<td>
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="get_mod_id">
				select staff_id, staff_type
				FROM ScheduleSpeaker
				WHERE project_code = '#URL.project_code#' AND staff_type = '2'
				GROUP BY staff_id, staff_type
				ORDER BY staff_id, staff_type
			</CFQUERY>				
			<CFOUTPUT>
			<font size="2">
			<CFLOOP QUERY="get_mod_id">
				<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="get_name">
					SELECT firstname, lastname FROM Speaker WHERE speakerid = #get_mod_id.staff_id#
				</CFQUERY>#CurrentRow#
				<CFLOOP QUERY="get_name">
					) #get_name.firstname# #get_name.lastname#
				</CFLOOP>
				
				<br>
			</CFLOOP>
			</font>	
			</CFOUTPUT>
		</td>
	</tr>
	<tr>
		<td>
			<table align="center" width="100%">
			<tr>
			<td align="left"><b><SCRIPT LANGUAGE="JavaScript">
			  <!-- Begin print button
			  if (window.print) {
			  document.write('<form>'
			  + '<input type=button name=print value="  Print  " '
			  + 'onClick="javascript:window.print()"></form>');
			  }
			  // End print button-->
			  </script></b>
			</td>
			<td colspan="2" align="right"><form>
			<input type="button" value="Close Window" onClick="javascript:window.close();"></form>
			</td>
			</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>
