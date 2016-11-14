
<CFSWITCH EXPRESSION="#URL.a#">
<!--- Default case to present edit selection form to user --->
<CFCASE VALUE="c">
<cfoutput>

<CFQUERY DATASOURCE="#application.WeeklyRptDSN#" NAME="qprogram_check">
SELECT projectcode
FROM Weekly_Reports_Decile_Information
where projectcode = '#session.project_code2#'
</CFQUERY>

<cfif NOT qprogram_check.recordcount>

<CFQUERY DATASOURCE="#application.WeeklyRptDSN#" NAME="qdecile">
INSERT INTO Weekly_Reports_Decile_Information
	(
		clientcode,projectcode,
		<CFIF isDefined("form.fchkDecile1")>
		decile1_exist,decile1_name,decile1_location_number,
		<CFELSE>decile1_exist,</CFIF>
		<CFIF isDefined("form.fchkDecile2")>
		decile2_exist,decile2_name,decile2_location_number,
		<CFELSE>decile2_exist,</CFIF>
		<CFIF isDefined("form.fchkDecile3")>
		decile3_exist,decile3_name,decile3_location_number
		<CFELSE>decile3_exist</CFIF>

	)
VALUES(
	'#session.client_code2#','#session.project_code2#',
	<CFIF isDefined("form.fchkDecile1")>
	1,'#form.fDecile1Name#',#form.fDecile1Location#,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkDecile2")>
	1,'#form.fDecile2Name#',#form.fDecile2Location#,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkDecile3")>
	1,'#form.fDecile3Name#',#form.fDecile3Location#<CFELSE>0</CFIF>
	)
</CFQUERY>


<CFQUERY DATASOURCE="#application.WeeklyRptDSN#" NAME="qpoll">
INSERT INTO Weekly_Reports_Poll
	(
		clientcode,projectcode,
		<CFIF isDefined("form.fchkPoll1")>poll1,poll1_short,poll1_long,<CFELSE>poll1,</CFIF>
		<CFIF isDefined("form.fchkPoll2")>poll2,poll2_short,poll2_long,<CFELSE>poll2,</CFIF>
		<CFIF isDefined("form.fchkPoll3")>poll3,poll3_short,poll3_long<CFELSE>poll3</CFIF>

	)
VALUES(
	'#session.client_code2#','#session.project_code2#',
	<CFIF isDefined("form.fchkPoll1")>1,'#form.fPoll1Short#','#form.fPoll1Long#',<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkPoll2")>1,'#form.fPoll2Short#','#form.fPoll2Long#',<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkPoll3")>1,'#form.fPoll31Short#','#form.fPoll3Long#'<CFELSE>0</CFIF>

	)
</CFQUERY>

<cfset todayDate = Now()>



<CFQUERY DATASOURCE="#application.WeeklyRptDSN#" NAME="qprogram_info">
INSERT INTO Weekly_Reports_Program_Information
	(
		clientcode, projectcode,
		program_name,
		<CFIF isDefined("form.fchkSpeakers")>speaker_info_exist,<CFELSE>speaker_info_exist,</CFIF>
		<CFIF isDefined("form.fchkCIData")>ci_data_exist,<CFELSE>ci_data_exist,</CFIF>
		<CFIF isDefined("fchkPolling")>polling_data_exist,<CFELSE>polling_data_exist,</CFIF>
		created_uid,
		created_date,
		edited_uid,
		edited_date

	)
VALUES(
<cfoutput>
	'#session.client_code2#','#session.project_code2#',
	'#form.fProgramName#',
	<CFIF isDefined("form.fchkSpeakers")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkCIData")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("fchkPolling")>1,<CFELSE>0,</CFIF>
	151,
	#DateFormat(todayDate, "mm/dd/yy")#,
	151,
	#DateFormat(todayDate, "mm/dd/yy")#
	</cfoutput>
	)
</CFQUERY>


<CFQUERY DATASOURCE="#application.WeeklyRptDSN#" NAME="qquery_exists">


INSERT INTO Weekly_Reports_Query_Exists
	(
		clientcode, projectcode,
		prime_specialty,
		menum,
		moderator,
		db_match,
		s1, s2, s3, s4, s5, s6, s7, s8, s9, s10,
		u5,
		terr1, terr2, terr3, terr4, terr5, terr6, terr7, terr8
	)
