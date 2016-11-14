<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
<cfquery name="GetAuditLog" datasource="#application.projdsn#">
Select top 2 *
From AuditLog
Order By AuditID desc
</cfquery>
<cfdump var="#GetAuditLog#">

</body>
</html>
