
<!----------------------------------------------------------------------------
 mod_edit_bridge.cfm 
 This page closes the  popup pages and refreshes the moderator details page
 ------------------------------------------------------------------------------
 --->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<cfoutput>
<cfset mod_edit_url = "mod_details.cfm?speakerid=#speakerid#"></cfoutput>


<html>
<head>
	<title>Moderator Edit Bridge</title>
	
<cfoutput>
<script language="JavaScript">
function redirect(){
window.opener.location.href="#mod_edit_url#";
self.close();
}
</script>
</cfoutput>	
</head>
	
<body onload="redirect();"></body>


</html>
