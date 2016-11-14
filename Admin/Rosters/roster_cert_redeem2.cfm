<!--------------------------------------------------------------------
-- roster_cert_redeem2.cfm 
-- Ben Jurevicius - 06242003
--
-- Pulls certificate redemption data from the table 'cert_redeem' in the CBARoster database,
-- matches it to roster data and loads the data into the 'cert_trans' table.
--
-- This program has 2 major functions steps:
-- 1) validate all data in the cert_redeem table.
-- 2) loads certificate redemption transactions into the cert_trans table.
--
-----------------------------------------------------------------------
--->

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Certificate Redemption Data" showCalendar="0">

<SCRIPT SRC="/includes/libraries/PIW1checker.js"></SCRIPT>
<CFSWITCH EXPRESSION="#URL.a#">
<!--- Step #1 - post a processing notice. --->
<CFCASE VALUE="1">

	<table border="0">
	<tr>
		<td width=50>&nbsp;</td>
		<td colspan=3><h4><font color="green">Validating certificate redemption data, please wait...</font></h4>This process verifies that all required data is present and reports any problems.</td>		
	</tr>
	</table>
	<cfoutput>
	<META HTTP-EQUIV="refresh" CONTENT="3; URL=roster_cert_redeem2.cfm?a=2&#Rand()#">
	</cfoutput>

</CFCASE>
<!--- Step #2 - validation the redemption data --->
<CFCASE VALUE="2">
	<!--- Pull all certificate data rows --->
	<CFQUERY DATASOURCE="#application.rosterDSN#"  NAME="q1">
		select trans_type, lastname, firstname, certnum, recvdate, invoice, cert_amount, 
		id_code, meetingcode, batchnum, source	from cert_redeem
	</CFQUERY>

	<cfif q1.recordcount EQ 0>
		<FORM NAME="redeem2-2a" ACTION="" METHOD="post">
		<table border="0">
		<tr>
			<td width=50>&nbsp;</td>
			<td colspan=3><h4><font color="red">No records were found in the 'CERT_REDEEM' table in the CBARoster database.</font></h4></td>		
		</tr>
		<tr height=20><td colspan=3>&nbsp;</td></tr>
		<cfoutput>
		<tr>	
			<td width=50>&nbsp;</td>
			<TD ALIGN="right"><input TYPE="Button"  NAME="run" VALUE=" Cancel " onClick="redeem2-2a.action = 'roster_cert_redeem.cfm?#Rand()#'; redeem2-2a.submit();"></TD>
			<td>&nbsp;</td>
		</tr>
		</cfoutput>			
		<tr height=20><td colspan=3>&nbsp;</td></tr>
		</table>
		</form>
	<cfelse>
		<cfset notranstype = 0>
		<cfset nolastname = 0>
		<cfset nofirstname = 0>
		<cfset nocertnum = 0>
		<cfset norecvdate = 0>
		<cfset noinvoice = 0>
		<cfset nocert_amount = 0>
		<cfset norowid = 0>
		<cfset nomeetingcode = 0>
		<cfset nobatchnum = 0>
		<cfset nosource = 0>
		<cfset errors = 0>
		<cfset row_exists = 0>
		<FORM NAME="redeem2-2b" ACTION="" METHOD="post">
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
			where cert_trans.batchnum = '#q1.batchnum#' AND cert_trans.trans_type = 'RD' AND cert_trans.cert = '#q1.certnum#' 
		</CFQUERY>
		<cfif #qe.recordcount# GT 0><cfset row_exists = row_exists + 1></cfif>
		<cfoutput>
		<!--- check trans_type --->
		<cfif len(q1.trans_type) LT 1> 
			<tr>
				<td width=50>&nbsp;</td>
				<td>#q1.currentrow#</b></td>
				<td>No transaction type</td>
			</tr>
			<cfset notranstype = notranstype + 1>
			<cfset errors = errors + 1>
		</cfif>
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
		<!--- check first name --->
		<cfif len(q1.firstname) LT 1> 
			<tr>
				<td width=50>&nbsp;</td>
				<td>#q1.currentrow#</b></td>
				<td>No firstname name</td>
			</tr>
			<cfset nofirstname = nofirstname + 1>
			<cfset errors = errors + 1>			
		</cfif>
		<cfif len(q1.certnum) LT 1> 
			<tr>
				<td width=50>&nbsp;</td>
				<td>#q1.currentrow#</b></td>
				<td>No certificate number</td>
			</tr>
			<cfset nocertnum = nocertnum + 1>
			<cfset errors = errors + 1>			
		</cfif>
		<!--- check recv date --->
		<cfif len(q1.recvdate) LT 1> 
			<tr>
				<td width=50>&nbsp;</td>
				<td>#q1.currentrow#</b></td>
				<td>No transaction date</td>
			</tr>
			<cfset norecvdate = norecvdate + 1>
			<cfset errors = errors + 1>			
		</cfif>
		<cfif len(q1.invoice) LT 1> 
			<tr>
				<td width=50>&nbsp;</td>
				<td>#q1.currentrow#</b></td>
				<td>No invoice number</td>
			</tr>
			<cfset noinvoice = noinvoice + 1>
			<cfset errors = errors + 1>			
		</cfif>
		<cfif len(q1.cert_amount) LT 1> 
			<tr>
				<td width=50>&nbsp;</td>
				<td>#q1.currentrow#</b></td>
				<td>No certificate amount</td>
			</tr>
			<cfset nocert_amount = nocert_amount + 1>
			<cfset errors = errors + 1>			
		</cfif>
		<cfif len(q1.id_code) LT 1> 
			<tr>
				<td width=50>&nbsp;</td>
				<td>#q1.currentrow#</b></td>
				<td>No ID code (rowid)</td>
			</tr>
			<cfset norowid = norowid + 1>
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
		<cfif len(q1.batchnum) LT 1> 
			<tr>
				<td width=50>&nbsp;</td>
				<td>#q1.currentrow#</b></td>
				<td>No batch number</td>
			</tr>
			<cfset nobatchnum = nobatchnum + 1>
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
				<td align="right"><input TYPE="Button"  NAME="cancel" VALUE="Cancel" onClick="action = 'roster_cert_redeem.cfm'; submit();"></td>
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
				<TD ALIGN="right"><input TYPE="Button"  NAME="continue" VALUE=" Continue " onClick="action = 'roster_cert_redeem2.cfm?a=3&#Rand()#'; submit();"></TD>
				<td align="right"><input TYPE="Button"  NAME="cancel" VALUE=" Cancel " onClick="action = 'roster_cert_redeem.cfm'; submit();"></td>
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
		<td colspan=3><h4><font color="green">Uploading certificate redemption data, please wait...</font></h4></td>		
	</tr>
	</table>
	<cfoutput>
	<META HTTP-EQUIV="refresh" CONTENT="3; URL=roster_cert_redeem2.cfm?a=4&#Rand()#">
	</cfoutput>

