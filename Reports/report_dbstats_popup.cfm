<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<LINK REL=stylesheet HREF="piw1style1.css" TYPE="text/css">
</head>

<body>
<tr><td colspan="2" align="center"><b>Database Information:</b><br><hr></td></tr>
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qdb">
			SELECT project_code,received_date,received_from,received_filename,total_records,rowid FROM database_info 
			WHERE project_code = '#session.project_code#'
			ORDER BY rowid
		</cfquery>
		
<CFIF #qdb.recordcount# EQ 0>
<tr><td colspan="2">No Database information exists!</td></tr>
<CFELSE>
<tr BGCOLOR="#e5f6ff">
		
		
		<td colspan="2">
		<table border=0 width="90%"><cfoutput>
		<cfloop query="qdb">
					<tr>
						<td>
							<!-- Shows a sampling of the Database, Becuase multiple databases occur with same Project Code  -->
							<font size="2">Project Code: #session.project_code#</font><br>
							<b>Received Date:</b> #dateFormat(qdb.received_date, "mm/dd/yy")# <br>
							<b>Received From:</b> #trim(qdb.received_from)# <br>
							<b>Original File:</b> #trim(qdb.received_filename)#<br>
							<b>Original Total Records:</b> #trim(qdb.total_records)#
						</td>
						<td>
							<!--- <form action="piwviewdb2.cfm" method="post">
								<input type="hidden" name="project_code" value="#session.project_code#">
								<input type="hidden" name="rowid" value="#qdb.rowid#">
								<INPUT  TYPE="submit" NAME="edit" VALUE="View Database Statistics">
							</form> --->
					<form action="piwdb2.cfm" onClick="javascript:void window.open('PIW_dbView2.cfm?project_code=#Trim(session.project_code)#&rowid=#qdb.rowid#&no_menu=1','','width=650,height=600,scrollbars=yes,location=no');">
					<input type="button" name="submit" value=" View Database ">
					</form>
						</td>
					</tr>
					<tr><td colspan=2><Hr noshade></td></tr>
				</cfloop>
				</cfoutput>
				</table>
		</td>
	</tr>
</CFIF>


	<tr><td><br></td></tr>
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