VALUES(
	'#session.client_code2#','#session.project_code2#',
	<CFIF isDefined("form.fchkprime_specialty")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkmenum")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkmoderator")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkdb_match")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkS1")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkS2")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkS3")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkS4")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkS5")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkS6")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkS7")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkS8")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkS9")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkS10")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchku5")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkterr1")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkterr2")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkterr3")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkterr4")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkterr5")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkterr6")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkterr7")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkterr8")>1<CFELSE>0</CFIF>
	)

</CFQUERY>


<CFQUERY DATASOURCE="#application.WeeklyRptDSN#" NAME="qquery_label">

INSERT INTO Weekly_Reports_Query_Labels
	(
		clientcode
		,projectcode
		<CFIF isDefined("form.fchkS1")>,s1_name</CFIF>
		<CFIF isDefined("form.fchkS2")>,s2_name</CFIF>
		<CFIF isDefined("form.fchkS3")>,s3_name</CFIF>
		<CFIF isDefined("form.fchkS4")>,s4_name</CFIF>
		<CFIF isDefined("form.fchkS5")>,s5_name</CFIF>
		<CFIF isDefined("form.fchkS6")>,s6_name</CFIF>
		<CFIF isDefined("form.fchkS7")>,s7_name</CFIF>
		<CFIF isDefined("form.fchkS8")>,s8_name</CFIF>
		<CFIF isDefined("form.fchkS9")>,s9_name</CFIF>
		<CFIF isDefined("form.fchkS10")>,s10_name</CFIF>
		<CFIF isDefined("form.fchku5")>,u5_name</CFIF>
		<CFIF isDefined("form.fchkterr1")>,terr1_name</CFIF>
		<CFIF isDefined("form.fchkterr2")>,terr2_name</CFIF>
		<CFIF isDefined("form.fchkterr3")>,terr3_name</CFIF>
		<CFIF isDefined("form.fchkterr4")>,terr4_name</CFIF>
		<CFIF isDefined("form.fchkterr5")>,terr5_name</CFIF>
		<CFIF isDefined("form.fchkterr6")>,terr6_name</CFIF>
		<CFIF isDefined("form.fchkterr7")>,terr7_name</CFIF>
		<CFIF isDefined("form.fchkterr8")>,terr8_name</CFIF>

	)
VALUES(
	'#session.client_code2#'
	,'#session.project_code2#'
	<CFIF isDefined("form.fchkS1")>,'#form.fs1_name#'</CFIF>
	<CFIF isDefined("form.fchkS2")>,'#form.fs2_name#'</CFIF>
	<CFIF isDefined("form.fchkS3")>,'#form.fs3_name#'</CFIF>
	<CFIF isDefined("form.fchkS4")>,'#form.fs4_name#'</CFIF>
	<CFIF isDefined("form.fchkS5")>,'#form.fs5_name#'</CFIF>
	<CFIF isDefined("form.fchkS6")>,'#form.fs6_name#'</CFIF>
	<CFIF isDefined("form.fchkS7")>,'#form.fs7_name#'</CFIF>
	<CFIF isDefined("form.fchkS8")>,'#form.fs8_name#'</CFIF>
	<CFIF isDefined("form.fchkS9")>,'#form.fs9_name#'</CFIF>
	<CFIF isDefined("form.fchkS10")>,'#form.fs10_name#'</CFIF>
	<CFIF isDefined("form.fchku5")>,'#form.fu5_name#'</CFIF>
	<CFIF isDefined("form.fchkterr1")>,'#form.fterr1_name#'</CFIF>
	<CFIF isDefined("form.fchkterr2")>,'#form.fterr2_name#'</CFIF>
	<CFIF isDefined("form.fchkterr3")>,'#form.fterr3_name#'</CFIF>
	<CFIF isDefined("form.fchkterr4")>,'#form.fterr4_name#'</CFIF>
	<CFIF isDefined("form.fchkterr5")>,'#form.fterr5_name#'</CFIF>
	<CFIF isDefined("form.fchkterr6")>,'#form.fterr6_name#'</CFIF>
	<CFIF isDefined("form.fchkterr7")>,'#form.fterr7_name#'</CFIF>
	<CFIF isDefined("form.fchkterr8")>,'#form.fterr8_name#'</CFIF>
	)
</CFQUERY>


<CFELSE>
Project Code: #session.project_code2# Already Exists! <br><br>
Please <a href="rpt_weeklyReportsSetup_edit.cfm">Edit</a> this Project Code.
</cfif>

