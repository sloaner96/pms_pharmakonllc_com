
		  
<cfset get_mod_id = request.project.getStaffID(URL.project_code, 2)>		  	  

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body onload="self.focus();">
<CFOUTPUT>
<table cellpadding="5" cellspacing="0" width="95%">
	
	<tr BGCOLOR="##eeeee">
		<td><font face="arial" size="2"><b>Assigned Project Speakers for #URL.project_code#</b></font></td>
	</tr>
	<CFLOOP QUERY="get_mod_id">
	   <cfset get_name = request.speakers.getSpeaker(get_mod_id.staff_id)>
		<tr <cfif get_mod_id.currentrow MOD 2 EQ 0>bgcolor="eeeeee"</cfif>>
			<td style="font-family:verdana;font-size:11px;">#CurrentRow# .)
				<CFLOOP QUERY="get_name">
						#get_name.firstname# #get_name.lastname#
				</CFLOOP>
			</td>
		</tr>
	</CFLOOP>
	<tr>
		<td>
			<table align="center" width="100%">
			<tr>
			<td colspan="2" align="right"><form>
			<input type="button" value="Print" onClick="javascript:window.print();"></form>
			</td>
			<td colspan="2" align="right"><form>
			<input type="button" value="Close Window" onClick="javascript:window.close();"></form>
			</td>
			</tr>
			</table>
		</td>
	</tr>
</table>
</CFOUTPUT>
</body>
</html>
