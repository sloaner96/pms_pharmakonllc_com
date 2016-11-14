
<!----------------------------------------------------------------------------
 venu_edit_bridge.cfm 
 This page closes the  popup pages and refreshes the venue details page
 ------------------------------------------------------------------------------
 --->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<cfoutput>
<cfset venu_edit_url = "venu_details.cfm?venue_id=#venue_id#"></cfoutput>


<html>
<head>
	<title>Venue Edit Bridge</title>
	
<cfoutput>
<script language="JavaScript">
function redirect(){
window.opener.location.href="#venu_edit_url#";
self.close();
}
</script>
</cfoutput>	
</head>
	
<body onload="redirect();"></body>


</html>
