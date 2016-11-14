<!------------------------------------------------------------------------------------------->
<!---			Template	Name	:	dsp_HomePagecontent.cfm				----------------->
<!---			Purpose				:	To Display the content of Actoslet Homepage  -------->
<!---			Created by			:	Kannan Padmanabhan					----------------->
<!---			Date Created		:	08/06/2004							----------------->
<!---			History				:													----->
<!---								:	bj20061129 - initial code for Gluconorm			----->
<!------------------------------------------------------------------------------------------->

	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
	"http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<!-- DW6 -->
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<title>Pharmakon, a PDI Company</title>
	<link rel="stylesheet" href="/stylesheets/pharmakon.css" type="text/css">
	<body>
		<cfset pagename="Attendance Emailer - <cfoutput>#meetingcode#</cfoutput>">
		<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Attendance Mailer" showCalendar="1">
		<cfif IsDefined("session.loggedin") and session.loggedin>
			<!---<div id="content">--->
				<div class="info1">
					<div align="center">
						<form name="attendanceemailer">
							<cfscript>
								qattendees = dataobj.getAttendeesFromTemp();
								qGetrepcount=dataobj.getRepCount();
								qGetattendeecount=dataobj.getAttendeeCount();
								EmailLog = dataobj.putEmailLog(qGetrepcount.totalemails);
							</cfscript>

							<!----  E  M  A  I  L     R O U T I N E ---->
							<cfmail
								query="qattendees"
								group="terr_id"
								from="Gluconorm.Marketing@edcommhc.com"
								to="Gluconorm.Marketing@pharmaklone.net"
								subject="A physician from your territory participated in a Clinical Experience Program"
								bcc="Gluconorm.Marketing@PHARMAKLONE.NET"
								server="mail.edcommhc.com"
								username="pharmakon\Gluconorm.Marketing"
								password="mob4merits"
								type="HTML">
							<br>
							A physician from your territory recently participated in a GlucoNorm&reg; Speaker<br>
							Teleconference (STS) titled <b>"Choosing an Insulin Secretagogue: Treating<br>
							Postprandial Glucose (PPG) for Improved Control."</b>  These are interactive one-hour<br>
							programs consisting of approximately 12-16 target physicians from across the country.<br>
							The programs are conducted by distinguished experts in the field of endocrinology along<br>
							with an EdComm moderator.  These programs are based on a selling technique that draws<br>
							on peer influence and word-of-mouth persuasion techniques to alter prescribing behavior.<br><br>
							Here is a summary of the information.<br>
							<cfoutput>
							<ul>
							<li><b>#trim(firstname)#&nbsp;#trim(lastname)#</b>&nbsp;from <b>#trim(city)#,&nbsp;#state#</b>
							participated in this GlocoNorm&reg; STS on <b>#DateFormat(apptdate, "m/d/yy")#</b>.</li>
							 <cfif #poll1# EQ 'YES'><li>He/she requested literature.</li></cfif>
							</ul>
							</cfoutput>
							<br><br>
							<b>What can you do to increase the impact of this program?</b><br><br>
							Please contact and work with your local primary care representative to:<br>
							<ul>
							<li>Visit the office within two weeks of the call.</li>
							<li>Discuss what physicians considered the most compelling message(s) and data.</li>
							<li>Address any unanswered questions.</li>
							<li>Ask the doctor to prescribe GlucoNorm&reg; (repaglinide) instead of a competitive product<br>
							for treating type 2 diabetes when diet and excercise alone have failed.</li>
							</ul>
							<br><br>
							Thanks for your prompt follow-up, and we hope this promotional GlucoNorm&reg; program drives<br>
							share in your local market.
							<br><br>
							<center><b>THIS IS AN AUTOMATED E-MAIL NOTIFICATION. DO NOT REPLY.</b><br></center>
							</cfmail>

							<!---   E N D    O F    E M A I L   R O U T I N E    --->
							<br><br>
							<table width=700 align="center"border=0 class="table1">
								<tr class="textc">
									<td align="left"><b>This is the attendee List sent for <cfoutput>#meetingcode# for dates #begindate# thru #enddate#</cfoutput></b></td>
								</tr>
								<tr class="textc">
									<td align="left"><cfoutput>#qGetattendeecount.totalrows#</cfoutput> attendees are listed.</td>
								</tr>
								<tr class="textc">
									<td align="left"><cfoutput>#qGetrepcount.totalemails#</cfoutput> emails have been sent.</td>
								</tr>
								<tr><td>&nbsp;</td></tr>
								<tr class="textc">
									<td align="left"><b>Emails were sent <cfoutput>#dateFormat(Now(), "mm/dd/yy hh:mm")# #TimeFormat(Now(),"tt")#</cfoutput></b>

<br><br> <a href="dsp_attendanceemailer.cfm"><u>Back to Attendees Mailer Selection Page</u></a>


</td>
								</tr>
							</table>
							<br>



							<br><br>
							<table border="0" width=700 align="center" class="table">
							<tr>
							<td>
							&nbsp;
							</td>
							<td align="left">
							<strong>ID</strong>
							</td>
							<td align="left">
							<strong>Rep. Name</strong>
							</td>
							<td align="left">
							<strong>Email</strong>
							</td>
							<td align="left">
							<strong>Name</strong>
							</td>
							<td align="left">
							<strong>City</strong>
							</td>
							<td align="left">
							<strong>State</strong>
							</td>
							</tr>

							<tr>
							<td colspan="7"><br>
							</td>
							</tr>


<cfoutput query="qattendees" group="email">

<tr>
<td align="left"><b>#qattendees.currentrow#.</b> </td>
<td align="left">#terr_id#
</td>
<td align="left">
#rep_firstname# #rep_lastname#
</td>
<td align="left">
<u><a href="mailto:#email#">#email#</a></u>
</td>
<td align="left">
#firstname#&nbsp;#lastname#
</td>
<td align="left">#city#
</td>
<td align="left">
#state#
</td>
</tr>
<tr>
<td colspan="7">
<hr align="center" size="1">
</td>
</tr>
</cfoutput>
</table>

						</form>
					</div>
				</div>
			<!---</div>--->
			<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
	<cfelse>
			<cflocation url="index.htm" addtoken="no">
	</cfif>


</body>
</html>
