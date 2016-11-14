<!--------------------------------------------------------------------
-- roster_cert_issue2.cfm 
-- Ben Jurevicius - 06232003
--
-- Pulls certificate issuance data from the table 'cert_issue' in the CBARoster database,
-- matches it to roster data and loads the data into the 'cert_trans' table.
--
-- This program has 2 major functions steps:
-- 1) validate all data in the cert_issue table.
-- 2) loads certificate data into the cert_trans table.
--
-----------------------------------------------------------------------
--->
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Upload Certificate Issuance Data" showCalendar="0">

<SCRIPT SRC="/includes/libraries/PIW1checker.js"></SCRIPT>

<CFSWITCH EXPRESSION="#URL.a#">
<!--- Step #1 - post a processing notice. --->
<CFCASE VALUE="1">

	<table border="0">
	<tr>
		<td width=50>&nbsp;</td>
		<td colspan=3><h4><font color="green">Validating certificate issuance data, please wait...</font></h4>This process verifies that all required data is present and reports any problems.</td>		
	</tr>
	</table>
	<cfoutput>
	<META HTTP-EQUIV="refresh" CONTENT="3; URL=roster_cert_issue2.cfm?a=2&#Rand()#">
	</cfoutput>

</CFCASE>
<!--- Step #2 - validation the issuance data --->
<CFCASE VALUE="2">
	<!--- Pull all certificate data rows --->
	<CFQUERY DATASOURCE="#application.rosterDSN#"  NAME="q1">
		select lastname, firstname, address1, address2, city, state, zipcode, phone, meetingcode,
			program_title, apptdate, certnum, issuedate, batchnum, roster_rowid, amount, source
			from cert_issue
	</CFQUERY>

	<cfif q1.recordcount EQ 0>
		<FORM NAME="issue2-2a" ACTION="" METHOD="post">
		<table border="0">
		<tr>
			<td width=50>&nbsp;</td>
			<td colspan=3><h4><font color="red">No records were found in the 'CERT_ISSUE' table in the CBARoster database.</font></h4></td>		
		</tr>
		<tr height=20><td colspan=3>&nbsp;</td></tr>
		<cfoutput>
		<tr>	
			<td width=50>&nbsp;</td>
			<TD ALIGN="right"><input TYPE="Button"  NAME="run" VALUE=" Cancel " onClick="issue2-2.action = 'roster_cert_issue.cfm?#Rand()#'; issue2-2a.submit();"></TD>
			<td>&nbsp;</td>
		</tr>
		</cfoutput>			
		<tr height=20><td colspan=3>&nbsp;</td></tr>
		</table>
		</form>
	<cfelse>
		<cfset nolastname = 0>
		<cfset nofirstname = 0>
		<cfset noaddress = 0>
		<cfset nostate = 0>
		<cfset nozipcode = 0>
		<cfset nomeetingcode = 0>
		<cfset noapptdate = 0>
		<cfset nocertnum = 0>
		<cfset noissuedate = 0>
		<cfset nobatchnum = 0>
		<cfset norowid = 0>
		<cfset noamount = 0>
		<cfset nosource = 0>
		<cfset errors = 0>
		<cfset row_exists = 0>
		<FORM NAME="issue2-2b" ACTION="" METHOD="post">
		<table border="0">
		<tr>
			<td width=50>&nbsp;</td>
			<td colspan=2><b>Validation Report</b></td>		
		</tr>
		<tr>
			<td width=50>&nbsp;</td>
			<td><b>Record #</b></td>		
			<td><b>Description</b></td>
		</tr>
		<cfloop query="q1">
			<!--- check if this row already exisits --->
		<CFQUERY DATASOURCE="#application.rosterDSN#"  NAME="qe">
			select batchnum, trans_type, cert from cert_trans 
			where cert_trans.batchnum = '#q1.batchnum#' AND cert_trans.trans_type = 'I' AND cert_trans.cert = '#q1.certnum#' 
		</CFQUERY>
		<cfif #qe.recordcount# GT 0><cfset row_exists = row_exists + 1></cfif>
		<cfoutput>
		<!--- check last name --->
		<cfif len(q1.lastname) LT 1> 
			<tr>
				<td width=50>&nbsp;</td>
				<td>#q1.currentrow#</b></td>
				<td>No last name</td>
			</tr>
			<cfset nolastname = nolastname + 1>
			<cfset errors = errors + 1>
		</cfif>
		<cfif len(q1.firstname) LT 1> 
			<tr>
				<td width=50>&nbsp;</td>
				<td>#q1.currentrow#</b></td>
				<td>No firstname name</td>
			</tr>
			<cfset nofirstname = nofirstname + 1>
			<cfset errors = errors + 1>			
		</cfif>
		<cfif len(q1.address1) LT 1> 
			<tr>
				<td width=50>&nbsp;</td>
				<td>#q1.currentrow#</b></td>
				<td>No address data</td>
			</tr>
			<cfset noaddress = noaddress + 1>
			<cfset errors = errors + 1>			
		</cfif>
		<cfif len(q1.city) LT 1> 
			<tr>
				<td width=50>&nbsp;</td>
				<td>#q1.currentrow#</b></td>
				<td>No city</td>
			</tr>
			<cfset nocity = nocity + 1>
			<cfset errors = errors + 1>			
		</cfif>
		<cfif len(q1.state) LT 1> 
			<tr>
				<td width=50>&nbsp;</td>
				<td>#q1.currentrow#</b></td>
				<td>No state</td>
			</tr>
			<cfset nostate = nostate + 1>
			<cfset errors = errors + 1>			
		</cfif>
		<cfif len(q1.zipcode) LT 1> 
			<tr>
				<td width=50>&nbsp;</td>
				<td>#q1.currentrow#</b></td>
				<td>No zip code</td>
			</tr>
			<cfset nozipcode = nozipcode + 1>
			<cfset errors = errors + 1>			
		</cfif>
		<cfif len(q1.meetingcode) LT 1> 
			<tr>
				<td width=50>&nbsp;</td>
				<td>#q1.currentrow#</b></td>
				<td>No meeting code</td>
			</tr>
			<cfset nomeetingcode = nomeetingcode + 1>
			<cfset errors = errors + 1>			
		</cfif>
		<cfif len(q1.apptdate) LT 1> 
			<tr>
				<td width=50>&nbsp;</td>
				<td>#q1.currentrow#</b></td>
				<td>No meeting date</td>
			</tr>
			<cfset noapptdate = noapptdate + 1>
			<cfset errors = errors + 1>			
		</cfif>
		<cfif len(q1.meetingcode) LT 1> 
			<tr>
				<td width=50>&nbsp;</td>
				<td>#q1.currentrow#</b></td>
				<td>No meeting code</td>
			</tr>
			<cfset nomeetingcode = nomeetingcode + 1>
			<cfset errors = errors + 1>			
		</cfif>
		<cfif len(q1.certnum) LT 1> 
			<tr>
				<td width=50>&nbsp;</td>
				<td>#q1.certnum#</b></td>
				<td>No certificate number</td>
			</tr>
			<cfset nocertnum = nocertnum + 1>
			<cfset errors = errors + 1>			
		</cfif>
		<cfif len(q1.issuedate) LT 1> 
			<tr>
				<td width=50>&nbsp;</td>
				<td>#q1.issuedate#</b></td>
				<td>No certificate issue date</td>
			</tr>
			<cfset noissuedate = noissuedate + 1>
			<cfset errors = errors + 1>			
		</cfif>
		<cfif len(q1.batchnum) LT 1> 
			<tr>
				<td width=50>&nbsp;</td>
				<td>#q1.currentrow#</b></td>
				<td>No batch number</td>
			</tr>
			<cfset nobatchnum = nobatchnum + 1>
			<cfset errors = errors + 1>			
		</cfif>
		<cfif len(q1.roster_rowid) LT 1> 
			<tr>
				<td width=50>&nbsp;</td>
				<td>#q1.currentrow#</b></td>
				<td>No row ID number</td>
			</tr>
			<cfset norowid = norowid + 1>
			<cfset errors = errors + 1>			
		</cfif>
		<cfif len(q1.amount) LT 1> 
			<tr>
				<td width=50>&nbsp;</td>
				<td>#q1.currentrow#</b></td>
				<td>No certificate amount</td>
			</tr>
			<cfset noamount = noamount + 1>
			<cfset errors = errors + 1>			
		</cfif>
		<cfif len(q1.source) LT 1> 
			<tr>
				<td width=50>&nbsp;</td>
				<td>#q1.currentrow#</b></td>
				<td>No source data</td>
			</tr>
			<cfset nosource = nosource + 1>
			<cfset errors = errors + 1>			
		</cfif>
		</cfoutput>
		</cfloop>
		<cfif row_exists GT 0>
		<cfoutput>
		<tr>
			<td width=50>&nbsp;</td>
			<td colspan=2><h5><font color="red">#row_exists# rows of #q1.recordcount# already exist in the 'cert_trans' table!</font></h5></td>
		</tr>
		</cfoutput>
		</cfif>
		</table>
		<FORM NAME="issue2-2c" ACTION="" METHOD="post">
		<cfoutput>
		<cfif errors GT 0>
			<!--- errors encountered --->
			<table>
			<tr height=20><td colspan=3>&nbsp;</td></tr>
			<tr>
				<td width=50>&nbsp;</td>
				<td colspan=2><h4><font color="red">#errors# Data validation error(s) were detected!</font></h4></td>
			</tr>
			<tr>
				<td width=50>&nbsp;</td>
				<!---<TD ALIGN="right"><input TYPE="Button"  NAME="run" VALUE=" Continue with Errors " onClick="action = 'roster_cert_issue2.cfm?a=3&#Rand()#'; submit();"></TD>--->
				<td align="right"><input TYPE="Button"  NAME="cancel" VALUE="Cancel" onClick="action = 'roster_cert_issue.cfm'; submit();"></td>
				<td>&nbsp;</td>
			</tr>
			<tr height=20><td colspan=3>&nbsp;</td></tr>
			</table>
		<cfelse>
			<!--- no errors --->
			<table>
			<tr height=20><td colspan=3>&nbsp;</td></tr>
			<tr>
				<td width=50>&nbsp;</td>
				<td colspan=2><h4><font color="green">No data validation errors were detected!</font></h4>Click <i><b>Continue</b></i> to proceed with the certificate upload process, or click <i><b>Cancel</b></i> to terminate this procedure.</td>
			</tr>
			<tr height=20><td colspan=3>&nbsp;</td></tr>
			<tr>
				<td width=50>&nbsp;</td>
				<TD ALIGN="right"><input TYPE="Button"  NAME="continue" VALUE=" Continue " onClick="action = 'roster_cert_issue2.cfm?a=3&#Rand()#'; submit();"></TD>
				<td align="right"><input TYPE="Button"  NAME="cancel" VALUE=" Cancel " onClick="action = 'roster_cert_issue.cfm'; submit();"></td>
			</tr>
			<tr height=20><td colspan=3>&nbsp;</td></tr>
			</table>
		</cfif>
		</cfoutput>
		</form>
	</cfif>
