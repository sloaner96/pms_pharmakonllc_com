<!------------------------------------------------------------------------------------------->
<!---			Template	Name	:	dsp_HomePagecontent.cfm				----------------->
<!---			Purpose				:	To Display the content of Actoslet Homepage  -------->
<!---			Created by			:	Kannan Padmanabhan					----------------->
<!---			Date Created		:	08/06/2004							----------------->
<!---			History				:   												----->
<!---									bj20061129 - initial code for Gluconorm			----->
<!------------------------------------------------------------------------------------------->
<cfoutput>
<cfset meetingcode = '#url.meetingcode#'>
<cfset begindate = '#url.begindate#'>
<cfset enddate = '#url.enddate#'>
</cfoutput>
	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
	"http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<!-- DW6 -->
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<title>Pharmakon, a PDI Company</title>
	<link rel="stylesheet" href="/stylesheets/pharmakon.css" type="text/css">
	<body>
		<cfset pagename="Attendance Emailer for <cfoutput>#meetingcode#</cfoutput>">
		<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Attendance Mailer" showCalendar="1">
		<cfif IsDefined("session.loggedin") and session.loggedin>
			<!---<div id="content">--->
				<div class="info1">
					<div align="center">
						<cfoutput><form name="emailer" action="em_#meetingcode#_mail.cfm" method="post"></cfoutput>
							<input type="hidden" name="fa" value="sendmail">
							<script language="javascript">
								function submitForm(colname)
								{
									with(document.emailer)
									{
										emailer.innerHTML="<input type=hidden name=fa value='"+colname+"'>";
										document.emailer.submit();
									}
								}
							</script>

							<cfscript>
								dataobj.refresh();
								for(i=1;i lt 2;i=i+1)
								{
									qGetAttendedWithReps = dataobj.getAttendedWithReps(i);
								}
							</cfscript>
							<cfscript>
								qattendees = dataobj.getAttendeesFromTemp();
								qalreadysent=dataobj.getAlreadySent();
								qGetrepcount=dataobj.getRepCount();
								qGetattendeecount=dataobj.getAttendeeCount();
							</cfscript>

							<cfif qattendees.recordcount eq 0>
								<br><br><br><br>
								<table width=700 align="center" class="table">
									<tr><td>&nbsp;</td></tr>
									<tr><td>&nbsp;</td></tr>
									<tr class="textc"><td align="center">This is not a valid selection, please select again. !!!</td></tr>
									<tr><td>&nbsp;</td></tr>
									<tr><td align="center" class="textc"><a href="dsp_attendanceemailer.cfm">back to Option page</a></td></tr>
								</table>
								<cfabort>
							</cfif>


							<table width="800" align="center" border="0">

								<tr class="textc"><td align="left"><br><br>This is the attendee list to be sent for <cfoutput><strong>#meetingcode#</strong> Dates from #begindate# To #enddate#.</font></b></cfoutput></td></tr>

								<tr class="textc"><td align="left"><cfoutput>#qGetattendeeCount.totalrows#</cfoutput> attendees have been found, <cfoutput>#qGetrepcount.totalemails#</cfoutput> e-mails will be sent<br><br> <a href="dsp_attendanceemailer.cfm"><u>Back to Attendees Mailer Selection Page</u></a></td></tr>
							</table>



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

							<table width=700 align="center" class="table">
								<tr><td>&nbsp;</td></tr>
								<tr><td>&nbsp;</td></tr>
								<cfif qalreadysent.recordcount>
									<tr class="textc"><td align="center"><strong>This list has already been sent. Are you sure you want to send it again?</strong></td></tr>
								<cfelse>
									<tr class="textc"><td align="center"><strong>Are you Sure, you want to send this Email?</strong></td></tr>
								</cfif>
								<tr><td>&nbsp;</td></tr>
								<tr><td align="right"><input type="submit" name="Email" value="Send Emails" class="css23"></td></tr>
							</table>

							<input type="hidden" name="meetingcode" value="<cfoutput>#meetingcode#</cfoutput>">
							<input type="hidden" name="begindate" value="<cfoutput>#begindate#</cfoutput>">
							<input type="hidden" name="enddate" value="<cfoutput>#enddate#</cfoutput>">
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
