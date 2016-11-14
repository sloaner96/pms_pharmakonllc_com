<!--- 
	*****************************************************************************************
	Name:		schedule_insert.cfm
	Function:	Inserts necessary info into the database, and runs a counter to determine what 
				days will be marked available or unavailable what doesn't exist, updates what 
				does exist.
	History:	Finalized code 8/28/01 TJS
	
	*****************************************************************************************
--->
<!--- CFSWITCH statement to allow entering and saving of data in same CF form file --->
<CFSWITCH EXPRESSION="#URL.action#">
			
	<!--- Saves all data inputted from the above form --->
	<CFCASE VALUE="insert">
	
		<!--- Defines variables needed within the page both from the previous form and URL --->
		<CFLOCK SCOPE="SESSION" TIMEOUT="30" TYPE="EXCLUSIVE">
			<CFSET session.id="#url.id#">
			<CFSET session.begin_month = "#form.begin_month#">
			<CFSET session.begin_year = "#form.begin_year#">
			<CFSET session.end_month = "#form.end_month#">
			<CFSET session.end_year = "#form.end_year#">
		</CFLOCK>
	
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
				WHERE id='#session.id#' AND year='#YearCounter#' AND month='#MonthCounter#';
			</CFQUERY>
			
			<CFIF check.recordcount EQ 0>
				<!--- Query to Insert Days into month selected on previous page --->
				<!--- Inserts 1 for Available Day (Mon, Tue, Wed, Thur)--->
				<!--- Inserts 0 for Unavailable Day (Sun, Fri, Sat)--->
				<!--- Inserts -1 for Undefined Day (i.e. in a month with 28 days inserts -1 into columns x29, x30, x31)--->
				<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="Insert_Months">
					INSERT Availability(ID, year, month, x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31)		
					VALUES('#session.id#', '#YearCounter#', '#MonthCounter#', 
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
			
				</CFLOOP>
				<!--- End of Days in Month Loop --->
				
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
	<!--- pull the rows (dates) that were just inserted into availability --->
		<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="qavailabledays">
			SELECT *
			FROM availability
			WHERE id='#session.id#' AND (year >= #form.begin_year# AND year <= #form.end_year#) AND (month >= #form.begin_month# AND month <= #form.end_month#);
		</CFQUERY>
		
		<!---Get any times already in the database pertaining to this speaker----->	
		<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="Get_Times">
			SELECT year, month FROM availability_time WHERE speakerid='#id#'
		</CFQUERY>
		
		<!---This puts user selected date ranges into an array that can 
		be used to check if the record already exsists before making an insert---->
		
		<cfinvoke 
			component="pms.com.cfc_checkdates" 
			method="CompareDates" 
			returnVariable="DateRange" 
			BeginMonth = #form.begin_month#
			BeginYear = #form.begin_year# 
			EndMonth = #form.end_month#
			EndYear = #form.end_year#
		>
		
				 
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
				<cfif #Evaluate(qday)# EQ 1>
					<CFSET atime[x][1] = #qavailabledays.id#>
					<CFSET atime[x][2] = #qavailabledays.year#>
					<CFSET atime[x][3] = #qavailabledays.month#>
					<CFSET atime[x][4] = 1>
					<CFSET atime[x][5] = #day#>
						<!--- If the day is not available, set the row with dummy
						 info. (value of 100 will be tested during the insert)
						 --->
						<cfelse>
					<CFSET atime[x][1] = 100>
					<CFSET atime[x][2] = 100>
					<CFSET atime[x][3] = 100>
					<CFSET atime[x][4] = 1>
					<CFSET atime[x][5] = 100>
					</cfif>
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
			<cfif atime[x][1] NEQ 100>
				<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="Insert_Times">
					INSERT availability_time(speakerid, year, month, day, start_time, end_time, allday, updated, updated_userid)		
					VALUES(#atime[x][1]#, #atime[x][2]#, #atime[x][3]#, #atime[x][5]#, '600PM', '1000PM', 0, #Now()#, #session.userinfo.rowid#)
				</cfquery>
			</cfif>
		</cfloop>		
			</CFLOOP><!--- end month loop --->
			</cfoutput>
			
		

				
<!--- ****************************************************************** --->				
			<CFELSE>
				<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="Update_months">
					UPDATE availability 
					SET	ID='#session.id#',
						year='#YearCounter#', 
						month='#MonthCounter#',
						
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
				
					</CFLOOP>
					<!--- End of Days in Month Loop --->
					
					<!--- Handles a new year --->
					<CFIF MonthCounter EQ 12>
						<CFSET MonthCounter = 1>
						<CFSET YearCounter = YearCounter + 1>
					<CFELSE>
						<CFSET MonthCounter = MonthCounter + 1>
					</CFIF>
					WHERE id='#session.id#' AND year='#YearCounter#' AND month='#MonthCounter#';
					</CFQUERY>
			</CFIF>
			  
			
			
			
		</CFLOOP>
		
		<CFOUTPUT>
			<META HTTP-EQUIV="refresh" CONTENT="0; Url=schedule_calendar.cfm?month=#session.begin_month#&year=#session.begin_year#">
		</CFOUTPUT>
	</CFCASE>
		
	
<!--- If no case is specified user is sent to data entry part of page --->
<CFDEFAULTCASE>
		<CFSET id="#URL.id#">
		<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="speaker_name">
			SELECT firstname,lastname
			FROM Speaker
			WHERE speakerid='#id#';
		</CFQUERY>
		<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="speakers_info">
			SELECT city, zipcode, state
			FROM SpeakerAddress
			WHERE speakerid='#id#';
		</CFQUERY>
		<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="Get_Times">
			SELECT month, year FROM availability_time WHERE speakerid='#id#' GROUP BY month, year
		</CFQUERY>
		
		<CFOUTPUT query="speaker_name"> 
			<CFSET fname="#firstname#">
			<CFSET lname="#lastname#">	
		</CFOUTPUT>
		
		<CFOUTPUT query="speakers_info"> 
			<CFSET city="#city#">
			<CFSET state="#state#">
			<CFSET zip="#zipcode#">		
		</CFOUTPUT>		
		<HTML>
			<HEAD>
				<TITLE>Project Initiation Form - General Information</TITLE>
				<LINK REL=stylesheet HREF="piw1style.css" TYPE="text/css">
				<SCRIPT SRC="confirm.js"></SCRIPT>
				<SCRIPT>
				function validate() 
					{	//form.begin_month 
						//form.begin_year	
						//form.end_month	
						//form.end_year
						
						test = document.forms[0].begin_month.value;
						test2 = document.forms[0].begin_year.value;
						test3 = document.forms[0].end_month.value;
						test4 = document.forms[0].end_year.value;
						
						if ((test == 15) || (test2 == 15) || (test3 == 15) || (test4 == 15))
						{
							alert("Please complete all elements of the form!"); 
							return false;
						}
						else
						{
							if(CheckDateOrder())
							{
								return true;
							}
							else
							{
								return false;
							}
						}
						
						
					}
					
				function CheckDateOrder()
				{
					var bmonth = parseInt(document.forms[0].begin_month.value);
					var byear = parseInt(document.forms[0].begin_year.value);
					var emonth = parseInt(document.forms[0].end_month.value);
					var eyear = parseInt(document.forms[0].end_year.value);
					
					if(eyear < byear)
					{
						alert("Begining Year is Later than Ending Year!");
						return false 
					}
					else   //Either Ending Date is Equal to or later than beging date.  OK.
					{
						if(byear == eyear)
						{
							if(bmonth <= emonth)
							{
								return true;
							}
							else
							{
								alert("Begining Month is Later than Ending Month!");
								return false 
							}
						}
						else
						{
							//Ending Year is Greater than Begining Year.  Don't care about months.
							return true;
						}
					}
				}
				
				</SCRIPT>
			</HEAD>
		
			<!--- Editable field --->
			<!--- action="view_schedule_mod.cfm?action=save" --->
			<BODY>
				<CFOUTPUT><FORM NAME="form" action="schedule_insert.cfm?action=insert&id=#trim(id)#" METHOD="post" onSubmit="return validate()"></CFOUTPUT>
				
				<TABLE BGCOLOR="#000080" ALIGN="Center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="720">
					<TR> 
						<TD CLASS="tdheader">Availability Month Selection</TD>
					</TR>
					<TR> 
						<TD>	<!--- Table containing input fields --->
							<TABLE ALIGN="Center" WIDTH="99%" CELLSPACING="0" CELLPADDING="10" BORDER="0">
								<TR>
									<TD ALIGN="Center">
										<CFOUTPUT>
											<B>#fname# #lname#
											<BR>
											#city#, #state# #zip#</B>
										</CFOUTPUT>
									</TD>
								</TR>
								<TR>
									<TD>&nbsp;</TD>
								</TR>
								<TR> 
									<TD><strong>At this time, <cfoutput>#fname# #lname#</cfoutput> has the following months already in the database:<br>
									<cfoutput query="Get_Times">
										#Get_Times.month#/#Get_Times.year#<br>
									</cfoutput>
									</strong>
									</TD
								></TR>
								<TR>
									<TD>&nbsp;</TD>
								</TR>
								<TR>
									<TD ALIGN="Center">
										<B>Begin Schedule:</B>&nbsp;&nbsp;&nbsp;&nbsp;
										<SELECT NAME="begin_month">
				                            <OPTION SELECTED VALUE=15>Select Month</OPTION> 
											<OPTION value="1">01</OPTION>	
											<OPTION value="2">02</OPTION>
											<OPTION value="3">03</OPTION>	
											<OPTION value="4">04</OPTION>	
											<OPTION value="5">05</OPTION>	
											<OPTION value="6">06</OPTION>	
											<OPTION value="7">07</OPTION>	
											<OPTION value="8">08</OPTION>	
											<OPTION value="9">09</OPTION>	
											<OPTION value="10">10</OPTION>	
											<OPTION value="11">11</OPTION>	
											<OPTION value="12">12</OPTION>					 
				                         </SELECT>
										&nbsp;&nbsp;
										<SELECT NAME="begin_year">
				                            <OPTION SELECTED VALUE=15>Select Year</OPTION> 
											<OPTION value="2001">2001</OPTION>	
											<OPTION value="2002">2002</OPTION>
											<OPTION value="2003">2003</OPTION>	
											<OPTION value="2004">2004</OPTION>
											<OPTION value="2005">2005</OPTION>
											<OPTION value="2006">2006</OPTION>	
											<OPTION value="2007">2007</OPTION>											 
				                         </SELECT>
									</TD>
								</TR>
										
								<TR>
									<TD ALIGN="Center">
										<B>End Schedule:</B>&nbsp;&nbsp;&nbsp;&nbsp;
										<SELECT NAME="end_month">
				                            <OPTION SELECTED VALUE=15>Select Month</OPTION> 
											<OPTION value="1">01</OPTION>	
											<OPTION value="2">02</OPTION>
											<OPTION value="3">03</OPTION>	
											<OPTION value="4">04</OPTION>	
											<OPTION value="5">05</OPTION>	
											<OPTION value="6">06</OPTION>	
											<OPTION value="7">07</OPTION>	
											<OPTION value="8">08</OPTION>	
											<OPTION value="9">09</OPTION>	
											<OPTION value="10">10</OPTION>	
											<OPTION value="11">11</OPTION>	
											<OPTION value="12">12</OPTION>										 
				                         </SELECT>
										&nbsp;&nbsp;	
										<SELECT NAME="end_year">
				                             <OPTION SELECTED VALUE=15>Select Year</OPTION> 
											<OPTION value="2001">2001</OPTION>	
											<OPTION value="2002">2002</OPTION>
											<OPTION value="2003">2003</OPTION>	
											<OPTION value="2004">2004</OPTION>
											<OPTION value="2005">2005</OPTION>
											<OPTION value="2006">2006</OPTION>	
											<OPTION value="2007">2007</OPTION>											 
				                         </SELECT>
									</TD>
								</TR>
								
								<TR>
									<TD>&nbsp;</TD>
								</TR>

								<TR>
						    		<TD ALIGN="center">
									
										<INPUT TYPE="submit" NAME="submit"  VALUE="Go to Schedule Calendar">
									</TD>
								</TR>
								
							</TABLE>
							</FORM>
						</TD>
					</TR>
				</TABLE>
			</BODY>
		</HTML>
	</CFDEFAULTCASE>

</CFSWITCH>