</CFCASE>
<!--- step #3 --->
<CFCASE VALUE="3">
	<table border="0">
	<tr>
		<td width=50>&nbsp;</td>
		<td colspan=3><h4><font color="green">Uploading certificate issuance data, please wait...</font></h4></td>		
	</tr>
	</table>
	<cfoutput>
	<META HTTP-EQUIV="refresh" CONTENT="3; URL=roster_cert_issue2.cfm?a=4&#Rand()#">
	</cfoutput>
</cfcase>
<!--- step #4 --->
<CFCASE VALUE="4">
	<!--- Pull all certificate data rows --->
	<CFQUERY DATASOURCE="#application.rosterDSN#"  NAME="q2">
		select lastname, firstname, address1, address2, city, state, zipcode, phone, meetingcode,
			program_title, apptdate, certnum, issuedate, batchnum, roster_rowid, amount, source
			from cert_issue
	</CFQUERY>

	<!--- set up some variables --->
	<cfset logfile = "C:\users shared folders\certificates issued\cert_issued.log">
	<cfset sDate = "#dateFormat(Now(), 'yyyymmdd')#">
	<cfset sSource = "">
	<cfset iUpdated = 0>
	<cfset iInserted = 0>
	<cfoutput query="q2">
		<cfif q2.currentrow EQ 1><cfset sSource = #trim(q2.source)#></cfif>	
		<!--- look for matching cert_trans row --->
		<CFQUERY DATASOURCE="#application.rosterDSN#"  NAME="q3">
			select batchnum, trans_type, cert from cert_trans 
			where cert_trans.batchnum = '#q2.batchnum#' AND cert_trans.trans_type = 'I' AND cert_trans.cert = '#q2.certnum#' 
		</CFQUERY>
		 
		<cfif q3.recordcount EQ 0>
			<!--- insert new row --->
			<CFQUERY DATASOURCE="#application.rosterDSN#"  NAME="q3">
				INSERT INTO cert_trans (batchnum, cert, trans_date, issue_date, trans_type, roster_rowid, 
					lastname, firstname, address1, address2, city, state, zipcode, phone, source, updated) 
				VALUES ( '#q2.batchnum#', '#q2.certnum#', '#q2.issuedate#', '#q2.issuedate#', 'I', #q2.roster_rowid#,
							'#trim(q2.lastname)#', '#trim(q2.firstname)#', '#trim(address1)#', '#trim(sddress2)#',
							'#trim(q2.city)#', '#trim(q2.state)#', '#trim(q2.zipcode)#', '#trim(q2.phone)#', '#trim(q2.source)#', '#sDate#')
			</CFQUERY>
			<cfset iInserted = iInserted + 1>
		<cfelse>
			<!--- update existing row --->
			<CFQUERY DATASOURCE="#application.rosterDSN#"  NAME="q4">
				UPDATE cert_trans 
					set batchnum = '#q2.batchnum#', cert = '#q2.certnum#', trans_date = '#q2.issuedate#',
						issue_date = '#q2.issuedate#', trans_type = 'I', roster_rowid = #q2.roster_rowid#,
						lastname = '#trim(q2.lastname)#', firstname = '#trim(q2.firstname)#', 
						address1 = '#trim(q2.address1)#', address2 = '#trim(q2.address2)#', 
						city = '#trim(q2.city)#', state = '#trim(state)#', zipcode = '#trim(q2.zipcode)#',
						phone = '#trim(q2.phone)#', source = '#trim(q2.source)#', updated = '#sDate#'
				where cert_trans.batchnum = '#q2.batchnum#' AND cert_trans.trans_type = 'I' AND cert_trans.cert = '#q2.certnum#' 
			</CFQUERY>
			<cfset iUpdated = iUpdated + 1>
		</cfif>
	</cfoutput>
	<!--- write log file entry --->
	<cffile action="append" file="#logfile#" addnewline="yes" output="#dateFormat(Now(), 'yyyymmdd')#|#sSource#|Inserted: #iInserted# rows|Updated: #iUpdated# rows">
	<FORM NAME="step3" ACTION="" METHOD="post">
	<cfoutput>
	<table>
	<tr>
		<td width=50>&nbsp;</td>
		<TD colspan=2><h4><font color="green">Processing Complete!</font></h4></TD>
	</tr>
	<tr>
		<td width=50>&nbsp;</td>
		<TD colspan=2>#iInserted# new rows were added to the 'cert_trans' table.</TD>
	</tr>
	<tr>
		<td width=50>&nbsp;</td>
		<TD colspan=2>#iUpdated# existing rows were updated in the 'cert_trans' table.</TD>
	</tr>
	<cfset iTotal = #iInserted# + #iUpdated#>
	<tr>
		<td width=50>&nbsp;</td>
		<TD colspan=2>#iTotal# rows were processed.</TD>
	</tr>
	<tr height=20><td colspan=3>&nbsp;</td></tr>
	<tr>
		<td width=50>&nbsp;</td>
		<TD colspan=2>Please select a new function from the menu...</TD>
	</tr>
	</table>
	</cfoutput>
	</form>
</cfcase>
		
<!--- If no case is specified user is sent a processing error --->
<CFDEFAULTCASE>
	<cfoutput>
	<FORM NAME="cert2" ACTION="" METHOD="post">
	</cfoutput>
	<table>
	<tr>
		<td width=50>&nbsp;</td>
		<td colspan=3><h4><font color=red>A processing error has occurred!  Please try again...</font></h4></td>
	</tr>
	<tr height=20><td colspan=3>&nbsp;</td></tr>
	<tr>
		<td width=50>&nbsp;</td>
		<TD ALIGN="right"><input TYPE="Button"  NAME="tryagain" VALUE="Try Again" onClick="action = 'roster_cert_issue.cfm'; submit();"></TD>
		<td>&nbsp;</td>
	</tr>
	<tr height=50><td colspan=3>&nbsp;</td></tr>
	</table>
	</form>
</CFDEFAULTCASE>
</CFSWITCH>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

