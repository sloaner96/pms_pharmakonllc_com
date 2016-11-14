<!----------------------------
cfc_check_available.cfc

Checks to see if speaker or moderator is unavailable based on the meeting time scheduled by the 
user. Component is called from schedule_time_add.cfm.

*****************NOTE*************************
This object uses global variables, if you are calling a function and getting unexpected results, check 
to ensure you are setting the global variables to something other than zero.

10/9/02 - Matt Eaves - Initial Code

----------------------------->

<cfcomponent hint="Checks to see if speaker or moderator is unavailable based on the meeting time scheduled by the user.">
	
	<!----Global Variables------>
	<cfset curYear = 0>
	<cfset curMonth = 0>
	<cfset curDay = 0>
	
	<cffunction name="getAllDay" hint="Checks if Speaker/Mod has all day Scheduled" access="public" output="true" returntype="numeric">
		<cfargument name="SpkrModCode" hint="Speaker/Mod ID" type="numeric" required="true"/>
		<cfargument name="cfcYear" type="numeric" required="true"/>
		<cfargument name="cfcMonth" type="numeric" required="true"/>
		<cfargument name="cfcDay" type="numeric" required="true"/>
		
		<cfset curYear = #arguments.cfcYear#>
		<cfset curMonth = #arguments.cfcMonth#>
		<cfset curDay = #arguments.cfcDay#>
		
		<!------Need to check if Speaker or Moderator has a conflict with time selected based on their availability----->
		<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetDay">
			SELECT allday
			FROM availability_time
			WHERE owner_id = #arguments.SpkrModCode# AND year = #curYear# AND month = #curMonth# AND day = #curDay#
		</CFQUERY>
		
		<cfif #GetDay.recordcount#>
			<cfset result = #GetDay.allday#>
		<cfelse>
			<cfset result = 3>
		</cfif>
		
		
		<cfreturn #result#>
		
	</cffunction>
	
<!---New Function---->	
	<cffunction name="getConflict" hint="Checks if Speaker/Mod is available for certain period of time" access="public" output="true" returntype="boolean">
		<cfargument name="SpkrModCode" hint="Speaker/Mod ID" type="numeric" required="true"/>
		<cfargument name="Year" hint="Meeting Year" type="numeric" required="true"/>
		<cfargument name="Month" hint="Meeting Month" type="numeric" required="true"/>
		<cfargument name="Day" hint="meeting day" type="numeric" required="true"/>
		<cfargument name="TimeSelected" hint="Array of User Selected Time" type="array" required="true"/>
		<cfargument name="cfcBeginTime" hint="Start Time" type="string" required="false"/>
		<cfargument name="cfcEndTime" hint="End Time" type="string" required="false"/>
		
		<cfset upperLimit = #ArrayLen(arguments.TimeSelected)#>
		<cfset conflict = false>
		<cfset count = 0>		
		
		<cfloop from="1" to="#upperLimit#" index="k" step="1">
			<cfif #Len(arguments.TimeSelected[k])# EQ 3>
				<cfset xcolumn = 'x0#arguments.TimeSelected[k]#'>
			<cfelseif #Len(TimeSelected[k])# EQ 2>
				<cfset xcolumn = 'x00#arguments.TimeSelected[k]#'>
			<cfelse>
				<cfset xcolumn = 'x#arguments.TimeSelected[k]#'>
			</cfif>
				
			<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetDays">
				SELECT *
				FROM availability_time
				WHERE owner_id = #arguments.SpkrModCode# 
				AND year = #Year# 
				AND month = #Month# 
				AND day = #Day#
				AND #xcolumn# = 0
				<cfif IsDefined("arguments.cfcBeginTime")>
				AND #xcolumn# != #arguments.cfcBeginTime# AND #xcolumn# != #arguments.cfcEndTime#
				</cfif>	
			</CFQUERY>
			
			<cfif #GetDays.recordcount#>
				<cfset count = #count# + 1>
			</cfif>
		
		</cfloop>
		
		<cfif #count# GT 1>
			<cfset conflict = true>
		</cfif>
		
		<cfreturn #conflict#>
		
	</cffunction>

<!---New Function---->	
	<cffunction name="setMeetingHours" hint="Sets the meeting Times to an array" access="public" output="true" returntype="array">
		<cfargument name="cfcBeginTime" hint="Start Time" type="string" required="true"/>
		<cfargument name="cfcEndTime" hint="End Time" type="string" required="true"/>
		
		<cfset MeetingTimes = ArrayNew(1)>
		<cfset strTime = #arguments.cfcBeginTime#>
		<cfset Diff = #arguments.cfcEndTime# - #arguments.cfcBeginTime#>		
		
		<cfset MeetingTimes[1] = #strTime#>
		<cfif #Diff# GT 0>
		
			<cfif #Diff# EQ 50>
				<cfset MeetingTimes[2] = #arguments.cfcEndTime#>
			<cfelse>
				<cfset upperLimit = #Diff# / 50>
				<cfset upperLimit = #upperLimit# + 1>
				
				<cfloop from="2" to="#upperLimit#" step="1" index="i">
					<cfset MeetingTimes[i] = #MeetingTimes[i - 1]# + 50>
				</cfloop>
				
			</cfif>
						
		<cfelse>
			<!---Going to need something to handle 11:00pm to 1:00am----->
		</cfif>	
		
		<cfreturn #MeetingTimes#>
		
	</cffunction>
	
<!---New Function---->	
	<cffunction name="checkConflict" hint="Checks the conflict to see if the only coflict is an ending or begining hour" access="public" output="true" returntype="boolean">
		<cfargument name="cfcTimeSelected" hint="Array to Time Selected" type="array" required="true"/>
		<cfargument name="cfcSpkrModCode" hint="The Spkr/Mod Code" type="numeric" required="true"/>
		
		<cfset upperLimit = #ArrayLen(arguments.cfcTimeSelected)#>
		<cfset conflict = false>
		<cfset count = 0>
		<cfloop from="1" to="#upperLimit#" index="k" step="1">
			<cfif #Len(arguments.cfcTimeSelected[k])# EQ 3>
				<cfset xcolumn = 'x0#arguments.cfcTimeSelected[k]#'>
			<cfelseif #Len(arguments.cfcTimeSelected[k])# EQ 2>
				<cfset xcolumn = 'x00#arguments.cfcTimeSelectedd[k]#'>
			<cfelse>
				<cfset xcolumn = 'x#arguments.cfcTimeSelected[k]#'>
			</cfif>
		
			<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetDays2">
				SELECT *
				FROM availability_time
				WHERE owner_id = #arguments.cfcSpkrModCode# 
				AND year = #curYear# 
				AND month = #curMonth# 
				AND day = #curDay#
				AND #xcolumn# = 0 	
			</CFQUERY>
			
			<cfif #GetDays2.recordcount#>
				<cfset count = #count# + 1>
			</cfif>
			
		</cfloop>
		
		<cfif count GT 1>
			<cfset conflict = true>
		</cfif>
		
		<cfreturn conflict>
		
	</cffunction>
		


</cfcomponent>

