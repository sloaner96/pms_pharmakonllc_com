<!--- 
	*****************************************************************************************
	Name:		reportpiw.cfm
	
	Function:	Pulls data for PIW into a printable "document"
	History:	9/25/01 LB
				10/12/01 TJS -added "NOT ISDEFINED" in beginning 
								for cases of reference from piw6.cfm"
	
	*****************************************************************************************
--->
<HTML>
<HEAD>
<TITLE>PIW Report</TITLE>
<LINK REL=stylesheet HREF="piw1style1.css" TYPE="text/css">		
<CFIF IsDefined("form.project_code")><cfset session.project_code = form.project_code>
<CFELSEIF IsDefined("URL.project_code")><cfset session.project_code = URL.project_code>
</CFIF>
</HEAD>
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qpiw">
	SELECT p.client_code
 		FROM  piw p
		WHERE p.project_code = '#session.project_code#' 
			
</cfquery>

<!--- save client_code from query above --->
<cfset session.client_code = qpiw.client_code>

<BODY>
<table>
<tr>
	<td width=20>&nbsp;</td>
	<td>
		<cfoutput>
		<p align="left"><b><font color="Navy">Below is the detail from project: #session.project_code#. Click the <b><i>print</i></b> button for a hard copy.</font></b></p>
	  	<p align=right>
		<form action="piw1.cfm">
  		<INPUT  TYPE="submit" NAME="edit" VALUE="Edit This PIW"></form>
		</p>
		</cfoutput>
	</td>
</tr>
<td width=20>&nbsp;</td>
<td>
<table width="550" border="0" cellspacing="0" cellpadding="5" align="left">
<cfoutput query="qpiw">
	<!--- contact info section --->
	<tr BGCOLOR="##99CCFF">
		<td colspan="2">
			<font size="2"><b><font color="Navy">Project Information Worksheet</font></b></font>
		</td>
	</tr>
	<tr BGCOLOR="##e5f6ff">
		<th width=300><b>Client Code:</b></th>
		<td width=250>#client_code#</td>
</cfoutput>

	<tr BGCOLOR="#99CCFF">
		<td colspan="2"><font size="2"><font color="Navy"><b>Project Moderators/Speakers</b></font></font></td>
	</tr>
	<tr BGCOLOR="#e5f6ff">
		<th><b>Assigned Moderators:</b></th>
		<td>
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="get_mod_id">
			select staff_id, staff_type
FROM schedule_meeting_time
WHERE project_code = '#session.project_code#' AND staff_type = '1'
GROUP BY staff_id, staff_type
ORDER BY staff_id, staff_type
		</CFQUERY>				
		<CFOUTPUT>
		<CFLOOP QUERY="get_mod_id">
			<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="get_name">
				SELECT firstname, lastname FROM spkr_table WHERE speaker_id = #get_mod_id.staff_id#
			</CFQUERY>
			<CFLOOP QUERY="get_name">
			
			#get_name.firstname# #get_name.lastname#,&nbsp;
			</CFLOOP>
		</CFLOOP>	
		</CFOUTPUT>
		</td>
	</tr>
	
<cfif IsDefined("report")>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td><b><SCRIPT LANGUAGE="JavaScript">
	 		 <!-- Begin print button
	  		if (window.print) {
			  document.write('<form>'
			  + '<input type=button  name=print value="  Print  " '
			  + 'onClick="javascript:window.print()"></form>');
			  }
		  // End print button-->
		  </script></b>
		</td>
		<form action="index.cfm">
		<td>
			<INPUT  TYPE="submit" NAME="list" VALUE="Back to Project List"></form>
	  	</td>
	  	<form action="report_piw_search.cfm">
	  <td><INPUT  TYPE="submit" NAME="submit" VALUE="  Back  "></form>
	  </td>
  </tr>
<cfelse>
  <tr><td>&nbsp;</td></tr>
	<tr>
		<td><b><SCRIPT LANGUAGE="JavaScript">
		  <!-- Begin print button
		  if (window.print) {
		  document.write('<form>'
		  + '<input type=button  name=print value="  Print  " '
		  + 'onClick="javascript:window.print()"></form>');
		  }
		  // End print button-->
		  </script></b>
  		</td>
		<form action="index.cfm">
		<td>
			<INPUT  TYPE="submit" NAME="list" VALUE="Back to Project List"></form>
	  	</td>
			<form action="piw1.cfm">
	  	<td><INPUT  TYPE="submit" NAME="edit" VALUE="Edit This PIW"></form></td>
  </tr>
</cfif>
</table>		
</td></tr>
</table>
</BODY>
</HTML>
