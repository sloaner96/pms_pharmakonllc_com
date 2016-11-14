
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<cfoutput>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

	<link rel="stylesheet" type="text/css" media="all" href="/includes/styles/schedule.css" title="tas" />
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<script>
		.textg{
		background-color: ffffff;
		color: black;
		height: 14;
		width:50;
		font-family: verdana;
		font-size: 8pt
		}
	</script>
</head>
	<body>
	
	<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Moderator Master Schedule" showCalendar="1">
	
		<br>
	 <a href="act_MasterSchedule2_b.cfm?begin_date=#FORM.begin_date#&end_date=#FORM.end_date#"><img src="/Images/excelico.gif" alt="Download Spreadsheet" width="16" height="16" border="0" align="middle" hspace="2"></a>&nbsp;
<a href="act_MasterSchedule2_b.cfm?begin_date=#FORM.begin_date#&end_date=#FORM.end_date#"><u>Download as Spreadsheet</u></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="dsp_MasterSchedule2.cfm"><u>Enter Different Dates</u></a>
	<br>
	
	
			<form name="modmasterschedule">
				<!--- run the stored procedure to populate the report table --->
				<cfquery name="qGetmodschedule" datasource="#application.MasterDSN#">
					EXEC sp_pms_masterschedule '#dateFormat(FORM.begin_date, "mm/dd/yyyy")#', '#dateFormat(FORM.end_date, "mm/dd/yyyy")#'
				</cfquery>
				<!--- fetch all report table rows --->				
				<cfquery name="qGetmodschedule" datasource="#application.MasterDSN#">
					select * from pms_masterschedule
					where eventdate between '#dateFormat(FORM.begin_date, "mm/dd/yyyy")#' and '#dateFormat(FORM.end_date, "mm/dd/yyyy")#'
				</cfquery>

				<cfif qGetmodschedule.recordcount>
						<cfset collist="eventdate">
						<cfset totallist ="">
						<cfset firsttime="yes">
						<cfloop index="ctr" list="#qGetmodschedule.columnlist#">
								<cfif ctr neq "eventdate" and ctr neq "totalmeetings" and ctr neq "date_created" and ctr neq "date_modified">
								   <cfset collist= ListAppend(collist,ctr)>
								</cfif>
						</cfloop>

						<cfloop index="ctr" list="#collist#">
							<cfset "tot#ctr#" = 0>
						</cfloop>
						<table width=600 align="center" border=0>
							<tr>
								<td colspan=10 align="left">
									<cfoutput>
									<center><font face="Verdana,Helvetica,Arial" size="2">
										<b>Moderator Master Schedule for Events between:</font></b><br> <font color="800000">#dateFormat(FORM.begin_date, "mm/dd/yy")#</font> and <font color="800000">#dateFormat(FORM.end_date, "mm/dd/yy")#</font></center><br><br>
									
									</cfoutput>
								</td>
							</tr>
						</table>
<!--- <cfcontent type="application/vnd.ms-excel"> --->
						<table width=600 align="center"  border=1>
							<!--- output the column headings --->
							<tr bgcolor="d3d3d3">
								<cfloop index="ctr" list="#collist#">
										<td align="center" nowrap><cfoutput><b>#UCase(ctr)#</b></cfoutput></td>
								</cfloop>
							</tr>
							<!--- output the column data by date --->
							<cfloop query="qGetmodschedule">
								<tr class="css_f05">
									<cfloop index="ctr" list="#collist#">
										<cfif ctr eq "eventdate">
											<td align="left" class="textg" valign="top" nowrap>
												<cfoutput><strong><font color="808080">#DateFormat(Evaluate("#ctr#"), 'dddd,mmmmm dd, yyyy')#</font></strong></cfoutput>
											</td>
										<cfelse>
											<cfset mystring ="#trim(Evaluate('#ctr#'))#">
											<cfset myArray = #ListToArray(mystring, "|")#>
											<cfset aLen = #ArrayLen(myArray)#>
											<!---<cfset nolines =len(mystring)/23>--->
											<cfset nolines = #ArrayLen(myArray)#>
											<cfset tmpStr = "">
											<!--- output a column for each moderator, for each day --->
											<td align="center" class="textg" align="left" valign="top" nowrap>
												<cfloop index="x" from="1" to="#aLen#">
													<cfset tmpStr = #SpanExcluding(myArray[x], "|")#>
													<cfoutput>#mid(tmpStr,1,9)# #TimeFormat(mid(tmpStr,11,8),"hh:mm tt")# #mid(tmpStr, 20, Len(tmpStr)-19)#</cfoutput><br>
												</cfloop>
											</td>
										</cfif>
									</cfloop>
								</tr>
							</cfloop>
						</table>
				<cfelse>
						<table width=600 align="center">
							<tr><td>&nbsp;</td></tr>
							<tr><td>&nbsp;</td></tr>
							<tr><td>&nbsp;</td></tr>
							<tr><td>&nbsp;</td></tr>
							<tr><td>&nbsp;</td></tr>
							<tr><td align="center"><h3>Query Returned No Records</h3></td></tr>
						</table><!--- </cfcontent> --->
				</cfif>
			</form>
			
			<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
	</body>
	
</html>
</cfoutput>