<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<!----------------------------------------------------------------------------
	spkr_Edit_product.cfm
	Form fields to edit client info. Clients are the companies speakers work for. Also have fields for fees and comments.
	
	lb060201-  Initial code.
	lb091002 - changed client and product codes to client_code
------------------------------------------------------------------------------
--->
<head>


	<title>Edit Product/Clients</title>

<LINK REL="stylesheet" HREF="speakerstyle.css" TYPE="text/css">

<cfset edit_action="edit">
</head>




<BODY bgcolor="#FBF9EB">


<!--- pulls clients and products that speaker works for
This query pulls from both projman and speaker dbs --->	
<cfquery name="qgetclients" datasource="#application.projdsn#">
	SELECT 	s.client_code, s.comments, c.client_code_description, s.fee, s.rowid
	FROM speaker.dbo.speaker_clients s, projman.dbo.client_code c
	WHERE s.speakerid = #speakerid# AND s.type = 'SPKR' AND c.client_code = s.client_code
	ORDER By c.client_code
</cfquery>


<table border="0" cellspacing="0" cellpadding="2">
<tr>
	<td colspan="3"><b>Speaker ID:&nbsp;&nbsp;</b><cfoutput>#speakerid#</cfoutput></td>
</tr>
<tr>
	<td colspan="4">&nbsp;</td>
</tr>
<tr><td colspan="4"><font color="#000080"><strong>To edit an existing client/product, make appropriate changes below and hit Edit. </strong></font></td></tr>
<tr>
	<td colspan="4">
	<cfoutput>
	<cfform action="spkr_add_product.cfm?speakerid=#URLEncodedFormat(speakerid)#&no_menu='1'">
	<strong><font color="##000080">To add a new client/product, click the Add button.</font></strong>&nbsp;&nbsp;

<INPUT TYPE="submit"  NAME="add" VALUE="Add">

</cfform>
</cfoutput>
</td>
</tr>
<cfform action="spkr_edit_product_action.cfm?speakerid=#URLEncodedFormat(speakerid)#&no_menu='1'&edit_action=edit" method="POST" enablecab="Yes" name="edit_product">
<tr>
	<td height="20" colspan="4">&nbsp;</td>
</tr>
</table>
<table bgcolor="navy" cellpadding="1" cellspacing="0">
<tr><td>
<table border="0" cellspacing="0" cellpadding="2">
<tr>
	<td height="20" BGCOLOR="#FBF9EB"><strong>Client</strong></td>
	<td BGCOLOR="#FBF9EB"><strong>&nbsp;&nbsp;Fee</strong></td>
	<td colspan="2" BGCOLOR="#FBF9EB"><strong>Comments</strong></td>
</tr>

<cfoutput query="qgetclients">
<cfif qgetclients.CurrentRow mod 2 EQ 0>
	<tr BGCOLOR="##FBF9EB">  
	  <cfelse>
	<tr BGCOLOR="eeeecc">
	</cfif>	
    <td width="200">#qgetclients.client_code# -<br>#qgetclients.client_code_description#
	<input type="hidden" name="rowid#qgetclients.CurrentRow#" value="#qgetclients.rowid#">
	</td>
	<td width="120">$<input type="text" name="fee#qgetclients.CurrentRow#" size="10" value="#DecimalFormat(qgetclients.fee)#">
	</td>
	<td width="250"><input type="text" name="comments#qgetclients.CurrentRow#" size="45" <cfif #qgetclients.comments# is "">value="  "<cfelse> value="#qgetclients.comments#"></cfif></td>
	<td width="10"><a href="spkr_Edit_Product_action.cfm?rowid=#qgetclients.rowid#&speakerid=#URLEncodedFormat(speakerid)#&no_menu='1&edit_action=delete">DELETE</a></td>
</tr>
</cfoutput>
<tr BGCOLOR="#FBF9EB"><td colspan="4">&nbsp;</td></tr>
	</td></tr>	

</table>
</td></tr>
</table>
<br> <br>
<table width="80%" border="0">
<tr>
<td width="83" align="center" valign="top">
<INPUT TYPE="submit"  NAME="edit" VALUE="Edit">
</cfform>
</td>

<td width="83" align="center" valign="top">
<form action="spkr_details.cfm?speakerid=#speakerid#">
<cfoutput>
<INPUT TYPE="submit"  NAME="back" VALUE="Back" onclick="self.close()">
</cfoutput>
</form>
</td>
<td width="83" align="center" valign="top">
<SCRIPT LANGUAGE="JavaScript">
		  <!-- Begin print button
		  if (window.print) {
		  document.write('<form>'
		  + '<input type=button  name=print value="  Print  " '
		  + 'onClick="javascript:window.print()"></form>');
		  }
		  // End print button-->
		  </script>	
</td>
</tr>

</table>






</body>
</html>
