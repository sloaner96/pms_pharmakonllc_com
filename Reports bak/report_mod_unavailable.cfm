<!--- 
	*****************************************************************************************
	Name:		
	Function:	
	History:	Finalized code 8/28/01 TJS
	
	*****************************************************************************************
--->
<HTML>
<head>
<LINK REL=STYLESHEET HREF="PIW1STYLE.CSS" TYPE="TEXT/CSS">
</head>

<!--- CFSWITCH statement to allow entering and saving of data in same CF form file --->
<CFSWITCH EXPRESSION="#URL.action#">
			
	<!--- Saves all data inputted from the above form --->
	<CFCASE VALUE="report">
	
 	<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="getunavailable">
		SELECT *
		FROM availability_time
		WHERE owner_id = #form.person_id# AND (allday = 0 or allday = 2) AND (month BETWEEN #form.begin_month# AND #form.end_month#) AND (year BETWEEN #form.begin_year# AND #form.end_year#)
		ORDER BY year, Month, Day
	</CFQUERY> 
	
	<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="getname">
		SELECT lastname, firstname
		FROM spkr_table
		WHERE speaker_id = #form.person_id#
	</CFQUERY> 
	
<!--- 	<cfinvoke
		component="pms.com.cfc_check_available" 
		method="setUnavailableHours"
		person_id="#form.person_id#" 
		begin_month="#form.begin_month#"
		end_month="#form.end_month#"
		begin_year="#form.begin_year#"
		end_year="#form.end_year#"
		returnVariable="aUnavailable"
	> --->
	
	<table width="600" border="0" align="center" cellpadding="5" cellspacing="0">
		<TR> 
			<TD colspan="3" CLASS="tdheader">Moderator Unavailability Report - <cfoutput>#getname.firstname# #getname.lastname#</cfoutput></TD>
		</TR>
		<tr>
			<td style="border-left: solid 1px #6699FF; border-top: solid 1px #6699FF;" width="50"><strong>Day</strong></td>
			<td style="border-left: solid 1px #6699FF; border-top: solid 1px #6699FF;" width="150"><strong>Unavailable Times</strong></td>
			<td style="border-left: solid 1px #6699FF; border-right: solid 1px #6699FF; border-top: solid 1px #6699FF;" width="400"><strong>Comments</strong></td>
		</tr>
		<!--- <cfset aUnavailable = ArrayNew(2)> --->
		<cfoutput query="getunavailable">
		<!--- <cfset x = 1>
		<cfset xcolumn = 0100> --->
		<cfset udate = CreateDate(#getunavailable.year#, #getunavailable.month#, #getunavailable.day#)>
			<cfif DayOfWeek("#udate#") NEQ 1 AND DayOfWeek("#udate#") NEQ 2 AND DayOfWeek("#udate#") NEQ 6 AND DayOfWeek("#udate#") NEQ 7>
			
			
		
 
<!--- 				<cfif getunavailable.x2300 EQ 0>
					<cfif getunavailable.x2250 NEQ 0>
						<cfset aUnavailable[x][1] = '11:00PM'>
					</cfif>
					<cfif getunavailable.x2350 NEQ 0>
						<cfset aUnavailable[x][2] = '11:00PM'>
						<cfset x = x + 1>
					</cfif>
				</cfif>
				<cfif getunavailable.x2350 EQ 0>
					<cfif getunavailable.x2300 NEQ 0>
					<cfset aUnavailable[x][1] = '11:30PM'>
					</cfif>
					<cfif getunavailable.x2400 NEQ 0>
					<cfset aUnavailable[x][2] = '11:30PM'>
					<cfset x = x + 1>
					</cfif>
				</cfif>
				<cfif getunavailable.x2400 EQ 0>
					<cfif getunavailable.x2350 NEQ 0>
														
					<cfset aUnavailable[x][1] = '12:00AM'>
					</cfif>
					
														
					<cfset aUnavailable[x][2] = '12:00PM'>
					<cfset x = x + 1>
				</cfif> --->

		<tr>
			<td style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">#month#/#day#/#year#</td>
			<td style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">
				<cfif getunavailable.allday EQ 0>All Day
				<cfelse>
				
				
<!--- 					<CFLOOP CONDITION="xcolumn LTE 2350">
						<cfif Evaluate("getunavailable.x#xcolumn#") EQ 0>
							<cfset bcolumn = xcolumn - 50>
							<cfset acolumn = xcolumn + 50>
								<cfif Evaluate("getunavailable.x#bcolumn#") NEQ 0>
									<cfset aUnavailable[x][1] = #xcolumn#>
								</cfif>
								<cfif Evaluate("getunavailable.x#acolumn#") NEQ 0>
									<cfset aUnavailable[x][2] = #xcolumn#>
									<cfset x = x + 1>
								</cfif>	
						</cfif>
						<cfset xcolumn = xcolumn + 50>
							<cfif #Len(xcolumn)# EQ 3>
								<cfset xcolumn = '0#xcolumn#'>
							<cfelseif #Len(xcolumn)# EQ 2>
								<cfset xcolumn = '00#xcolumn#'>
							</cfif>
					</cfloop>
				
				
				
				
					<cfloop from="1" to="#ArrayLen(aUnavailable)#" step="1" index="x">
						TEST:#aUnavailable[x][1]# - #aUnavailable[x][2]#
					</cfloop> --->
					<!--- Ulist:#Ulist# --->
					<cfif getunavailable.x0500 EQ 0>5:00AM</cfif>
					<cfif getunavailable.x0550 EQ 0>5:30AM</cfif>
					<cfif getunavailable.x0600 EQ 0>6:00AM</cfif>
					<cfif getunavailable.x0650 EQ 0>6:30AM</cfif>
					<cfif getunavailable.x0700 EQ 0>7:00AM</cfif>
					<cfif getunavailable.x0750 EQ 0>7:30AM</cfif>
					<cfif getunavailable.x0800 EQ 0>8:00AM</cfif>
					<cfif getunavailable.x0850 EQ 0>8:30AM</cfif>
					<cfif getunavailable.x0900 EQ 0>9:00AM</cfif>
					<cfif getunavailable.x0950 EQ 0>9:30AM</cfif>
					<cfif getunavailable.x1000 EQ 0>10:00AM</cfif>
					<cfif getunavailable.x1050 EQ 0>10:30AM</cfif>	
					<cfif getunavailable.x1100 EQ 0>11:00AM</cfif>
					<cfif getunavailable.x1150 EQ 0>11:30AM</cfif>
					<cfif getunavailable.x1200 EQ 0>12:00PM</cfif>
					<cfif getunavailable.x1250 EQ 0>12:30PM</cfif>
					<cfif getunavailable.x1300 EQ 0>1:00PM</cfif>
					<cfif getunavailable.x1350 EQ 0>1:30PM</cfif>
					<cfif getunavailable.x1400 EQ 0>2:00PM</cfif>
					<cfif getunavailable.x1450 EQ 0>2:30PM</cfif>
					<cfif getunavailable.x1500 EQ 0>3:00PM</cfif>
					<cfif getunavailable.x1550 EQ 0>3:30PM</cfif>
					<cfif getunavailable.x1600 EQ 0>4:00PM</cfif>
					<cfif getunavailable.x1650 EQ 0>4:30PM</cfif>
					<cfif getunavailable.x1700 EQ 0>5:00PM</cfif>
					<cfif getunavailable.x1750 EQ 0>5:30PM</cfif>
					<cfif getunavailable.x1800 EQ 0>6:00PM</cfif>
					<cfif getunavailable.x1850 EQ 0>6:30PM</cfif>
					<cfif getunavailable.x1900 EQ 0>7:00PM</cfif>
					<cfif getunavailable.x1950 EQ 0>7:30PM</cfif>
					<cfif getunavailable.x2000 EQ 0>8:00PM</cfif>
					<cfif getunavailable.x2050 EQ 0>8:30PM</cfif>
					<cfif getunavailable.x2100 EQ 0>9:00PM</cfif>
					<cfif getunavailable.x2150 EQ 0>9:30PM</cfif>
					<cfif getunavailable.x2200 EQ 0>10:00PM</cfif>
					<cfif getunavailable.x2250 EQ 0>10:30PM</cfif>
					<cfif getunavailable.x2300 EQ 0>11:00PM</cfif>
					<cfif getunavailable.x2350 EQ 0>11:30PM</cfif>
					<cfif getunavailable.x2400 EQ 0>12:00PM</cfif>
				</cfif>
			</td>
			<td style="border-left: solid 1px ##6699FF; border-right: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">
			<cfif getunavailable.comments EQ "">&nbsp;<cfelse>#comments#</cfif></td>
		</tr>
			</cfif>
		</cfoutput>
		<tr><td colspan="3" style="border-top: solid 1px #6699FF;">&nbsp;</td></tr>	
	</table>
		
	</CFCASE>
		
	
<!--- If no case is specified user is sent to data entry part of page --->
<!--- Allows user to select months in which meetings will occur --->
<CFDEFAULTCASE>
		

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
						if ((test == 1) || (test2 == 1) || (test3 == 1) || (test4 == 1))
						{
							alert("Please complete all elements of the form!"); 
							return false;
						}
						
					}
				</SCRIPT>
			</HEAD>
		
