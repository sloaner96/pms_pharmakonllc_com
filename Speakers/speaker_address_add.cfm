<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<!--- <CFQUERY DATASOURCE="#application.speakerDSN#" NAME="select_rows">
Select s.speakerid
From Speaker s, address a
WHERE s.speakerid *= a.speakerid AND a.speakerid is Null
</cfquery>

<cfoutput query="select_rows">

<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="add_rows">
INSERT address(speakerid, type)		
	VALUES('#select_rows.speakerid#', 'SPKR')
</cfquery>
	
</cfoutput> --->

<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="select_rows">
	SELECT b.*
	FROM SpeakerAddress a, address b
	WHERE a.speakerid = b.speakerid AND (a.city Is Not Null AND b.city Is Null);
</cfquery>

<cfoutput query="select_rows">
	#select_rows.speakerid#<br>
</cfoutput>
<cfoutput>#select_rows.recordcount#</cfoutput>
</body>
</html>
