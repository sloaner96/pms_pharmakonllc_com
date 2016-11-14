<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>

<body>
<cfoutput>
<table border="0" cellpadding="0" cellspacing="1" bgcolor="##000000" width="100%" style="font-family:verdana;font-size:11px;">
	<tr bgcolor="##eeeee">
	  <td colspan="2" align="center"><b>Database Information:</b></td>
	</tr>
	<!-- Shows a sampling of the Database, Becuase multiple databases occur with same Project Code  -->
	<cfset qdb = request.project.getDBStats(session.project_code)>
			
	<cfif qdb.recordcount EQ 0>
     <tr>
       <td colspan="2">No Database information exists!</td>
	 </tr>
   <cfelse>
	<tr BGCOLOR="##000000">
		<td colspan="2">
			<table border=0 width="100%" bgcolor="##ffffff" style="font-family:verdana;font-size:11px;">
			  <cfloop query="qdb">
					<tr>
					   <td><strong>Project Code:</strong></td>
					   <td>#session.project_code#</font></td>
					</tr>
					<tr>
					  <td><strong>Received Date:</strong></td>
					  <td>#dateFormat(qdb.received_date, "mm/dd/yy")#</td>
					</tr>  
					<tr>
					  <td><strong>Received From:</strong></td>
					  <td>#trim(qdb.received_from)#</td>
					</tr> 
					<tr>
					  <td><strong>Original File:</strong> </td>
					  <td>#trim(qdb.received_filename)#</td>
					</tr> 
					<tr>
					  <td><strong>Original Total Records:</strong></td>
					  <td>#trim(qdb.total_records)#</td>
					</tr>  
			  </cfloop>
				<tr>
				  <td colspan=2><form action="piwdb2.cfm" onClick="javascript:window.open('PIW_dbView2.cfm?project_code=#Trim(session.project_code)#&rowid=#qdb.rowid#&no_menu=1','','width=650,height=600,scrollbars=yes,location=no');">
								  <input type="button" name="submit" value=" View Database ">
								</form>
				  </td>
			    </tr>
			 </table>
			 <table align="center" width="100%" bgcolor="ffffff">
				<tr>
					<td align="left"><img src="/Images/btn_print.gif" width="91" height="23" alt="Print this document" border="0" onclick="javascript:self.print();"></td>
					<td colspan="2" align="right"><img src="/Images/btn_close.gif" width="91" height="23" alt="Close this Window" border="0" onClick="javascript:window.close();"></td>
				</tr>
			 </table>
			</td>
		</tr>
      </cfif>
     </td>
	</tr>
</table>
</cfoutput>
</body>
</html>