</cfoutput>
</CFCASE>
<!---   ----->
<CFCASE VALUE="a">
<cfoutput>

<CFQUERY DATASOURCE="#application.WeeklyRptDSN#" NAME="qprogram_check">
SELECT projectcode
FROM Weekly_Reports_Decile_Information
where projectcode = '#session.project_code#'
</CFQUERY>

<cfif NOT qprogram_check.recordcount>

<CFQUERY DATASOURCE="#application.WeeklyRptDSN#" NAME="qdecile">
INSERT INTO Weekly_Reports_Decile_Information
	(
		clientcode,projectcode,
		<CFIF isDefined("form.fchkDecile1")>
		decile1_exist,decile1_name,decile1_location_number,
		<CFELSE>decile1_exist,</CFIF>
		<CFIF isDefined("form.fchkDecile2")>
		decile2_exist,decile2_name,decile2_location_number,
		<CFELSE>decile2_exist,</CFIF>
		<CFIF isDefined("form.fchkDecile3")>
		decile3_exist,decile3_name,decile3_location_number
		<CFELSE>decile3_exist</CFIF>

	)
VALUES(
	'#session.client_code#','#session.project_code#',
	<CFIF isDefined("form.fchkDecile1")>
	1,decile1_name='#form.fDecile1Name#',#form.fDecile1Location#,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkDecile2")>
	1,decile2_name='#form.fDecile2Name#',#form.fDecile2Location#,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkDecile3")>
	1,decile3_name='#form.fDecile3Name#',#form.fDecile3Location#<CFELSE>0</CFIF>
	)
</CFQUERY>


<CFQUERY DATASOURCE="#application.WeeklyRptDSN#" NAME="qpoll">
INSERT INTO Weekly_Reports_Poll
	(
		clientcode,projectcode,
		<CFIF isDefined("form.fchkPoll1")>poll1,poll1_short,poll1_long,<CFELSE>poll1,</CFIF>
		<CFIF isDefined("form.fchkPoll2")>poll2,poll2_short,poll2_long,<CFELSE>poll2,</CFIF>
		<CFIF isDefined("form.fchkPoll3")>poll3,poll3_short,poll3_long<CFELSE>poll3</CFIF>

	)
VALUES(
	'#session.client_code#','#session.project_code#',
	<CFIF isDefined("form.fchkPoll1")>1,'#form.fPoll1Short#','#form.fPoll1Long#',<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkPoll2")>1,'#form.fPoll2Short#','#form.fPoll2Long#',<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkPoll3")>1,'#form.fPoll31Short#','#form.fPoll3Long#'<CFELSE>0</CFIF>

	)
</CFQUERY>

<cfset todayDate = Now()>



<CFQUERY DATASOURCE="#application.WeeklyRptDSN#" NAME="qprogram_info">
INSERT INTO Weekly_Reports_Program_Information
	(
		clientcode, projectcode,
		program_name,
		<CFIF isDefined("form.fchkSpeakers")>speaker_info_exist,<CFELSE>speaker_info_exist,</CFIF>
		<CFIF isDefined("form.fchkCIData")>ci_data_exist,<CFELSE>ci_data_exist,</CFIF>
		<CFIF isDefined("fchkPolling")>polling_data_exist,<CFELSE>polling_data_exist,</CFIF>
		created_uid,
		created_date,
		edited_uid,
		edited_date

	)
VALUES(
	'#session.client_code#','#session.project_code#',
	'#form.fProgramName#',
	<CFIF isDefined("form.fchkSpeakers")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkCIData")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("fchkPolling")>1,<CFELSE>0,</CFIF>
	#session.userinfo.rowid#,
	#DateFormat(todayDate, "mm/dd/yy")#,
	#session.userinfo.rowid#,
	#DateFormat(todayDate, "mm/dd/yy")#
	)
</CFQUERY>


<CFQUERY DATASOURCE="#application.WeeklyRptDSN#" NAME="qquery_exists">


INSERT INTO Weekly_Reports_Query_Exists
	(
		clientcode, projectcode,
		prime_specialty,
		menum,
		moderator,
		db_match,
		s1, s2, s3, s4, s5, s6, s7, s8, s9, s10,
		u5,
		terr1, terr2, terr3, terr4, terr5, terr6, terr7, terr8
	)
