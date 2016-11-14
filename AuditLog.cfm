<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
<cfquery name="GetAuditLog" datasource="PMS">
  Select *
  From AuditLog
  order by dateCreated
</cfquery>

<cfdump var="#getAuditLog#">


</body>
</html>
