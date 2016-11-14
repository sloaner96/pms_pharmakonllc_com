
<cfoutput>
<cfset FORM.begin_date = '#url.begin_date#'>
<cfset FORM.end_date = '#url.end_date#'> 

<cfcontent type="application/vnd.ms-excel">
	
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
						</table>
				</cfif>
			</form>
			</cfcontent>
</cfoutput>