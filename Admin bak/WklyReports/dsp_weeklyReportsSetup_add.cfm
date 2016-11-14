<html>
<head>
<script>
	function showhide(id){
		if (document.getElementById)
		{
			obj = document.getElementById(id);
			if (obj.style.display == "none")
			{
				obj.style.display = "";
			}
			else
			{
				obj.style.display = "none";
			}
		}
	}

	function Verify ( form )
			{
			  // ** START **
			errorString = "";

			if (form.fProgramName.value == "") {
					errorString = errorString + '\n-> ' + 'Please enter a PROJECT NAME.';

			}
			if (form.fProgramName.value.length > 75) {
					errorString = errorString + '\n-> ' + 'Please reduce the length of the PROJECT NAME field.';

			}

			if(form.fchkDecile1.checked)
			{

				if (form.fDecile1Location.value == "") {
						errorString = errorString + '\n-> ' + 'Please enter 1st Decile Location.';

				}

			}

			if(form.fchkDecile2.checked)
			{

				if (form.fDecile2Location.value == "") {
						errorString = errorString + '\n-> ' + 'Please enter 2nd Decile Location.';

				}

			}

			if(form.fchkDecile3.checked)
			{

				if (form.fDecile3Location.value == "") {
						errorString = errorString + '\n-> ' + 'Please select the 3rd Decile Location.';

				}

			}

			if (form.fchkPolling.checked) {
				if(!form.fchkPoll1.checked && !form.fchkPoll2.checked && !form.fchkPoll3.checked)
				{
					errorString = errorString + '\n-> ' + 'Please enter in Pollling Information, as you have chosen polling questions.';

				}

				if(form.fchkPoll1.checked)
				{

						if (form.fPoll1Short.value == "") {
								errorString = errorString + '\n-> ' + 'Please enter Poll 1 Short Question.';

						}
						if (form.fPoll1Short.value.length > 50) {
								errorString = errorString + '\n-> ' + 'Please reduce the length of the Poll 1 Short field.';

						}

						if (form.fPoll1Long.value == "") {
								errorString = errorString + '\n-> ' + 'Please enter Poll 1 Long Question.';

						}
						if (form.fPoll1Long.value.length > 500) {
								errorString = errorString + '\n-> ' + 'Please reduce the length of the Poll 1 Long field.';

						}

				}
				if(form.fchkPoll2.checked)
				{

					if (form.fPoll2Short.value == "") {
							errorString = errorString + '\n-> ' + 'Please enter Poll 2 Short Question.';

					}
					if (form.fPoll2Short.value.length > 50) {
							errorString = errorString + '\n-> ' + 'Please reduce the length of the Poll 2 Short field.';

					}

					if (form.fPoll2Long.value == "") {
							errorString = errorString + '\n-> ' + 'Please enter Poll 2 Long Question.';

					}
					if (form.fPoll2Long.value.length > 500) {
							errorString = errorString + '\n-> ' + 'Please reduce the length of the Poll 2 Long field.';

					}

				}
				if(form.fchkPoll3.checked)
				{

					if (form.fPoll3Short.value == "") {
							errorString = errorString + '\n-> ' + 'Please enter Poll 3 Short Question.';

					}
					if (form.fPoll3Short.value.length > 50) {
							errorString = errorString + '\n-> ' + 'Please reduce the length of the Poll 3 Short field.';

					}

					if (form.fPoll3Long.value == "") {
							errorString = errorString + '\n-> ' + 'Please enter Poll 3 Long Question.';

					}
					if (form.fPoll3Long.value.length > 500) {
							errorString = errorString + '\n-> ' + 'Please reduce the length of the Poll 3 Long field.';

					}

				}
			}

		if(form.fchkS1.checked)
			{

				if (form.fS1_name.value == "") {
					errorString = errorString + '\n-> ' + 'Please enter Screener1 name.';

				}
				if (form.fS1_name.value.length > 25) {
					errorString = errorString + '\n-> ' + 'Please reduce the length of the Screener1 name.';

				}
			}

			if(form.fchkS2.checked)
			{

				if (form.fS2_name.value == "") {
					errorString = errorString + '\n-> ' + 'Please enter Screener2 name.';

				}
				if (form.fS2_name.value.length > 25) {
					errorString = errorString + '\n-> ' + 'Please reduce the length of the Screener2 name.';

				}
			}

			if(form.fchkS3.checked)
			{

				if (form.fS3_name.value == "") {
					errorString = errorString + '\n-> ' + 'Please enter Screener3 name.';

				}
				if (form.fS3_name.value.length > 25) {
					errorString = errorString + '\n-> ' + 'Please reduce the length of the Screener3 name.';

				}
			}
			if(form.fchkS4.checked)
			{

				if (form.fS4_name.value == "") {
					errorString = errorString + '\n-> ' + 'Please enter Screener4 name.';

				}
				if (form.fS4_name.value.length > 25) {
					errorString = errorString + '\n-> ' + 'Please reduce the length of the Screener4 name.';

				}
			}
			if(form.fchkS5.checked)
			{

				if (form.fS5_name.value == "") {
					errorString = errorString + '\n-> ' + 'Please enter Screener5 name.';

				}
				if (form.fS5_name.value.length > 25) {
					errorString = errorString + '\n-> ' + 'Please reduce the length of the Screener5 name.';

				}
			}
			if(form.fchkS6.checked)
			{

				if (form.fS6_name.value == "") {
					errorString = errorString + '\n-> ' + 'Please enter Screener6 name.';

				}
				if (form.fS6_name.value.length > 25) {
					errorString = errorString + '\n-> ' + 'Please reduce the length of the Screener6 name.';

				}
			}
			if(form.fchkS7.checked)
			{

				if (form.fS7_name.value == "") {
					errorString = errorString + '\n-> ' + 'Please enter Screener7 name.';

				}
				if (form.fS7_name.value.length > 25) {
					errorString = errorString + '\n-> ' + 'Please reduce the length of the Screener7 name.';

				}
			}
			if(form.fchkS8.checked)
			{

				if (form.fS8_name.value == "") {
					errorString = errorString + '\n-> ' + 'Please enter Screener8 name.';

				}
				if (form.fS8_name.value.length > 25) {
					errorString = errorString + '\n-> ' + 'Please reduce the length of the Screener8 name.';

				}
			}
			if(form.fchkS9.checked)
			{

				if (form.fS9_name.value == "") {
					errorString = errorString + '\n-> ' + 'Please enter Screener9 name.';

				}
				if (form.fS9_name.value.length > 25) {
					errorString = errorString + '\n-> ' + 'Please reduce the length of the Screener9 name.';

				}
			}
			if(form.fchkS10.checked)
			{

				if (form.fS10_name.value == "") {
					errorString = errorString + '\n-> ' + 'Please enter Screener10 name.';

				}
				if (form.fS10_name.value.length > 25) {
					errorString = errorString + '\n-> ' + 'Please reduce the length of the Screener10 name.';

				}
			}
		if(form.fchkU5.checked)
					{

						if (form.fu5_name.value == "") {
							errorString = errorString + '\n-> ' + 'Please enter User 5 name.';

						}
						if (form.fu5_name.value.length > 25) {
							errorString = errorString + '\n-> ' + 'Please reduce the length of the User 5 name.';

						}
			}

		if(form.fchkterr1.checked)
			{

				if (form.fterr1_name.value == "") {
					errorString = errorString + '\n-> ' + 'Terr 1 name.';

				}
				if (form.fterr1_name.value.length > 25) {
					errorString = errorString + '\n-> ' + 'Please reduce the length of the Terr 1 name.';

				}
			}

			if(form.fchkterr2.checked)
			{

				if (form.fterr2_name.value == "") {
					errorString = errorString + '\n-> ' + 'Terr 2 name.';

				}
				if (form.fterr2_name.value.length > 25) {
					errorString = errorString + '\n-> ' + 'Please reduce the length of the Terr 2 name.';

				}
			}

			if(form.fchkterr3.checked)
			{

				if (form.fterr3_name.value == "") {
					errorString = errorString + '\n-> ' + 'Terr 3 name.';

				}
				if (form.fterr3_name.value.length > 25) {
					errorString = errorString + '\n-> ' + 'Please reduce the length of the Terr 3 name.';

				}
			}
			if(form.fchkterr4.checked)
			{

				if (form.fterr4_name.value == "") {
					errorString = errorString + '\n-> ' + 'Terr 4 name.';

				}
				if (form.fterr4_name.value.length > 25) {
					errorString = errorString + '\n-> ' + 'Please reduce the length of the Terr 4 name.';

				}
			}
			if(form.fchkterr5.checked)
			{

				if (form.fterr5_name.value == "") {
					errorString = errorString + '\n-> ' + 'Terr 5 name.';

				}
				if (form.fterr5_name.value.length > 25) {
					errorString = errorString + '\n-> ' + 'Please reduce the length of the Terr 5 name.';

				}
			}
			if(form.fchkterr6.checked)
			{

				if (form.fterr6_name.value == "") {
					errorString = errorString + '\n-> ' + 'Terr 6 name.';

				}
				if (form.fterr6_name.value.length > 25) {
					errorString = errorString + '\n-> ' + 'Please reduce the length of the Terr 6 name.';

				}
			}
			if(form.fchkterr7.checked)
			{

				if (form.fterr7_name.value == "") {
					errorString = errorString + '\n-> ' + 'Terr 7 name.';

				}
				if (form.fterr7_name.value.length > 25) {
					errorString = errorString + '\n-> ' + 'Please reduce the length of the Terr 7 name.';

				}
			}
			if(form.fchkterr8.checked)
			{

				if (form.fterr8_name.value == "") {
					errorString = errorString + '\n-> ' + 'Terr 8 name.';

				}
				if (form.fterr8_name.value.length > 25) {
					errorString = errorString + '\n-> ' + 'Please reduce the length of the Terr 8 name.';

				}
		}

		if(errorString.length > 0)
		{
			errorString = errorString + '\n';
			errorString = errorString + '-----------------------------------------------------';
			errorString = errorString + '\n';
			errorString = errorString + 'PLEASE FILL IN THE BOXES WITH RED ARROWS NEXT TO THEM';
			alert(errorString);
			return false;
		}
		else
		{
			verifyString = "";

			if (form.fProgramName.value != "" && form.fProgramName.value.length < 75) {
					verifyString = verifyString + '\n-> ' + 'Project Name:' + form.fProgramName.value;

			}


			if(form.fchkSpeakers.checked)
				verifyString = verifyString + '\n-> ' + 'Speaker Data: Yes' ;
			//else
			//	verifyString = verifyString + '\n-> ' + 'SPEAKER DATA: No' ;
			if(form.fchkCIData.checked)
				verifyString = verifyString + '\n-> ' + 'CI Data: Yes' ;
			//else
			//	verifyString = verifyString + '\n-> ' + 'CI DATA: No' ;


			if (form.fchkPolling.checked) {
				verifyString = verifyString + '\n-> ' + 'Polling Question: Yes' ;
				if(form.fchkPoll1.checked)
				{
					verifyString = verifyString + '\n-> ' + 'Poll 1 Questions: Yes' ;
					if (form.fPoll1Short.value != "") {
						verifyString = verifyString + '\n-> ' + 'Poll 1 Short Question: ' + form.fPoll1Short.value;

					}

					if (form.fPoll1Long.value !="") {
						verifyString = verifyString + '\n-> ' + 'Poll 1 Long Question: ' + form.fPoll1Long.value;

					}

				}
			//	else {verifyString = verifyString + '\n-> ' + 'POLL1 QUESTIONS: No';}
				if(form.fchkPoll2.checked)
				{
					verifyString = verifyString + '\n-> ' + 'Poll 2 Questions: Yes' ;
					if (form.fPoll2Short.value != "") {
						verifyString = verifyString + '\n-> ' + 'Poll 2 Short Question: ' + form.fPoll1Short.value;

					}

					if (form.fPoll2Long.value !="") {
						verifyString = verifyString + '\n-> ' + 'Poll 2 Long Question: ' + form.fPoll1Long.value;

					}

				}
			//	else {verifyString = verifyString + '\n-> ' + 'POLL2 QUESTIONS: No';}
				if(form.fchkPoll3.checked)
				{
					verifyString = verifyString + '\n-> ' + 'Poll 3 Questions: Yes' ;
					if (form.fPoll3Short.value != "") {
						verifyString = verifyString + '\n-> ' + 'Poll 3 Short Question: ' + form.fPoll1Short.value;

					}

					if (form.fPoll3Long.value !="") {
						verifyString = verifyString + '\n-> ' + 'Poll 3 Long Question: ' + form.fPoll1Long.value;

					}

				}
			//	else {verifyString = verifyString + '\n-> ' + 'Poll3 Questions: No';}

			}
			//else
			//	verifyString = verifyString + '\n-> ' + 'POLLING QUESTIONS: No' ;


			if(form.fchkDecile1.checked)
			{
				verifyString = verifyString + '\n-> ' + 'Decile 1: Yes' ;
				verifyString = verifyString + '\n-> ' + 'Decile Name:' + form.fDecile1Name.value;
				verifyString = verifyString + '\n-> ' + 'Decile Location:' + form.fDecile1Location.value;

			}
			//else
			//verifyString = verifyString + '\n-> ' + 'DECILE 1: No' ;

			if(form.fchkDecile2.checked)
				{
					verifyString = verifyString + '\n-> ' + 'Decile 2: Yes' ;
					verifyString = verifyString + '\n-> ' + 'Decile 2 Name:' + form.fDecile2Name.value;
					verifyString = verifyString + '\n-> ' + 'Decile 2 Location:' + form.fDecile2Location.value;

				}
			//	else
			//verifyString = verifyString + '\n-> ' + 'DECILE 2: No' ;

			if(form.fchkDecile3.checked)
				{
					verifyString = verifyString + '\n-> ' + 'Decile 3: Yes' ;
					verifyString = verifyString + '\n-> ' + 'Decile 3 Name:' + form.fDecile3Name.value;
					verifyString = verifyString + '\n-> ' + 'Decile 3 Location:' + form.fDecile3Location.value;

				}
			//	else
			//verifyString = verifyString + '\n-> ' + 'DECILE 3: No' ;

			if(form.fchkS1.checked)
				{
					verifyString = verifyString + '\n-> ' + 'Screener1: Yes';
					verifyString = verifyString + '\n-> ' + 'Screener1 Name: ' + form.fS1_name.value;

				}
			//	else
			//		verifyString = verifyString + '\n-> ' + 'Screener1: No';
			if(form.fchkS2.checked)
				{
					verifyString = verifyString + '\n-> ' + 'Screener2: Yes';
					verifyString = verifyString + '\n-> ' + 'Screener2 Name: ' + form.fS2_name.value;

				}
			//	else
			//		verifyString = verifyString + '\n-> ' + 'Screener2: No';
			if(form.fchkS3.checked)
				{
					verifyString = verifyString + '\n-> ' + 'Screener3: Yes';
					verifyString = verifyString + '\n-> ' + 'Screener3 Name: ' + form.fS3_name.value;

				}
			//	else
			//		verifyString = verifyString + '\n-> ' + 'Screener3: No';
			if(form.fchkS4.checked)
				{
					verifyString = verifyString + '\n-> ' + 'Screener4: Yes';
					verifyString = verifyString + '\n-> ' + 'Screener4 Name: ' + form.fS4_name.value;

				}
			//	else
			//		verifyString = verifyString + '\n-> ' + 'Screener4: No';
			if(form.fchkS5.checked)
				{
					verifyString = verifyString + '\n-> ' + 'Screener5: Yes';
					verifyString = verifyString + '\n-> ' + 'Screener5 Name: ' + form.fS5_name.value;

				}
			//	else
			//		verifyString = verifyString + '\n-> ' + 'Screener5: No';
			if(form.fchkS6.checked)
				{
					verifyString = verifyString + '\n-> ' + 'Screener6: Yes';
					verifyString = verifyString + '\n-> ' + 'Screener6 Name: ' + form.fS6_name.value;

				}
			//	else
			//		verifyString = verifyString + '\n-> ' + 'Screener6: No';
			if(form.fchkS7.checked)
				{
					verifyString = verifyString + '\n-> ' + 'Screener7: Yes';
					verifyString = verifyString + '\n-> ' + 'Screener7 Name: ' + form.fS7_name.value;

				}
			//	else
			//		verifyString = verifyString + '\n-> ' + 'Screener7: No';
			if(form.fchkS8.checked)
				{
					verifyString = verifyString + '\n-> ' + 'Screener8: Yes';
					verifyString = verifyString + '\n-> ' + 'Screener8 Name: ' + form.fS8_name.value;

				}
			//	else
			//		verifyString = verifyString + '\n-> ' + 'Screener8: No';
			if(form.fchkS9.checked)
				{
					verifyString = verifyString + '\n-> ' + 'Screener9: Yes';
					verifyString = verifyString + '\n-> ' + 'Screener9 Name: ' + form.fS9_name.value;

				}
			//	else
			//		verifyString = verifyString + '\n-> ' + 'Screener9: No';
			if(form.fchkS10.checked)
				{
					verifyString = verifyString + '\n-> ' + 'Screener10: Yes';
					verifyString = verifyString + '\n-> ' + 'Screener10 Name: ' + form.fS10_name.value;

				}
			//	else
			//verifyString = verifyString + '\n-> ' + 'Screener10: No';

			if(form.fchkU5.checked)
				{
					verifyString = verifyString + '\n-> ' + 'User5: Yes';
					verifyString = verifyString + '\n-> ' + 'User5 Name: ' + form.fu5_name.value;
				}
				//else
				//verifyString = verifyString + '\n-> ' + 'User5: No';

				if(form.fchkprime_specialty.checked)
				{
					verifyString = verifyString + '\n-> ' + 'Prime Specialty: Yes';
				}
				//else
				//	verifyString = verifyString + '\n-> ' + 'Prime Specialty: No';
				if(form.fchkmenum.checked)
				{
					verifyString = verifyString + '\n-> ' + 'Menum: Yes';
				}
				//else
				//	verifyString = verifyString + '\n-> ' + 'Menum: No';
				if(form.fchkmoderator.checked)
				{
					verifyString = verifyString + '\n-> ' + 'Moderator: Yes';
				}
				//else
				//	verifyString = verifyString + '\n-> ' + 'Moderator: No';
				if(form.fchkdb_match.checked)
				{
					verifyString = verifyString + '\n-> ' + 'DB Match: Yes';
				}
				//else
				//	verifyString = verifyString + '\n-> ' + 'DB Match: No';

				if(form.fchkterr1.checked)
					{
						verifyString = verifyString + '\n-> ' + 'Terr 1: Yes';
						verifyString = verifyString + '\n-> ' + 'Terr 1 Name: ' + form.fterr1_name.value;
					}
				//else
				//	verifyString = verifyString + '\n-> ' + 'Terr1: No';
				if(form.fchkterr2.checked)
					{
						verifyString = verifyString + '\n-> ' + 'Terr 2: Yes';
						verifyString = verifyString + '\n-> ' + 'Terr 2 Name: ' + form.fterr2_name.value;
					}
				//else
				//	verifyString = verifyString + '\n-> ' + 'Terr2: No';
				if(form.fchkterr3.checked)
					{
						verifyString = verifyString + '\n-> ' + 'Terr 3: Yes';
						verifyString = verifyString + '\n-> ' + 'Terr 3 Name: ' + form.fterr3_name.value;
					}
				//else
				//	verifyString = verifyString + '\n-> ' + 'Terr3: No';
				if(form.fchkterr4.checked)
					{
						verifyString = verifyString + '\n-> ' + 'Terr 4: Yes';
						verifyString = verifyString + '\n-> ' + 'Terr 4 Name: ' + form.fterr4_name.value;
					}
				//else
				//	verifyString = verifyString + '\n-> ' + 'Terr4: No';
				if(form.fchkterr5.checked)
					{
						verifyString = verifyString + '\n-> ' + 'Terr 5: Yes';
						verifyString = verifyString + '\n-> ' + 'Terr 5 Name: ' + form.fterr5_name.value;
					}
				//else
				//	verifyString = verifyString + '\n-> ' + 'Terr5: No';
				if(form.fchkterr6.checked)
					{
						verifyString = verifyString + '\n-> ' + 'Terr 6: Yes';
						verifyString = verifyString + '\n-> ' + 'Terr 6 Name: ' + form.fterr6_name.value;
					}
				//else
				//	verifyString = verifyString + '\n-> ' + 'Terr6: No';
				if(form.fchkterr7.checked)
					{
						verifyString = verifyString + '\n-> ' + 'Terr 7: Yes';
						verifyString = verifyString + '\n-> ' + 'Terr 7 Name: ' + form.fterr7_name.value;
					}
				//else
				//	verifyString = verifyString + '\n-> ' + 'Terr7: No';
				if(form.fchkterr8.checked)
					{
						verifyString = verifyString + '\n-> ' + 'Terr 8: Yes';
						verifyString = verifyString + '\n-> ' + 'Terr 8 Name: ' + form.fterr8_name.value;
					}
				//else
				//	verifyString = verifyString + '\n-> ' + 'Terr8: No';


			verifyString = verifyString + '\n';
			verifyString = verifyString + '-----------------------------------------------------';
			verifyString = verifyString + '\n';
			verifyString = verifyString + 'THIS INFORMATION WILL BE INSERTED/CHANGED IN THE DATABASE!!!';
			verifyString = verifyString + '\n';
			verifyString = verifyString + 'THIS WILL EFFECT HOW WEEKLY REPORTS RUN';
			verifyString = verifyString + '\n';
			verifyString = verifyString + 'PRESS OK TO ADD/CHANGE  OR CANCEL TO EDIT FIELDS.';

			var answer = confirm (verifyString)

			if (answer)
				return true;
			else
				return false;

		}
		return false;
	}

