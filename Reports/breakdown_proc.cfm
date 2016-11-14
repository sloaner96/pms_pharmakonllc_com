<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<cfquery name="getactivemod" datasource="#application.speakerDSN#">
		SELECT DISTINCT speakerid, 
		                lastname, 
						firstname
						From Speaker
						Where type ='MOD' 
						and active ='yes'
						order by lastname
</cfquery> 




<cfoutput>
<html>
<head>
<link rel="stylesheet" type="text/css" media="all" href="/includes/styles/schedule.css" title="tas" />
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<body>
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Weekly Breakdown Report" showCalendar="1">
<!--- <cfcontent type="application/vnd.ms-excel"> --->
	<TABLE ALIGN="Center" BORDER="0" CELLPADDING="3" CELLSPACING="1">
			<TR> 
				<TD align="center" valign="top">
<br><br><br><br>
UNDER CONSTRUCTION<br><br><br><br><br>
		</TD>
			</TR>
		</TABLE>
		
		<!--- </cfcontent> --->
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
	</body>	
</html>
</cfoutput>