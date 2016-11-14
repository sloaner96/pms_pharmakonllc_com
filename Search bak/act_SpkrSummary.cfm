<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Search for Speaker" showCalendar="0">
<script language="JavaScript">
function OpenNewWindow()
{
	window.open('/schedule/popup_mod_spkr_AddtoProject.cfm?no_menu=1&clientID=<cfoutput>#trim(form.client)#</cfoutput>&type=SPKR','','height=300,width=500,toolbar=0,statusbar=no,resizable=no,menubar=0,locationbar=0')
}

</script>
</head>

<!--- Pulls speaker info based on info selected from previous form --->
<cfquery name="summary" DATASOURCE="#application.speakerDSN#" cachedwithin="#createTimespan(0,0,20,0)#">
SELECT DISTINCT s.speaker_id, s.lastname, s.firstname, s.middleinitial, s.degree, s.specialty, a.mailtocity, a.mailtostate, a.owner_id, p.phone1 
	<cfif form.client NEQ '0'>,c.client_id</cfif>,
	(SELECT description
			FROM codes
			WHERE code_type = 'SPEC' 
			AND code = s.specialty) as SpecialtyDesc
FROM spkr_table S, address A, phone_details P, speaker_clients C
WHERE s.speaker_id *= p.owner_id 
AND p.owner_type = 'SPKR' 
AND s.type = 'SPKR' 
<cfif form.speaker_name NEQ '0'>
	AND (s.lastname LIKE '#form.speaker_name#%')
</cfif>
<cfif form.client NEQ '0'>
	AND s.speaker_id = c.owner_id AND c.owner_type = 'SPKR' AND (c.client_code = '#form.client#')
<!--- <cfelse>
	AND spkr_table.speaker_id *= speaker_clients.owner_id AND speaker_clients.owner_type = 'SPKR' ---> 
</cfif>
<cfif form.status NEQ '0'>
	AND (s.active LIKE '#form.status#%')
</cfif>
<cfif form.specialty NEQ '0'>
	AND (s.specialty LIKE '#form.specialty#%')
</cfif>
 <cfif form.city NEQ '0' AND form.state NEQ '0'>
	AND s.speaker_id = address.owner_id 
	AND a.owner_type = 'SPKR'  
	AND (a.mailtocity LIKE '#form.city#%') 
	AND (a.mailtostate LIKE '#form.state#%')
<cfelseif form.city NEQ '0' AND form.state EQ '0'>
	AND s.speaker_id = a.owner_id 
	AND a.owner_type = 'SPKR'   
	AND (a.mailtocity LIKE '#form.city#%')
<cfelseif form.city EQ '0' AND form.state NEQ '0'>
	AND s.speaker_id = a.owner_id 
	AND a.owner_type = 'SPKR'  
	AND (a.mailtostate LIKE '#form.state#%')
<cfelseif form.city EQ '0' AND form.state EQ '0'>
	AND s.speaker_id *= a.owner_id AND a.owner_type = 'SPKR'   
</cfif>	  
ORDER BY s.lastname, s.firstname
</cfquery>

<!--- if no records were found... --->
<cfif Summary.RecordCount LT 1>
<table border="0" style="margin-left: 4px;">
	<tr>
		<td align="center" colspan="2"><i><font size="3"><font color="Maroon"><b>Sorry. No records matched your criteria. </b></font></font></i></td>
	</tr>
	<tr>
		<td height="25" colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td width="200" align="center" valign="top">
				<INPUT TYPE="button"  NAME="back" VALUE="Search Again" onclick="javascript:history.back(-1);">

		</td>
		<td width="200" align="center" valign="top">
			<form action="/speakers/dsp_AddSpeaker.cfm">
				<INPUT TYPE="submit"  NAME="add" VALUE="Add New Speaker">
			</form>
     	</td>
		<td width="200" align="center" valign="top">
			<cfif form.client NEQ '0'>
				<INPUT TYPE="button"  VALUE="Add New Speaker to Project" onclick="OpenNewWindow()">
			<cfelse>
				&nbsp;
			</cfif>
		</td>
	</tr>
</table>

	
<!--- display summary results --->
<cfelse>
<br>
<cfoutput>Your Search Returned <strong>#Summary.recordcount#</strong> speakers<br></cfoutput>
Click on the speakers name to view more information about the speaker.
<br><br>

<table border="0" cellspacing="1" cellpadding="2" width="100%" bgcolor="#666666">
	<tr bgcolor="#767676"> 
		<td><strong style="color:#ffffff;">Speaker Name</strong></td>
	  	<td><strong style="color:#ffffff;">Specialty</strong></td>
		<td><strong style="color:#ffffff;">City</strong></td>
		<td><strong style="color:#ffffff;">State</strong></td>
	  	<td><strong style="color:#ffffff;">Office Phone</strong></td>
	</tr>
	  <cfoutput query="Summary">
	  
	<tr align="left" <cfif Summary.CurrentRow mod 2 EQ 0>BGCOLOR="##ffffff"<cfelse>BGCOLOR="##efefef"</cfif>>  
	  	<TD><A HREF="/speakers/spkr_details.cfm?speaker_id=#speaker_id#"><b>#lastname#&nbsp;#degree#,&nbsp;#firstname#&nbsp;#middleinitial#</b></a></td>
		<TD>#summary.SpecialtyDesc#</td>
	  	<TD>#summary.mailtocity#</td>
        <TD>#summary.mailtostate#</TD>
	  	<TD>#summary.phone1#</td>
	</tr>
	</cfoutput>
	</table>
	

	 <br> 
	<table border="0" cellpadding="5" align="center">
		<tr>
			<td align="center" valign="top">
					<INPUT TYPE="submit"  NAME="back" VALUE="Back" onclick="javascript:history.back(-1);">
			</td>
			<td align="center" valign="top">
				<input type="button"  name="print" value="  Print  " onClick="javascript:window.print()">
			</td>
			<td align="center" valign="top">
				<form action="/speakers/dsp_AddSpeaker.cfm">
					<INPUT TYPE="submit"  NAME="add" VALUE="Add New Speaker">
				</form>
	      	</td>
			<td align="center" valign="top">
				<!--- <cfif form.client NEQ '0'>
					<INPUT TYPE="button"  VALUE="Add New Speaker to Project" onclick="OpenNewWindow()">
				<cfelse>
					&nbsp;
				</cfif> --->
			</td>
		</tr>
	</table>
</cfif>
 <cfmodule template="#Application.tagpath#/ctags/footer.cfm">