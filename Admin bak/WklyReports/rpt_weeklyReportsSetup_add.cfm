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

<div align="center">
				<h4>Project Information (<cfoutput>#session.project_code#</cfoutput>)</h4>
<!---				<h3>Put a shadow under a block of content.</h3>	--->
<!---				<p>With a little imagination, and the addition of another element (<code>&lt;div&gt;</code>) that wraps around your content object, you can put a drop shadow under virtually anything. In this case, the content object consists of an <code>&lt;h2&gt;</code>, an <code>&lt;h3&gt;</code>, and a couple of <code>&lt;p&gt;</code>'s.</p>	--->
<!--- 				<p>The new <code>&lt;div&gt;</code> content wrapper introduced in this example uses the <code>.box</code> class which sets the <code>background-color</code>, <code>padding</code>, and <code>border</code> properties for this object. The <code>background-color</code> property is critical, since it masks the underlying shadow.</p>	--->
				<p>
				<div>
				<img src="/images/red_arrow_9x9.gif"> = Required Field<br><hr noshade size="1">
</div>
<div style="padding-left:150px;">
<FORM ACTION="rpt_weeklyReportsSetup_action.cfm?a=a" METHOD="post" name="get_client" onsubmit="return Verify(this);">

				<div class="bigquestion"><img src="/images/red_arrow_9x9.gif">Program Name: <input type="text" name="fProgramName"> <br>
				</div>
				<div class="bigquestion">Are there Speakers: <input type="checkbox" name="fchkSpeakers"><br>
				</div>
				<div class="bigquestion">Is there CI Data: <input type="checkbox" name="fchkCIData"><br>

				<div class="bigquestion">Polling Questions? <input type="checkbox" name="fchkPolling" onclick="showhide('pollinglayer'); return(true);">
				</div>
				</div>
				<div style="display: none;margin-left:1em;" id="pollinglayer">
					<div>
						Polling Questions #1? <input type="checkbox"poll1 name="fchkPoll1" onclick="showhide('polling1layer'); return(true);">
					</div>
					<div style="display: none;margin-left:1em;" id="polling1layer">
						<img src="/images/red_arrow_9x9.gif">Poll 1 Short Question: <input type="text" name="fPoll1Short"> <br>
						<img src="/images/red_arrow_9x9.gif">Poll 1 Full Question: <textarea name="fPoll1Long" rows="3" cols="40"></textarea>
					</div>

					<div>
						Polling Questions #2? <input type="checkbox"poll2 name="fchkPoll2" onclick="showhide('polling2layer'); return(true);">
					</div>
					<div style="display: none;margin-left:1em;" id="polling2layer">
						<img src="/images/red_arrow_9x9.gif">Poll 2 Short Question: <input type="text" name="fPoll2Short"> <br>
						<img src="/images/red_arrow_9x9.gif">Poll 2 Full Question: <textarea name="fPoll2Long" rows="3" cols="40"></textarea>
					</div>

					<div>
							Polling Questions #3? <input type="checkbox" name="fchkPoll3" onclick="showhide('polling3layer'); return(true);">
						</div>
						<div style="display: none;margin-left:1em;" id="polling3layer">
							<img src="/images/red_arrow_9x9.gif">Poll 3 Short Question: <input type="text" name="fPoll3Short"> <br>
							<br/>
							<img src="/images/red_arrow_9x9.gif">Poll 3 Full Question: <textarea name="fPoll3Long" rows="3" cols="40"></textarea>
						</div>
					</div>

					<div style="" id="decilelayer">
					<div style="" id="" class="bigquestion">
						Decile 1? <input type="checkbox"  name="fchkDecile1" onclick="showhide('decile1layer'); return(true);">
					</div>
					<div style="display: none;margin-left:1em;" id="decile1layer">
						Decile 1 Name: <input type="text" name="fDecile1Name"> (leave blank for unnamed decile)  <br>
						<img src="/images/red_arrow_9x9.gif">Decile 1 Location:
						<select name="fDecile1Location">
						<option value="">Select Decile 1 Location</option>
							<option value="">---------------</option>
							<cfoutput query="qdecile_column_name">
								<option value="#id#">#decile_column_name#</option>
							</cfoutput>
						</select>
					</div>

					<div style="" id="" class="bigquestion">
						Decile 2? <input type="checkbox" name="fchkDecile2" onclick="showhide('decile2layer'); return(true);">
					</div>
					<div style="display: none;margin-left:1em;" id="decile2layer">
						Decile 2 Name: <input type="text" name="fDecile2Name"> (leave blank for unnamed decile) <br>
						<img src="/images/red_arrow_9x9.gif">Decile 2 Location:
						<select name="fDecile2Location">
						<option value="">Select Decile 2 Location</option>
							<option value="">---------------</option>
							<cfoutput query="qdecile_column_name">
								<option value="#id#">#decile_column_name#</option>
							</cfoutput>
						</select>
					</div>

					<div style="" id="" class="bigquestion">
					Decile 3? <input type="checkbox" name="fchkDecile3" onclick="showhide('decile3layer'); return(true);">
					</div>
					<div style="display: none;margin-left:1em;" id="decile3layer">
						Decile 3 Name: <input type="text" name="fDecile3Name"> (leave blank for unnamed decile) <br>
						<img src="/images/red_arrow_9x9.gif">Decile 3 Location:
						<select name="fDecile3Location">
						<option value="">Select Decile 3 Location</option>
							<option value="">---------------</option>
							<cfoutput query="qdecile_column_name">
								<option value="#id#">#decile_column_name#</option>
							</cfoutput>
						</select>
					</div>
				<div class="bigquestion">
				Screener1? <input type="checkbox" name="fchkS1" onclick="showhide('s1layer'); return(true);">
				</div>
				<div style="display: none;margin-left:1em;" id="s1layer">
				<img src="/images/red_arrow_9x9.gif">Screener1 Name: <input type="text" name="fS1_name"> <br>
				</div>
				<div class="bigquestion">
				Screener2? <input type="checkbox" name="fchkS2" onclick="showhide('s2layer'); return(true);">
				</div>
				<div style="display: none;margin-left:1em;" id="s2layer">
				<img src="/images/red_arrow_9x9.gif">Screener2 Name: <input type="text" name="fS2_name"> <br>
				</div>
				<div class="bigquestion">
				Screener3? <input type="checkbox" name="fchkS3" onclick="showhide('s3layer'); return(true);">
				</div>
				<div style="display: none;margin-left:1em;" id="s3layer">
				<img src="/images/red_arrow_9x9.gif">Screener3 Name: <input type="text" name="fS3_name"> <br>
				</div>
				<div class="bigquestion">
				Screener4? <input type="checkbox" name="fchkS4" onclick="showhide('s4layer'); return(true);">
				</div>
				<div style="display: none;margin-left:1em;" id="s4layer">
				<img src="/images/red_arrow_9x9.gif">Screener4 Name: <input type="text" name="fS4_name"> <br>
				</div>
				<div class="bigquestion">
				Screener5? <input type="checkbox" name="fchkS5" onclick="showhide('s5layer'); return(true);">
				</div>
				<div style="display: none;margin-left:1em;" id="s5layer">
				<img src="/images/red_arrow_9x9.gif">Screener5 Name: <input type="text" name="fS5_name"> <br>
				</div>
				<div class="bigquestion">
				Screener6? <input type="checkbox" name="fchkS6" onclick="showhide('s6layer'); return(true);">
				</div>
				<div style="display: none;margin-left:1em;" id="s6layer">
				<img src="/images/red_arrow_9x9.gif">Screener6 Name: <input type="text" name="fS6_name"> <br>
				</div>
				<div class="bigquestion">
				Screener7? <input type="checkbox" name="fchkS7" onclick="showhide('s7layer'); return(true);">
				</div>
				<div style="display: none;margin-left:1em;" id="s7layer">
				<img src="/images/red_arrow_9x9.gif">Screener7 Name: <input type="text" name="fS7_name"^> <br>
				</div>
				<div class="bigquestion">
				Screener8? <input type="checkbox" name="fchkS8" onclick="showhide('s8layer'); return(true);">
				</div>
				<div style="display: none;margin-left:1em;" id="s8layer">
				<img src="/images/red_arrow_9x9.gif">Screener8 Name: <input type="text" name="fS8_name"> <br>
				</div>
				<div class="bigquestion">
				Screener9? <input type="checkbox" name="fchkS9" onclick="showhide('s9layer'); return(true);">
				</div>
				<div style="display: none;margin-left:1em;" id="s9layer">
				<img src="/images/red_arrow_9x9.gif">Screener9 Name: <input type="text" name="fS9_name"> <br>
				</div>
				<div class="bigquestion">
				Screener10? <input type="checkbox" name="fchkS10" onclick="showhide('s10layer'); return(true);">
				</div>
				<div style="display: none;margin-left:1em;" id="s10layer">
				<img src="/images/red_arrow_9x9.gif">Screener10 Name: <input type="text" name="fS10_name"> <br>
				</div>
				
				<div class="bigquestion">
				User5? <input type="checkbox" name="fchkU5" onclick="showhide('u5layer'); return(true);">
				</div>
				<div style="display: none;margin-left:1em;" id="u5layer">
				<img src="/images/red_arrow_9x9.gif">User 5 Name: <input type="text" name="fu5_name"> <br>
				</div>
				
				<div class="bigquestion">Prime Specialty? <input type="checkbox" name="fchkprime_specialty"></div>
				
				<div class="bigquestion">Menum? <input type="checkbox" name="fchkmenum"></div>
				
				<div class="bigquestion">Moderator? <input type="checkbox" name="fchkmoderator"></div>
				
				<div class="bigquestion">DB Match? <input type="checkbox" name="fchkdb_match"></div>
				
				<div class="bigquestion">
				Territory 1 Name? <input type="checkbox" name="fchkterr1" onclick="showhide('terr1layer'); return(true);">
				</div>
				<div style="display: none;margin-left:1em;" id="terr1layer">
				<img src="/images/red_arrow_9x9.gif">Territory 1 Name: <input type="text" name="fterr1_name"> <br>
				</div>
				<div class="bigquestion">
				Territory 2 Name? <input type="checkbox" name="fchkterr2" onclick="showhide('terr2layer'); return(true);">
				</div>
				<div style="display: none;margin-left:1em;" id="terr2layer">
				<img src="/images/red_arrow_9x9.gif">Territory 2 Name: <input type="text" name="fterr2_name"> <br>
				</div>
				<div class="bigquestion">
				Territory 3 Name? <input type="checkbox" name="fchkterr3" onclick="showhide('terr3layer'); return(true);">
				</div>
				<div style="display: none;margin-left:1em;" id="terr3layer">
				<img src="/images/red_arrow_9x9.gif">Territory 3 Name: <input type="text" name="fterr3_name"> <br>
				</div>
				<div class="bigquestion">
				Territory 4 Name? <input type="checkbox" name="fchkterr4" onclick="showhide('terr4layer'); return(true);">
				</div>
				<div style="display: none;margin-left:1em;" id="terr4layer">
				<img src="/images/red_arrow_9x9.gif">Territory 4 Name: <input type="text" name="fterr4_name"> <br>
				</div>
				<div class="bigquestion">
				Territory 5 Name? <input type="checkbox" name="fchkterr5" onclick="showhide('terr5layer'); return(true);">
				</div>
				<div style="display: none;margin-left:1em;" id="terr5layer">
				<img src="/images/red_arrow_9x9.gif">Territory 5 Name: <input type="text" name="fterr5_name"> <br>
				</div>
				<div class="bigquestion">
				Territory 6 Name? <input type="checkbox" name="fchkterr6" onclick="showhide('terr6layer'); return(true);">
				</div>
				<div style="display: none;margin-left:1em;" id="terr6layer">
				<img src="/images/red_arrow_9x9.gif">Territory 6 Name: <input type="text" name="fterr6_name"> <br>
				</div>
				<div class="bigquestion">
				Territory 7 Name? <input type="checkbox" name="fchkterr7" onclick="showhide('terr7layer'); return(true);">
				</div>
				<div style="display: none;margin-left:1em;" id="terr7layer">
				<img src="/images/red_arrow_9x9.gif">Territory 7 Name: <input type="text" name="fterr7_name"> <br>
				</div>
				<div class="bigquestion">
				Territory 8 Name? <input type="checkbox" name="fchkterr8" onclick="showhide('terr8layer'); return(true);">
				</div>
				<div style="display: none;margin-left:1em;" id="terr8layer">
				<img src="/images/red_arrow_9x9.gif">Territory 8 Name: <input type="text" name="fterr8_name"> <br>
				</div>

				</div>

				</p>
				<p>

				<INPUT TYPE="submit" NAME="submit" VALUE=" Finish -> "  style="float:left;">

				</P>
				</div>
				</form>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

