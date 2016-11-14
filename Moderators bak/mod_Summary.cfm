<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Search for Speaker" showCalendar="0">


 <link rel="stylesheet" type="text/css" media="all" href="/includes/styles/schedule.css" title="tas" />
<!--- <script language="JavaScript">
function OpenNewWindow()
{
	window.open('mod_MOD_AddtoProject.cfm?no_menu=1&clientID=<cfoutput>#trim(form.client)#</cfoutput>&type=MOD','','height=300,width=500,toolbar=0,statusbar=no,resizable=no,menubar=0,locationbar=0')
}

</script> --->

<!--- Pulls speaker info based on info selected from previous form --->
<cfquery name="summary" datasource="#application.speakerDSN#">
SELECT DISTINCT
s.speakerid, 
s.lastname, 
s.firstname, 
s.middlename, 
s.degree, 
s.specialty, 
s.type, 
sa.city, 
sa.state, 
sa.speakerid, 
sa.phone1  
<cfif #form.client# NEQ '0'>,sc.clientid</cfif>
FROM 
Speaker s, 
SpeakerAddress sa, 
SpeakerClients sc

WHERE s.speakerid = sa.speakerid AND 
s.type = 'MOD'  
<cfif #form.speaker_name# NEQ '0'>
	AND s.lastname LIKE '#form.speaker_name#%'
</cfif> 
 <cfif #form.client# NEQ '0'>
	AND s.speakerid = sc.speakerid AND s.type = 'MOD' AND sc.clientcode = '#Left(form.client, 5)#'
<cfelse>
	AND s.speakerid *= sc.speakerid AND sc.type = 'MOD' 
</cfif> 
<cfif #form.status# NEQ '0'>
	AND s.active = '#form.status#'
</cfif>
<cfif #form.specialty# NEQ '0'>
	AND s.specialty LIKE '#form.specialty#%'
</cfif>
<cfif #form.city# NEQ '0' AND #form.state# NEQ '0'>
	AND s.speakerid = sa.speakerid AND s.type = 'MOD'  AND sa.city LIKE '#form.city#%' AND sa.state LIKE '#form.state#%'
<cfelseif #form.city# NEQ '0' AND #form.state# EQ '0'>
	AND s.speakerid = sa.speakerid AND s.type = 'MOD'  AND sa.city LIKE '#form.city#%'
<cfelseif #form.city# EQ '0' AND #form.state# NEQ '0'>
	AND s.speakerid = sa.speakerid AND s.type = 'MOD'  AND sa.state LIKE '#form.state#%'
<cfelseif #form.city# EQ '0' AND #form.state# EQ '0'>
	AND s.speakerid = sa.speakerid AND s.type = 'MOD'   
</cfif>	  
ORDER BY s.lastname, s.firstname
</cfquery>

<!--- if no records were found... --->
<cfif #Summary.RecordCount# LT 1>
<body background="images/blue_stripe.jpg">

<table border="0" style="margin-left: 4px;">
	<tr>
		<td align="center" colspan="2"><i><font size="3"><font color="Maroon"><b>Sorry. No records matched your criteria. </b></font></font></i></td>
	</tr>
	<tr>
		<td height="25" colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td width="200" align="center" valign="top">
			<form action="../Search/dsp_searchMod.cfm">
				<INPUT TYPE="submit"  NAME="Search Again" VALUE="Search Again">
			</form>
		</td>
		<!--- <td width="200" align="center" valign="top">
			<form action="MOD_AddSpeaker.cfm">
				<INPUT TYPE="submit"  NAME="add" VALUE="Add New Speaker">
			</form>
     	</td> --->
		<!--- <td width="200" align="center" valign="top">
			<cfif #form.client# NEQ '0'>
				<INPUT TYPE="button"  VALUE="Add New Speaker to Project" onclick="OpenNewWindow()">
			<cfelse>
				&nbsp;
			</cfif>
		</td> --->
	</tr>
</table>

	
<!--- display summary results --->
<cfelse>
<body> 
<font size="2">
<cfoutput><strong>#summary.recordcount#</strong></cfoutput> Records Found&nbsp;&nbsp;&nbsp;&nbsp;<a href="../Search/dsp_searchSpeaker.cfm"><u>Search Again</u></a><!---  | <a href="javascript:OpenNewWindow()"><u>Add New Speaker</u></a> ---></font><br><br>

<font size="1"><em>Click on Speaker ID to view details.</em></font><br><br>

<table border="0" cellspacing="0" cellpadding="2">
	<tr> 
		<td BGCOLOR="ffffff" width="25">&nbsp;</td>
		<td BGCOLOR="ffffff" width="200" class="searchlabel">Speaker Name</td>
	  	<td BGCOLOR="ffffff" width="150" class="searchlabel">Specialty</td>
		<td BGCOLOR="ffffff" width="150" class="searchlabel">City, State</td>
	  	<td BGCOLOR="ffffff" width="100" class="searchlabel">Office Phone</td>
	</tr>
	  <cfoutput query="Summary">
	  <tr><td colspan="5"></td></tr>
	  <cfif Summary.CurrentRow mod 2 EQ 0>
	<tr align="left" BGCOLOR="ffffff">  
	  <cfelse>
	<tr align="left" class="highlight2">
	</cfif>
	   <TD height="18">&nbsp;</td>
	  	<TD><A HREF="MOD_details.cfm?speakerid=#speakerid#"><u>#lastname#&nbsp;#degree#,&nbsp;#firstname#&nbsp;#middlename#</u></a></td>
		<!--- pulls description for specialty code --->
<cfquery name="qspecialty" datasource="#application.speakerDSN#">
	SELECT description
	FROM codes
	WHERE code_type = 'SPEC' AND code = '#summary.specialty#'
	</cfquery>
		<TD>#qspecialty.description#</td>
	  	<TD>#summary.city#&nbsp;#summary.state#</td>
		<!--- <TD>#First_Name#&nbsp;#Last_Name#</td> --->
	  	<TD>#summary.phone1#</td>
	</tr>
	  </cfoutput>
	</table>
	

	 <br> 
<table border="0" cellpadding="15px" style="margin-left: 4px;">
	<tr>
		<td align="center" valign="top">
			<form action="../Search/dsp_searchMod.cfm">
				<INPUT TYPE="submit"  NAME="Search Again" VALUE="Search Again">
			</form>
		</td>
		<!--- <td align="center" valign="top">
			<input type="button"  name="print" value="  Print  " onClick="javascript:window.print()">
		</td>
		<td align="center" valign="top">
			<form action="MOD_AddSpeaker.cfm">
				<INPUT TYPE="submit"  NAME="add" VALUE="Add New Speaker">
			</form>
      	</td>
		<td align="center" valign="top">
			<cfif #form.client# NEQ '0'>
				<INPUT TYPE="button"  VALUE="Add New Speaker to Project" onclick="OpenNewWindow()">
			<cfelse>
				&nbsp;
			</cfif>
		</td> --->
	</tr>
</table>
	
	</cfif>


 <cfmodule template="#Application.tagpath#/ctags/footer.cfm">
 