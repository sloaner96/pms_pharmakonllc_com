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
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Availability Month Selection" showCalendar="0">

		<SCRIPT SRC="confirm.js"></SCRIPT>
		<SCRIPT>
			function validate() 
			{	
				//form.begin_month 
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

	<CFOUTPUT>
	<FORM NAME="form" action="schedule_insert2.cfm?action=insert&id=#trim(id)#" METHOD="post" onSubmit="return validate()">
	</CFOUTPUT>
	<TABLE ALIGN="Center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="720">
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
			<tr><td colspan="2">
				<table border="0" cellpadding="2" cellspacing="0">
					<tr>
			<cfif #Get_Times.recordcount#>
						<TD colspan="6">
						<strong><font color="#3333CC">At this time, <cfoutput>#fname# #lname#</cfoutput> has the following months scheduled:</font></strong>
						</td>
					</tr>
					<tr><td width="30"></td>
						<td width="30"></td>
						<td width="30"></td>
						<td width="30"></td>
						<td width="30"></td>
						<td width="30"></td></tr>	
					<tr>
						<CFOUTPUT query="Get_Times">	
						<td><strong>#Get_Times.month#/#Get_Times.year#</strong></td>
						<cfif Get_Times.CurrentRow MOD 6 IS 0>
						</tr>
						<tr>
						</cfif>
						</cfoutput>
			<cfelse>
					<CFOUTPUT query="Get_Times">
						<td>
						<strong>#fname# #lname# does not have any time scheduled.</strong>
						</td>
					</cfoutput>	
			</cfif>
					</tr>
				</table>
				</td></tr>	
					
					
					
					<!--- <TR> 
						<TD style="background-color:#66CCFF;"><cfif #Get_Times.recordcount#>
								<strong>At this time, <cfoutput>#fname# #lname#</cfoutput> has the following months scheduled:<br>
								<cfoutput query="Get_Times">
									#Get_Times.month#/#Get_Times.year#<br>
								</cfoutput>
							<cfelse>
								<cfoutput><strong>#fname# #lname# does not have any time scheduled.</strong></cfoutput>
							</cfif>
							</strong>
						</TD>
					</TR> --->
					<TR>
						<TD align="center"><font color="#3399FF"><strong>Select the months you would like to add or edit.</strong></font></TD>
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
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">