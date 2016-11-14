<!--------------------------------------------------------------------
-- roster_certificates2.cfm
-- Ben Jurevicius - 06192003
-- Ben Jurevicius - 12112003 - modified step 3 to create separate files for each client code
--								rather than each compy code.
-- Rich Sloan - 071405 - Modified step 3 to use 7 digit meeting code to create files instead of 5
--                              digit meeting code, this will cause the files generate on those codes.
-- Rich Sloan = 072005 - Modified Step 3 to use quoted identifier for text, this involved creating 2
--                              variables, DataHeader and DataOutput to hold the strings.
--
-- Pulls roster data based on the dates entered in roster_certificates.cfm
--
-- This program has 2 steps:
-- 1) pull and tabluate all the data by compnay and product.
-- 2) generate the certiciate report if prove by the user.
--
-----------------------------------------------------------------------
--->

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Certificates- Pull Date" showCalendar="0">

<SCRIPT SRC="/includes/libraries/PIW1checker.js"></SCRIPT>

<cfsetting requesttimeout=6400>
<cfset sGROUPDYNAMICS = "03">
<cfset sSHARECOM = "23">
<cfset sVISTACOM = "07">
<cfset sPHARMAKON = "00">

<CFSWITCH EXPRESSION="#URL.a#">
<!--- Step #1 --->
<CFCASE VALUE="1">
	<!--- Pull appropriate row for the selected project code --->
	<CFQUERY DATASOURCE="#application.MasterDSN#"  NAME="step1">
		SELECT r.meetingcode, r.eventdate, count(r.meetingcode) as cnt
		FROM roster r, rosteraccounts a
		  WHERE r.projectid = a.projectid
		    AND r.meetingcode = a.meetingcode
		    AND r.phid = a.phid
			AND r.eventdate between #Createodbcdate(form.begin_date)# and #Createodbcdate(form.end_date)#
			AND r.closed = 0
			AND r.attended = 0
			AND a.honorariatype = 1
			GROUP BY r.meetingcode, r.eventdate
			ORDER BY r.meetingcode, r.eventdate
	</CFQUERY>
	<body>
	<table border="0">
	<tr>
		<td width=50>&nbsp;</td>
		<td colspan=3><b>Attendees requiring honoraria certificate issuance</b></td>
	</tr>
	<tr>
		<td width=50>&nbsp;</td>
		<td><b>Appt. Date</b></td>
		<td><b>Meeting Code</b></td>
		<td><b>Attendees</b></td>
	</tr>
	<cfset m_cbeck_tot = 0>
	<cfset m_groupdynamics_tot = 0>
	<cfset m_sharecom_tot = 0>
	<cfset m_vistacom_tot = 0>
	<cfset m_pharmakon_tot = 0>
	<cfset m_grand_tot = 0>
	<cfset a_cbeck_tot = 0>
	<cfset a_groupdynamics_tot = 0>
	<cfset a_sharecom_tot = 0>
	<cfset a_vistacom_tot = 0>
	<cfset a_pharmakon_tot = 0>
	<cfset a_grand_tot = 0>
	<cfoutput query="step1">
	<tr>
		<td width=50>&nbsp;</td>
		<td>#DateFormat(step1.eventdate, "mm/dd/yyyy")#</b></td>
		<td>#trim(step1.meetingcode)#</b></td>
		<td>#step1.cnt#</b></td>
		<cfset m_grand_tot = m_grand_tot + 1>
		<cfset a_grand_tot = a_grand_tot + #step1.cnt#>
		<cfif #left(step1.meetingcode, 1)# EQ "C">
			<cfset m_cbeck_tot = m_cbeck_tot + 1>
			<cfset a_cbeck_tot = a_cbeck_tot + #step1.cnt#>
		</cfif>
		<cfif #left(step1.meetingcode, 1)# EQ "G">
			<cfset m_groupdynamics_tot = m_groupdynamics_tot + 1>
			<cfset a_groupdynamics_tot = a_groupdynamics_tot + #step1.cnt#>
		</cfif>
		<cfif #left(step1.meetingcode, 1)# EQ "S">
			<cfset m_sharecom_tot = m_sharecom_tot + 1>
			<cfset a_sharecom_tot = a_sharecom_tot + #step1.cnt#>
		</cfif>
		<cfif #left(step1.meetingcode, 1)# EQ "V">
			<cfset m_vistacom_tot = m_vistacom_tot + 1>
			<cfset a_vistacom_tot = a_vistacom_tot + #step1.cnt#>
		</cfif>
		<cfif #left(step1.meetingcode, 1)# EQ "P">
			<cfset m_pharmakon_tot = m_pharmakon_tot + 1>
			<cfset a_pharmakon_tot = a_pharmakon_tot + #step1.cnt#>
		</cfif>
	</tr>
	</cfoutput>
	</table>
	<table>
	<cfoutput>
	<tr>
		<td width=50>&nbsp;</td>
		<td colspan=3><b>Total Attendees by Company</b></td>
	</tr>
	<tr>
		<td width=50>&nbsp;</td>
		<td>&nbsp;</td>
		<td><b>## Meetings</b></td>
		<td><b>## Attendees</b></td>
	</tr>
	<cfif m_cbeck_tot GT 0>
	<tr>
		<td width=50>&nbsp;</td>
		<td align=right><b>C. Beck </b></td>
		<td align=center>#m_cbeck_tot#</b></td>
		<td align=center>#a_cbeck_tot#</b></td>
	</tr>
	</cfif>
	<cfif m_groupdynamics_tot GT 0>
	<tr>
		<td width=50>&nbsp;</td>
		<td align=right><b>Group Dynamics </b></td>
		<td align=center>#m_groupdynamics_tot#</b></td>
		<td align=center>#a_groupdynamics_tot#</b></td>
	</tr>
	</cfif>
	<cfif m_sharecom_tot GT 0>
	<tr>
		<td width=50>&nbsp;</td>
		<td align=right><b>Share-Com </b></td>
		<td align=center>#m_sharecom_tot#</b></td>
		<td align=center>#a_sharecom_tot#</b></td>
	</tr>
	</cfif>
	<cfif m_vistacom_tot GT 0>
	<tr>
		<td width=50>&nbsp;</td>
		<td align=right><b>Vista-Com </b></td>
		<td align=center>#m_vistacom_tot#</b></td>
		<td align=center>#a_vistacom_tot#</b></td>
	</tr>
	</cfif>
	<cfif m_Pharmakon_tot GT 0>
	<tr>
		<td width=50>&nbsp;</td>
		<td align=right><b>Pharmakon </b></td>
		<td align=center>#m_pharmakon_tot#</b></td>
		<td align=center>#a_pharmakon_tot#</b></td>
	</tr>
	</cfif>
	<tr>
		<td width=50>&nbsp;</td>
		<td colspan=3 align=right><b>==============================</b></td>
	</tr>
	<tr>
		<td width=50>&nbsp;</td>
		<td align=right><b>Total Attendees </b></td>
		<td align=center>#m_grand_tot#</b></td>
		<td align=center>#a_grand_tot#</b></td>
	</tr>
	</cfoutput>
	</table>
	<FORM NAME="step1" ACTION="" METHOD="post">
	<table>
	<cfoutput>
	<tr>
		<td width=50>&nbsp;</td>
		<TD ALIGN="right"><input TYPE="Button"  NAME="run" VALUE="Create Honoraria Report" onClick="action = 'roster_certificates2.cfm?a=2&bd=#form.begin_date#&ed=#form.end_date#&#Rand()#'; submit();"></TD>
		<td align="right"><input TYPE="Button"  NAME="cancel" VALUE="Cancel" onClick="action = 'roster_certificates.cfm'; submit();"></td>
	</tr>
	</cfoutput>
	<tr height=20><td colspan=3>&nbsp;</td></tr>
	</table>
	</form>

