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
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Weekly Reports Setup-Edit" showCalendar="0">

<CFQUERY DATASOURCE="#application.MasterDSN#" NAME="qMasterRow">
	SELECT pi.program_name, pi.speaker_info_exist, pi.ci_data_exist , pi.polling_data_exist,
		di.decile1_exist, di.decile1_name, di.decile1_location_number,
		di.decile2_exist, di.decile2_name, di.decile2_location_number,
		di.decile3_exist, di.decile3_name, di.decile3_location_number,
		p.poll1, p.poll1_short, p.poll1_long, p.poll1_type, p.poll1_nchoices,
		p.poll1_resp1, p.poll1_resp2, p.poll1_resp3, p.poll1_resp4, p.poll1_resp5, p.poll1_resp6, p.poll1_resp7,
		p.poll2, p.poll2_short, p.poll2_long, p.poll2_type, p.poll2_nchoices,
		p.poll2_resp1, p.poll2_resp2, p.poll2_resp3, p.poll2_resp4, p.poll2_resp5, p.poll2_resp6, p.poll2_resp7,
		p.poll3, p.poll3_short, p.poll3_long, p.poll3_type, p.poll3_nchoices,
		p.poll3_resp1, p.poll3_resp2, p.poll3_resp3, p.poll3_resp4, p.poll3_resp5, p.poll3_resp6, p.poll3_resp7,
		p.poll4, p.poll4_short, p.poll4_long, p.poll4_type, p.poll4_nchoices,
		p.poll4_resp1, p.poll4_resp2, p.poll4_resp3, p.poll4_resp4, p.poll4_resp5, p.poll4_resp6, p.poll4_resp7,
		p.poll5, p.poll5_short, p.poll5_long, p.poll5_type, p.poll5_nchoices,
		p.poll5_resp1, p.poll5_resp2, p.poll5_resp3, p.poll5_resp4, p.poll5_resp5, p.poll5_resp6, p.poll5_resp7
	FROM Weekly_Reports.dbo.Weekly_Reports_Program_Information pi,
		Weekly_Reports.dbo.Weekly_Reports_Decile_Information di,
		Weekly_Reports.dbo.Weekly_Reports_Poll p
	where pi.projectcode = '#session.project_code#' and di.projectcode like '#session.project_code#'
		and p.projectcode ='#session.project_code#'
</CFQUERY>

<CFQUERY DATASOURCE="#application.MasterDSN#" NAME="qMasterQueryRow">
	SELECT qe.s1, qe.s2, qe.s3, qe.s4, qe.s5, qe.s6, qe.s7, qe.s8, qe.s9,qe.s10,
		qe.u5, qe.prime_specialty, qe.menum, qe.moderator, qe.db_match, qe.terr1,
		qe.terr2, qe.terr3, qe.terr4, qe.terr5, qe.terr6, qe.terr7, qe.terr8,
		ql.s1_name , ql.s2_name, ql.s3_name, ql.s4_name, ql.s5_name, ql.s6_name,
		ql.s7_name, ql.s8_name, ql.s9_name, ql.s10_name, ql.u5_name, ql.terr1_name,
		ql.terr2_name, ql.terr3_name, ql.terr4_name, ql.terr5_name, ql.terr6_name,
		ql.terr7_name, ql.terr8_name
	FROM Weekly_Reports.dbo.Weekly_Reports_Query_Labels ql,
		Weekly_Reports.dbo.Weekly_Reports_Query_Exists qe
	where ql.projectcode = qe.projectcode
		and qe.projectcode = '#session.project_code#'
</CFQUERY>

<cfif qMasterRow.RecordCount GT 0>
<cfoutput query="qMasterRow">
<cfset d1 = #decile1_exist#>
<cfset d1_name = #decile1_Name#>
<cfset d1_location = #decile1_location_number#>

<cfset d2 = #decile2_exist#>
<cfset d2_name = #decile2_Name#>
<cfset d2_location = #decile2_location_number#>

<cfset d3 = #decile3_exist#>
<cfset d3_name = #decile3_Name#>
<cfset d3_location = #decile3_location_number#>

<cfset program_name = #program_name#>

<cfset speaker = #speaker_info_exist#>
<cfset ci = #ci_data_exist#>
<cfset polling = #polling_data_exist#>