VALUES(
	'#session.client_code#','#session.project_code#',
	<CFIF isDefined("form.fchkprime_specialty")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkmenum")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkmoderator")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkdb_match")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkS1")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkS2")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkS3")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkS4")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkS5")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkS6")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkS7")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkS8")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkS9")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkS10")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchku5")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkterr1")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkterr2")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkterr3")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkterr4")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkterr5")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkterr6")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkterr7")>1,<CFELSE>0,</CFIF>
	<CFIF isDefined("form.fchkterr8")>1<CFELSE>0</CFIF>
	)

</CFQUERY>


<CFQUERY DATASOURCE="#application.WeeklyRptDSN#" NAME="qquery_label">

INSERT INTO Weekly_Reports_Query_Labels
	(
		clientcode
		,projectcode
		<CFIF isDefined("form.fchkS1")>,s1_name</CFIF>
		<CFIF isDefined("form.fchkS2")>,s2_name</CFIF>
		<CFIF isDefined("form.fchkS3")>,s3_name</CFIF>
		<CFIF isDefined("form.fchkS4")>,s4_name</CFIF>
		<CFIF isDefined("form.fchkS5")>,s5_name</CFIF>
		<CFIF isDefined("form.fchkS6")>,s6_name</CFIF>
		<CFIF isDefined("form.fchkS7")>,s7_name</CFIF>
		<CFIF isDefined("form.fchkS8")>,s8_name</CFIF>
		<CFIF isDefined("form.fchkS9")>,s9_name</CFIF>
		<CFIF isDefined("form.fchkS10")>,s10_name</CFIF>
		<CFIF isDefined("form.fchku5")>,u5_name</CFIF>
		<CFIF isDefined("form.fchkterr1")>,terr1_name</CFIF>
		<CFIF isDefined("form.fchkterr2")>,terr2_name</CFIF>
		<CFIF isDefined("form.fchkterr3")>,terr3_name</CFIF>
		<CFIF isDefined("form.fchkterr4")>,terr4_name</CFIF>
		<CFIF isDefined("form.fchkterr5")>,terr5_name</CFIF>
		<CFIF isDefined("form.fchkterr6")>,terr6_name</CFIF>
		<CFIF isDefined("form.fchkterr7")>,terr7_name</CFIF>
		<CFIF isDefined("form.fchkterr8")>,terr8_name</CFIF>

	)
VALUES(
	'#session.client_code#'
	,'#session.project_code#'
	<CFIF isDefined("form.fchkS1")>,'#form.fs1_name#'</CFIF>
	<CFIF isDefined("form.fchkS2")>,'#form.fs2_name#'</CFIF>
	<CFIF isDefined("form.fchkS3")>,'#form.fs3_name#'</CFIF>
	<CFIF isDefined("form.fchkS4")>,'#form.fs4_name#'</CFIF>
	<CFIF isDefined("form.fchkS5")>,'#form.fs5_name#'</CFIF>
	<CFIF isDefined("form.fchkS6")>,'#form.fs6_name#'</CFIF>
	<CFIF isDefined("form.fchkS7")>,'#form.fs7_name#'</CFIF>
	<CFIF isDefined("form.fchkS8")>,'#form.fs8_name#'</CFIF>
	<CFIF isDefined("form.fchkS9")>,'#form.fs9_name#'</CFIF>
	<CFIF isDefined("form.fchkS10")>,'#form.fs10_name#'</CFIF>
	<CFIF isDefined("form.fchku5")>,'#form.fu5_name#'</CFIF>
	<CFIF isDefined("form.fchkterr1")>,'#form.fterr1_name#'</CFIF>
	<CFIF isDefined("form.fchkterr2")>,'#form.fterr2_name#'</CFIF>
	<CFIF isDefined("form.fchkterr3")>,'#form.fterr3_name#'</CFIF>
	<CFIF isDefined("form.fchkterr4")>,'#form.fterr4_name#'</CFIF>
	<CFIF isDefined("form.fchkterr5")>,'#form.fterr5_name#'</CFIF>
	<CFIF isDefined("form.fchkterr6")>,'#form.fterr6_name#'</CFIF>
	<CFIF isDefined("form.fchkterr7")>,'#form.fterr7_name#'</CFIF>
	<CFIF isDefined("form.fchkterr8")>,'#form.fterr8_name#'</CFIF>
	)
</CFQUERY>


<CFELSE>
Project Code: #session.project_code# Already Exists! <br><br>
Please <a href="rpt_weeklyReportsSetup_edit.cfm">Edit</a> this Project Code.
</cfif>

</cfoutput>
</CFCASE>

<CFCASE VALUE="u">
<cfoutput>

