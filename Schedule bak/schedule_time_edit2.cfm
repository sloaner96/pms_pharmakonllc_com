<html>
<head>
<title>Update Time</title>

<!--- update available times --->
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="Udpdate_Times">
		UPDATE availability_time
	SET  x0100 = <cfif IsDefined("form.x0100")>1<cfelse>0</cfif>,
	x0150 = <cfif IsDefined("form.x0150")>1<cfelse>0</cfif>,
	x0200 = <cfif IsDefined("form.x0200")>1<cfelse>0</cfif>,
	x0250 = <cfif IsDefined("form.x0250")>1<cfelse>0</cfif>,
	x0300 = <cfif IsDefined("form.x0300")>1<cfelse>0</cfif>,
	x0350 = <cfif IsDefined("form.x0350")>1<cfelse>0</cfif>,
	x0400 = <cfif IsDefined("form.x0400")>1<cfelse>0</cfif>,
	x0450 = <cfif IsDefined("form.x0450")>1<cfelse>0</cfif>,
	x0500 = <cfif IsDefined("form.x0500")>1<cfelse>0</cfif>,
	x0550 = <cfif IsDefined("form.x0550")>1<cfelse>0</cfif>,
	x0600 = <cfif IsDefined("form.x0600")>1<cfelse>0</cfif>,
	x0650 =<cfif IsDefined("form.x0650")>1<cfelse>0</cfif>, 
	x0700 =<cfif IsDefined("form.x0700")>1<cfelse>0</cfif>,
	x0750 =<cfif IsDefined("form.x0750")>1<cfelse>0</cfif>, 
	x0800 =<cfif IsDefined("form.x0800")>1<cfelse>0</cfif>,
	x0850 =<cfif IsDefined("form.x0850")>1<cfelse>0</cfif>, 
	x0900 =<cfif IsDefined("form.x0900")>1<cfelse>0</cfif>,
	x0950 =<cfif IsDefined("form.x0950")>1<cfelse>0</cfif>, 
	x1000 =<cfif IsDefined("form.x1000")>1<cfelse>0</cfif>,
	x1050 =<cfif IsDefined("form.x1050")>1<cfelse>0</cfif>, 
	x1100 =<cfif IsDefined("form.x1100")>1<cfelse>0</cfif>,
	x1150 =<cfif IsDefined("form.x1150")>1<cfelse>0</cfif>, 
	x1200 =<cfif IsDefined("form.x1200")>1<cfelse>0</cfif>,
	x1250 =<cfif IsDefined("form.x1250")>1<cfelse>0</cfif>, 
	x1300 =<cfif IsDefined("form.x1300")>1<cfelse>0</cfif>,
	x1350 =<cfif IsDefined("form.x1350")>1<cfelse>0</cfif>, 
	x1400 =<cfif IsDefined("form.x1400")>1<cfelse>0</cfif>,
	x1450 =<cfif IsDefined("form.x1450")>1<cfelse>0</cfif>, 
	x1500 =<cfif IsDefined("form.x1500")>1<cfelse>0</cfif>,
	x1550 =<cfif IsDefined("form.x1550")>1<cfelse>0</cfif>, 
	x1600 =<cfif IsDefined("form.x1600")>1<cfelse>0</cfif>,
	x1650 =<cfif IsDefined("form.x1650")>1<cfelse>0</cfif>, 
	x1700 =<cfif IsDefined("form.x1700")>1<cfelse>0</cfif>,
	x1750 =<cfif IsDefined("form.x1750")>1<cfelse>0</cfif>, 
	x1800 =<cfif IsDefined("form.x1800")>1<cfelse>0</cfif>,
	x1850 =<cfif IsDefined("form.x1850")>1<cfelse>0</cfif>, 
	x1900 =<cfif IsDefined("form.x1900")>1<cfelse>0</cfif>,
	x1950 =<cfif IsDefined("form.x1950")>1<cfelse>0</cfif>, 
	x2000 =<cfif IsDefined("form.x2000")>1<cfelse>0</cfif>,
	x2050 =<cfif IsDefined("form.x2050")>1<cfelse>0</cfif>, 
	x2100 =<cfif IsDefined("form.x2100")>1<cfelse>0</cfif>, 
	x2150 =<cfif IsDefined("form.x2150")>1<cfelse>0</cfif>, 
	x2200 =<cfif IsDefined("form.x2200")>1<cfelse>0</cfif>, 
	x2250 =<cfif IsDefined("form.x2250")>1<cfelse>0</cfif>, 
	x2300 =<cfif IsDefined("form.x2300")>1<cfelse>0</cfif>,
	x2350 =<cfif IsDefined("form.x2350")>1<cfelse>0</cfif>,
	x2400 =<cfif IsDefined("form.x2400")>1<cfelse>0</cfif>,
	x0050 =<cfif IsDefined("form.x0050")>1<cfelse>0</cfif>,
	allday = #form.allday#,
	u_reason =<cfif IsDefined("form.u_reason")>#form.u_reason#<cfelse>0</cfif>,
	<cfif IsDefined("form.comments")>comments = '#form.comments#',</cfif> 
	updated = #Now()#, 
	updated_userid = #session.userinfo.rowid#
	WHERE rowid = #form.rowid# 
</cfquery>

<!--- update availability table - marks whole day available or unavailable --->
	<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="Update_Day">
	UPDATE availability
	SET x#url.day# = <cfif form.allday EQ 0>0<cfelse>1</cfif>
	WHERE ID = #url.id# AND year = #url.year# AND month = #url.month#
	</cfquery>	

<!--- this method checks to see if the mod/speaker has any meetings scheduled for this month. If so, keep those times
are marked unavailable --->
	<cfinvoke
		component="pms.com.cfc_checkdates" 
		method="UpdateUnavailable" 
		savemonth="#url.month#"
		saveyear="#url.year#"
		id="#url.ID#"
		today="#createodbcdate(Now())#"
		userid="#session.userinfo.rowid#"
	>

</head>

<body>
	<!--- send back to time display --->
	<cflocation url="schedule_time_add.cfm?ID=#ID#&no_menu=1&day=#url.Day#&month=#url.month#&year=#url.year#">
</body>
</html>
