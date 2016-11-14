<!-------
schedule_insert2.cfm

Action page for schedule_insert.cfm  
---------->

<!--- Defines variables needed within the page both from the previous form and URL --->
<CFLOCK SCOPE="SESSION" TIMEOUT="30" TYPE="EXCLUSIVE">
	<CFSET session.id="#url.id#">
	<CFSET session.begin_month = "#form.begin_month#">
	<CFSET session.begin_year = "#form.begin_year#">
	<CFSET session.end_month = "#form.end_month#">
	<CFSET session.end_year = "#form.end_year#">
</CFLOCK>

<!---Set Times Globally for Insert Statement. Using Military to avoid am/pm issues--->
<cfset start_time = 1800>
<cfset end_time = 2200>
	
<CFSET StartDay = DayOfWeek(CreateDate(session.begin_year, session.begin_month, 1))>
<CFSET DaysMonth = DaysInMonth(CreateDate(session.begin_year, session.begin_month, 1))>
		
<!--- Defines Counter For Outer Month Loop --->
<CFSET MonthCounter = session.begin_month>
<CFSET YearCounter = session.begin_year>
		
		
<CFLOOP CONDITION="DateCompare(CreateDate(YearCounter, MonthCounter, 1), CreateDate(session.end_year, session.end_month, 1)) NEQ 1">
	<!--- Defines Counter For Inner Day Loop --->
	<CFSET DayCounter = 1>
	<CFSET date = CreateDate(yearCounter, monthCounter, DayCounter)>
	<CFSET StartDay = DayOfWeek(date)>
	<CFSET DaysMonth = DaysInMonth(date)>
	<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="check">
		SELECT *
		FROM availability
		WHERE id='#session.id#' AND year=#YearCounter# AND month=#MonthCounter#
	</CFQUERY>
			
	
	<CFIF check.recordcount EQ 0>
		<!---Use lock to avoid the MAX() function reading MAX value that another user has set--->
		<CFLOCK SCOPE="SESSION" TIMEOUT="30" TYPE="EXCLUSIVE">
			<!--- Query to Insert Days into month selected on previous page --->
			<!--- Inserts 1 for Available Day (Mon, Tue, Wed, Thur)--->
			<!--- Inserts 0 for Unavailable Day (Sun, Fri, Sat)--->
			<!--- Inserts -1 for Undefined Day (i.e. in a month with 28 days inserts -1 into columns x29, x30, x31)--->
			<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="Insert_Months">
				INSERT Availability(ID, year, month, x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31)		
				VALUES('#session.id#', #YearCounter#, #MonthCounter#, 
				<!--- Day in Month Loops 1 to 31 (inserts 1,0,-1 accordingly) --->
				<CFLOOP CONDITION="DayCounter LTE 31">
					<!--- Keeps DayofWeek from giving error on an invalid day for that month since not all --->
					<!--- have 31 days in them. --->
					<CFIF DayCounter LTE DaysMonth>
						<CFSET StartDay = DayofWeek(CreateDate(yearCounter, monthCounter, DayCounter))>
					</CFIF>
					<CFIF ((StartDay EQ 2) OR (StartDay EQ 3) OR (StartDay EQ 4) OR (StartDay EQ 5)) AND (DayCounter LTE DaysMonth)>
						<!--- Inserts 1 for Available Day (Mon=2, Tue=3, Wed=4, Thur=5)--->
						'1'<CFIF DayCounter NEQ 31>,</CFIF>
					<CFELSEIF ((StartDay EQ 1) OR (StartDay EQ 6) OR (StartDay EQ 7)) AND (DayCounter LTE DaysMonth)>
						<!--- Inserts 0 for Unavailable Day (Sun=1, Fri=6, Sat=7)--->			
						'0'<CFIF DayCounter NEQ 31>,</CFIF>
					<CFELSE>
						<!--- Inserts -1 for Undefined Day (i.e. in a month with 28 days inserts -1 into columns x29, x30, x31)--->
						'-1'<CFIF DayCounter NEQ 31>,</CFIF>
					</CFIF>
					<!--- Increment Day Counter --->
					<CFSET DayCounter = DayCounter + 1>
				</CFLOOP><!--- End of Days in Month Loop --->
					
				<!--- Handles a new year --->
				<CFIF MonthCounter EQ 12>
					<CFSET MonthCounter = 1>
					<CFSET YearCounter = YearCounter + 1>
				<CFELSE>
					<CFSET MonthCounter = MonthCounter + 1>
				</CFIF>
				<!--- End of Query Statement --->
				);
			</CFQUERY>
					
		<!--- ***************************************************************
			Added 9/17/02 to insert rows into availability_time table. All times are marked as available all day.
		 ********************************************************************--->
						
		<!--- Matt Eaves.  Added this query to avoid pulling more than one record at a time.  This 
		pulls only the last record that was actually inserted from the insert statement above. If we 
		didnt do this, if more than one month was in availabiltity, the availability_time insert would 
		run once more than the time before.  For example if the user chooses January and February then 
		the first time through it would pull January from availability then insert January. The second 
		time through it would pull January AND February and insert both of those into availability_time.  
		Adding 1,1,2 to availability_time.  Using MAX(rowid) prevents this.  CFLOCK prevents multiple users
		updating the same person at the same time.
		---->
		<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="max_record">
			SELECT MAX(rowid) as last_record
			FROM availability
			WHERE id='#session.id#' AND (year >= #form.begin_year# AND year <= #form.end_year#) AND (month >= #form.begin_month# AND month <= #form.end_month#);
		</CFQUERY>
	</CFLOCK>
	
	<!--- pull the rows (dates) that were just inserted into availability --->
	<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="qavailabledays">
		SELECT *
		FROM availability
		WHERE id='#session.id#' 
		AND (year >= #form.begin_year# 
		AND year <= #form.end_year#) 
		AND (month >= #form.begin_month# 
		AND month <= #form.end_month#)
		AND rowid = #max_record.last_record#
	</CFQUERY>
			
	<!--- set a new array to hold a row for each available day --->
	<CFSET atime=ArrayNew(2)>
	<!--- the day variable holds the day of the month --->
	<cfset day = 1>
		
	<cfoutput>	
	<!--- 1st loop loops over number of months pulled from availability --->		
		<CFLOOP QUERY="qavailabledays">	
			<!--- 2ns loop loops over number of possible days --->
			<cfloop from="1" to="31" index="x" step="1">
				<!--- set a variable the holds the name of the query and day field in availability table --->
				<cfset qday = 'qavailabledays.x'&#day#>
					<!--- Evaluate each day column to see if it is available 
					if it is, set a new row in the array with its info--->
				<!--- **<cfif #Evaluate(qday)# EQ 1> **--->
					<CFSET atime[x][1] = #qavailabledays.id#>
					<CFSET atime[x][2] = #qavailabledays.year#>
					<CFSET atime[x][3] = #qavailabledays.month#>
					<CFSET atime[x][4] = #Evaluate(qday)#>
					<!---** <CFSET atime[x][4] = 1> **--->
					<CFSET atime[x][5] = #day#>
						<!--- If the day is not available, set the row with dummy
						 info. (value of 100 will be tested during the insert)
						 --->
				<!---** <cfelse>
					<CFSET atime[x][1] = 100>
					<CFSET atime[x][2] = 100>
					<CFSET atime[x][3] = 100>
					<CFSET atime[x][4] = 1>
					<CFSET atime[x][5] = 100>
				</cfif> **--->
				<!--- After the 1st day is evaluated, change variable to day 2 --->
					<cfset day = #day# + 1>	
					<!--- If all days have been evaluated, set day back to 1 --->
					<cfif day GT 31>
						<cfset day = 1>
					</cfif>
					<!--- end loop that checks if each day is available --->
				</cfloop>	
				<!--- Insert the days and times for the month. If there is more
				than 1 month, loop through the next months days, then run this 
				insert query again. --->
				<cfloop from="1" to="#ArrayLen(atime)#" index="x" step="1">
					<!---** <cfif atime[x][1] NEQ 100> --->
						<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="Insert_Times">
							INSERT availability_time(owner_id, year, month, day, x0050, x0100, x0150, x0200, x0250, x0300, x0350, x0400, x0450, x0500, x0550, x0600, x0650, x0700, x0750, x0800, x0850, x0900, x0950, x1000, x1050, x1100, x1150, x1200, x1250, x1300, x1350, x1400, x1450, x1500, x1550, x1600, x1650, x1700, x1750, x1800, x1850, x1900, x1950, x2000, x2050, x2100, x2150, x2200, x2250, x2300, x2350, x2400, allday, updated, updated_userid)		
							VALUES(#atime[x][1]#, #atime[x][2]#, #atime[x][3]#, #atime[x][5]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #atime[x][4]#, #Now()#, #session.userinfo.rowid#)
						</cfquery>
					<!---** </cfif> --->
				</cfloop>		
		</CFLOOP><!--- end month loop --->
	</cfoutput>
			
	
	<!--- ***********************************************************************
		Removed update portion of this screen - if schedule exixts do not change!
	 **************************************************************************--->
<!---<CFELSE><!-----Recordcount is GT 0------------>
		<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="Update_months">
			UPDATE availability 
				SET	ID='#session.id#',
				year=#YearCounter#, 
				month=#MonthCounter#,
			<!--- Day in Month Loops 1 to 31 (inserts 1,0,-1 accordingly) --->
			<CFLOOP CONDITION="DayCounter LTE 31">
				x#DayCounter#=
				<!--- Keeps DayofWeek from giving error on an invalid day for that month since not all --->
				<!--- have 31 days in them. --->
				<CFIF DayCounter LTE DaysMonth>
					<CFSET StartDay = DayofWeek(CreateDate(yearCounter, monthCounter, DayCounter))>
				</CFIF>
				<CFIF ((StartDay EQ 2) OR (StartDay EQ 3) OR (StartDay EQ 4) OR (StartDay EQ 5)) AND (DayCounter LTE DaysMonth)>
					<!--- Inserts 1 for Available Day (Mon=2, Tue=3, Wed=4, Thur=5)--->
					'1'<CFIF DayCounter NEQ 31>,</CFIF>
				<CFELSEIF ((StartDay EQ 1) OR (StartDay EQ 6) OR (StartDay EQ 7)) AND (DayCounter LTE DaysMonth)>
					<!--- Inserts 0 for Unavailable Day (Sun=1, Fri=6, Sat=7)--->			
					'0'<CFIF DayCounter NEQ 31>,</CFIF>
				<CFELSE>
					<!--- Inserts -1 for Undefined Day (i.e. in a month with 28 days inserts -1 into columns x29, x30, x31)--->
					'-1'<CFIF DayCounter NEQ 31>,</CFIF>
				</CFIF>
				<!--- Increment Day Counter --->
				<CFSET DayCounter = DayCounter + 1>
			</CFLOOP><!--- End of Days in Month Loop --->
			<!--- Handles a new year --->
			<!--- <CFIF MonthCounter EQ 12>
				<CFSET MonthCounter = 1>
				<CFSET YearCounter = YearCounter + 1>
			<CFELSE>
				<CFSET MonthCounter = MonthCounter + 1>
			</CFIF> --->
				WHERE id='#session.id#' AND year=#YearCounter# AND month=#MonthCounter#;
		</CFQUERY>--->
		<cfelse>
		<CFIF MonthCounter EQ 12>
			<CFSET MonthCounter = 1>
			<CFSET YearCounter = YearCounter + 1>
		<CFELSE>
			<CFSET MonthCounter = MonthCounter + 1>
		</CFIF> 
	</CFIF>
</CFLOOP>


	<cflocation url="schedule_calendar.cfm?month=#session.begin_month#&year=#session.begin_year#" addtoken="no">










