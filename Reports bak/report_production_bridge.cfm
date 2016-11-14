<!--- *****************************************************************************************
	Name:		report_production_bridge.cfm
	
	Function:	This page sets session variables and sends user to appropriate report forms 
				based on the criteria selected on report_production_select.cfm. This page is 
				not viewed by user.
	History:	lb111202 - complete
	
	*****************************************************************************************--->
<html>
<head>
<title>Report Production Bridge</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

		<!--- Defines variables needed for reports --->
		<CFLOCK SCOPE="SESSION" TIMEOUT="30" TYPE="EXCLUSIVE">
		
			<CFSET session.begin_date = #CreateDate(form.begin_year,form.begin_month,1)#>
			<CFSET session.end_date = #CreateDate(form.end_year,form.end_month,1)#>
			<CFSET session.begin_month = #form.begin_month#>
			<CFSET session.begin_year = #form.begin_year#>
			<CFSET session.end_month = #form.end_month#>
			<CFSET session.end_year = #form.end_year#>
			<CFSET session.query_id = #form.query_id#>
			<CFSET session.display = #form.display#>
			<!--- If no select criteria is defined, set select_criteria to 0 (all) --->
			<cfif isDefined("form.select_criteria")>
				<CFSET session.select_criteria = #form.select_criteria#>
			<cfelse>
				<CFSET session.select_criteria = 0>
			</cfif>
			
		</CFLOCK>

</head>

<body>
<cfswitch expression="#session.query_id#">
	<!--- report by project code --->
	<cfcase value="1">
		<cflocation url="report_production_project.cfm">
	</cfcase>
	<!--- moderator report --->
	<cfcase value="2">
		<cflocation url="report_moderator_status.cfm?no_menu=1" addtoken="no">
	</cfcase>
	<!--- speaker report --->
	<cfcase value="3">
		<cflocation url="report_speaker_status.cfm?no_menu=1" addtoken="no">
	</cfcase>
	<!--- Recruiter Report --->
	<cfcase value="4">
		<cflocation url="report_production_recruiter.cfm">
	</cfcase>
	<!--- Teleconference Co. Report --->
	<cfcase value="5">
		<cflocation url="report_production_teleco.cfm">
	</cfcase>
	<!--- report by client --->
	<cfcase value="6">
		<cflocation url="report_production_client.cfm">
	</cfcase>
	
	
</cfswitch>
</body>
</html>
