<!--- 
	*****************************************************************************************
	Name:		meeting_date_insert.cfm
	Function:	Inserts what doesn't exist, updates what does exist.
	History:	Finalized code 8/28/01 TJS
	
	*****************************************************************************************
--->
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Schedule Meeting Date" showCalendar="1">
<cfparam name="url.action" default="">
<!--- CFSWITCH statement to allow entering and saving of data in same CF form file --->
<CFSWITCH EXPRESSION="#URL.action#">
	<!--- Saves all data inputted from the above form --->
	<CFCASE VALUE="insert">
		<!--- Defines variables needed within the page both from the previous form and URL --->
		<!--- parse the beginning date --->
		<cfset ptr1 = Find("/", #trim(form.begin_date)#, 1)>
		<cfset bmonth = "#left(form.begin_date, (ptr1-1))#">
		<cfif ptr1 GT 0>
			<cfset ptr2 = Find("/", #trim(form.begin_date)#, ptr1+1)>
		</cfif>
		<cfif ptr1 GT 0 and ptr2 GT 0>
			<cfset bday = "#mid(form.begin_date, (ptr1+1), ((ptr2 - ptr1)-1))#">
			<cfset byear = "#mid(form.begin_date, (ptr2+1), ((Len(form.begin_date)) - ptr2) )#">
		<cfelse>
			<cfset bday = 0>
			<cfset dyear = 0>
		</cfif>
		<!--- parse the ending date --->
		<cfset ptr1 = Find("/", #trim(form.end_date)#, 1)>
		<cfset emonth = "#left(form.end_date, (ptr1-1))#">
		<cfif ptr1 GT 0>
			<cfset ptr2 = Find("/", #trim(form.end_date)#, ptr1+1)>
		</cfif>
		<cfif ptr1 GT 0 and ptr2 GT 0>
			<cfset eday = "#mid(form.end_date, (ptr1+1), ((ptr2 - ptr1)-1))#">
			<cfset eyear = "#mid(form.end_date, (ptr2+1), ((Len(form.end_date)) - ptr2) )#">
		<cfelse>
			<cfset eday = 0>
			<cfset eyear = 0>
		</cfif>
		
		<!--- for testing purposes 
		<cfoutput>
		#bmonth#<br>
		#bday#<br>
		#byear#<br>
		#emonth#<br>
		#eday#<br>
		#eyear#
		</cfoutput>
		--->
		
		<CFLOCK SCOPE="SESSION" TIMEOUT="30" TYPE="EXCLUSIVE">
			<CFSET session.begin_month = "#bmonth#">
			<CFSET session.begin_year = "#byear#">
			<CFSET session.end_month = "#emonth#">
			<CFSET session.end_year = "#eyear#">
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
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="check">
				SELECT *
				FROM schedule_meeting_date
				WHERE project_code='#session.project_code#' AND year=#YearCounter# AND month=#MonthCounter#;
			</CFQUERY>
			
			<!---  If nothing exists for the month chosen insert, else update the database--->
			<CFIF check.recordcount EQ 0>
				<!--- Query to Insert Days into month selected on previous page --->
				<!--- Inserts 1 for Available Day (Mon, Tue, Wed, Thur)--->
				<!--- Inserts 0 for Unavailable Day (Sun, Fri, Sat)--->
				<!--- Inserts -1 for Undefined Day (i.e. in a month with 28 days inserts -1 into columns x29, x30, x31)--->
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="insert_date">
					INSERT schedule_meeting_date(project_code, year, month, x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31)		
					VALUES('#session.project_code#', #YearCounter#, #MonthCounter#, 
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
			<CFELSE>
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="update_date">
					UPDATE schedule_meeting_date 
					SET	project_code='#session.project_code#',
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
					
					<!--- <!--- Handles a new year --->
					<CFIF MonthCounter EQ 12>
						<CFSET MonthCounter = 1>
						<CFSET YearCounter = YearCounter + 1>
					<CFELSE>
						<CFSET MonthCounter = MonthCounter + 1>
					</CFIF> --->
					WHERE project_code='#session.project_code#' AND year='#YearCounter#' AND month='#MonthCounter#';
					</CFQUERY>
					<!--- Handles a new year --->
					<CFIF MonthCounter EQ 12>
						<CFSET MonthCounter = 1>
						<CFSET YearCounter = YearCounter + 1>
					<CFELSE>
						<CFSET MonthCounter = MonthCounter + 1>
					</CFIF>
			</CFIF>
		</CFLOOP>

		
		<cflocation url="meeting_date_calendar.cfm?month=#session.begin_month#&year=#session.begin_year#" addtoken="NO">
		
		
	</CFCASE>
		
	
<!--- If no case is specified user is sent to data entry part of page --->
<!--- Allows user to select months in which meetings will occur --->
<CFDEFAULTCASE>
	<SCRIPT SRC="/includes/libraries/CallCal.js"></SCRIPT>
	<SCRIPT SRC="/includes/libraries/confirm.js"></SCRIPT>
	<SCRIPT>
	function validate(f) 
	{			
		var sbdate = f.begin_date.value;
		var sedate = f.end_date.value;
		
		if (f.begin_date.value == "" || f.begin_date.value == " " || sbdate.length < 6)
		{
			alert("Please select a beginning date!"); 
			return false;
		}

		if (f.end_date.value == "" || f.end_date.value == " " || sedate.length < 6)
		{
			alert("Please select an ending date!"); 
			return false;
		}
		
		sbdate = sbdate.split("/"); //Break starting date into array
		sedate = sedate.split("/");  //Bread ending date inot array
		
		
		for(i=0; i<sbdate.length; i++)
		{
			sbdate[i] = parseInt(sbdate[i]) //turn all string into integers
		}
		
		for(j=0; j<sedate.length; j++)
		{
			sedate[j] = parseInt(sedate[j]) //turn all string into integers
		}
		
		
		if(sbdate[2] < sedate[2]) //begining year is less than ending year
		{
			return true;
		}
		else if(sbdate[2] == sedate[2]) //years are equal
		{
				if(sbdate[0] < sedate[0]) //begining month is less than ending month
				{
					if(sbdate[1] < sedate[1]) //begining day is less than ending day
					{
						return true;
					}
				}
				else if(sbdate[0] == sedate[0]) //begining month is equal to ending month
				{
					if(sbdate[1] <= sedate[1]) //begining day is less than or equal to ending day
					{
						return true;
					}
					else
					{
						alert("The Beginging Date is Later then the Ending Date!")
						return false;
					}
				}
				else //begining month is more than ending month in the same year
				{
					alert("The Beginging Date is Later then the Ending Date!")
					return false;
				}

		}
		else 
		{
			alert("The Beginging Date is Later then the Ending Date!");
			return false;
		}
		
	}
	</SCRIPT>
	</HEAD>
	<BODY>
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="GetSchedule">
		Select month, year FROM schedule_meeting_date
		WHERE project_code = '#session.project_code#' 
		ORDER BY year, month
	</CFQUERY>
	<cfscript>
		ProjectName = createObject("component","pms.com.cfc_get_name");
		projName = ProjectName.getProjName(ProjCode="#session.Project_code#");
	</cfscript>
	<TABLE ALIGN="Center" WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" style="margin-top: 10px">
	<tr>
		<td align="center">
		<cfoutput>#projName#</cfoutput>
		</td>
	</tr>
	</table><br>
	<cfif GetSchedule.recordcount>
		<TABLE ALIGN="Center" WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" style="margin-top: 10px">
		<tr>
			<td align="center"><strong><font color="#cc0000#">A schedule has already been created for the following months:</font></strong></td>
		</tr>
		<tr>
			<td align="center">
				<cfoutput query="GetSchedule">
					<strong>#GetSchedule.month#/#GetSchedule.year# &nbsp;</strong>
				</cfoutput>
			</td>
		</tr>
		</table>
	</cfif>
	<CFOUTPUT><FORM NAME="form" ACTION="meeting_date_insert.cfm?action=insert" METHOD="post" onSubmit="return validate(this);"></CFOUTPUT>
		<TABLE ALIGN="Center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="400">
			<TR> 
				<TD CLASS="tdheader"><CFOUTPUT>Meeting Month Selection for #session.project_code#</CFOUTPUT></TD>
			</TR>
			<TR> 
				<TD>	<!--- Table containing input fields --->
					<TABLE ALIGN="Center" WIDTH=300 CELLSPACING="0" CELLPADDING="5" BORDER="0">
					  <TR>
						 <TD colspan=2>&nbsp;</TD>
					  </TR>
					  <TR valign="middle">
						 <TD ALIGN=right><b>Beginning Date</b></td>
						 <td align=left><cfmodule template="#Application.TagPath#/ctags/CalInput.cfm" inputname="begin_date" htmlid="begindate" formvalue="" imgid="begindatebtn"></TD>
					  </TR>
					  <TR>
						 <TD ALIGN=right><b>Ending Date</b></td>
						 <td align=left><cfmodule template="#Application.TagPath#/ctags/CalInput.cfm" inputname="end_date" htmlid="enddate" formvalue="" imgid="enddatebtn"></td>
					  </TR>
					  <TR>
						 <TD colspan=2>&nbsp;</TD>
					  </TR>
					  <TR>
				    	 <TD ALIGN="center"><INPUT TYPE="submit" NAME="submit" VALUE="Submit"></TD>
						 <TD ALIGN="center"><INPUT TYPE="reset" NAME="cancel" VALUE=" Cancel " onclick="javascript:history.back(-1);"></TD>
					  </TR>
					</TABLE>
				</TD>
			</TR>
		</TABLE>
	 </form>
	</CFDEFAULTCASE>
</CFSWITCH>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

