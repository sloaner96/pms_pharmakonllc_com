<cfcomponent displayname="Speakers" output="No">
      
   <!--- lock name is the name used to wrap file io/data ops --->
	<cfset LOCK_NAME = "speaker_cfc">

	<!--- Constructor --->
	<cfset init()>
	
	<!--- Initialize datasources --->
	<cfset instance.spkrDSN = "speakers">
	
   <!--------------------------- 
     Initialize the component 
	 --------------------------->
   <cffunction name="init" output="true" returnType="boolean" access="public"
				hint="Handles initialization.">
	      <cfset instance.initialized = true>
	      <cfreturn instance.initialized />
   </cffunction>
   <!---*******************************************
     Get the Speaker Information based on speaker ID 
	********************************************--->
   <cffunction name="getSpeaker" access="remote" returntype="query">
      <cfargument name="SpeakerID" type="numeric" required="No">
	  
	  <cfquery name="getspeaker" datasource="#instance.spkrdsn#">
		  SELECT * 
		  FROM spkr_table 
		  <cfif IsDefined("Arguments.SpeakerID")>
		  WHERE speaker_id = #Arguments.SpeakerID#
		  </cfif>
	  </cfquery>
	  
	  <cfreturn getSpeaker />
   </cffunction>
   
    <cffunction name="getProjectSpeaker" access="public" returntype="query">
      <cfargument name="projectCode" type="string" required="YES">
	  <cfargument name="year" type="string" required="YES">
	  <cfargument name="month" type="string" required="YES">
	  <cfargument name="day" type="string" required="YES">
	  
	  <cfquery name="getspeaker" datasource="#instance.spkrdsn#">
		     SELECT a.id, a.rowid, st.firstname, st.lastname, st.speaker_id, st.type, sc.client_code, sc.rowid as spkrrow, sc.fee
				FROM availability a, spkr_table st, speaker_clients sc
				WHERE active = 'ACT' 
				    AND a.id = sc.owner_id
					AND sc.client_code = '#Left(arguments.projectcode, 5)#'
					AND a.id = st.speaker_id
					AND a.year=#arguments.year#
					AND a.month=#arguments.month#
					AND a.x#arguments.day#=1
					AND st.type='SPKR'
				ORDER BY st.lastname, st.firstname
	  </cfquery>
	  
	  <cfreturn getSpeaker />
   </cffunction>

   
</cfcomponent>