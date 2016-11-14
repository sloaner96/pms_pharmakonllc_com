<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Edit Client</title>
	<style>
	BODY, TD {font-family : Verdana, Arial, sans-serif ;font-size : 8pt;}
	TH {
		font-family : Verdana, Arial, sans-serif ;
		font-size : 9pt;
		color: navy;
		text-align : right;
		font-weight : bold;
	}
	A {	text-decoration: none; color: blue;}
	A:Hover {text-decoration: underline;color: red;}
</style>

</head>



<cfoutput><BODY bgcolor="##FBF9EB"></cfoutput>

	
<cfquery name="qclients" datasource="#application.speakerDSN#">
	SELECT 	clients.client_id, clients.client_name, speaker_clients.client
	FROM 	clients, speaker_clients
	WHERE	clients.client_id *= speaker_clients.client AND speaker_clients.speakerid = #speakerid# AND speaker_clients.type = 'SPKR'
	ORDER BY	clients.client_name	
</cfquery>

<cfform action="spkr_edit_client_action.cfm?speakerid=#URLEncodedFormat(speakerid)#&no_menu='1'" method="POST" enablecab="Yes">
<table width="80%" border="0" cellspacing="2" cellpadding="2">
<tr>
	<td><b>Speaker ID:&nbsp;&nbsp;</b><cfoutput>#speakerid#</cfoutput></td>
</tr>
<tr BGCOLOR="eeeecc">
	<td colspan="2"><b><font color="Navy">Clients:</font></b></td>
</tr>	
<tr>
<cfoutput query="qclients">
      		<td> <input type="Checkbox" name="client" value="#qclients.client_id#" <cfif qclients.client EQ qclients.client_id>checked="Yes"</cfif>>#client_name#</td>
		<cfif qclients.CurrentRow MOD 2 IS 0>
		</tr>
		<tr></cfif>
</cfoutput>
</tr>

</table>
<br> <br>
<table width="80%" border="0">
<tr>
<td valign="bottom"><a href="##" onclick="javascript:window.print()"><img name="print" src="../images/print.gif" border="0" align=absmiddle><br><b><font color="Maroon">print</font></b></a></td>

<td valign="bottom"><input type="image" name="Edit" value="Save" src="../images/floppy.gif"><br>
<b><font color="Maroon">save</font></b></td>

<td width="10">&nbsp;</td>

<td align="right"><i><b><a href="spkr_details.cfm?speakerid=#speakerid#" onclick="self.close()">Back to Search</a></b></i></td>
</tr>
</table>
</cfform>





</body>
</html>