</CFCASE>
<!--- step #2 --->
<CFCASE VALUE="2">

	<FORM NAME="step2" ACTION="roster_certificates2.cfm?a=3&#Rand()#" METHOD="post">
	<table>
	<tr>
		<td width=50>&nbsp;</td>
		<td colspan=2 align=center><h5><font color="red">Attention! Roster data will be updated!</font></h5><b>Are you sure you wish to continue?</b><br><br></td>
	</tr>
	<cfoutput>
	<tr>
		<td width=50>&nbsp;</td>
		<TD ALIGN="right"><input TYPE="Button"  NAME="continue" VALUE="Continue" onClick="action = 'roster_certificates2.cfm?a=3&bd=#url.bd#&ed=#url.ed#&#Rand()#'; submit();"></TD>
		<td align="right"><input TYPE="Button"  NAME="cancel2" VALUE="Cancel" onClick="action = 'roster_certificates.cfm'; submit();"></td>
	</tr>
	</cfoutput>
	<tr height=20><td colspan=3>&nbsp;</td></tr>
	</table>
	</form>

</cfcase>
<!--- step #3 --->
<CFCASE VALUE="3">
	<!--- Pull attendees requiring honraria --->
	<CFQUERY DATASOURCE="#application.MasterDSN#"  NAME="step3">
	    select r.projectID, r.meetingcode, p.lastname, p.firstname,
		  c.shipaddress1 as address1, c.shipaddress2 as address2, c.shipcity as city, c.shipstate as state, c.shipzip as zip,
			c.officephone as phone1, r.eventdate, r.phid, a.honorariaamt, p.menum
		FROM roster r, Physician p, rostercontacts c, PhysicianContact S, rosteraccounts a
		 where r.projectid = a.projectid
		  AND c.projectid = a.projectid
		  AND r.meetingcode = a.meetingcode
		  and c.meetingcode = a.meetingcode
		  AND r.phid = a.phid
		  AND r.phid = c.phid
		  AND r.phid = p.phid
		  AND r.Phid = s.phid
		  AND r.eventdate between #CreateODBCDate(URL.bd)# and #CreateODBCDate(URL.ed)#
		  AND r.closed = 0
		  AND r.attended = 0
		  AND a.honorariatype = 1
		  ORDER BY r.meetingcode, r.eventdate desc, p.lastname, p.firstname
	</CFQUERY>

	<!--- set up some variables --->
	<!--- old, no longer used
	<cfset sPHARMAKON = "00">
	<cfset sCBECK = "02">
	<cfset sGROUPDYNAMICS = "03">
	<cfset sSHARECOM = "23">
	<cfset sVISTACOM = "07">
	--->
	<cfset iRecNum = 0>
	<cfset sBATCHNUM = "">
	<cfset a_cbeck_tot = 0>
	<cfset a_groupdynamics_tot = 0>
	<cfset a_sharecom_tot = 0>
	<cfset a_vistacom_tot = 0>
	<cfset a_pharmakon_tot = 0>
	<cfset a_grand_tot = 0>
	<cfset fname = "">
	<cfset fpath = "\\beethoven\Users\medsite\">
	<cfset sDate = "#dateFormat(Now(), 'yyyymmdd')#">
	<cfset ThisClient = "">
	<cfset LastClient = "">
	<cfoutput query="step3">
		<cfset ThisClient = #left(step3.meetingcode, 7)#>
		<!--- incremetn record number --->
		<cfset iRecNum = iRecNum + 1>
		<!--- setup next batch number --->
		<cfset sBATCHNUM = "">
		<cfif #left(step3.meetingcode, 1)# EQ "C"><cfset sBATCHNUM = "C" & #sDate# & #NumberFormat(iRecNum, "00000")#>
		<cfelseif #left(step3.meetingcode, 1)# EQ "G"><cfset sBATCHNUM = "G" & #sDate# & #NumberFormat(iRecNum, "00000")#>
		<cfelseif #left(step3.meetingcode, 1)# EQ "P"><cfset sBATCHNUM  = "P" & #sDate# & #NumberFormat(iRecNum, "00000")#>
		<cfelseif #left(step3.meetingcode, 1)# EQ "S"><cfset sBATCHNUM  = "S" & #sDate# & #NumberFormat(iRecNum, "00000")#>
		<cfelseif #left(step3.meetingcode, 1)# EQ "V"><cfset sBATCHNUM  = "V" & #sDate# & #NumberFormat(iRecNum, "00000")#>
		</cfif>

		<!--- Pull PIW info --->
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="pc">
			select piw.guide_topic, piw.product, piw.client, clients.ID, clients.client_name
			from piw, clients
			where piw.project_code = '#left(step3.meetingcode, 9)#'
				and piw.client = clients.ID
		</CFQUERY>
		<cfset DataOutput = "">
		<cfsavecontent variable="Dataheader">PHID,"ACTIVITY CODE","LAST NAME","FIRST NAME","ADDRESS1","ADDRESS2","CITY","STATE","ZIP CODE","PHONE","ACTIVITY DATE","E-MAIL ADDRESS",E-MAIL FLAG,"ACTIVITY NAME",CERTIFICATE,"CLIENT NAME",ME NUMBER,CLIENT SO,"DRUG NAME","BATCH NUMBER"</cfsavecontent>
		<cfsavecontent variable="DataOutput">#step3.Phid#,"#trim(step3.meetingcode)#","#ReplaceNoCase(trim(step3.lastname), Chr(34), '', 'ALL')#","#ReplaceNoCase(trim(step3.firstname), Chr(34), '', 'ALL')#","#ReplaceNoCase(trim(step3.address1), Chr(34), '', 'ALL')#","#ReplaceNoCase(trim(step3.address2), Chr(34), '', 'ALL')#","#trim(step3.city)#","#trim(step3.state)#","#trim(step3.zip)#","#trim(step3.phone1)#","#dateFormat(step3.eventdate, 'mm/dd/yy')#","",,"#ReplaceNoCase(trim(pc.guide_topic), chr(34), '', 'ALL')#",#trim(step3.honorariaamt)#,"#ReplaceNoCase(trim(pc.client_name), Chr(34), '', 'ALL')#",#step3.menum#,,"#ReplaceNoCase(trim(pc.product), Chr(34), '', 'ALL')#","#sBATCHNUM#"</cfsavecontent>

		<cfif ThisClient EQ #LastClient#>
			<cffile action="append" file="#fname#" nameconflict="overwrite"
				output="#DataOutput#">
		<cfelse>
			<cfset LastClient = #ThisClient#>
			<cfset fname = #fpath# & #left(step3.meetingcode, 7)# & "_" & #sDate# & ".csv">
			<cffile action="write" file="#fname#" nameconflict="overwrite"
				output="#Dataheader#">

			<cffile action="append" file="#fname#" nameconflict="overwrite"
				output="#DataOutput#">
		</cfif>
		<cfif #left(step3.meetingcode, 1)# EQ "C"><cfset a_cbeck_tot = a_cbeck_tot + 1>
		<cfelseif #left(step3.meetingcode, 1)# EQ "G"><cfset a_groupdynamics_tot = a_groupdynamics_tot + 1>
		<cfelseif #left(step3.meetingcode, 1)# EQ "P"><cfset a_pharmakon_tot = a_pharmakon_tot + 1>
		<cfelseif #left(step3.meetingcode, 1)# EQ "S"><cfset a_sharecom_tot = a_sharecom_tot + 1>
		<cfelseif #left(step3.meetingcode, 1)# EQ "V"><cfset a_vistacom_tot = a_vistacom_tot + 1>
		</cfif>
		<!--- calculate totals --->
		<cfset a_grand_tot = a_grand_tot + 1>
		<!--- update roster with batch number --->
		<!--- <CFQUERY DATASOURCE="#application.MasterDSN#"  NAME="updateroster">
			update rosteraccountsdetail
			set batchnum = '#sBATCHNUM#'
			where ProjectID = #setp3.projectID#
			AND meetingcode = #step3.meetingCode#
			AND Phid = #Step3.Phid#
		</CFQUERY>  --->
	</cfoutput>

	<FORM NAME="step3" ACTION="" METHOD="post">
	<cfoutput>
	<table>
	<tr>
		<td width=50>&nbsp;</td>
		<TD colspan=2><h4><font color="green">Processing Complete!</font></h4></TD>
	</tr>
	<tr>
		<td width=50>&nbsp;</td>
		<TD colspan=2>Output files are located in <B>#fpath#</B> and are named with today's date: <B>#sDate#</B></TD>
	</tr>
	<tr>
		<td width=50>&nbsp;</td>
		<td colspan=3><b>Total Attendees by Company</b></td>
	</tr>
	<tr>
		<td width=50>&nbsp;</td>
		<td><b></b></td>
		<td align=center><b>## Attendees</b></td>
	</tr>
	<cfif a_cbeck_tot GT 0>
	<tr>
		<td width=50>&nbsp;</td>
		<td align=right><b>C. Beck </b></td>
		<td align=center>#a_cbeck_tot#</b></td>
	</tr>
	</cfif>
	<cfif a_groupdynamics_tot GT 0>
	<tr>
		<td width=50>&nbsp;</td>
		<td align=right><b>Group Dynamics </b></td>
		<td align=center>#a_groupdynamics_tot#</b></td>
	</tr>
	</cfif>
	<cfif a_sharecom_tot GT 0>
	<tr>
		<td width=50>&nbsp;</td>
		<td align=right><b>Share-Com </b></td>
		<td align=center>#a_sharecom_tot#</b></td>
	</tr>
	</cfif>
	<cfif a_vistacom_tot GT 0>
	<tr>
		<td width=50>&nbsp;</td>
		<td align=right><b>Vista-Com </b></td>
		<td align=center>#a_vistacom_tot#</b></td>
	</tr>
	</cfif>
	<cfif a_Pharmakon_tot GT 0>
	<tr>
		<td width=50>&nbsp;</td>
		<td align=right><b>Pharmakon </b></td>
		<td align=center>#a_pharmakon_tot#</b></td>
	</tr>
	</cfif>
	<tr>
		<td width=50>&nbsp;</td>
		<td colspan=2 align=right><b>==============================</b></td>
	</tr>
	<tr>
		<td width=50>&nbsp;</td>
		<td align=right><b>Total Attendees </b></td>
		<td align=center>#a_grand_tot#</b></td>
	</tr>
	<tr>
		<td width=50>&nbsp;</td>
		<TD ALIGN="center"><input TYPE="Button"  NAME="finish" VALUE="Finished" onClick="action = 'roster_certificates.cfm?&#Rand()#'; submit();"></TD>
	</tr>
	<tr height=20><td colspan=3>&nbsp;</td></tr>
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
		<TD ALIGN="right"><input TYPE="Button"  NAME="tryagain" VALUE="Try Again" onClick="action = 'roster_certificates.cfm'; submit();"></TD>
		<td>&nbsp;</td>
	</tr>
	<tr height=50><td colspan=3>&nbsp;</td></tr>
	</table>
	</form>
</CFDEFAULTCASE>
</CFSWITCH>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