<cfset todayDate = Now()>

<CFQUERY DATASOURCE="#application.WeeklyRptDSN#" NAME="qprogram_info">

UPDATE Weekly_Reports_Program_Information
SET
	program_name='#form.fProgramName#',
	<CFIF isDefined("form.fchkSpeakers")>
	speaker_info_exist=1,
	<CFELSE>
	speaker_info_exist=0,
	</CFIF>
	<CFIF isDefined("form.fchkCIData")>
	ci_data_exist=1,
	<CFELSE>
	ci_data_exist=0,
	</CFIF>
	<CFIF isDefined("fchkPolling")>
	polling_data_exist=1,
	<CFELSE>
	polling_data_exist=0,
	</CFIF>
	edited_uid=#session.userinfo.rowid#,
	edited_date = #DateFormat(todayDate, "mm/dd/yy")#
WHERE clientcode='#session.client_code#'
and projectcode='#session.project_code#'
</CFQUERY>

<CFQUERY DATASOURCE="#application.WeeklyRptDSN#" NAME="qpoll">
UPDATE Weekly_Reports_Poll
SET
<CFIF isDefined("form.fchkPoll1")>
poll1=1,
poll1_short='#form.fPoll1Short#',
poll1_long='#form.fPoll1Long#',
<CFELSE>
poll1=0,
</CFIF>
<CFIF isDefined("form.fchkPoll2")>
poll2=1,
poll2_short='#form.fPoll2Short#',
poll2_long='#form.fPoll2Long#',
<CFELSE>
poll2=0,
</CFIF>
<CFIF isDefined("form.fchkPoll3")>
poll3=1,
poll3_short='#form.fPoll31Short#',
poll3_long='#form.fPoll3Long#'
<CFELSE>
poll3=0
</CFIF>
WHERE clientcode='#session.client_code#'
and projectcode='#session.project_code#'
</CFQUERY>



<CFQUERY DATASOURCE="#application.WeeklyRptDSN#" NAME="qdecile">
UPDATE Weekly_Reports_Decile_Information
SET
<CFIF isDefined("form.fchkDecile1")>
decile1_exist=1,
decile1_name='#form.fDecile1Name#',
decile1_location_number=#form.fDecile1Location#,
<CFELSE>
decile1_exist=0,
</CFIF>
<CFIF isDefined("form.fchkDecile2")>
decile2_exist=1,
decile2_name='#form.fDecile2Name#',
decile2_location_number=#form.fDecile2Location#,
<CFELSE>
decile2_exist=0,
</CFIF>
<CFIF isDefined("form.fchkDecile3")>
decile3_exist=1,
decile3_name='#form.fDecile3Name#',
decile3_location_number=#form.fDecile3Location#
<CFELSE>
decile3_exist=0
</CFIF>
WHERE clientcode='#session.client_code#'
and projectcode='#session.project_code#'
</CFQUERY>


<CFQUERY DATASOURCE="#application.WeeklyRptDSN#" NAME="qquery_exists">

UPDATE Weekly_Reports_Query_Exists
SET
<CFIF isDefined("form.fchkprime_specialty")>
prime_specialty=1,
<CFELSE>
prime_specialty=0,
</CFIF>

<CFIF isDefined("form.fchkmenum")>
menum=1,
<CFELSE>
menum=0,
</CFIF>

<CFIF isDefined("form.fchkmoderator")>
moderator=1,
<CFELSE>
moderator=0,
</CFIF>

<CFIF isDefined("form.fchkdb_match")>
db_match=1,
<CFELSE>
db_match=0,
</CFIF>

<CFIF isDefined("form.fchkS1")>
s1=1,
<CFELSE>
s1=0,
</CFIF>

<CFIF isDefined("form.fchkS2")>
s2=1,
<CFELSE>
s2=0,
</CFIF>


<CFIF isDefined("form.fchkS3")>
s3=1,
<CFELSE>
s3=0,
</CFIF>

<CFIF isDefined("form.fchkS4")>
s4=1,
<CFELSE>
s4=0,
</CFIF>

<CFIF isDefined("form.fchkS5")>
s5=1,
<CFELSE>
s5=0,
</CFIF>

<CFIF isDefined("form.fchkS6")>
s6=1,
<CFELSE>
s6=0,
</CFIF>

<CFIF isDefined("form.fchkS7")>
s7=1,
<CFELSE>
s7=0,
</CFIF>

