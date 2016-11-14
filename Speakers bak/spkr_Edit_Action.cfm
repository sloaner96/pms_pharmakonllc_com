<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<!----------------------------------------------------------------------------
	mod_Edit_action.cfm
	performs queries to update moderator info: status, region, specialty, first name, middle initial, last name, degree, affiliations/credentials, sex, ss
	
	lb060201-  Initial code.
------------------------------------------------------------------------------
--->
<head>
	<title>Edit Moderator action</title>
	
</head>



<body>
<!--- <cfset commitIt = "yes"> --->

<!--- <CFTRANSaction action="Begin"> --->
<!--- pulls status info - in qUpdatemoderator verify if status was previously inactive and currently inactive. If so, so not update inactive date --->
<cfquery name="qfetch" datasource="#application.speakerDSN#">
	SELECT  active
	FROM   	Speaker  
	WHERE  	Speaker.speakerid =  '#url.speakerid#'
	AND active = 'yes' 
	
	</cfquery>


	<!--- <CFTRY> --->
		<cfquery name="qUpdatemoderator" datasource="#application.speakerDSN#">
			Update Speaker 
			Set firstname		= '#trim(Left(form.firstname, 30))#',
			    lastname		= '#trim(Left(form.lastname, 50))#', 
				middlename	= '#trim(Left(form.middlename, 3))#',
				updated	= #Now()#, 
				updatedby		= '#session.user#', 
				degree			= '#trim(Left(form.degree, 30))#', 
				sex				= '#trim(Left(form.sex, 1))#', 
				travel			= '#trim(Left(form.travel, 5))#', 
				specialty		= '#trim(Left(form.specialty, 5))#', 
				affil			= '#trim(Left(form.affil, 500))#', 
				taxid				= '#trim(Left(form.ss, 11))#', 
				active			= '#form.active#'
				<!--- <cfif form.active EQ 'INyes' AND qfetch.active NEQ 'INyes'>,date_inactive=#Now()#</cfif> --->
			Where speakerid = '#url.speakerid#' 
		</cfquery>
		 <!--- <cfcatch type="Database">
				<Cftransaction action="Rollback"/>
				<CFSET CommitIt = "no"> --->
		<!---  </Cfcatch> --->
<!--- </cftry> --->
<!--- <cfif commitIt EQ "yes">
  <Cftransaction action="COMMIT"/>
   
</cfif> --->

<!--- </cftransaction> --->


<!--- <cfif commitIt EQ "yes"> --->

<cfoutput> 
<cflocation url="spkr_edit.cfm?speakerid=#url.speakerid#" addtoken="No">
</cfoutput> 
<!--- <cfelse>
This Moderator has not been edited. Please Contact IT for assistance.
</cfif> --->
</body>
</html>