</script>
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Weekly Reports Setup: ADD" showCalendar="0">
<CFQUERY DATASOURCE="#application.WeeklyRptDSN#" NAME="qdecile_column_name">
	SELECT id,decile_column_name
	FROM Weekly_Reports_Decile_Column_Names
</CFQUERY>

<div align="left">
	<h4>Project Information (<cfoutput>#session.project_code#</cfoutput>)</h4>
	<p>
	<div>
		<img src="/images/red_arrow_9x9.gif"> = Required Field<br><hr noshade size="1">
	</div>
<div style="padding-left:50px;">
<FORM ACTION="act_weeklyReportsSetup.cfm?a=a" METHOD="post" name="get_client" onsubmit="return Verify(this);">
	<div>
	<table cellpadding="2" cellspacing="2">
	<tr>
		<div class="bigquestion">
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Program Name</b></td>
		<td align="left"><input type="text" name="fProgramName" VALUE=""></td>
		</div>
	</tr>
	<tr>
		<div class="bigquestion">
		<td align="right"><b>Are there Speakers</b></td>
		<td align="left"><input type="checkbox" name="fchkSpeakers"></td>
		</div>
	</tr>
	<tr>
		<div class="bigquestion">
		<td align="right"><b>Is there CI Data</b></td>
		<td align="left"><input type="checkbox" name="fchkCIData"></td>
		</div>
	</tr>
	<tr>
		<div class="bigquestion">
		<td align="right"><b>Polling Questions?</b></td>
		<td align="left"><input type="checkbox" name="fchkPolling" onclick="showhide('pollinglayer'); return(true);"></td>
		</div>
	</tr>
	</table>
	</div>
	<div style="display: none;margin-left:1em;" id="pollinglayer">
		<!--- polling question #1 --->
		<table cellpadding="2" cellspacing="2">
		<tr>
		<div>
			<td align="right"><b>Polling Questions #1?</b></td>
			<td align="left"><input type="checkbox" name="fchkPoll1" onclick="showhide('polling1layer'); return(true);"></td>
		</div>
		</tr>
		</table>
		<div style="display: none;margin-left:1em;" id="polling1layer">
			<table cellpadding="2" cellspacing="2">
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 1 Short Question</b></td>
				<td align="left"><input type="text" name="fPoll1Short" VALUE=""></td>
			</tr>
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 1 Full Question</b></td>
				<td align="left"><textarea name="fPoll1Long" rows="3" cols="40"></textarea></td>
			</tr>
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 1 Type</b></td>
				<td align="left">
					<select name="fPoll1Type" onChange="showhide('polling1choices'); return(true);">
					<option value="YN">Yes/No</option>
					<option value="MULTI">Multiple Choice</option>
					</select>
				</td>
			</tr>
			</table>
		</div>
		<div style="display: none; margin-left:1em;" id="polling1choices">
			<table cellpadding="2" cellspacing="2">
			<tr>
				<td width="50"></td>
				<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Poll 1 # Choices</b></td>
				<td align="left"><input type="text" name="fPoll1Choices" size="5" VALUE="">
				Enter number of response choices (1-7) and associated labels
				</td>					
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 1 Response 1</b></td>
				<td align="left"><input type="text" name="fPoll1Resp1" size="50" VALUE=""></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 1 Response 2</b></td>
				<td align="left"><input type="text" name="fPoll1resp2" size="50" value=""></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 1 Response 3</b></td>
				<td align="left"><input type="text" name="fPoll1resp3" size="50" value=""></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 1 Response 4</b></td>
				<td align="left"><input type="text" name="fPoll1resp4" size="50" value=""></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 1 Response 5</b></td>
				<td align="left"><input type="text" name="fPoll1resp5" size="50" value=""></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 1 Response 6</b></td>
				<td align="left"><input type="text" name="fPoll1resp6" size="50" value=""></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 1 Response 7</b></td>
				<td align="left"><input type="text" name="fPoll1resp7" size="50" value=""></td>
			</tr>
			</table>
			</div> <!--- end of polling 1 multiple choice --->

		<!--- polling question #2 --->
		<table cellpadding="2" cellspacing="2">
		<tr>
		<div>
			<td align="right"><b>Polling Questions #2?</b></td>
			<td align="left"><input type="checkbox" name="fchkPoll2" onclick="showhide('polling2layer'); return(true);"></td>
		</div>
		</tr>
		</table>
		<div style="display: none;margin-left:1em;" id="polling2layer">
			<table cellpadding="2" cellspacing="2">
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 2 Short Question</b></td>
				<td><input type="text" name="fPoll2Short" VALUE=""></td>
			</tr>
			<tr>
				<td align="left" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 2 Full Question</b></td>
				<td align="left"><textarea name="fPoll2Long" rows="3" cols="40"></textarea></td>
			</tr>
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 2 Type</b></td>
				<td align="left">
					<select name="fPoll2Type" onChange="showhide('polling2choices'); return(true);">
					<option value="YN" >Yes/No</option>
					<option value="MULTI" >Multiple Choice</option>
					</select>
				</td>
			</tr>
			</table>
			</div>
			<div style="display: none; margin-left:1em;" id="polling2choices">
			<table cellpadding="2" cellspacing="2">
			<tr>
				<td width="50"></td>
				<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Poll 2 # Choices</b></td>
				<td align="left"><input type="text" name="fPoll2Choices" size="5" VALUE="">
				Enter number of response choices (1-7) and associated labels
				</td>					
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 2 Response 1</b></td>
				<td align="left"><input type="text" name="fPoll2Resp1" size="50" VALUE=""></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 2 Response 2</b></td>
				<td align="left"><input type="text" name="fPoll2resp2" size="50" value=""></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 2 Response 3</b></td>
				<td align="left"><input type="text" name="fPoll2resp3" size="50" value=""></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 2 Response 4</b></td>
				<td align="left"><input type="text" name="fPoll2resp4" size="50" value=""></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 2 Response 5</b></td>
				<td align="left"><input type="text" name="fPoll2resp5" size="50" value=""></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 2 Response 6</b></td>
				<td align="left"><input type="text" name="fPoll2resp6" size="50" value=""></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 2 Response 7</b></td>
				<td align="left"><input type="text" name="fPoll2resp7" size="50" value=""></td>
			</tr>
			</table>
			</div> <!--- end of polling 2 multiple choice --->

		<!--- polling question #3 --->
		<table cellpadding="2" cellspacing="2">
		<tr>
		<div>
			<td align="right"><b>Polling Questions #3?</b></td>
			<td align="left"><input type="checkbox" name="fchkPoll3" onclick="showhide('polling3layer'); return(true);"></td>
		</div>
		</tr>
		</table>
		<div style="display: none;margin-left:1em;" id="polling3layer">
			<table cellpadding="2" cellspacing="2">
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 3 Short Question</b></td>
				<td align="left"><input type="text" name="fPoll3Short" VALUE=""></td>
			</tr>
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 3 Full Question</b></td>
				<td align="left"><textarea name="fPoll3Long" rows="3" cols="40"></textarea></td>
			</tr>
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 3 Type</b></td>
				<td align="left">
					<select name="fPoll3Type" onChange="showhide('polling3choices'); return(true);">
					<option value="YN" >Yes/No</option>
					<option value="MULTI" >Multiple Choice</option>
					</select>
				</td>
			</tr>
			</table>
		</div>
		<div style="display: none; margin-left:1em;" id="polling3choices">
			<table cellpadding="2" cellspacing="2">
			<tr>
				<td width="50"></td>
				<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Poll 3 # Choices</b></td>
				<td align="left"><input type="text" name="fPoll3Choices" size="5" VALUE="">
				Enter number of response choices (1-7) and associated labels
				</td>					
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 3 Response 1</b></td>
				<td align="left"><input type="text" name="fPoll3Resp1" size="50" VALUE=""></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 3 Response 2</b></td>
				<td align="left"><input type="text" name="fPoll3resp2" size="50" value=""></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 3 Response 3</b></td>
				<td align="left"><input type="text" name="fPoll3resp3" size="50" value=""></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 3 Response 3</b></td>
				<td align="left"><input type="text" name="fPoll3resp4" size="50" value=""></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 3 Response 5</b></td>
				<td align="left"><input type="text" name="fPoll3resp5" size="50" value=""></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 3 Response 6</b></td>
				<td align="left"><input type="text" name="fPoll3resp6" size="50" value=""></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 3 Response 7</b></td>
				<td align="left"><input type="text" name="fPoll3resp7" size="50" value=""></td>
			</tr>
			</table>
			</div> <!--- end of polling 3 multiple choice --->

		<!--- polling question #4 --->
		<table cellpadding="2" cellspacing="2">
		<tr>
		<div>
			<td align="right"><b>Polling Questions #4?</b></td>
			<td align="left"><input type="checkbox" name="fchkPoll4" onclick="showhide('polling4layer'); return(true);"></td>
		</div>
		</tr>
		</table>
		<div style="display: none;margin-left:1em;" id="polling4layer">
			<table cellpadding="2" cellspacing="2">
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 4 Short Question</b></td>
				<td align="left"><input type="text" name="fPoll4Short" VALUE=""></td>
			</tr>		
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 4 Full Question</b></td>
				<td align="left"><textarea name="fPoll4Long" rows="3" cols="40"></textarea></b>
			</tr>
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 4 Type</b></td>
				<td align="left">
					<select name="fPoll4Type" onChange="showhide('polling4choices'); return(true);">
					<option value="YN" >Yes/No</option>
					<option value="MULTI" >Multiple Choice</option>
					</select>
				</td>
			</tr>
			</table>
		</div>
		<div style="display: none; margin-left:1em;" id="polling4choices">
			<table cellpadding="2" cellspacing="2">
			<tr>
				<td width="50"></td>
				<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Poll 4 # Choices</b></td>
				<td align="left"><input type="text" name="fPoll4Choices" size="5" VALUE="">
				Enter number of response choices (1-7) and associated labels
				</td>					
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 4 Response 1</b></td>
				<td align="left"><input type="text" name="fPoll4Resp1" size="50" VALUE=""></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 4 Response 2</b></td>
				<td align="left"><input type="text" name="fPoll4resp2" size="50" value=""></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 4 Response 3</b></td>
				<td align="left"><input type="text" name="fPoll4resp3" size="50" value=""></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 4 Response 4</b></td>
				<td align="left"><input type="text" name="fPoll4resp4" size="50" value=""></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 4 Response 5</b></td>
				<td align="left"><input type="text" name="fPoll4resp5" size="50" value=""></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 4 Response 6</b></td>
				<td align="left"><input type="text" name="fPoll4resp6" size="50" value=""></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 4 Response 7</b></td>
				<td align="left"><input type="text" name="fPoll4resp7" size="50" value=""></td>
			</tr>
			</table>
			</div> <!--- end of polling 4 multiple choice --->

		<!--- polling question #5 --->
		<table cellpadding="2" cellspacing="2">
		<tr>
			<div>
			<td align="right"><b>Polling Questions #5?</b></td>
			<td align="left"><input type="checkbox" name="fchkPoll5" onclick="showhide('polling5layer'); return(true);"></td>
			</div>
		</tr>
		</table>
		<div style="display: none;margin-left:1em;" id="polling5layer">
			<table cellpadding="2" cellspacing="2">
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 5 Short Question</b></td>
				<td align="left"><input type="text" name="fPoll5Short" VALUE=""></td>
			</tr>
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 5 Full Question</b></td>
				<td align="left"><textarea name="fPoll5Long" rows="3" cols="40"></textarea></td>
			</tr>			
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 5 Type</b></td>
				<td align="left">
					<select name="fPoll5Type" onChange="showhide('polling5choices'); return(true);">
					<option value="YN" >Yes/No</option>
					<option value="MULTI" >Multiple Choice</option>
					</select>
				</td>
			</tr>
			</table>
		</div>
		<div style="display: none; margin-left:1em;" id="polling5choices">
		<table cellpadding="2" cellspacing="2">
		<tr>
			<td width="50"></td>
			<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 5 # Choices</b></td>
			<td align="left"><input type="text" name="fPoll5Choices" size="5" VALUE="">
			Enter number of response choices (1-7) and associated labels
			</td>					
		</tr>
		<tr>
			<td width="50"></td>
			<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 5 Response 1</b></td>
			<td align="left"><input type="text" name="fPoll5Resp1" size="50" VALUE=""></td>
		</tr>
		<tr>
			<td width="50"></td>
			<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 5 Response 2</b></td>
			<td align="left"><input type="text" name="fPoll5resp2" size="50" value=""></td>
		</tr>
		<tr>
			<td width="50"></td>
			<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 5 Response 3</b></td>
			<td align="left"><input type="text" name="fPoll5resp3" size="50" value=""></td>
		</tr>
		<tr>
			<td width="50"></td>
			<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 5 Response 4</b></td>
			<td align="left"><input type="text" name="fPoll5resp4" size="50" value=""></td>
		</tr>
		<tr>
			<td width="50"></td>
			<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 5 Response 5</b></td>
			<td align="left"><input type="text" name="fPoll5resp5" size="50" value=""></td>
		</tr>
		<tr>
			<td width="50"></td>
			<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 5 Response 6</b></td>
			<td align="left"><input type="text" name="fPoll5resp6" size="50" value=""></td>
		</tr>
		<tr>
			<td width="50"></td>
			<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 5 Response 7</b></td>
			<td align="left"><input type="text" name="fPoll5resp7" size="50" value=""></td>
		</tr>
		</table>
		</div> <!--- end of polling 5 multiple choice --->
	</div> <!--- end of pollinglayer --->

	<div style="" id="decilelayer">
	<table cellpadding="2" cellspacing="2">
	<tr>
	<div style="" id="" class="bigquestion">
		<td align="right"><b>Decile 1?</b></td>
		<td align="left"><input type="checkbox" name="fchkDecile1" onclick="showhide('decile1layer'); return(true);"></td>
	</div>
	</tr>
	</table>
	<div style="display: none;margin-left:1em;" id="decile1layer">
		<table cellpadding="2" cellspacing="2">
		<tr>
			<td align="right"><b>Decile 1 Name</b></td>
			<td><input type="text" name="fDecile1Name" VALUE=""> (leave blank for unnamed decile)</td>
		</tr>
		</tr>
			<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Decile 1 Location</b></td>
			<td align="left">
				<select name="fDecile1Location">
					<option value="">Select Decile 1 Location</option>
					<option value="">---------------</option>
					<cfoutput query="qdecile_column_name">
						<option value="#id#">#decile_column_name#</option>
					</cfoutput>
				</select>
			</td>
		</tr>
		</table>
		</div>
		<!--- decile 2 --->
		<table cellpadding="2" cellspacing="2">
		<tr>
			<div style="" id="" class="bigquestion">
			<td align="right"><b>Decile 2?</b></td>
			<td align="left"><input type="checkbox" onclick="showhide('decile2layer'); return(true);"></td>
			</div>
		</tr>
		</table>
		<div style="display: none;margin-left:1em;" id="decile2layer">
			<table cellpadding="2" cellspacing="2">
			<tr>
				<td align="right"><b>Decile 2 Name</b></td>
				<td align="left"><input type="text" name="fDecile2Name"  VALUE=""> (leave blank for unnamed decile)</td>
			</tr>
			<tr>
				<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Decile 2 Location</b></td>
				<td align="left">
					<select name="fDecile2Location">
						<option value="">Select Decile 2 Location</option>
						<option value="">---------------</option>
						<cfoutput query="qdecile_column_name">
							<option value="#id#">#decile_column_name#</option>
						</cfoutput>
					</select>
				</td>
			</tr>
			</table>
		</div>
		<!--- decile 3 --->
		<table cellpadding="2" cellspacing="2">
		<tr>
			<div style="" id="" class="bigquestion">	
			<td align="right"><b>Decile 3?</b>
			<td align="left"><input type="checkbox" name="fchkDecile3" onclick="showhide('decile3layer'); return(true);"></td>
			</div>
		</tr>
		</table>
		<div style="display: none;margin-left:1em;" id="decile3layer">
			<table cellpadding="2" cellspacing="2">
			<tr>
				<td align="right"><b>Decile 3 Name</b></td>
				<td align="left"><input type="text" name="fDecile3Name" VALUE=""> (leave blank for unnamed decile)</td>
			</tr>
			<tr>
				<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Decile 3 Location</b></td>
				<td align="left">
					<select name="fDecile3Location">
					<option value="">Select Decile 3 Location</option>
						<option value="">---------------</option>
						<cfoutput query="qdecile_column_name">
							<option value="#id#" >#decile_column_name#</option>
						</cfoutput>
					</select>
				</td>
			</tr>
			</table>
		</div>

	<table cellpadding="2" cellspacing="2">
	<tr>		
		<div class="bigquestion">
		<td align="right"><b>Screener1?</b></td>
		<td align="left"><input type="checkbox" name="fchkS1" onclick="showhide('s1layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="display: none;margin-left:1em;" id="s1layer">
		<table cellpadding="2" cellspacing="2">
		<tr>		
			<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Screener1 Name</b></td>
			<td align="left"><input type="text" name="fS1_name" VALUE=""></td>
		</tr>
		</table>
	</div>
	<!--- screener2 --->
	<table cellpadding="2" cellspacing="2">
	<tr>		
		<div class="bigquestion">
		<td align="right"><b>Screener2?</b></td>
		<td align="left"><input type="checkbox" name="fchkS2" onclick="showhide('s2layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="display: none;margin-left:1em;" id="s2layer">
		<table cellpadding="2" cellspacing="2">
		<tr>		
			<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Screener2 Name</b></td>
			<td align="left"><input type="text" name="fS2_name" VALUE=""></td>
		</tr>
		</table>			
	</div>
	<!--- screener3 --->	
	<table cellpadding="2" cellspacing="2">
	<tr>		
		<div class="bigquestion">
		<td align="right"><b>Screener3?</b></td>
		<td align="left"><input type="checkbox" name="fchkS3" onclick="showhide('s3layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="display: none;margin-left:1em;" id="s3layer">
		<table cellpadding="2" cellspacing="2">
		<tr>		
			<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Screener3 Name</b></td>
			<td align="left"><input type="text" name="fS3_name" VALUE=""></td>
		</tr>
		</table>
	</div>
	<!--- screener4 --->
	<table cellpadding="2" cellspacing="2">
	<tr>		
		<div class="bigquestion">
		<td align="right"><b>Screener4?</b></td> 
		<td align="left"><input type="checkbox" name="fchkS4" onclick="showhide('s4layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="display: none;margin-left:1em;" id="s4layer">
		<table cellpadding="2" cellspacing="2">
		<tr>		
			<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Screener4 Name</b></td>
			<td align="left"><input type="text" name="fS4_name" VALUE=""></td>
		</tr>
		</table>
	</div>
	<!--- screener5 --->	
	<table cellpadding="2" cellspacing="2">
	<tr>		
		<div class="bigquestion">
		<td align="right"><b>Screener5?</b></td>
		<td align="left"><input type="checkbox" name="fchkS5" onclick="showhide('s5layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="display: none;margin-left:1em;" id="s5layer">
		<table cellpadding="2" cellspacing="2">
		<tr>		
			<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Screener5 Name</b></td>
			<td align="left"><input type="text" name="fS5_name" VALUE=""></td>
		</tr>
		</table>
	</div>
	<!--- screener 6 --->	
	<table cellpadding="2" cellspacing="2">
	<tr>		
		<div class="bigquestion">
		<td align="right"><b>Screener6?</b></td>
		<td align="left"><input type="checkbox" name="fchkS6" onclick="showhide('s6layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="display: none;margin-left:1em;" id="s6layer">
	<table cellpadding="2" cellspacing="2">
	<tr>		
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Screener6 Name</b></td>
		<td align="left"><input type="text" name="fS6_name" VALUE=""></td>
	</tr>
	</table>
	</div>
	<!--- screener 7 --->	
	<table cellpadding="2" cellspacing="2">
	<tr>		
		<div class="bigquestion">
		<td align="right"><b>Screener7?</b></td>
		<td align="left"><input type="checkbox" name="fchkS7" onclick="showhide('s7layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="display: none;margin-left:1em;" id="s7layer">
	<table cellpadding="2" cellspacing="2">
	<tr>		
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Screener7 Name</b></td>
		<td align="left"><input type="text" name="fS7_name" VALUE=""></td>
	</tr>
	</table>
	</div>
	<!--- screener 8 --->
	<table cellpadding="2" cellspacing="2">
	<tr>		
		<div class="bigquestion">
		<td align="right"><b>Screener8?</b></td>
		<td align="left"><input type="checkbox" name="fchkS8" onclick="showhide('s8layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="display: none;margin-left:1em;" id="s8layer">
	<table cellpadding="2" cellspacing="2">
	<tr>		
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Screener8 Name</b></td>
		<td align="left"><input type="text" name="fS8_name" VALUE=""></td>
	</tr>
	</table>
	</div>
	<!--- screener 9 --->
	<table cellpadding="2" cellspacing="2">
	<tr>		
		<div class="bigquestion">
		<td align="right"><b>Screener9?</b></td>
		<td align="left"><input type="checkbox" name="fchkS9" onclick="showhide('s9layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="display: none;margin-left:1em;" id="s9layer">
	<table cellpadding="2" cellspacing="2">
	<tr>		
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Screener9 Name</b></td>
		<td align="left"><input type="text" name="fS9_name" VALUE=""></td>
	</tr>
	</table>
	</div>
	<!--- screener 10 --->	
	<table cellpadding="2" cellspacing="2">
	<tr>		
		<div class="bigquestion">
		<td align="right"><b>Screener10?</b></td>
		<td align="left"><input type="checkbox" name="fchkS10" onclick="showhide('s10layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="display: none;margin-left:1em;" id="s10layer">
	<table cellpadding="2" cellspacing="2">
	<tr>		
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Screener10 Name</b></td>
		<td align="left"><input type="text" name="fS10_name" VALUE=""></td>
	</tr>
	</table>
	</div>

	<div class="bigquestion">
	<table cellpadding="2" cellspacing="2">
	<tr>	
		<td align="right"><b>User5?</b></td>
		<td align="left"><input type="checkbox" name="fchkU5" onclick="showhide('u5layer'); return(true);"></td>
	</tr>
	</table>
	</div>
	<div style="display: none;margin-left:1em;" id="u5layer">
	<table cellpadding="2" cellspacing="2">
	<tr>	
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>User 5 Name</b></td>
		<td align="left"><input type="text" name="fu5_name" VALUE=""></td>
	</tr>
	</table>
	</div>
	<!--- specialty --->	
	<table cellpadding="2" cellspacing="2">
	<tr>	
		<td align="right"><b>Prime Specialty?</b></td>
		<td align="left"><input type="checkbox" name="fchkprime_specialty"></td>
	</tr>
	</table>
	<!--- me number --->
	<table cellpadding="2" cellspacing="2">
	<tr>	
		<td align="right"><b>Menum?</b></td>
		<td align="left"><input type="checkbox" name="fchkmenum"></td>
	</tr>
	</table>
	<!--- moderator --->	
	<table cellpadding="2" cellspacing="2">
	<tr>	
		<td align="right"><b>Moderator?</b></td>
		<td align="left"><input type="checkbox" name="fchkmoderator"></td>
	</tr>
	</table>
	<!--- DB Match --->	
	<table cellpadding="2" cellspacing="2">
	<tr>	
		<td align="right"><b>DB Match?</b></td>
		<td align="left"><input type="checkbox" name="fchkdb_match"></td>
	</tr>
	</table>

	<!--- terr1 --->
	<table cellpadding="2" cellspacing="2">
	<tr>		
		<div class="bigquestion">
		<td align="right"><b>Territory 1 Rep?</b></td>
		<td align="left"><input type="checkbox" name="fchkterr1" onclick="showhide('terr1layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="display: none;margin-left:1em;" id="terr1layer">
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Territory 1 Name</b></td>
		<td align="left"><input type="text" name="fterr1_name" VALUE=""></td>
	</tr>
	</table>
	</div>
	<!--- terr2 --->
	<table cellpadding="2" cellspacing="2">
	<tr>		
		<div class="bigquestion">
		<td align="right"><b>Territory 2 Rep?</b></td>
		<td align="left"><input type="checkbox" name="fchkterr2" onclick="showhide('terr2layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="display: none;margin-left:1em;" id="terr2layer">
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Territory 2 Name</b></td>
		<td align="left"><input type="text" name="fterr2_name" VALUE=""></td>
	</tr>
	</table>
	</div>
	
	<!--- terr3 --->
	<table cellpadding="2" cellspacing="2">
	<tr>		
		<div class="bigquestion">
		<td align="right"><b>Territory 3 Rep?</b></td>
		<td align="left"><input type="checkbox" name="fchkterr3" onclick="showhide('terr3layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="display: none;margin-left:1em;" id="terr3layer">
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Territory 3 Name</b></td>
		<td align="left"><input type="text" name="fterr3_name" VALUE=""></td>
	</tr>
	</table>
	</div>
	
	<!--- Terr4 --->
	<table cellpadding="2" cellspacing="2">
	<tr>		
		<div class="bigquestion">
		<td align="right"><b>Territory 4 Rep?</b></td>
		<td align="left"><input type="checkbox" name="fchkterr4" onclick="showhide('terr4layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="display: none;margin-left:1em;" id="terr4layer">
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Territory 4 Name</b></td>
		<td align="left"><input type="text" name="fterr4_name" VALUE=""></td>
	</tr>
	</table>
	</div>

	<!--- Terr5 --->
	<table cellpadding="2" cellspacing="2">
	<tr>		
		<div class="bigquestion">
		<td align="right"><b>Territory 5 Rep?</b></td>
		<td align="left"><input type="checkbox" name="fchkterr5" onclick="showhide('terr5layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="display: none;margin-left:1em;" id="terr5layer">
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Territory 5 Name</b></td>
		<td align="left"><input type="text" name="fterr5_name" VALUE=""></td>
	</tr>
	</table>
	</div>

	<!--- Terr6 --->
	<table cellpadding="2" cellspacing="2">
	<tr>		
		<div class="bigquestion">
		<td align="right"><b>Territory 6 Rep?</b></td> 
		<td align="left"><input type="checkbox" name="fchkterr6" onclick="showhide('terr6layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="display: none;margin-left:1em;" id="terr6layer">
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Territory 6 Name</b></td>
		<td align="left"><input type="text" name="fterr6_name" VALUE=""></td>
	</tr>
	</table>
	</div>
	
	<!--- terr7 --->
	<table cellpadding="2" cellspacing="2">
	<tr>		
		<div class="bigquestion">
		<td align="right"><b>Territory 7 Rep?</b></td>
		<td align="left"><input type="checkbox" name="fchkterr7" onclick="showhide('terr7layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="display: none;margin-left:1em;" id="terr7layer">
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Territory 7 Name</b></td>
		<td align="left"><input type="text" name="fterr7_name" VALUE=""></td>
	</tr>
	</table>
	</div>
	
	<!--- terr8 --->
	<table cellpadding="2" cellspacing="2">
	<tr>		
		<div class="bigquestion">
		<td align="right"><b>Territory 8 Rep?</b></td>
		<td align="left"><input type="checkbox" name="fchkterr8" onclick="showhide('terr8layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="display: none;margin-left:1em;" id="terr8layer">
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Territory 8 Name</b></td>
		<td align="left"><input type="text" name="fterr8_name" VALUE=""></td>
	</tr>
	</table>
	</div>
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td colspan="2">
			<INPUT TYPE="submit" NAME="submit" VALUE=" Finish -> "  style="float:left;">
		</td>
	</tr>
	</table>
	</form>	
</div>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

