<cfapplication name="PMS" clientmanagement="Yes" sessionmanagement="Yes" sessiontimeout="#CreateTimeSpan(1, 0, 0, 60)#"  applicationtimeout="#CreateTimeSpan(1, 0, 0, 60)#">
<cfsilent>
<cfif Not IsDefined("application.REPORTPATH") or isDefined("URL.reint")>
<!--- Set All Global Application Variables  --->
	<cflock scope="application" timeout="50" throwontimeout="no"  type="exclusive">
		<cfset application.projdsn   = "****">
		<cfset application.rosterDSN = "*****">
	    <cfset application.speakerDSN   = "*****">
	    <cfset application.HourDayDSN = "*****">
		<cfset application.MasterDSN  = "*****">
	
		<cfset application.TagPath  = "/PMS">
		<cfset application.Baseurl  = "http://pms.pharmakonllc.com">
		<cfset application.SitePath  = "C:\InetPub\wwwroot\pms_pharmakonllc_com">
		<cfset application.REPORTPATH  = "C:\InetPub\wwwroot\pms_pharmakonllc_com\Reports\Temp">
    </cflock>
</cfif>

<!--- Set All Global Session Variables --->
    <cflock scope="session" timeout="50" throwontimeout="no" type="exclusive">
	     <CFPARAM NAME="session.project_code" DEFAULT="">
		<!--- Application View --->
		  <CFPARAM NAME="session.view" DEFAULT="1">
		<!--- Application Sortby --->
		  <CFPARAM NAME="session.sortby" DEFAULT="eventdate1">
		<!--- Application Order By --->
		  <CFPARAM NAME="session.order" DEFAULT="DESC">
    </cflock>

<!--- Check for Login Status--->
<cfparam name="attributes.IsComponent" default="0">

   <cfif FindNoCase("com",CGI.SCRIPT_NAME, 1) EQ 0>
	   <cfif Not IsDefined("Session.IsLoggedIN")>
		  <cfif FindNoCase('login.cfm',CGI.SCRIPT_NAME, 1) EQ 0 AND FindNoCase('authenticate.cfm',CGI.SCRIPT_NAME, 1) EQ 0>
			     <cfinclude template="login.cfm">
				 <cfabort>
		  </cfif>
		</cfif>
     </cfif>

  <cfif Not IsDefined("application.admin")  or isDefined("URL.reint")>
	<cflock scope="application" type="exclusive" timeout="50">
			<!--- initialize the project component --->
			<CFOBJECT COMPONENT="pms.com.projects"
			          NAME="application.project">
			<!--- initialize the utilities component --->
			<CFOBJECT COMPONENT="pms.com.utilities"
			          NAME="application.util">
			<!--- initialize the utilities component --->
			<CFOBJECT COMPONENT="pms.com.reports"
			          NAME="application.reports">

			<!--- initialize the utilities component --->
			<CFOBJECT COMPONENT="pms.com.speakers"
			          NAME="application.speakers">

			<!--- initialize the utilities component --->
			<CFOBJECT COMPONENT="pms.com.scheduling"
			          NAME="application.scheduling">

			<!--- initialize the utilities component --->
			<CFOBJECT COMPONENT="pms.com.admin"
			          NAME="application.admin">
	</cflock>
</cfif>

    <cflock scope="application" type="read-only" timeout="50">
		<cfset request.project  = application.project>
		<cfset request.util     = application.util>
		<cfset request.reports  = application.reports>
		<cfset request.Schedule = application.scheduling>
		<cfset request.Speakers = application.Speakers>
		<cfset request.Admin    = application.Admin>
	</cflock>


	<!--- TODO:OLD CODE @@@@@@@ REMOVE AT SOME POINT --->
			<CFLOCK SCOPE="SESSION" TIMEOUT="90" TYPE="EXCLUSIVE">

			<!--- Creates variable for project code if not already created with a default value of empty --->
			<CFPARAM NAME="session.project_code" DEFAULT="">

			<!--- Database login info for the Projman Database --->
			<CFPARAM NAME="session.dbs" DEFAULT="PMS">
			<CFPARAM NAME="session.dbn" DEFAULT="PMS">
			<CFPARAM NAME="session.dbu" DEFAULT="******">
			<CFPARAM NAME="session.dbp" DEFAULT="*******">

			<CFPARAM NAME="session.dbstest" DEFAULT="PMStest">
			<CFPARAM NAME="session.dbntest" DEFAULT="PMStest">
			<CFPARAM NAME="session.dbutest" DEFAULT="******">
			<CFPARAM NAME="session.dbptest" DEFAULT="******">

			<CFPARAM NAME="session.solvaydbs" DEFAULT="******">
			<CFPARAM NAME="session.solvaydbn" DEFAULT="******">
			<CFPARAM NAME="session.solvaydbu" DEFAULT="******">
			<CFPARAM NAME="session.solvaydbp" DEFAULT="******">


			<CFPARAM NAME="session.rosterdbs" DEFAULT="******">
			<CFPARAM NAME="session.rosterdbn" DEFAULT="******">
			<CFPARAM NAME="session.rosterdbu" DEFAULT="******">
			<CFPARAM NAME="session.rosterdbp" DEFAULT="******">


			<!--- Application View --->
			<CFPARAM NAME="session.view" DEFAULT="1">
			<!--- Application Sortby --->
			<CFPARAM NAME="session.sortby" DEFAULT="eventdate1">
			<!--- Application Order By --->
			<CFPARAM NAME="session.order" DEFAULT="DESC">
			<CFPARAM NAME="session.year" DEFAULT="#dateformat(now(), "YYYY")#">

			<!--- Database login info for the Speaker Database --->
			<CFPARAM NAME="session.spkrdbs" DEFAULT="******">
		    <CFPARAM NAME="session.spkrdbn" DEFAULT="******">
		    <CFPARAM NAME="session.spkrdbu" DEFAULT="******">
		    <CFPARAM NAME="session.spkrdbp" DEFAULT="******">

			<!--- Database login info for the Hourday Database --->
			<CFPARAM NAME="session.login_dbs" DEFAULT="******">
		    <CFPARAM NAME="session.login_dbn" DEFAULT="******">
		    <CFPARAM NAME="session.login_dbu" DEFAULT="******">
		    <CFPARAM NAME="session.login_dbp" DEFAULT="******">
		</CFLOCK>

		<!--- set application variables to hold Bob's and Howard's ids for PO approval --->
			<cfset application.cliapp = 98>
			<cfset application.accapp = 133>

			<cfif NOT IsDefined("session.nospeaker")></cfif>
	            <cfset session.nospeaker = "AD,AT,CD,CT,CU,DM,DR,ET,IV,LG,MD,MP,MT,RT,OT,WB,WS">

</cfsilent>