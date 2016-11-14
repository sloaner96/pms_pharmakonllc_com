<cfsetting enablecfoutputonly="Yes">

<CFPARAM Name="Attributes.Action"		default="tmp">
<CFPARAM Name="Attributes.Message"		default="<none>">
<CFPARAM Name="Attributes.User"			default="0">
<CFPARAM Name="Attributes.Status"		default="0K">
<CFPARAM Name="Attributes.datasource"	default="PMS">


<cfquery name="LogEntry" datasource="#Attributes.datasource#">
	INSERT into AuditLog
		(DateCreated,
		 ActionMsg, 
		 Status,
		 Message,
		 IPAddress,
		 UserAgent,
		 UserID
		)
	VALUES
		(#CreateODBCDateTime(Now())#,
		 '#Attributes.Action#', 
		  '#Attributes.Status#',
		 '#Attributes.Message#',
		 '#CGI.REMOTE_ADDR#',
		 '#CGI.HTTP_USER_AGENT#',
		 <cfif len(trim(Attributes.User)) GT 0>#Attributes.User#<cfelse>0</cfif>
		)
</cfquery>

<cfsetting enablecfoutputonly="No">