<BODY>
				<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="person">
					SELECT *
					FROM spkr_table
					WHERE type='MOD'
					ORDER BY lastname, firstname
				</CFQUERY>
			
			
				<CFOUTPUT><FORM NAME="form" ACTION="report_mod_unavailable.cfm?action=report" METHOD="post" onSubmit="return validate()"></CFOUTPUT>
				
			<TABLE BGCOLOR="#000080" ALIGN="Center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="720">
				<TR> 
					<TD CLASS="tdheader">Moderator Unavailability Report</TD>
				</TR>
				<TR> 
					<TD>	<!--- Table containing input fields --->
					<TABLE ALIGN="Center" BORDER="0" WIDTH="99%" CELLSPACING="1" CELLPADDING="10">
						<TR>
							<TD ALIGN="Center">
								<B>Moderator:</B>&nbsp;&nbsp;&nbsp;&nbsp;
								<SELECT NAME="person_id">
								<CFOUTPUT query="person"><OPTION VALUE=#speaker_id#>#lastname#, #Firstname#</CFOUTPUT>
								</SELECT>	
							</TD>
						</TR>
						<TR>
							<TD ALIGN="Center">
								<B>Begin Schedule:</B>&nbsp;&nbsp;&nbsp;&nbsp;
								<SELECT NAME="begin_month">
				                    <OPTION SELECTED VALUE=1>Select Month</OPTION> 
									<OPTION>01</OPTION>	
									<OPTION>02</OPTION>
									<OPTION>03</OPTION>	
									<OPTION>04</OPTION>	
									<OPTION>05</OPTION>	
									<OPTION>06</OPTION>	
									<OPTION>07</OPTION>	
									<OPTION>08</OPTION>	
									<OPTION>09</OPTION>	
									<OPTION>10</OPTION>	
									<OPTION>11</OPTION>	
									<OPTION>12</OPTION>										 
				                 </SELECT>
								&nbsp;&nbsp;
								<SELECT NAME="begin_year">
				                    <OPTION SELECTED VALUE=1>Select Year</OPTION> 
									<OPTION>2001</OPTION>	
									<OPTION>2002</OPTION>
									<OPTION>2003</OPTION>	
									<OPTION>2004</OPTION>
									<OPTION>2004</OPTION>
									<OPTION>2005</OPTION>
									<OPTION>2006</OPTION>	
									<OPTION>2007</OPTION>											 
				                 </SELECT>
							</TD>
						</TR>
						<TR>
							<TD ALIGN="Center">
							<B>End Schedule:</B>&nbsp;&nbsp;&nbsp;&nbsp;
								<SELECT NAME="end_month">
				                    <OPTION SELECTED VALUE=1>Select Month</OPTION> 
									<OPTION>01</OPTION>	
									<OPTION>02</OPTION>
									<OPTION>03</OPTION>	
									<OPTION>04</OPTION>	
									<OPTION>05</OPTION>	
									<OPTION>06</OPTION>	
									<OPTION>07</OPTION>	
									<OPTION>08</OPTION>	
									<OPTION>09</OPTION>	
									<OPTION>10</OPTION>	
									<OPTION>11</OPTION>	
									<OPTION>12</OPTION>										 
				                </SELECT>
								&nbsp;&nbsp;	
								<SELECT NAME="end_year">
				                    <OPTION SELECTED VALUE=1>Select Year</OPTION> 
									<OPTION>2001</OPTION>	
									<OPTION>2002</OPTION>
									<OPTION>2003</OPTION>	
									<OPTION>2004</OPTION>
									<OPTION>2004</OPTION>
									<OPTION>2005</OPTION>
									<OPTION>2006</OPTION>	
									<OPTION>2007</OPTION>											 
				                </SELECT>
							</TD>
						</TR>
						<tr><td height="5">&nbsp;</td></tr>		
						<TR>
						 	<TD ALIGN="center">
							<INPUT TYPE="submit" NAME="submit"  VALUE="  Start Report  ">
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