</cfcase>
<!--- step #4 --->
<CFCASE VALUE="4">
	<!--- Pull all certificate data rows --->
	<CFQUERY DATASOURCE="#application.rosterDSN#"  NAME="q2">
		select lastname, firstname, certnum, reissue1, reissue2, recvdate, invoice, cert_amount, bill_amount,
			id_code, meetingcode, meetingdate, batchnum, source	from cert_redeem
	</CFQUERY>

	<!--- set up some variables --->
	<cfset logfile = "C:\users shared folders\certificates redeemed\cert_redeemed.log">
	<cfset sDate = "#dateFormat(Now(), 'yyyymmdd')#">
	<cfset sSource = "">
	<cfset iUpdated = 0>
	<cfset iInserted = 0>
	<cfoutput query="q2">	
		<!--- save source info --->
		<cfif q2.currentrow EQ 1><cfset sSource = #trim(q2.source)#></cfif>	
		<!--- look for matching cert_trans row --->
		<CFQUERY DATASOURCE="#application.rosterDSN#"  NAME="q3">
			select batchnum, trans_type, cert from cert_trans 
			where cert_trans.batchnum = '#q2.batchnum#' AND cert_trans.trans_type = 'RD' AND cert_trans.cert = '#q2.certnum#' 
		</CFQUERY>
		 
		<cfif q3.recordcount EQ 0>
			<!--- insert new row --->
			<CFQUERY DATASOURCE="#application.rosterDSN#"  NAME="q4">
				INSERT INTO cert_trans (batchnum, cert, trans_date, trans_type, roster_rowid, 
					lastname, firstname, reissue1, reissue2, invoicenum, source, updated) 
				VALUES ( '#q2.batchnum#', '#q2.certnum#', '#q2.recvdate#', 'RD', #q2.ID_code#,
							'#trim(q2.lastname)#', '#trim(q2.firstname)#', '#trim(q2.reissue1)#',
							'#trim(q2.reissue2)#', '#trim(q2.invoice)#', '#trim(q2.source)#', '#sDate#')
			</CFQUERY>
			<cfset iInserted = iInserted + 1>
		<cfelse>
			<!--- update existing row --->
			<CFQUERY DATASOURCE="#application.rosterDSN#"  NAME="q5">
				UPDATE cert_trans 
					set batchnum = '#q2.batchnum#', cert = '#q2.certnum#', trans_date = '#q2.recvdate#',
						trans_type = 'RD', roster_rowid = #q2.ID_code#,
						lastname = '#trim(q2.lastname)#', firstname = '#trim(q2.firstname)#', 
						reissue1 = '#trim(q2.reissue1)#', reissue2 = '#trim(q2.reissue2)#', 
						invoicenum = '#trim(q2.invoice)#', source = '#trim(q2.source)#', updated = '#sDate#'
				where cert_trans.batchnum = '#q2.batchnum#' AND cert_trans.trans_type = 'RD' AND cert_trans.cert = '#q2.certnum#' 
			</CFQUERY>
			<cfset iUpdated = iUpdated + 1>
		</cfif>
	</cfoutput>

	<!--- write log file entry --->
	<cffile action="append" file="#logfile#" addnewline="yes" output="#dateFormat(now(), 'yyyymmdd')#|#sSource#|Inserted: #iInserted# rows|Updated: #iUpdated# rows">

	<FORM NAME="redeem4" ACTION="" METHOD="post">
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
	<FORM NAME="redeem" ACTION="" METHOD="post">
	</cfoutput>
	<table>
	<tr>
		<td width=50>&nbsp;</td>
		<td colspan=3><h4><font color=red>A processing error has occurred!  Please try again...</font></h4></td>
	</tr>
	<tr height=20><td colspan=3>&nbsp;</td></tr>
	<tr>
		<td width=50>&nbsp;</td>
		<TD ALIGN="right"><input TYPE="Button"  NAME="tryagain" VALUE="Try Again" onClick="action = 'roster_cert_redeem.cfm'; submit();"></TD>
		<td>&nbsp;</td>
	</tr>
	<tr height=50><td colspan=3>&nbsp;</td></tr>
	</table>
	</form>
</CFDEFAULTCASE>
</CFSWITCH>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

