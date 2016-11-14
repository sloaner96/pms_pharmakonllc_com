<!---------------------------------------------------------------------
	act_weeklyReportsSetup.cfm

	Updates the database with changes made on the display pages.

----------------------------------------------------------------------->
<CFSWITCH EXPRESSION="#URL.a#">
<!--- Default case to present edit selection form to user --->
<CFCASE VALUE="c">
	<cfoutput>

	<CFQUERY DATASOURCE="#application.MasterDSN#" NAME="qprogram_check">
	SELECT projectcode
	FROM Weekly_Reports.dbo.Weekly_Reports_Decile_Information
	where projectcode = '#session.project_code2#'
	</CFQUERY>

	<cfif NOT qprogram_check.recordcount>

	<CFQUERY DATASOURCE="#application.MasterDSN#" NAME="qdecile">
	INSERT INTO Weekly_reports.dbo.Weekly_Reports_Decile_Information
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

	<CFQUERY DATASOURCE="#application.MasterDSN#" NAME="qpoll">
	INSERT INTO Weekly_reports.dbo.Weekly_Reports_Poll
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

	<CFQUERY DATASOURCE="#application.MasterDSN#" NAME="qprogram_info">
	INSERT INTO Weekly_Reports.dbo.Weekly_Reports_Program_Information
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

	<CFQUERY DATASOURCE="#application.MasterDSN#" NAME="qquery_exists">

	INSERT INTO Weekly_Reports.dbo.Weekly_Reports_Query_Exists
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

	<CFQUERY DATASOURCE="#application.MasterDSN#" NAME="qquery_label">
	INSERT INTO Weekly_Reports.dbo.Weekly_Reports_Query_Labels
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
	<cfoutput>
	<META HTTP-EQUIV="REFRESH" CONTENT="0; URL=dsp_weeklyReportsSetup_view.cfm">
	</cfoutput>

	<CFELSE>
		Project Code: #session.project_code2# Already Exists! <br><br>
		Please <a href="dsp_weeklyReportsSetup_edit.cfm">Edit</a> this Project Code.
	</cfif>
	</cfoutput>
</CFCASE>
<!---------------------------------------------------------------------
	CASE "a"
	Add new weekly report setup
