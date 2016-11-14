
<!---------
mod_spkr_AddtoProject2.cfm

Adds client/spkr to database

11/27/02 -- Matt Eaves -- Initial Code
rws101505 - added new header, cleaned up HTML
------------------>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<script language="JavaScript">
function GoBack()
{
	window.open("mod_spkr_AddtoProject.cfm?no_menu=1&<cfoutput>clientID=#form.clientCode#&type=#form.smType#</cfoutput>","_self");
}

</script>
<LINK REL=stylesheet HREF="piw1style.css" TYPE="text/css">
<title>Project Management System || Add Mod/Speaker to Project</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>

<cfquery name="qInsertNewClient" datasource="#application.speakerDSN#">
	Insert into speaker_clients (speakerid, client_code, type, comments, fee)  
	Values(#form.SpkrModID#, '#form.clientCode#', '#form.smType#', '#form.comments#', #LSParseNumber(form.fee)#)
</cfquery>

<center>
	<TABLE ALIGN="Center" BORDER="0" WIDTH="450px" CELLSPACING="0" CELLPADDING="0" style="border: solid 1px navy;">
		<TR>
			<TD ALIGN="Center" class="tdheader" style="border-bottom: solid 1px navy; padding-top: 2px; padding-bottom: 2px;"><strong>Add <cfif #form.smType# EQ "MOD">Moderator<cfelse>Speaker</cfif> to Client <cfoutput>#form.clientCode#</cfoutput></strong></TD>
		</TR>
		<TR>
			<TD ALIGN="Center" style="padding-top: 8px; padding-bottom: 8px;">
				<strong><cfif #form.smType# EQ "MOD">Moderator<cfelse>Speaker</cfif> added succesfully.</strong>
			</td>
		</tr>
	</table>
<br><br>
<input type="button"  value=" Add Another <cfif #form.smType# EQ "MOD">Moderator<cfelse>Speaker</cfif>" onclick="GoBack()">&nbsp; &nbsp; &nbsp; <input type="button"  value=" Close Window " onclick="self.close()">
</center>

</body>
</html>