<cfset poll1 = #poll1#>
<cfset poll1_short=#poll1_short#>
<cfset poll1_long = #poll1_long#>
<cfset poll1_type=#poll1_type#>
<cfset poll1_nchoices=#poll1_nchoices#>
<cfset poll1_resp1 =#poll1_resp1#>
<cfset poll1_resp2 =#poll1_resp2#>
<cfset poll1_resp3 =#poll1_resp3#>
<cfset poll1_resp4 =#poll1_resp4#>
<cfset poll1_resp5 =#poll1_resp5#>
<cfset poll1_resp6 =#poll1_resp6#>
<cfset poll1_resp7 =#poll1_resp7#>
<cfset poll2 = #poll2#>
<cfset poll2_short=#poll2_short#>
<cfset poll2_long = #poll2_long#>
<cfset poll2_type=#poll2_type#>
<cfset poll2_nchoices=#poll2_nchoices#>
<cfset poll2_resp1 =#poll2_resp1#>
<cfset poll2_resp2 =#poll2_resp2#>
<cfset poll2_resp3 =#poll2_resp3#>
<cfset poll2_resp4 =#poll2_resp4#>
<cfset poll2_resp5 =#poll2_resp5#>
<cfset poll2_resp6 =#poll2_resp6#>
<cfset poll2_resp7 =#poll2_resp7#>
<cfset poll3 = #poll3#>
<cfset poll3_short=#poll3_short#>
<cfset poll3_long = #poll3_long#>
<cfset poll3_type=#poll3_type#>
<cfset poll3_nchoices=#poll3_nchoices#>
<cfset poll3_resp1 =#poll3_resp1#>
<cfset poll3_resp2 =#poll3_resp2#>
<cfset poll3_resp3 =#poll3_resp3#>
<cfset poll3_resp4 =#poll3_resp4#>
<cfset poll3_resp5 =#poll3_resp5#>
<cfset poll3_resp6 =#poll3_resp6#>
<cfset poll3_resp7 =#poll3_resp7#>
<cfset poll4 = #poll4#>
<cfset poll4_short=#poll4_short#>
<cfset poll4_long = #poll4_long#>
<cfset poll4_type=#poll4_type#>
<cfset poll4_nchoices=#poll4_nchoices#>
<cfset poll4_resp1 =#poll4_resp1#>
<cfset poll4_resp2 =#poll4_resp2#>
<cfset poll4_resp3 =#poll4_resp3#>
<cfset poll4_resp4 =#poll4_resp4#>
<cfset poll4_resp5 =#poll4_resp5#>
<cfset poll4_resp6 =#poll4_resp6#>
<cfset poll4_resp7 =#poll4_resp7#>
<cfset poll5 = #poll5#>
<cfset poll5_short=#poll5_short#>
<cfset poll5_long = #poll5_long#>
<cfset poll5_type=#poll5_type#>
<cfset poll5_nchoices=#poll5_nchoices#>
<cfset poll5_resp1 =#poll5_resp1#>
<cfset poll5_resp2 =#poll5_resp2#>
<cfset poll5_resp3 =#poll5_resp3#>
<cfset poll5_resp4 =#poll5_resp4#>
<cfset poll5_resp5 =#poll5_resp5#>
<cfset poll5_resp6 =#poll5_resp6#>
<cfset poll5_resp7 =#poll5_resp7#>
</cfoutput>
<!--- preset these values in case of update failure --->
<cfset s1 = ''>
<cfset s1_name = ''>
<cfset s2 = ''>
<cfset s2_name = ''>
<cfset s3 = ''>
<cfset s3_name = ''>
<cfset s4 = ''>
<cfset s4_name = ''>
<cfset s5 = ''>
<cfset s5_name = ''>
<cfset s6 = ''>
<cfset s6_name = ''>
<cfset s7 = ''>
<cfset s7_name = ''>
<cfset s8 = ''>
<cfset s8_name = ''>
<cfset s9 = ''>
<cfset s9_name = ''>
<cfset s10 = ''>
<cfset s10_name = ''>
<cfset u5=''>
<cfset u5_name = ''>
<cfset prime_specialty=''>
<cfset menum = ''>
<cfset moderator = ''>
<cfset db_match = ''>
<cfset terr1 = ''>
<cfset terr2 = ''>
<cfset terr3 = ''>
<cfset terr4 = ''>
<cfset terr5 = ''>
<cfset terr6 = ''>
<cfset terr7 = ''>
<cfset terr8 = ''>
<cfset terr1_name = ''>
<cfset terr2_name = ''>
<cfset terr3_name = ''>
<cfset terr4_name = ''>
<cfset terr5_name = ''>
<cfset terr6_name = ''>
<cfset terr7_name = ''>
<cfset terr8_name = ''>

	<cfif qMasterRow.RecordCount GT 0>
		<cfoutput query="qMasterQueryRow">
		<cfset s1 = #s1#>
		<cfset s1_name = #s1_name#>
		<cfset s2 = #s2#>
		<cfset s2_name = #s2_name#>
		<cfset s3 = #s3#>
		<cfset s3_name = #s3_name#>
		<cfset s4 = #s4#>
		<cfset s4_name = #s4_name#>
		<cfset s5 = #s5#>
		<cfset s5_name = #s5_name#>
		<cfset s6 = #s6#>
		<cfset s6_name = #s6_name#>
		<cfset s7 = #s7#>
		<cfset s7_name = #s7_name#>
		<cfset s8 = #s8#>
		<cfset s8_name = #s8_name#>
		<cfset s9 = #s9#>
		<cfset s9_name = #s9_name#>
		<cfset s10 = #s10#>
		<cfset s10_name = #s10_name#>

		<cfset u5=#u5#>
		<cfset u5_name = #u5_name#>

		<cfset prime_specialty=#prime_specialty#>
		<cfset menum = #menum#>
		<cfset moderator = #moderator#>
		<cfset db_match = #db_match#>

		<cfset terr1 = #terr1#>
		<cfset terr2 = #terr2#>
		<cfset terr3 = #terr3#>
		<cfset terr4 = #terr4#>
		<cfset terr5 = #terr5#>
		<cfset terr6 = #terr6#>
		<cfset terr7 = #terr7#>
		<cfset terr8 = #terr8#>
		<cfset terr1_name = #terr1_name#>
		<cfset terr2_name = #terr2_name#>
		<cfset terr3_name = #terr3_name#>
		<cfset terr4_name = #terr4_name#>
		<cfset terr5_name = #terr5_name#>
		<cfset terr6_name = #terr6_name#>
		<cfset terr7_name = #terr7_name#>
		<cfset terr8_name = #terr8_name#>

		</cfoutput>
	</cfif>

<CFQUERY DATASOURCE="#application.MasterDSN#" NAME="qdecile_column_name">
	SELECT id,decile_column_name
	FROM Weekly_Reports.dbo.Weekly_Reports_Decile_Column_Names
</CFQUERY>

