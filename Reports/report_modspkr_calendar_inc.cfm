<!--------------
report_moderspkr_calendar_inc.cfm

This is an include for report_modspkr_calendar2.cfm, for the unavailable portion.

Just to make the code more readable.  No real functionality gain by segregating this code.

------------------------>
<cfset TheDate = CreateDate(#form.select_year#, #form.select_month#, #DayNumbers#)>
<cfset intDayofWeek = DayOfWeek(TheDate)>
<cfif getunavailable.allday EQ 0 >
	<cfif intDayofWeek EQ 1 OR intDayofWeek EQ 6 OR intDayofWeek EQ 7>
	&nbsp;
	<cfelse>
		Unavialable All Day
	</cfif>
<cfelse>
	<cfset UnavailableArray = ArrayNew(1)>
	<cfset count = 1>
	<cfif getunavailable.x0500 EQ 0>
		<cfset UnavailableArray[count] = "5:00AM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x0550 EQ 0>
		<cfset UnavailableArray[count] = "5:30AM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x0600 EQ 0>
		<cfset UnavailableArray[count] = "6:00AM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x0650 EQ 0>
		<cfset UnavailableArray[count] = "6:30AM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x0700 EQ 0>
		<cfset UnavailableArray[count] = "7:00AM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x0750 EQ 0>
		<cfset UnavailableArray[count] = "7:30AM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x0800 EQ 0>
		<cfset UnavailableArray[count] = "8:00AM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x0850 EQ 0>
		<cfset UnavailableArray[count] = "8:30AM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x0900 EQ 0>
		<cfset UnavailableArray[count] = "9:00AM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x0950 EQ 0>
		<cfset UnavailableArray[count] = "9:30AM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x1000 EQ 0>
		<cfset UnavailableArray[count] = "10:00AM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x1050 EQ 0>
		<cfset UnavailableArray[count] = "10:30AM">
		<cfset count = #count# + 1>
	</cfif>	
	<cfif getunavailable.x1100 EQ 0>
		<cfset UnavailableArray[count] = "11:00AM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x1150 EQ 0>1
		<cfset UnavailableArray[count] = "1:30AM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x1200 EQ 0>
		<cfset UnavailableArray[count] = "12:00PM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x1250 EQ 0>
		<cfset UnavailableArray[count] = "12:30PM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x1300 EQ 0>
		<cfset UnavailableArray[count] = "1:00PM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x1350 EQ 0>
		<cfset UnavailableArray[count] = "1:30PM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x1400 EQ 0>
		<cfset UnavailableArray[count] = "2:00PM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x1450 EQ 0>
		<cfset UnavailableArray[count] = "2:30PM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x1500 EQ 0>
		<cfset UnavailableArray[count] = "3:00PM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x1550 EQ 0>
		<cfset UnavailableArray[count] = "3:30PM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x1600 EQ 0>
		<cfset UnavailableArray[count] = "4:00PM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x1650 EQ 0>
		<cfset UnavailableArray[count] = "4:30PM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x1700 EQ 0>
		<cfset UnavailableArray[count] = "5:00PM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x1750 EQ 0>
		<cfset UnavailableArray[count] = "5:30PM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x1800 EQ 0>
		<cfset UnavailableArray[count] = "6:00PM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x1850 EQ 0>
		<cfset UnavailableArray[count] = "6:30PM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x1900 EQ 0>
		<cfset UnavailableArray[count] = "7:00PM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x1950 EQ 0>
		<cfset UnavailableArray[count] = "7:30PM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x2000 EQ 0>
		<cfset UnavailableArray[count] = "8:00PM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x2050 EQ 0>
		<cfset UnavailableArray[count] = "8:30PM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x2100 EQ 0>
		<cfset UnavailableArray[count] = "9:00PM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x2150 EQ 0>
		<cfset UnavailableArray[count] = "9:30PM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x2200 EQ 0>
		<cfset UnavailableArray[count] = "10:00PM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x2250 EQ 0>
		<cfset UnavailableArray[count] = "10:30PM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x2300 EQ 0>
		<cfset UnavailableArray[count] = "11:00PM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x2350 EQ 0>
		<cfset UnavailableArray[count] = "11:30PM">
		<cfset count = #count# + 1>
	</cfif>
	<cfif getunavailable.x2400 EQ 0>
		<cfset UnavailableArray[count] = "12:00PM">
		<cfset count = #count# + 1>
	</cfif>
	
	<cfset temp = ArrayToList(UnavailableArray, ", ")>
	<cfoutput>#temp#</cfoutput>
</cfif>