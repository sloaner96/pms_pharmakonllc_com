<!------------
cfc_time_conversion.cfc

Component that changes civilian time to military time and vise versa

10/1/02 - Matt Eaves - Initial Code

--------------------->

<cfcomponent hint="Converts Time String to Appropriate Military or Civilian Time">
	<cffunction name="toMilitary" access="public" returntype="array" hint="Changes Time String to Military Time">
		<cfargument name="BeginHour" type="string" required="true"/>
		<cfargument name="BeginMinute" type="string" required="true"/>
		<cfargument name="BeginMeridiem" type="string" required="true"/>
		<cfargument name="EndHour" type="string" required="true"/>
		<cfargument name="EndMinute" type="string" required="true"/>
		<cfargument name="EndMeridiem" type="string" required="true"/>
		
		<cfif #arguments.BeginMeridiem# EQ 'AM'>
			<cfswitch expression="#arguments.BeginHour#">
				<cfcase value="01"><cfset B_MilitaryHour = "0100"></cfcase>
				<cfcase value="02"><cfset B_MilitaryHour = "0200"></cfcase>
				<cfcase value="03"><cfset B_MilitaryHour = "0300"></cfcase>
				<cfcase value="04"><cfset B_MilitaryHour = "0400"></cfcase>
				<cfcase value="05"><cfset B_MilitaryHour = "0500"></cfcase>
				<cfcase value="06"><cfset B_MilitaryHour = "0600"></cfcase>
				<cfcase value="07"><cfset B_MilitaryHour = "0700"></cfcase>
				<cfcase value="08"><cfset B_MilitaryHour = "0800"></cfcase>
				<cfcase value="09"><cfset B_MilitaryHour = "0900"></cfcase>
				<cfcase value="10"><cfset B_MilitaryHour = "1000"></cfcase>
				<cfcase value="11"><cfset B_MilitaryHour = "1100"></cfcase>
				<cfcase value="12"><cfset B_MilitaryHour = "2400"></cfcase>
			</cfswitch>
		<cfelse>
			<cfswitch expression="#arguments.BeginHour#">
				<cfcase value="12"><cfset B_MilitaryHour = "1200"></cfcase>
				<cfcase value="01"><cfset B_MilitaryHour = "1300"></cfcase>
				<cfcase value="02"><cfset B_MilitaryHour = "1400"></cfcase>
				<cfcase value="03"><cfset B_MilitaryHour = "1500"></cfcase>
				<cfcase value="04"><cfset B_MilitaryHour = "1600"></cfcase>
				<cfcase value="05"><cfset B_MilitaryHour = "1700"></cfcase>
				<cfcase value="06"><cfset B_MilitaryHour = "1800"></cfcase>
				<cfcase value="07"><cfset B_MilitaryHour = "1900"></cfcase>
				<cfcase value="08"><cfset B_MilitaryHour = "2000"></cfcase>
				<cfcase value="09"><cfset B_MilitaryHour = "2100"></cfcase>
				<cfcase value="10"><cfset B_MilitaryHour = "2200"></cfcase>
				<cfcase value="11"><cfset B_MilitaryHour = "2300"></cfcase>
			</cfswitch>
		</cfif>
		
		<cfif #arguments.EndMeridiem# EQ 'AM'>
			<cfswitch expression="#arguments.EndHour#">
				<cfcase value="01"><cfset E_MilitaryHour = "0100"></cfcase>
				<cfcase value="02"><cfset E_MilitaryHour = "0200"></cfcase>
				<cfcase value="03"><cfset E_MilitaryHour = "0300"></cfcase>
				<cfcase value="04"><cfset E_MilitaryHour = "0400"></cfcase>
				<cfcase value="05"><cfset E_MilitaryHour = "0500"></cfcase>
				<cfcase value="06"><cfset E_MilitaryHour = "0600"></cfcase>
				<cfcase value="07"><cfset E_MilitaryHour = "0700"></cfcase>
				<cfcase value="08"><cfset E_MilitaryHour = "0800"></cfcase>
				<cfcase value="09"><cfset E_MilitaryHour = "0900"></cfcase>
				<cfcase value="10"><cfset E_MilitaryHour = "1000"></cfcase>
				<cfcase value="11"><cfset E_MilitaryHour = "1100"></cfcase>
				<cfcase value="12"><cfset E_MilitaryHour = "2400"></cfcase>
			</cfswitch>
		<cfelse>
			<cfswitch expression="#arguments.EndHour#">
				<cfcase value="12"><cfset E_MilitaryHour = "1200"></cfcase>
				<cfcase value="01"><cfset E_MilitaryHour = "1300"></cfcase>
				<cfcase value="02"><cfset E_MilitaryHour = "1400"></cfcase>
				<cfcase value="03"><cfset E_MilitaryHour = "1500"></cfcase>
				<cfcase value="04"><cfset E_MilitaryHour = "1600"></cfcase>
				<cfcase value="05"><cfset E_MilitaryHour = "1700"></cfcase>
				<cfcase value="06"><cfset E_MilitaryHour = "1800"></cfcase>
				<cfcase value="07"><cfset E_MilitaryHour = "1900"></cfcase>
				<cfcase value="08"><cfset E_MilitaryHour = "2000"></cfcase>
				<cfcase value="09"><cfset E_MilitaryHour = "2100"></cfcase>
				<cfcase value="10"><cfset E_MilitaryHour = "2200"></cfcase>
				<cfcase value="11"><cfset E_MilitaryHour = "2300"></cfcase>
			</cfswitch>
		</cfif>
		
		<cfif #arguments.BeginMinute# EQ "30">
			<cfset B_MilitaryMinute = "50">
		<cfelse>
			<cfset B_MilitaryMinute = "00">
		</cfif>
		
		<cfif #arguments.EndMinute# EQ "30">
			<cfset E_MilitaryMinute = "50">
		<cfelse>
			<cfset E_MilitaryMinute = "00">
		</cfif>
				
		<cfset B_MilitaryTime = #B_MilitaryHour# + #B_MilitaryMinute#>
		<cfset E_MilitaryTime = #E_MilitaryHour# + #E_MilitaryMinute#>
		
		<cfset B_MilitaryTime = #ToString(B_MilitaryTime)#>
		<cfset E_MilitaryTime = #ToString(E_MilitaryTime)#>
		
		<cfif #Len(B_MilitaryTime)# EQ 3>
			<cfset B_MilitaryTime = #Insert("0", B_MilitaryTime, 0)#>
		</cfif>
		
		
		
		<cfif #Len(E_MilitaryTime)# EQ 3>
			<cfset E_MilitaryTime = #Insert("0", E_MilitaryTime, 0)#>
		</cfif>
		
		<cfset MilitaryTimeArray = ArrayNew(1)>
		<cfset MilitaryTimeArray[1] = #B_MilitaryTime#>
		<cfset MilitaryTimeArray[2] = #E_MilitaryTime#>

		<cfreturn #MilitaryTimeArray#>
	
	</cffunction>

	<cffunction name="toCivilian" access="public" returntype="array" hint="Changes Military Time to Civilian. Return is array with length of 6.  First 3 are begin time.  Last 3 are end time.">
		<cfargument name="BeginMilitary" type="string" required="true"/>
		<cfargument name="EndMilitary" type="string" required="true"/>
				
		<!---Pull out the hour and minutes seperately from the Military times.---->
		<cfset B_CivilianHour = #Left(BeginMilitary, 2)#>
		<cfset B_CivilianMinute = #Mid(BeginMilitary, 3, 2)#>
		<cfset E_CivilianHour = #Left(EndMilitary, 2)#>
		<cfset E_CivilianMinute = #Mid(EndMilitary, 3, 2)#>
		
		<!-----Set the Minutes---->
		<cfset B_Minute = "00">
		<cfif B_CivilianMinute EQ "50">
			<cfset B_Minute = "30">
		</cfif>
		
		<cfset E_Minute = "00">
		<cfif E_CivilianMinute EQ "50">
			<cfset E_Minute = "30">
		</cfif>
	
		<cfset B_Hour = #B_CivilianHour#>
		<cfset E_Hour = #E_CivilianHour#>
		
		<!----If hour is < 12, the hour is the same. ex. 0100 == 1:00AM---->
		<cfset B_Meridiem = "PM">
		<cfif #B_Hour# GT 12 AND #B_Hour# NEQ 24>
			<cfset B_Hour = #B_Hour# - 12>
		<cfelseif #B_Hour# GT 12 AND #B_Hour# EQ 24>
			<cfset B_Hour = #B_Hour# - 12>
			<cfset B_Meridiem = "AM">
		<cfelseif #B_Hour# EQ 12>
			<cfset B_Meridiem = "PM">
		<cfelse>
			<cfset B_Meridiem = "AM">
		</cfif>
		
		<cfset E_Meridiem = "PM">
		<cfif #E_Hour# GT 12 AND #E_Hour# NEQ 24>
			<cfset E_Hour = #E_Hour# - 12>
		<cfelseif #E_Hour# GT 12 AND #E_Hour# EQ 24>
			<cfset E_Hour = #E_Hour# - 12>
			<cfset E_Meridiem = "AM">
		<cfelseif #E_Hour# EQ 12>
			<cfset E_Meridiem = "PM">
		<cfelse>
			<cfset E_Meridiem = "AM">
		</cfif>
	
	<cfset CivilianTimeArray = ArrayNew(1)>
	<cfset CivilianTimeArray[1] = #ToString(B_Hour)#>
	<cfset CivilianTimeArray[2] = #ToString(B_Minute)#>
	<cfset CivilianTimeArray[3] = #ToString(B_Meridiem)#>
	<cfset CivilianTimeArray[4] = #ToString(E_Hour)#>
	<cfset CivilianTimeArray[5] = #ToString(E_Minute)#>
	<cfset CivilianTimeArray[6] = #ToString(E_Meridiem)#>
	
	<cfreturn #CivilianTimeArray#>
	
	</cffunction>
	
	<cffunction name="ConCatTime" access="public" returntype="string" hint="Converts the seperate strings of Civilan Time to two string, begin and end">
		<cfargument name="cfcTime" type="array" required="true"/>
	
			<cfset StartTime = #arguments.cfcTime[3]#>
			<cfset StartTime = #Insert(#arguments.cfcTime[2]#, #StartTime#, 0)#>
			<cfset StartTime = #Insert(":", #StartTime#, 0)#>
			<cfset StartTime = #Insert(#arguments.cfcTime[1]#, #StartTime#, 0)#>
			<cfset EndTime = #arguments.cfcTime[6]#>
			<cfset EndTime = #Insert(#arguments.cfcTime[5]#, #EndTime#, 0)#>
			<cfset EndTime = #Insert(":", #EndTime#, 0)#>
			<cfset EndTime = #Insert(#arguments.cfcTime[4]#, #EndTime#, 0)#>
			<cfset TheTime = #Insert(" - ", #EndTime#, 0)#>
			<cfset TheTime = #Insert(#StartTime#, #TheTime#, 0)#>
			
		<cfreturn #TheTime#>
	</cffunction>

</cfcomponent>