----------------------------------------------------------------------->
<CFCASE VALUE="a">
	<cfoutput>

	<CFQUERY DATASOURCE="#application.MasterDSN#" NAME="qprogram_check">
	SELECT projectcode
	FROM Weekly_Reports.dbo.Weekly_Reports_Decile_Information
	where projectcode = '#session.project_code#'
	</CFQUERY>

	<cfif NOT qprogram_check.recordcount>

	<CFQUERY DATASOURCE="#application.MasterDSN#" NAME="qdecile">
	INSERT INTO Weekly_Reports.dbo.Weekly_Reports_Decile_Information
		(
		clientcode,projectcode,
		<CFIF isDefined("form.fchkDecile1")>
			decile1_exist,decile1_name,decile1_location_number,
		<CFELSE>
			decile1_exist,
		</CFIF>
		<CFIF isDefined("form.fchkDecile2")>
			decile2_exist,decile2_name,decile2_location_number,
		<CFELSE>
			decile2_exist,
		</CFIF>
		<CFIF isDefined("form.fchkDecile3")>
			decile3_exist,decile3_name,decile3_location_number
		<CFELSE>
			decile3_exist
		</CFIF>
		)
	VALUES(
		'#session.client_code#','#session.project_code#'
		<CFIF isDefined("form.fchkDecile1")>
			,1,'#form.fDecile1Name#',#form.fDecile1Location#
		<CFELSE>,0
		</CFIF>
		<CFIF isDefined("form.fchkDecile2")>
			,1,'#form.fDecile2Name#',#form.fDecile2Location#
		<CFELSE>,0
		</CFIF>
		<CFIF isDefined("form.fchkDecile3")>
			,1,'#form.fDecile3Name#',#form.fDecile3Location#
		<CFELSE>
			,0
		</CFIF>
		)
	</CFQUERY>

	<CFQUERY DATASOURCE="#application.MasterDSN#" NAME="qpoll">
	INSERT INTO Weekly_Reports.dbo.Weekly_Reports_Poll
		(
		clientcode,projectcode,
		<CFIF isDefined("form.fchkPoll1")>
			poll1,poll1_short,poll1_long,poll1_type,
			<CFIF isDefined("form.fPoll1Choices")>
				poll1_nChoices, poll1_resp1, poll1_resp2, poll1_resp3,
				poll1_resp4, poll1_resp5, poll1_resp6, poll1_resp7,
			</cfif>
		<CFELSE>
			poll1,
		</CFIF>
		<CFIF isDefined("form.fchkPoll2")>
			poll2,poll2_short,poll2_long,poll2_type,
			<CFIF isDefined("form.fPoll2Choices")>
				poll2_nChoices, poll2_resp1, poll2_resp2, poll2_resp3,
				poll2_resp4, poll2_resp5, poll2_resp6, poll2_resp7,
			</cfif>
		<CFELSE>
			poll2,
		</CFIF>
		<CFIF isDefined("form.fchkPoll3")>
			poll3,poll3_short,poll3_long,poll3_type,
			<CFIF isDefined("form.fPoll3Choices")>
				poll3_nChoices, poll3_resp1, poll3_resp2, poll3_resp3,
				poll3_resp4, poll3_resp5, poll3_resp6, poll3_resp7,
			</cfif>
		<CFELSE>
			poll3,
		</CFIF>
		<CFIF isDefined("form.fchkPoll4")>
			poll4,poll4_short,poll4_long,poll4_type,
			<CFIF isDefined("form.fPoll4Choices")>
				poll4_nChoices, poll4_resp1, poll4_resp2, poll4_resp3,
				poll4_resp4, poll4_resp5, poll4_resp6, poll4_resp7,
			</cfif>
		<CFELSE>
			poll4,
		</CFIF>
		<CFIF isDefined("form.fchkPoll5")>
			poll5,poll5_short,poll5_long,poll5_type,
			<CFIF isDefined("form.fPoll5Choices")>
				poll5_nChoices, poll5_resp1, poll5_resp2, poll5_resp3,
				poll5_resp4, poll5_resp5, poll5_resp6, poll5_resp7
			</cfif>
		<CFELSE>
			poll5
		</CFIF>
		)
	VALUES(
		'#session.client_code#','#session.project_code#',
		<CFIF isDefined("form.fchkPoll1")>
			1,'#form.fPoll1Short#','#form.fPoll1Long#', '#form.fPoll1Type#',
			<CFIF isDefined("form.fPoll1Choices")>
				'#form.fPoll1Choices#', '#form.fPoll1Resp1#','#form.fPoll1Resp2#','#form.fPoll1Resp3#',
				'#form.fPoll1Resp4#','#form.fPoll1Resp5#','#form.fPoll1Resp6#','#form.fPoll1Resp7#',
			</cfif>
		<CFELSE>
			0,
		</CFIF>
		<CFIF isDefined("form.fchkPoll2")>
			1,'#form.fPoll2Short#','#form.fPoll2Long#', '#form.fPoll2Type#',
			<CFIF isDefined("form.fPoll2Choices")>
				'#form.fPoll1Choices#','#form.fPoll2Resp1#','#form.fPoll2Resp2#','#form.fPoll2Resp3#',
				'#form.fPoll2Resp4#','#form.fPoll2Resp5#','#form.fPoll2Resp6#','#form.fPoll2Resp7#',
			</cfif>
		<CFELSE>
			0,
		</CFIF>
		<CFIF isDefined("form.fchkPoll3")>
			1,'#form.fPoll3Short#','#form.fPoll3Long#', '#form.fPoll3Type#',
			<CFIF isDefined("form.fPoll3Choices")>
				'#form.fPoll1Choices#','#form.fPoll3Resp1#','#form.fPoll3Resp2#','#form.fPoll3Resp3#',
				'#form.fPoll3Resp4#','#form.fPoll3Resp5#','#form.fPoll3Resp6#','#form.fPoll3Resp7#',
			</cfif>
		<CFELSE>
			0,
		</CFIF>
		<CFIF isDefined("form.fchkPoll4")>
			1,'#form.fPoll4Short#','#form.fPoll4Long#', '#form.fPoll4Type#',
			<CFIF isDefined("form.fPoll4Choices")>
				'#form.fPoll1Choices#','#form.fPoll4Resp1#','#form.fPoll4Resp2#','#form.fPoll4Resp3#',
				'#form.fPoll4Resp4#','#form.fPoll4Resp5#','#form.fPoll4Resp6#','#form.fPoll4Resp7#',
			</cfif>
		<CFELSE>
			0,
		</CFIF>
		<CFIF isDefined("form.fchkPoll5")>
			1,'#form.fPoll5Short#','#form.fPoll5Long#', '#form.fPoll5Type#'
			<CFIF isDefined("form.fPoll5Choices")>
				,'#form.fPoll1Choices#','#form.fPoll1Resp1#','#form.fPoll1Resp2#','#form.fPoll1Resp3#'
				,'#form.fPoll1Resp4#','#form.fPoll1Resp5#','#form.fPoll1Resp6#','#form.fPoll1Resp7#'
			</cfif>
		<CFELSE>
			0
		</CFIF>
		)
	</CFQUERY>

	<cfset todayDate = Now()>
	<CFQUERY DATASOURCE="#application.MasterDSN#" NAME="qprogram_info">
	INSERT INTO Weekly_Reports.dbo.Weekly_Reports_Program_Information
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

	<CFQUERY DATASOURCE="#application.MasterDSN#" NAME="qquery_exists">
	INSERT INTO Weekly_Reports.dbo.Weekly_Reports_Query_Exists
		(
		clientcode,
		projectcode,
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

	<CFQUERY DATASOURCE="#application.MasterDSN#" NAME="qquery_label">
	INSERT INTO Weekly_Reports.dbo.Weekly_Reports_Query_Labels
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
	<cfoutput>
	<META HTTP-EQUIV="REFRESH" CONTENT="0; URL=dsp_weeklyReportsSetup_view.cfm">
	</cfoutput>

	<CFELSE>
		Project Code: #session.project_code# Already Exists! <br><br>
		Please <a href="dsp_weeklyReportsSetup_edit.cfm">Edit</a> this Project Code.
	</cfif>

	</cfoutput>
</CFCASE>
<!---------------------------------------------------------------------
	CASE "a"
	Add new weekly report setup
----------------------------------------------------------------------->

<!---------------------------------------------------------------------
	CASE "u"
	Update existing weekly report setup
----------------------------------------------------------------------->
<CFCASE VALUE="u">
	<cfoutput>
	<cfset todayDate = Now()>
	<CFQUERY DATASOURCE="#application.MasterDSN#" NAME="qprogram_info">
	UPDATE Weekly_Reports.dbo.Weekly_Reports_Program_Information
	SET
		program_name='#form.fProgramName#',
		<CFIF isDefined("form.fchkSpeakers")>speaker_info_exist=1,<CFELSE>speaker_info_exist=0,</CFIF>
		<CFIF isDefined("form.fchkCIData")>ci_data_exist=1,<CFELSE>ci_data_exist=0,</CFIF>
		<CFIF isDefined("fchkPolling")>polling_data_exist=1,<CFELSE>polling_data_exist=0,</CFIF>
		edited_uid=#session.userinfo.rowid#,
		edited_date = #DateFormat(todayDate, "mm/dd/yy")#
	WHERE clientcode='#session.client_code#'
		and projectcode='#session.project_code#'
	</CFQUERY>

	<CFQUERY DATASOURCE="#application.MasterDSN#" NAME="qpoll">
	UPDATE Weekly_Reports.dbo.Weekly_Reports_Poll
	SET
	<!--- poll1 --->
	<CFIF isDefined("form.fchkPoll1")>
		poll1=1,
		poll1_short='#form.fPoll1Short#',
		poll1_long='#form.fPoll1Long#',
		poll1_type='#form.fPoll1Type#',
		<CFIF isDefined("form.fPoll1Choices")>
			poll1_nChoices='#form.fPoll1Choices#',
			poll1_resp1='#form.fPoll1Resp1#',
			poll1_resp2='#form.fPoll1Resp2#',
			poll1_resp3='#form.fPoll1Resp3#',
			poll1_resp4='#form.fPoll1Resp4#',
			poll1_resp5='#form.fPoll1Resp5#',
			poll1_resp6='#form.fPoll1Resp6#',
			poll1_resp7='#form.fPoll1Resp7#',
		<CFELSE>
			poll1_nChoices = null,
			poll1_resp1 = null,
			poll1_resp2 = null,
			poll1_resp3 = null,
			poll1_resp4 = null,
			poll1_resp5 = null,
			poll1_resp6 = null,
			poll1_resp7 = null,
		</CFIF>
	<CFELSE>
		poll1=0,
	</CFIF>

	<CFIF isDefined("form.fchkPoll2")>
		poll2=1,
		poll2_short='#form.fPoll2Short#',
		poll2_long='#form.fPoll2Long#',
		poll2_type='#fPoll2Type#',
		<CFIF isDefined("form.fPoll2Choices")>
			poll2_nChoices='#form.fPoll2Choices#',
			poll2_resp1='#form.fPoll2Resp1#',
			poll2_resp2='#form.fPoll2Resp2#',
			poll2_resp3='#form.fPoll2Resp3#',
			poll2_resp4='#form.fPoll2Resp4#',
			poll2_resp5='#form.fPoll2Resp5#',
			poll2_resp6='#form.fPoll2Resp6#',
			poll2_resp7='#form.fPoll2Resp7#',
		<CFELSE>
			poll2_nChoices = null,
			poll2_resp1 = null,
			poll2_resp2 = null,
			poll2_resp3 = null,
			poll2_resp4 = null,
			poll2_resp5 = null,
			poll2_resp6 = null,
			poll2_resp7 = null,
		</CFIF>
	<CFELSE>
		poll2=0,
	</CFIF>

	<CFIF isDefined("form.fchkPoll3")>
		poll3=1,
		poll3_short='#form.fPoll3Short#',
		poll3_long='#form.fPoll3Long#',
		poll3_type='#fPoll3Type#',
		<CFIF isDefined("form.fPoll3Choices")>
			poll3_nChoices='#form.fPoll3Choices#',
			poll3_resp1='#form.fPoll3Resp1#',
			poll3_resp2='#form.fPoll3Resp2#',
			poll3_resp3='#form.fPoll3Resp3#',
			poll3_resp4='#form.fPoll3Resp4#',
			poll3_resp5='#form.fPoll3Resp5#',
			poll3_resp6='#form.fPoll3Resp6#',
			poll3_resp7='#form.fPoll3Resp7#',
		<CFELSE>
			poll3_nChoices = null,
			poll3_resp1 = null,
			poll3_resp2 = null,
			poll3_resp3 = null,
			poll3_resp4 = null,
			poll3_resp5 = null,
			poll3_resp6 = null,
			poll3_resp7 = null,
		</CFIF>
	<CFELSE>
		poll3=0,
	</CFIF>

	<CFIF isDefined("form.fchkPoll4")>
		poll4=1,
		poll4_short='#form.fPoll4Short#',
		poll4_long='#form.fPoll4Long#',
		poll4_type='#fPoll4Type#',
		<CFIF isDefined("form.fPoll4Choices")>
			poll4_nChoices='#form.fPoll4Choices#',
			poll4_resp1='#form.fPoll4Resp1#',
			poll4_resp2='#form.fPoll4Resp2#',
			poll4_resp3='#form.fPoll4Resp3#',
			poll4_resp4='#form.fPoll4Resp4#',
			poll4_resp5='#form.fPoll4Resp5#',
			poll4_resp6='#form.fPoll4Resp6#',
			poll4_resp7='#form.fPoll4Resp7#',
		<CFELSE>
			poll4_nChoices = null,
			poll4_resp1 = null,
			poll4_resp2 = null,
			poll4_resp3 = null,
			poll4_resp4 = null,
			poll4_resp5 = null,
			poll4_resp6 = null,
			poll4_resp7 = null,
		</CFIF>
	<CFELSE>
		poll4=0,
	</CFIF>

	<CFIF isDefined("form.fchkPoll5")>
		poll5=1,
		poll5_short='#form.fPoll51Short#',
		poll5_long='#form.fPoll5long#',
		poll5_type='#fPoll5Type#'
		<CFIF isDefined("form.fPoll5Choices")>
			poll5_nChoices='#form.fPoll5Choices#',
			poll5_resp1='#form.fPoll5Resp1#',
			poll5_resp2='#form.fPoll5Resp2#',
			poll5_resp3='#form.fPoll5Resp3#',
			poll5_resp4='#form.fPoll5Resp4#',
			poll5_resp5='#form.fPoll5Resp5#',
			poll5_resp6='#form.fPoll5Resp6#',
			poll5_resp7='#form.fPoll5Resp7#',
		<CFELSE>
			poll5_nChoices = null,
			poll5_resp1 = null,
			poll5_resp2 = null,
			poll5_resp3 = null,
			poll5_resp4 = null,
			poll5_resp5 = null,
			poll5_resp6 = null,
			poll5_resp7 = null,
		</CFIF>
	<CFELSE>
		poll5=0
	</CFIF>

	WHERE clientcode='#session.client_code#'
		and projectcode='#session.project_code#'
	</CFQUERY>


	<CFQUERY DATASOURCE="#application.MasterDSN#" NAME="qdecile">
	UPDATE Weekly_Reports.dbo.Weekly_Reports_Decile_Information
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

	<CFQUERY DATASOURCE="#application.MasterDSN#" NAME="qquery_exists">
	UPDATE Weekly_Reports.dbo.Weekly_Reports_Query_Exists
	SET
	<CFIF isDefined("form.fchkprime_specialty")>prime_specialty=1,<CFELSE>prime_specialty=0,</CFIF>
	<CFIF isDefined("form.fchkmenum")>menum=1,<CFELSE>menum=0,</CFIF>
	<CFIF isDefined("form.fchkmoderator")>moderator=1,<CFELSE>moderator=0,</CFIF>
	<CFIF isDefined("form.fchkdb_match")>db_match=1,<CFELSE>db_match=0,</CFIF>
	<CFIF isDefined("form.fchkS1")>s1=1,<CFELSE>s1=0,</CFIF>
	<CFIF isDefined("form.fchkS2")>s2=1,<CFELSE>s2=0,</CFIF>
	<CFIF isDefined("form.fchkS3")>s3=1,<CFELSE>s3=0,</CFIF>
	<CFIF isDefined("form.fchkS4")>s4=1,<CFELSE>s4=0,</CFIF>
	<CFIF isDefined("form.fchkS5")>s5=1,<CFELSE>s5=0,</CFIF>
	<CFIF isDefined("form.fchkS6")>s6=1,<CFELSE>s6=0,</CFIF>
	<CFIF isDefined("form.fchkS7")>s7=1,<CFELSE>s7=0,</CFIF>
	<CFIF isDefined("form.fchkS8")>s8=1,<CFELSE>s8=0,</CFIF>
	<CFIF isDefined("form.fchkS9")>s9=1,<CFELSE>s9=0,</CFIF>
	<CFIF isDefined("form.fchkS10")>s10=1,<CFELSE>s10=0,</CFIF>
	<CFIF isDefined("form.fchku5")>u5=1,<CFELSE>u5=0,</CFIF>
	<CFIF isDefined("form.fchkterr1")>terr1=1,<CFELSE>terr1=0,</CFIF>
	<CFIF isDefined("form.fchkterr2")>terr2=1,<CFELSE>terr2=0,</CFIF>
	<CFIF isDefined("form.fchkterr3")>terr3=1,<CFELSE>terr3=0,</CFIF>
	<CFIF isDefined("form.fchkterr4")>terr4=1,<CFELSE>terr4=0,</CFIF>
	<CFIF isDefined("form.fchkterr5")>terr5=1,<CFELSE>terr5=0,</CFIF>
	<CFIF isDefined("form.fchkterr6")>terr6=1,<CFELSE>terr6=0,</CFIF>
	<CFIF isDefined("form.fchkterr7")>terr7=1,<CFELSE>terr7=0,</CFIF>
	<CFIF isDefined("form.fchkterr8")>terr8=1<CFELSE>terr8=0</CFIF>
	WHERE clientcode='#session.client_code#'
		and projectcode='#session.project_code#'
	</CFQUERY>

	<CFQUERY DATASOURCE="#application.MasterDSN#" NAME="qquery_label">
	UPDATE Weekly_Reports.dbo.Weekly_Reports_Query_Labels
	SET	projectcode='#session.project_code#'
	<CFIF isDefined("form.fchkS1")>,s1_name='#form.fS1_name#'<CFELSE>,s1_name=null</CFIF>
	<CFIF isDefined("form.fchkS2")>,s2_name='#form.fS2_name#'<CFELSE>,s2_name=null</CFIF>
	<CFIF isDefined("form.fchkS3")>,s3_name='#form.fS3_name#'<CFELSE>,s3_name=null</CFIF>
	<CFIF isDefined("form.fchkS4")>,s4_name='#form.fS4_name#'<CFELSE>,s4_name=null</CFIF>
	<CFIF isDefined("form.fchkS5")>,s5_name='#form.fS5_name#'<CFELSE>,s5_name=null</CFIF>
	<CFIF isDefined("form.fchkS6")>,s6_name='#form.fS6_name#'<CFELSE>,s6_name=null</CFIF>
	<CFIF isDefined("form.fchkS7")>,s7_name='#form.fS7_name#'<CFELSE>,s7_name=null</CFIF>
	<CFIF isDefined("form.fchkS8")>,s8_name='#form.fS8_name#'<CFELSE>,s8_name=null</CFIF>
	<CFIF isDefined("form.fchkS9")>,s9_name='#form.fS9_name#'<CFELSE>,s9_name=null</CFIF>
	<CFIF isDefined("form.fchkS10")>,s10_name='#form.fs10_name#'<CFELSE>,s10_name=null</CFIF>
	<CFIF isDefined("form.fchku5")>,u5_name='#form.fu5_name#'<CFELSE>,u5_name=null</CFIF>
	<CFIF isDefined("form.fchkterr1")>,terr1_name='#form.fterr1_name#'<CFELSE>,terr1_name=null</CFIF>
	<CFIF isDefined("form.fchkterr2")>,terr2_name='#form.fterr2_name#'<CFELSE>,terr2_name=null</CFIF>
	<CFIF isDefined("form.fchkterr3")>,terr3_name='#form.fterr3_name#'<CFELSE>,terr3_name=null</CFIF>
	<CFIF isDefined("form.fchkterr4")>,terr4_name='#form.fterr4_name#'<CFELSE>,terr4_name=null</CFIF>
	<CFIF isDefined("form.fchkterr5")>,terr5_name='#form.fterr5_name#'<CFELSE>,terr5_name=null</CFIF>
	<CFIF isDefined("form.fchkterr6")>,terr6_name='#form.fterr6_name#'<CFELSE>,terr6_name=null</CFIF>
	<CFIF isDefined("form.fchkterr7")>,terr7_name='#form.fterr7_name#'<CFELSE>,terr7_name=null</CFIF>
	<CFIF isDefined("form.fchkterr8")>,terr8_name='#form.fterr8_name#'<CFELSE>,terr8_name=null</CFIF>
	WHERE clientcode='#session.client_code#'
		and projectcode='#session.project_code#'
	</CFQUERY>
	</cfoutput>

	<cfoutput>
	<META HTTP-EQUIV="REFRESH" CONTENT="0; URL=dsp_weeklyReportsSetup_view.cfm">
	</cfoutput>

</CFCASE>

<CFDEFAULTCASE>
	<div class="main">
	An error has occured please <a href="dsp_weeklyReportsSetup.cfm">start</a> again.
	</div>
</CFDEFAULTCASE>
</CFSWITCH>