<div class="main">
<h3>Weekly Reports Setup</h3>
<FORM ACTION="act_weeklyReportsSetup.cfm?a=u" METHOD="post" name="get_client" onsubmit="return Verify(this);">
	<h4>Project Information (<cfoutput>#session.project_code#</cfoutput>)</h4>
	<p>
	<table cellpadding="2" cellspacing="2">
	<div>
		<tr>
		<td colspan="2"><img src="/images/red_arrow_9x9.gif"> = Required Field</td>
		</tr>
		<tr>
			<div class="bigquestion">
			<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Program Name</b></td>
			<td align="left"><input type="text" name="fProgramName" VALUE="<cfoutput>#Trim(program_name)#</cfoutput>"></td>
			</div>
		</tr>
		<tr>
			<div class="bigquestion">
			<td align="right"><b>Are there Speakers</b></td>
			<td align="left"><input type="checkbox" name="fchkSpeakers" <cfif speaker EQ 1>CHECKED</cfif>></td>
			</div>
		</tr>
		<tr>
			<div class="bigquestion">
			<td align="right"><b>Is there CI Data</b></td>
			<td align="left"><input type="checkbox" name="fchkCIData" <cfif ci EQ 1>CHECKED</cfif>></td>
			</div>
		</tr>
		<tr>
			<div class="bigquestion">
			<td align="right"><b>Polling Questions?</b></td>
			<td align="left"><input type="checkbox" <cfif polling EQ 1>CHECKED</cfif> name="fchkPolling" onclick="showhide('pollinglayer'); return(true);"></td>
			</div>
		</tr>
		</table>
		</div>
	<div style="<cfif polling NEQ 1>display: none;</cfif>margin-left:1em;" id="pollinglayer">
		<!--- polling question #1 --->
		<table cellpadding="2" cellspacing="2">
		<tr>
		<div>
			<td align="right"><b>Polling Questions #1?</b></td>
			<td align="left"><input type="checkbox" <cfif poll1 EQ 1>CHECKED</cfif> name="fchkPoll1" onclick="showhide('polling1layer'); return(true);"></td>
		</div>
		</tr>
		</table>
		<div style="<cfif poll1 NEQ 1>display: none;</cfif>margin-left:1em;" id="polling1layer">
			<table cellpadding="2" cellspacing="2">
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 1 Short Question</b></td>
				<td align="left"><input type="text" name="fPoll1Short" VALUE="<cfoutput>#Trim(poll1_short)#</cfoutput>"></td>
			</tr>
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 1 Full Question</b></td>
				<td align="left"><textarea name="fPoll1Long" rows="3" cols="40"><cfoutput>#Trim(poll1_long)#</cfoutput></textarea></td>
			</tr>
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 1 Type</b></td>
				<td align="left">
					<select name="fPoll1Type" onChange="showhide('polling1choices'); return(true);">
					<option value="YN" <cfif #poll1_type# EQ "YN">selected</cfif>>Yes/No</option>
					<option value="MULTI" <cfif #poll1_type# EQ "MULTI">selected</cfif> >Multiple Choice</option>
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
				<td align="left"><input type="text" name="fPoll1Choices" size="5" VALUE="<cfoutput>#Trim(poll1_nchoices)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 1 Response 1</b></td>
				<td align="left"><input type="text" name="fPoll1Resp1" size="50" VALUE="<cfoutput>#Trim(poll1_resp1)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 1 Response 2</b></td>
				<td align="left"><input type="text" name="fPoll1resp2" size="50" value="<cfoutput>#Trim(poll1_resp2)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 1 Response 3</b></td>
				<td align="left"><input type="text" name="fPoll1resp3" size="50" value="<cfoutput>#Trim(poll1_resp3)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 1 Response 4</b></td>
				<td align="left"><input type="text" name="fPoll1resp4" size="50" value="<cfoutput>#Trim(poll1_resp4)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 1 Response 5</b></td>
				<td align="left"><input type="text" name="fPoll1resp5" size="50" value="<cfoutput>#Trim(poll1_resp5)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 1 Response 6</b></td>
				<td align="left"><input type="text" name="fPoll1resp6" size="50" value="<cfoutput>#Trim(poll1_resp6)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 1 Response 7</b></td>
				<td align="left"><input type="text" name="fPoll1resp7" size="50" value="<cfoutput>#Trim(poll1_resp7)#</cfoutput>"></td>
			</tr>
			</table>
			</div> <!--- end of polling 1 multiple choice --->

		<!--- polling question #2 --->
		<table cellpadding="2" cellspacing="2">
		<tr>
		<div>
			<td align="right"><b>Polling Questions #2?</b></td>
			<td align="left"><input type="checkbox" <cfif poll2 EQ 1>CHECKED</cfif> name="fchkPoll2" onclick="showhide('polling2layer'); return(true);"></td>
		</div>
		</tr>
		</table>
		<div style="<cfif poll2 NEQ 1>display: none;</cfif>margin-left:1em;" id="polling2layer">
			<table cellpadding="2" cellspacing="2">
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 2 Short Question</b></td>
				<td><input type="text" name="fPoll2Short" VALUE="<cfoutput>#Trim(poll2_short)#</cfoutput>"></td>
			</tr>
			<tr>
				<td align="left" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 2 Full Question</b></td>
				<td align="left"><textarea name="fPoll2Long" rows="3" cols="40"><cfoutput>#Trim(poll2_long)#</cfoutput></textarea></td>
			</tr>
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 2 Type</b></td>
				<td align="left">
					<select name="fPoll2Type" onChange="showhide('polling2choices'); return(true);">
					<option value="YN" <cfif #poll2_type# EQ "YN">selected</cfif>>Yes/No</option>
					<option value="MULTI" <cfif #poll2_type# EQ "MULTI">selected</cfif> >Multiple Choice</option>
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
				<td align="left"><input type="text" name="fPoll2Choices" size="5" VALUE="<cfoutput>#Trim(poll2_nchoices)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 2 Response 1</b></td>
				<td align="left"><input type="text" name="fPoll2Resp1" size="50" VALUE="<cfoutput>#Trim(poll2_resp1)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 2 Response 2</b></td>
				<td align="left"><input type="text" name="fPoll2resp2" size="50" value="<cfoutput>#Trim(poll2_resp2)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 2 Response 3</b></td>
				<td align="left"><input type="text" name="fPoll2resp3" size="50" value="<cfoutput>#Trim(poll2_resp3)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 2 Response 4</b></td>
				<td align="left"><input type="text" name="fPoll2resp4" size="50" value="<cfoutput>#Trim(poll2_resp4)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 2 Response 5</b></td>
				<td align="left"><input type="text" name="fPoll2resp5" size="50" value="<cfoutput>#Trim(poll2_resp5)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 2 Response 6</b></td>
				<td align="left"><input type="text" name="fPoll2resp6" size="50" value="<cfoutput>#Trim(poll2_resp6)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 2 Response 7</b></td>
				<td align="left"><input type="text" name="fPoll2resp7" size="50" value="<cfoutput>#Trim(poll2_resp7)#</cfoutput>"></td>
			</tr>
			</table>
			</div> <!--- end of polling 2 multiple choice --->

		<!--- polling question #3 --->
		<table cellpadding="2" cellspacing="2">
		<tr>
		<div>
			<td align="right"><b>Polling Questions #3?</b></td>
			<td align="left"><input type="checkbox" <cfif poll3 EQ 1>CHECKED</cfif> name="fchkPoll3" onclick="showhide('polling3layer'); return(true);"></td>
		</div>
		</tr>
		</table>
		<div style="<cfif poll3 NEQ 1>display: none;</cfif>margin-left:1em;" id="polling3layer">
			<table cellpadding="2" cellspacing="2">
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 3 Short Question</b></td>
				<td align="left"><input type="text" name="fPoll3Short" VALUE="<cfoutput>#Trim(poll3_short)#</cfoutput>"></td>
			</tr>
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 3 Full Question</b></td>
				<td align="left"><textarea name="fPoll3Long" rows="3" cols="40"><cfoutput>#Trim(poll3_long)#</cfoutput></textarea></td>
			</tr>
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 3 Type</b></td>
				<td align="left">
					<select name="fPoll3Type" onChange="showhide('polling3choices'); return(true);">
					<option value="YN" <cfif #poll3_type# EQ "YN">selected</cfif>>Yes/No</option>
					<option value="MULTI" <cfif #poll3_type# EQ "MULTI">selected</cfif> >Multiple Choice</option>
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
				<td align="left"><input type="text" name="fPoll3Choices" size="5" VALUE="<cfoutput>#Trim(poll3_nchoices)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 3 Response 1</b></td>
				<td align="left"><input type="text" name="fPoll3Resp1" size="50" VALUE="<cfoutput>#Trim(poll3_resp1)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 3 Response 2</b></td>
				<td align="left"><input type="text" name="fPoll3resp2" size="50" value="<cfoutput>#Trim(poll3_resp2)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 3 Response 3</b></td>
				<td align="left"><input type="text" name="fPoll3resp3" size="50" value="<cfoutput>#Trim(poll3_resp3)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 3 Response 3</b></td>
				<td align="left"><input type="text" name="fPoll3resp4" size="50" value="<cfoutput>#Trim(poll3_resp4)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 3 Response 5</b></td>
				<td align="left"><input type="text" name="fPoll3resp5" size="50" value="<cfoutput>#Trim(poll3_resp5)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 3 Response 6</b></td>
				<td align="left"><input type="text" name="fPoll3resp6" size="50" value="<cfoutput>#Trim(poll3_resp6)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 3 Response 7</b></td>
				<td align="left"><input type="text" name="fPoll3resp7" size="50" value="<cfoutput>#Trim(poll3_resp7)#</cfoutput>"></td>
			</tr>
			</table>
			</div> <!--- end of polling 3 multiple choice --->

		<!--- polling question #4 --->
		<table cellpadding="2" cellspacing="2">
		<tr>
		<div>
			<td align="right"><b>Polling Questions #4?</b></td>
			<td align="left"><input type="checkbox" <cfif poll4 EQ 1>CHECKED</cfif> name="fchkPoll4" onclick="showhide('polling4layer'); return(true);"></td>
		</div>
		</tr>
		</table>
		<div style="<cfif poll4 NEQ 1>display: none;</cfif>margin-left:1em;" id="polling4layer">
			<table cellpadding="2" cellspacing="2">
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 4 Short Question</b></td>
				<td align="left"><input type="text" name="fPoll4Short" VALUE="<cfoutput>#Trim(poll4_short)#</cfoutput>"></td>
			</tr>
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 4 Full Question</b></td>
				<td align="left"><textarea name="fPoll4Long" rows="3" cols="40"><cfoutput>#Trim(poll4_long)#</cfoutput></textarea></b>
			</tr>
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 4 Type</b></td>
				<td align="left">
					<select name="fPoll4Type" onChange="showhide('polling4choices'); return(true);">
					<option value="YN" <cfif #poll4_type# EQ "YN">selected</cfif>>Yes/No</option>
					<option value="MULTI" <cfif #poll4_type# EQ "MULTI">selected</cfif> >Multiple Choice</option>
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
				<td align="left"><input type="text" name="fPoll4Choices" size="5" VALUE="<cfoutput>#Trim(poll4_nchoices)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 4 Response 1</b></td>
				<td align="left"><input type="text" name="fPoll4Resp1" size="50" VALUE="<cfoutput>#Trim(poll4_resp1)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 4 Response 2</b></td>
				<td align="left"><input type="text" name="fPoll4resp2" size="50" value="<cfoutput>#Trim(poll4_resp2)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 4 Response 3</b></td>
				<td align="left"><input type="text" name="fPoll4resp3" size="50" value="<cfoutput>#Trim(poll4_resp3)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 4 Response 4</b></td>
				<td align="left"><input type="text" name="fPoll4resp4" size="50" value="<cfoutput>#Trim(poll4_resp4)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 4 Response 5</b></td>
				<td align="left"><input type="text" name="fPoll4resp5" size="50" value="<cfoutput>#Trim(poll4_resp5)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 4 Response 6</b></td>
				<td align="left"><input type="text" name="fPoll4resp6" size="50" value="<cfoutput>#Trim(poll4_resp6)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 4 Response 7</b></td>
				<td align="left"><input type="text" name="fPoll4resp7" size="50" value="<cfoutput>#Trim(poll4_resp7)#</cfoutput>"></td>
			</tr>
			</table>
			</div> <!--- end of polling 4 multiple choice --->

		<!--- polling question #5 --->
		<table cellpadding="2" cellspacing="2">
		<tr>
			<div>
			<td align="right"><b>Polling Questions #5?</b></td>
			<td align="left"><input type="checkbox" <cfif poll5 EQ 1>CHECKED</cfif> name="fchkPoll5" onclick="showhide('polling5layer'); return(true);"></td>
			</div>
		</tr>
		</table>
		<div style="<cfif poll5 NEQ 1>display: none;</cfif>margin-left:1em;" id="polling5layer">
			<table cellpadding="2" cellspacing="2">
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 5 Short Question</b></td>
				<td align="left"><input type="text" name="fPoll5Short" VALUE="<cfoutput>#Trim(poll5_short)#</cfoutput>"></td>
			</tr>
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 5 Full Question</b></td>
				<td align="left"><textarea name="fPoll5Long" rows="3" cols="40"><cfoutput>#Trim(poll5_long)#</cfoutput></textarea></td>
			</tr>
			<tr>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 5 Type</b></td>
				<td align="left">
					<select name="fPoll5Type" onChange="showhide('polling5choices'); return(true);">
					<option value="YN" <cfif #poll5_type# EQ "YN">selected</cfif>>Yes/No</option>
					<option value="MULTI" <cfif #poll5_type# EQ "MULTI">selected</cfif> >Multiple Choice</option>
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
				<td align="left"><input type="text" name="fPoll5Choices" size="5" VALUE="<cfoutput>#Trim(poll5_nchoices)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 5 Response 1</b></td>
				<td align="left"><input type="text" name="fPoll5Resp1" size="50" VALUE="<cfoutput>#Trim(poll5_resp1)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 5 Response 2</b></td>
				<td align="left"><input type="text" name="fPoll5resp2" size="50" value="<cfoutput>#Trim(poll5_resp2)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 5 Response 3</b></td>
				<td align="left"><input type="text" name="fPoll5resp3" size="50" value="<cfoutput>#Trim(poll5_resp3)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 5 Response 4</b></td>
				<td align="left"><input type="text" name="fPoll5resp4" size="50" value="<cfoutput>#Trim(poll5_resp4)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 5 Response 5</b></td>
				<td align="left"><input type="text" name="fPoll5resp5" size="50" value="<cfoutput>#Trim(poll5_resp5)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 5 Response 6</b></td>
				<td align="left"><input type="text" name="fPoll5resp6" size="50" value="<cfoutput>#Trim(poll5_resp6)#</cfoutput>"></td>
			</tr>
			<tr>
				<td width="50"></td>
				<td align="right" valign="top"><img src="/images/red_arrow_9x9.gif"><b>Poll 5 Response 7</b></td>
				<td align="left"><input type="text" name="fPoll5resp7" size="50" value="<cfoutput>#Trim(poll5_resp7)#</cfoutput>"></td>
			</tr>
			</table>
			</div> <!--- end of polling 5 multiple choice --->
	</div> <!--- end of pollinglayer --->

	<div style="" id="decilelayer">
	<table cellpadding="2" cellspacing="2">
	<tr>
	<div style="" id="" class="bigquestion">
		<td align="right"><b>Decile 1?</b></td>
		<td align="left"><input type="checkbox" <cfif d1 EQ 1>CHECKED</cfif>  name="fchkDecile1" onclick="showhide('decile1layer'); return(true);"></td>
	</div>
	</tr>
	</table>
	<div style="<cfif d1 NEQ 1>display: none;</cfif>margin-left:1em;" id="decile1layer">
		<table cellpadding="2" cellspacing="2">
		<tr>
			<td align="right"><b>Decile 1 Name</b></td>
			<td><input type="text" name="fDecile1Name" VALUE="<cfoutput>#Trim(d1_name)#</cfoutput>"> (leave blank for unnamed decile)</td>
		</tr>
		</tr>
			<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Decile 1 Location</b></td>
			<td align="left">
				<select name="fDecile1Location">
					<option value="">Select Decile 1 Location</option>
					<option value="">---------------</option>
					<cfoutput query="qdecile_column_name">
						<option value="#id#" <cfif #id# EQ #d1_location#>SELECTED</cfif>>#decile_column_name#</option>
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
			<td align="left"><input type="checkbox" <cfif d2 EQ 1>CHECKED</cfif> name="fchkDecile2" onclick="showhide('decile2layer'); return(true);"></td>
			</div>
		</tr>
		</table>
		<div style="<cfif d2 NEQ 1>display: none;</cfif>margin-left:1em;" id="decile2layer">
			<table cellpadding="2" cellspacing="2">
			<tr>
				<td align="right"><b>Decile 2 Name</b></td>
				<td align="left"><input type="text" name="fDecile2Name"  VALUE="<cfoutput>#Trim(d2_name)#</cfoutput>"> (leave blank for unnamed decile)</td>
			</tr>
			<tr>
				<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Decile 2 Location</b></td>
				<td align="left">
					<select name="fDecile2Location">
						<option value="">Select Decile 2 Location</option>
						<option value="">---------------</option>
						<cfoutput query="qdecile_column_name">
							<option value="#id#" <cfif #id# EQ #d2_location#>SELECTED</cfif>>#decile_column_name#</option>
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
			<td align="left"><input type="checkbox" <cfif d3 EQ 1>CHECKED</cfif> name="fchkDecile3" onclick="showhide('decile3layer'); return(true);"></td>
			</div>
		</tr>
		</table>
		<div style="<cfif d3 NEQ 1>display: none;</cfif>margin-left:1em;" id="decile3layer">
			<table cellpadding="2" cellspacing="2">
			<tr>
				<td align="right"><b>Decile 3 Name</b></td>
				<td align="left"><input type="text" name="fDecile3Name" VALUE="<cfoutput>#Trim(d3_name)#</cfoutput>"> (leave blank for unnamed decile)</td>
			</tr>
			<tr>
				<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Decile 3 Location</b></td>
				<td align="left">
					<select name="fDecile3Location">
					<option value="">Select Decile 3 Location</option>
						<option value="">---------------</option>
						<cfoutput query="qdecile_column_name">
							<option value="#id#" <cfif #id# EQ #d3_location#>SELECTED</cfif>>#decile_column_name#</option>
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
		<td align="left"><input type="checkbox" name="fchkS1" <cfif s1 EQ 1>CHECKED</cfif>  onclick="showhide('s1layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="<cfif s1 NEQ 1>display: none;</cfif>margin-left:1em;" id="s1layer">
		<table cellpadding="2" cellspacing="2">
		<tr>
			<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Screener1 Name</b></td>
			<td align="left"><input type="text" name="fS1_name" VALUE="<cfoutput>#Trim(s1_name)#</cfoutput>"></td>
		</tr>
		</table>
	</div>
	<!--- screener2 --->
	<table cellpadding="2" cellspacing="2">
	<tr>
		<div class="bigquestion">
		<td align="right"><b>Screener2?</b></td>
		<td align="left"><input type="checkbox" name="fchkS2" <cfif s2 EQ 1>CHECKED</cfif>  onclick="showhide('s2layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="<cfif s2 NEQ 1>display: none;</cfif>margin-left:1em;" id="s2layer">
		<table cellpadding="2" cellspacing="2">
		<tr>
			<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Screener2 Name</b></td>
			<td align="left"><input type="text" name="fS2_name" VALUE="<cfoutput>#Trim(s2_name)#</cfoutput>"></td>
		</tr>
		</table>
	</div>
	<!--- screener3 --->
	<table cellpadding="2" cellspacing="2">
	<tr>
		<div class="bigquestion">
		<td align="right"><b>Screener3?</b></td>
		<td align="left"><input type="checkbox" <cfif s3 EQ 1>CHECKED</cfif> name="fchkS3" onclick="showhide('s3layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="<cfif s3 NEQ 1>display: none;</cfif>margin-left:1em;" id="s3layer">
		<table cellpadding="2" cellspacing="2">
		<tr>
			<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Screener3 Name</b></td>
			<td align="left"><input type="text" name="fS3_name" VALUE="<cfoutput>#Trim(s3_name)#</cfoutput>"></td>
		</tr>
		</table>
	</div>
	<!--- screener4 --->
	<table cellpadding="2" cellspacing="2">
	<tr>
		<div class="bigquestion">
		<td align="right"><b>Screener4?</b></td>
		<td align="left"><input type="checkbox" <cfif s4 EQ 1>CHECKED</cfif> name="fchkS4" onclick="showhide('s4layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="<cfif s4 NEQ 1>display: none;</cfif>margin-left:1em;" id="s4layer">
		<table cellpadding="2" cellspacing="2">
		<tr>
			<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Screener4 Name</b></td>
			<td align="left"><input type="text" name="fS4_name" VALUE="<cfoutput>#Trim(s4_name)#</cfoutput>"></td>
		</tr>
		</table>
	</div>
	<!--- screener5 --->
	<table cellpadding="2" cellspacing="2">
	<tr>
		<div class="bigquestion">
		<td align="right"><b>Screener5?</b></td>
		<td align="left"><input type="checkbox" <cfif s5 EQ 1>CHECKED</cfif> name="fchkS5" onclick="showhide('s5layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="<cfif s5 NEQ 1>display: none;</cfif>margin-left:1em;" id="s5layer">
		<table cellpadding="2" cellspacing="2">
		<tr>
			<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Screener5 Name</b></td>
			<td align="left"><input type="text" name="fS5_name" VALUE="<cfoutput>#Trim(s5_name)#</cfoutput>"></td>
		</tr>
		</table>
	</div>
	<!--- screener 6 --->
	<table cellpadding="2" cellspacing="2">
	<tr>
		<div class="bigquestion">
		<td align="right"><b>Screener6?</b></td>
		<td align="left"><input type="checkbox" <cfif s6 EQ 1>CHECKED</cfif> name="fchkS6" onclick="showhide('s6layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="<cfif s6 NEQ 1>display: none;</cfif>margin-left:1em;" id="s6layer">
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Screener6 Name</b></td>
		<td align="left"><input type="text" name="fS6_name" VALUE="<cfoutput>#Trim(s6_name)#</cfoutput>"></td>
	</tr>
	</table>
	</div>
	<!--- screener 7 --->
	<table cellpadding="2" cellspacing="2">
	<tr>
		<div class="bigquestion">
		<td align="right"><b>Screener7?</b></td>
		<td align="left"><input type="checkbox" <cfif s7 EQ 1>CHECKED</cfif> name="fchkS7" onclick="showhide('s7layer'); return(true);"></td>
	</tr>
	</table>
	</div>
	<div style="<cfif s7 NEQ 1>display: none;</cfif>margin-left:1em;" id="s7layer">
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Screener7 Name</b></td>
		<td align="left"><input type="text" name="fS7_name" VALUE="<cfoutput>#Trim(s7_name)#</cfoutput>"></td>
	</tr>
	</table>
	</div>
	<!--- screener 8 --->
	<table cellpadding="2" cellspacing="2">
	<tr>
		<div class="bigquestion">
		<td align="right"><b>Screener8?</b></td>
		<td align="left"><input type="checkbox" <cfif s8 EQ 1>CHECKED</cfif> name="fchkS8" onclick="showhide('s8layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="<cfif s8 NEQ 1>display: none;</cfif>margin-left:1em;" id="s8layer">
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Screener8 Name</b></td>
		<td align="left"><input type="text" name="fS8_name" VALUE="<cfoutput>#Trim(s8_name)#</cfoutput>"></td>
	</tr>
	</table>
	</div>
	<!--- screener 9 --->
	<table cellpadding="2" cellspacing="2">
	<tr>
		<div class="bigquestion">
		<td align="right"><b>Screener9?</b></td>
		<td align="left"><input type="checkbox" <cfif s9 EQ 1>CHECKED</cfif> name="fchkS9" onclick="showhide('s9layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="<cfif s9 NEQ 1>display: none;</cfif>margin-left:1em;" id="s9layer">
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Screener9 Name</b></td>
		<td align="left"><input type="text" name="fS9_name" VALUE="<cfoutput>#Trim(s9_name)#</cfoutput>"></td>
	</tr>
	</table>
	</div>
	<!--- screener 10 --->
	<table cellpadding="2" cellspacing="2">
	<tr>
		<div class="bigquestion">
		<td align="right"><b>Screener10?</b></td>
		<td align="left"><input type="checkbox" <cfif s10 EQ 1>CHECKED</cfif> name="fchkS10" onclick="showhide('s10layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="<cfif s10 NEQ 1>display: none;</cfif>margin-left:1em;" id="s10layer">
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Screener10 Name</b></td>
		<td align="left"><input type="text" name="fS10_name" VALUE="<cfoutput>#Trim(s10_name)#</cfoutput>"></td>
	</tr>
	</table>
	</div>

	<div class="bigquestion">
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td align="right"><b>User5?</b></td>
		<td align="left"><input type="checkbox" <cfif u5 EQ 1>CHECKED</cfif> name="fchkU5" onclick="showhide('u5layer'); return(true);"></td>
	</tr>
	</table>
	</div>
	<div style="<cfif u5 NEQ 1>display: none;</cfif>margin-left:1em;" id="u5layer">
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>User 5 Name</b></td>
		<td align="left"><input type="text" name="fu5_name" VALUE="<cfoutput>#Trim(u5_name)#</cfoutput>"></td>
	</tr>
	</table>
	</div>
	<!--- specialty --->
	<div class="bigquestion">
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td align="right"><b>Prime Specialty?</b></td>
		<td align="left"><input type="checkbox" <cfif prime_specialty EQ 1>CHECKED</cfif> name="fchkprime_specialty"></td>
	</tr>
	</table>
	</div>
	<!--- me number --->
	<div class="bigquestion">
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td align="right"><b>Menum?</b></td>
		<td align="left"><input type="checkbox" <cfif menum EQ 1>CHECKED</cfif> name="fchkmenum"></td>
	</tr>
	</table>
	</div>
	<!--- moderator --->
	<div class="bigquestion">
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td align="right"><b>Moderator?</b></td>
		<td align="left"><input type="checkbox" <cfif moderator EQ 1>CHECKED</cfif> name="fchkmoderator"></td>
	</tr>
	</table>
	</div>
	<!--- DB Match --->
	<div class="bigquestion">
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td align="right"><b>DB Match?</b></td>
		<td align="left"><input type="checkbox" <cfif db_match EQ 1>CHECKED</cfif> name="fchkdb_match"></td>
	</tr>
	</table>
	</div>
	<!--- terr1 --->
	<table cellpadding="2" cellspacing="2">
	<tr>
		<div class="bigquestion">
		<td align="right"><b>Territory 1 Rep?</b></td>
		<td align="left"><input type="checkbox" <cfif terr1 EQ 1>CHECKED</cfif> name="fchkterr1" onclick="showhide('terr1layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="<cfif terr1 NEQ 1>display: none;</cfif>margin-left:1em;" id="terr1layer">
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Territory 1 Name</b></td>
		<td align="left"><input type="text" name="fterr1_name" VALUE="<cfoutput>#Trim(terr1_name)#</cfoutput>"></td>
	</tr>
	</table>
	</div>
	<!--- terr2 --->
	<table cellpadding="2" cellspacing="2">
	<tr>
		<div class="bigquestion">
		<td align="right"><b>Territory 2 Rep?</b></td>
		<td align="left"><input type="checkbox" <cfif terr2 EQ 1>CHECKED</cfif> name="fchkterr2" onclick="showhide('terr2layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="<cfif terr2 NEQ 1>display: none;</cfif>margin-left:1em;" id="terr2layer">
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Territory 2 Name</b></td>
		<td align="left"><input type="text" name="fterr2_name" VALUE="<cfoutput>#Trim(terr2_name)#</cfoutput>"></td>
	</tr>
	</table>
	</div>

	<!--- terr3 --->
	<table cellpadding="2" cellspacing="2">
	<tr>
		<div class="bigquestion">
		<td align="right"><b>Territory 3 Rep?</b></td>
		<td align="left"><input type="checkbox" <cfif terr3 EQ 1>CHECKED</cfif> name="fchkterr3" onclick="showhide('terr3layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="<cfif terr3 NEQ 1>display: none;</cfif>margin-left:1em;" id="terr3layer">
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Territory 3 Name</b></td>
		<td align="left"><input type="text" name="fterr3_name" VALUE="<cfoutput>#Trim(terr3_name)#</cfoutput>"></td>
	</tr>
	</table>
	</div>

	<!--- Terr4 --->
	<table cellpadding="2" cellspacing="2">
	<tr>
		<div class="bigquestion">
		<td align="right"><b>Territory 4 Rep?</b></td>
		<td align="left"><input type="checkbox" <cfif terr4 EQ 1>CHECKED</cfif> name="fchkterr4" onclick="showhide('terr4layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="<cfif terr4 NEQ 1>display: none;</cfif>margin-left:1em;" id="terr4layer">
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Territory 4 Name</b></td>
		<td align="left"><input type="text" name="fterr4_name" VALUE="<cfoutput>#Trim(terr4_name)#</cfoutput>"></td>
	</tr>
	</table>
	</div>

	<!--- Terr5 --->
	<table cellpadding="2" cellspacing="2">
	<tr>
		<div class="bigquestion">
		<td align="right"><b>Territory 5 Rep?</b></td>
		<td align="left"><input type="checkbox" <cfif terr5 EQ 1>CHECKED</cfif> name="fchkterr5" onclick="showhide('terr5layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="<cfif terr5 NEQ 1>display: none;</cfif>margin-left:1em;" id="terr5layer">
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Territory 5 Name</b></td>
		<td align="left"><input type="text" name="fterr5_name" VALUE="<cfoutput>#Trim(terr5_name)#</cfoutput>"></td>
	</tr>
	</table>
	</div>

	<!--- Terr6 --->
	<table cellpadding="2" cellspacing="2">
	<tr>
		<div class="bigquestion">
		<td align="right"><b>Territory 6 Rep?</b></td>
		<td align="left"><input type="checkbox" <cfif terr6 EQ 1>CHECKED</cfif> name="fchkterr6" onclick="showhide('terr6layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="<cfif terr6 NEQ 1>display: none;</cfif>margin-left:1em;" id="terr6layer">
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Territory 6 Name</b></td>
		<td align="left"><input type="text" name="fterr6_name" VALUE="<cfoutput>#Trim(terr6_name)#</cfoutput>"></td>
	</tr>
	</table>
	</div>

	<!--- terr7 --->
	<table cellpadding="2" cellspacing="2">
	<tr>
		<div class="bigquestion">
		<td align="right"><b>Territory 7 Rep?</b></td>
		<td align="left"><input type="checkbox" <cfif terr7 EQ 1>CHECKED</cfif> name="fchkterr7" onclick="showhide('terr7layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="<cfif terr7 NEQ 1>display: none;</cfif>margin-left:1em;" id="terr7layer">
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Territory 7 Name</b></td>
		<td align="left"><input type="text" name="fterr7_name" VALUE="<cfoutput>#Trim(terr7_name)#</cfoutput>"></td>
	</tr>
	</table>
	</div>

	<!--- terr8 --->
	<table cellpadding="2" cellspacing="2">
	<tr>
		<div class="bigquestion">
		<td align="right"><b>Territory 8 Rep?</b></td>
		<td align="left"><input type="checkbox" <cfif terr8 EQ 1>CHECKED</cfif> name="fchkterr8" onclick="showhide('terr8layer'); return(true);"></td>
		</div>
	</tr>
	</table>
	<div style="<cfif terr8 NEQ 1>display: none;</cfif>margin-left:1em;" id="terr8layer">
	<table cellpadding="2" cellspacing="2">
	<tr>
		<td align="right"><img src="/images/red_arrow_9x9.gif"><b>Territory 8 Name</b></td>
		<td align="left"><input type="text" name="fterr8_name" VALUE="<cfoutput>#Trim(terr8_name)#</cfoutput>"></td>
	</tr>
	</table>
	</div>
	<!--- end of rep territory --->
	</div>
	</p>
		<p>
		<INPUT TYPE="submit" NAME="submit" VALUE=" Finish -> "  style="float:left;">
		</P>
	</form>
	</div>
<cfelse>
	<div class="main">
	Records Do Not exist for <cfoutput>#session.project_code#</cfoutput>. <br><br>
	Would you like to <a href="dsp_weeklyReportsSetup_add.cfm">add</a> information for code <cfoutput>#session.project_code#</cfoutput>?
	</div>
</cfif>

</body>
</html>
