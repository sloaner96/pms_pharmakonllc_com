<!----------------------------
cfc_pull_alternates.cfc

When a speaker or moderator conflict arises, this component is called and supplies user with 
alternates who could possibly do meeting. For the most part, the names supplied will be people 
conducting meetings at the same time. If they were available, they would appear in the drop down.

10/10/02 - Matt Eaves - Initial Code

----------------------------->

<cfcomponent hint="Provides user with alternate choices of Moderators or Speakers to do meeting.">
	
	<cffunction name="getCode" hint="Gets Client Code to find people who are qualifed to speak on this product" access="public" output="true" returntype="string">
		<cfargument name="cfcProjCode" type="string" required="true"/>
		
		<!---Pull off the first 5 characters of the project Code to get client code---->
		
		<cfset result = #Mid(#arguments.cfcProjCode#, 1, 5)#>
		
		<cfreturn #result#>
		
	</cffunction>
	
<!---New Function---->	
	<cffunction name="getAlternates" hint="Returns Alternate Speakers/Moderators" access="public" output="true" returntype="query">
		<cfargument name="cfcClientCode" hint="First 5 characters of Project Code" type="string" required="true"/>
		<cfargument name="cfcType" hint="The type of person we are looking for MOD/SPKR" type="string" required="true"/>		
		
		<CFQUERY DATASOURCE="#session.spkrdbs#" NAME="GetSpeakers" USERNAME="#session.spkrdbu#" PASSWORD="#session.spkrdbp#">
			SELECT st.speaker_id, st.firstname, st.lastname
			FROM spkr_table st 
			WHERE st.type = '#arguments.cfcType#' AND st.speaker_id IN (SELECT owner_id FROM speaker_clients sc WHERE sc.client_code = '#arguments.cfcClientCode#')
		</CFQUERY>
		
		<cfreturn #GetSpeakers#>
		
	</cffunction>
	
<!---New Function---->	
	<cffunction name="getSchedule" hint="Returns Speaker/Mod Schedule for that Day" access="public" output="true" returntype="Array">
		<cfargument name="cfcID" hint="Speaker/Mod ID" type="numeric" required="true"/>
		<cfargument name="cfcDay" type="numeric" required="true"/>
		<cfargument name="cfcMonth" type="numeric" required="true"/>
		<cfargument name="cfcYear" type="numeric" required="true"/>
		<cfargument name="cfcTime" type="array" required="true"/>		
		
		<CFQUERY DATASOURCE="#session.dbs#" NAME="Schedule" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">			
			SELECT project_code, start_time, end_time 
			FROM schedule_meeting_time 
			WHERE (staff_id = #arguments.cfcID# OR staff_id = #arguments.cfcID#) 
			AND day = #arguments.cfcDay# 
			AND month = #arguments.cfcMonth# 
			AND year = #arguments.cfcYear# 
			AND status = 0	
		</CFQUERY>
				
		<!---Choosing Return Type as Array, so if recordcount is zero, just return string "Not Scheduled for this Time"--->
		<cfset currentSchedule = ArrayNew(1)>
		
		<cfif #Schedule.recordcount#>
		
			<cfscript>//Lets convert the times before we go back to the calling page.
				oCivTime = createObject("component","cfc_time_conversion");
				NewTimes = oCivTime.toCivilian(BeginMilitary="#Schedule.start_time#",EndMilitary="#Schedule.end_time#");
				TheTime = oCivTime.ConCatTime(#NewTimes#);
			</cfscript>
			
			<cfset currentSchedule[1] = #Schedule.project_code#>
			<cfset currentSchedule[2] = #TheTime#>
		<cfelseif #isDefined("arguments.cfcTime")#>	<!----If they are not scheduled for a meeting at 
													that particular time, lets check their availability---->
			<cfscript>
				oSpkerAvail = createObject("component","cfc_check_available");
				SetGlobals = oSpkerAvail.getAllDay(SpkrModCode="#arguments.cfcID#",cfcYear="#arguments.cfcYear#",cfcMonth="#arguments.cfcMonth#",cfcDay="#arguments.cfcDay#");
				NewTimes = oSpkerAvail.getConflict(SpkrModCode="#arguments.cfcID#",TimeSelected="#arguments.cfcTime#",Year="#cfcyear#",Month="#cfcmonth#",Day="#cfcday#");
			</cfscript>
			
			<cfif #NewTimes# AND #SetGlobals# NEQ 3>
				<cfset currentSchedule[1] = "Availability Conflict">
			<cfelseif NOT #NewTimes# AND #SetGlobals# EQ 3>
				<cfset currentSchedule[1] = "Schedule has not been made.">
			<cfelse>
				<cfset currentSchedule[1] = "Available and not scheduled for this time.">
			</cfif>
				
		<cfelse>
			
			<cfset currentSchedule[1] = "Problem Retreiving Schedule">
		
		</cfif>
		
		<cfreturn #currentSchedule#>
		
	</cffunction>



</cfcomponent>

