
<cfcomponent>
	<cffunction name="UpdateUnavailable" hint="updates speaker/mod to unavailable at times he has a meeting scheduled" access="public" output="false">
		<cfargument name="savemonth" hint="month that is being updated" type="numeric" required="true"/>
		<cfargument name="saveyear" hint="year that is being updated" type="numeric" required="true"/>
		<cfargument name="id" hint="speaker or moderator id" type="numeric" required="true"/>
		<cfargument name="userid" hint="users id" type="numeric" required="true"/>
		<cfargument name="today" hint="todays date" type="date" required="true"/>
			
		<!--- Pull meeting times that match speaker/mod availability month selected on prior page --->
		<CFQUERY DATASOURCE="#session.dbs#" NAME="check_meetings" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
			SELECT day, start_time, end_time
			FROM schedule_meeting_time
			WHERE (month = #arguments.savemonth# AND year = #arguments.saveyear#) 
			AND (staff_id = #arguments.id#)
		</CFQUERY>
		
		<!--- If the moderator/speaker has meetings scheduled for that month, mark those times unavailable  --->
		<cfif check_meetings.recordcount>
			<!--- loop number of meetings found --->	
			<cfloop query="check_meetings">
				
				<!--- set variable with start time --->
				<cfoutput>
					<cfset xcolumn = #check_meetings.start_time#>
				</cfoutput>
			
			<!--- set times to unavailable if a meeting is already scheduled --->
				<CFQUERY DATASOURCE="#session.spkrdbs#" NAME="update_newtimes" USERNAME="#session.spkrdbu#" PASSWORD="#session.spkrdbp#">
					UPDATE availability_time
					SET <CFLOOP CONDITION="xcolumn LTE check_meetings.end_time">x#xcolumn# = 0, 
						<cfset xcolumn = xcolumn + 50>
							<cfif #Len(xcolumn)# EQ 3>
								<cfset xcolumn = '0#xcolumn#'>
							<cfelseif #Len(xcolumn)# EQ 2>
								<cfset xcolumn = '00#xcolumn#'>
							</cfif>
						</cfloop>updated = #arguments.today#, updated_userid = #arguments.userid#, allday = 2
					WHERE (month = #arguments.savemonth# AND year = #arguments.saveyear# AND day = #check_meetings.day#) AND owner_id = #arguments.ID#
				</CFQUERY>
	
			</cfloop>
		</cfif>
	</cffunction>
	
	<cffunction name="PullUnavailable" hint="pulls meetings assigned to this speaker/mod for the requested month" access="public" returntype="array">
		<cfargument name="savemonth" hint="month that is being updated" type="numeric" required="true"/>
		<cfargument name="saveyear" hint="year that is being updated" type="numeric" required="true"/>
		<cfargument name="saveday" hint="day that is being updated" type="numeric" required="true"/>
		<cfargument name="id" hint="speaker or moderator id" type="numeric" required="true"/>
		<cfargument name="userid" hint="users id" type="numeric" required="true"/>
		<cfargument name="today" hint="todays date" type="date" required="true"/>
			
		<!--- Pull meeting times for specific day for this mod/spkr--->
		<CFQUERY DATASOURCE="#session.dbs#" NAME="check_meetings" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
			SELECT day, start_time, end_time
			FROM schedule_meeting_time
			WHERE (month = #arguments.savemonth# AND year = #arguments.saveyear# AND day = #arguments.saveday#) AND (speaker_id = #arguments.id# OR moderator_id = #arguments.id#)
		</CFQUERY>
		
		<!--- If the moderator/speaker has meetings scheduled for that day, put the times in an array  --->
		<cfif check_meetings.recordcount>
				<CFSET aMeetings=ArrayNew(2)>
				<cfset i = 1>

			<!--- loop number of meetings found --->	
			<cfloop query="check_meetings">
				
				<!--- set variable with start time --->
				<cfoutput>
					<cfset xcolumn = #check_meetings.start_time#>
					<!--- variable i holds array row number --->
					
				</cfoutput>
			
			<!--- set set array with times of meetings --->
				<CFLOOP CONDITION="xcolumn LTE check_meetings.end_time">
						<cfset aMeetings[#i#][1] = #check_meetings.day#>
						<cfset aMeetings[#i#][2] = #arguments.savemonth#>
						<cfset aMeetings[#i#][3] = #xcolumn#>  
						<cfset xcolumn = xcolumn + 50>
						<cfif #Len(xcolumn)# EQ 3>
								<cfset xcolumn = '0#xcolumn#'>
							<cfelseif #Len(xcolumn)# EQ 2>
								<cfset xcolumn = '00#xcolumn#'>
							</cfif>
						<cfset i = i + 1>
				</cfloop>
	
			</cfloop>
			<!--- if no meetings are scheduled, set array [1][1] to 0 --->
			<cfelse>
			<cfset aMeetings[1][1] = "0">
		</cfif>
		<cfreturn aMeetings>
	</cffunction>	
</cfcomponent>