<CFIF isDefined("form.fchkS8")>
s8=1,
<CFELSE>
s8=0,
</CFIF>

<CFIF isDefined("form.fchkS9")>
s9=1,
<CFELSE>
s9=0,
</CFIF>

<CFIF isDefined("form.fchkS10")>
s10=1,
<CFELSE>
s10=0,
</CFIF>

<CFIF isDefined("form.fchku5")>
u5=1,
<CFELSE>
u5=0,
</CFIF>

<CFIF isDefined("form.fchkterr1")>
terr1=1,
<CFELSE>
terr1=0,
</CFIF>

<CFIF isDefined("form.fchkterr2")>
terr2=1,
<CFELSE>
terr2=0,
</CFIF>

<CFIF isDefined("form.fchkterr3")>
terr3=1,
<CFELSE>
terr3=0,
</CFIF>

<CFIF isDefined("form.fchkterr4")>
terr4=1,
<CFELSE>
terr4=0,
</CFIF>

<CFIF isDefined("form.fchkterr5")>
terr5=1,
<CFELSE>
terr5=0,
</CFIF>


<CFIF isDefined("form.fchkterr6")>
terr6=1,
<CFELSE>
terr6=0,
</CFIF>


<CFIF isDefined("form.fchkterr7")>
terr7=1,
<CFELSE>
terr7=0,
</CFIF>

<CFIF isDefined("form.fchkterr8")>
terr8=1
<CFELSE>
terr8=0
</CFIF>
WHERE clientcode='#session.client_code#'
and projectcode='#session.project_code#'

</CFQUERY>

<CFQUERY DATASOURCE="#application.WeeklyRptDSN#" NAME="qquery_label">

UPDATE Weekly_Reports_Query_Labels
SET
projectcode='#session.project_code#'
<CFIF isDefined("form.fchkS1")>
,s1_name='#form.fs1_name#'
</CFIF>

<CFIF isDefined("form.fchkS2")>
,s2_name='#form.fs2_name#'
</CFIF>


<CFIF isDefined("form.fchkS3")>
,s3_name='#form.fs3_name#'
</CFIF>

<CFIF isDefined("form.fchkS4")>
,s4_name='#form.fs4_name#'
</CFIF>

<CFIF isDefined("form.fchkS5")>
,s5_name='#form.fs5_name#'
</CFIF>

<CFIF isDefined("form.fchkS6")>
,s6_name='#form.fs6_name#'
</CFIF>

<CFIF isDefined("form.fchkS7")>
,s7_name='#form.fs7_name#'
</CFIF>

<CFIF isDefined("form.fchkS8")>
,s8_name='#form.fs8_name#'
</CFIF>

<CFIF isDefined("form.fchkS9")>
,s9_name='#form.fs9_name#'
</CFIF>

<CFIF isDefined("form.fchkS10")>
,s10_name='#form.fs10_name#'
</CFIF>

<CFIF isDefined("form.fchku5")>
,u5_name='#form.fu5_name#'
</CFIF>

<CFIF isDefined("form.fchkterr1")>
,terr1_name='#form.fterr1_name#'
</CFIF>

<CFIF isDefined("form.fchkterr2")>
,terr2_name='#form.fterr2_name#'
</CFIF>

<CFIF isDefined("form.fchkterr3")>
,terr3_name='#form.fterr3_name#'
</CFIF>

<CFIF isDefined("form.fchkterr4")>
,terr4_name='#form.fterr4_name#'
</CFIF>

<CFIF isDefined("form.fchkterr5")>
,terr5_name='#form.fterr5_name#'
</CFIF>

<CFIF isDefined("form.fchkterr6")>
,terr6_name='#form.fterr6_name#'
</CFIF>

<CFIF isDefined("form.fchkterr7")>
,terr7_name='#form.fterr7_name#'
</CFIF>

<CFIF isDefined("form.fchkterr8")>
,terr8_name='#form.fterr8_name#'
</CFIF>

WHERE clientcode='#session.client_code#'
and projectcode='#session.project_code#'

</CFQUERY>
</cfoutput>

<cfoutput>
<META HTTP-EQUIV="REFRESH" CONTENT="0; URL=rpt_weeklyReportsSetup_view.cfm">
</cfoutput>

</CFCASE>

<CFDEFAULTCASE>
<div class="main">
An error has occured please <a href="rpt_weeklyReportsSetup.cfm">start</a> again.
</div>
</CFDEFAULTCASE>
</CFSWITCH>

