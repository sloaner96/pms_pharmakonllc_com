<!------------------------------------------------------------------------------------------->
<!---			Template	Name	:	dsp_HomePagecontent.cfm				----------------->
<!---			Purpose				:	To Display the content of Actoslet Homepage  -------->
<!---			Created by			:	Kannan Padmanabhan					----------------->
<!---			Date Created		:	08/06/2004							----------------->

<!------------------------------------------------------------------------------------------->

<cfset today = DateFormat(now(), "m/d/yyyy")>
 <cfset yesterdayx = dateAdd('d', -1, today)>
 <cfset yesterday = DateFormat(yesterdayx, "m/d/yyyy")>


	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
	"http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<!-- DW6 -->
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<title>Pharmakon, a PDI Company</title>

	<LINK REL=stylesheet HREF="piw1style.css" TYPE="text/css">
	<body>

		<!--- <cfset pagename="Attendance Emailer"> --->
		<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Attendance Mailer" showCalendar="1">
		<cfif IsDefined("session.loggedin") and session.loggedin>
			<!---<div id="content">--->
				<div class="info1">
					<div align="center">
						<form name="attendanceemailer" action="attendanceemailer_proc.cfm" method="post">
							<SCRIPT SRC="/includes/libraries/CallCal.js"></SCRIPT>
	                         <SCRIPT SRC="/includes/libraries/confirm.js"></SCRIPT>

							<cfif ListFindNoCase(session.userInRole,"PHAdmin") eq 0 and ListFindNoCase(session.userInRole,"PHUsers") eq 0>
								<br><br>
								<table width=700 align="center" class="table">
									<tr><td>&nbsp;</td></tr>
									<tr><td>&nbsp;</td></tr>
									<tr class="textc"><td align="center"><font color="Maroon"><b>Sorry, we couldn't determine your level of accessiblity.</b></td></tr>
									<tr><td>&nbsp;</td></tr>
									<tr class="textc"><td align="center"><font color="maroon"><b>Please try again, or contact Pharmakon support for help if the problem persists.</b></font></td></tr>
									<tr><td>&nbsp;</td></tr>
								</table>
							<cfelseif not ListFindnocase(session.userinRole,"PHAdmin")>
								<br><br>
								<table width=700 align="center" class="table">
									<tr><td>&nbsp;</td></tr>
									<tr class="textc"><td align="center"><font color="Maroon"><b>You are not authorized to view this page</b></td></tr>
									<tr><td>&nbsp;</td></tr>
								</table>
							<cfelse>
								<br><h3>Attendance Emailer</h><br><br>
								<table width="700" border="0" align="center" bgcolor="EDEDED">
									<tr class="css23"><td colspan=2>&nbsp;</td></tr>
									<tr>
										<td align="left" class="textc" width=150>Select a Project</td>
										<td align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<select name="select_project" class="textf">
												<option value="">------------------------------Choose----------------------------</option>
												<option value="em_CTAAC11SX">CTAAC11SX (Actos Compliment)</option>
												<option value="em_CTAAC15SX">CTAAC15SX (ActoPlusMet)</option>
												<option value="em_CTAAC11SX_RSD">CTAAC11SX (Actos Compliment RSM)</option>
												<option value="em_CTAAC15SX_RSD">CTAAC15SX (ActoPlusMet RSM)</option>
												<option value="em_CBIAG04SX">CBIAG04SX (Aggrenox Series 1)</option>
												<option value="em_CBIAG05SX">CBIAG05SX (Aggrenox Series 2)</option>
												<option value="em_CTAAZ00SX">CTAAZ00SX (Amitiza STS)</option>
												<option value="em_CACBX02CT">CACBX02CT (Biaxin English)</option>
												<option value="em_CACBX03CT">CACBX03CT (Biaxin French)</option>
												<option value="em_GLICY05SX">GLICY05SX (Cymbalta PCP)</option>
												<option value="em_GLICY06SX">GLICY06SX (Cymbalta PCP Series 2)</option>
												<option value="em_GLICY07SX">GLICY07SX (Cymbalta PCP Series 3)</option>
												<option value="em_GLICY08SX">GLICY08SX (Cymbalta PCP Series 4)</option>
												<option value="em_GLICY08SX_PSYCH">GLICY08SX (Cymbalta Psych Series 4)</option>
												<option value="em_GLICY01WX">GLICY01WX (Cymbalta PCP Web)</option>
												<option value="em_GLICY02WX">GLICY02WX (Cymbalta PCP Web Series 3)</option>
												<option value="em_GLICY03WX">GLICY03WX (Cymbalta PCP Web Series 4)</option>
												<option value="em_GLICY03WX_PSYCH">GLICY03WX (Cymbalta Psych Web Series 4)</option>
												<option value="em_GLICP00SX">GLICP00SX (Cymbalta Psych)</option>
												<option value="em_GLIHM01CT">GLIHM01CT (Humalog Series 1 CET)</option>
												<option value="em_GLIHM02CT">GLIHM02CT (Humalog Series 2 CET)</option>
												<option value="em_GLIHM03SX">GLIHM03SX (Humalog Series 3 STS)</option>
												<option value="em_GLIHM01CT_NPPA">GLIHM01CT (Humalog Series 1 NPPA CET)</option>
												<option value="em_GLIHM02CT_NPPA">GLIHM02CT (Humalog Series 2 NPPA CET)</option>
												<option value="em_GLIHM03SX_NPPA">GLIHM03SX (Humalog Series 3 NPPA STS)</option>
												<option value="em_ENNGL00SX">ENNGL00SX (GlucoNorm-English)</option>
												<option value="em_ENNNR00SX">ENNNR00SX (NovoRapid-English)</option>
												<option value="em_ENNNR01SX">ENNNR01SX (NovoRapid-French)</option>
												<option value="em_EJZXY00SX">EJZXY00SX (Xyrem Neuro/Psych STS)</option>
												<option value="em_EJZXY01SX">EJZXY01SX (Xyrem Pulm STS)</option>
												<option value="em_EJZXY00SX_RSM">EJZXY00SX (Xyrem Neuro/Psych RSM)</option>
												<option value="em_EJZXY01SX_RSM">EJZXY01SX (Xyrem Pulm RSM)</option>
												<option value="em_GLISP00SX">GLISP00SX (Strattera Psych Series 1)</option>
												<option value="em_GLISP01SX">GLISP01SX (Strattera Psych/PCP Series 1)</option>
												<option value="em_GLISP02SX">GLISP02SX (Strattera Psych)</option>
												<option value="em_GLISK00SX">GLISK00SX (Strattera PED)</option>
												<option value="em_GLISM00SX">GLISM00SX (Strattera Managed Care (FL))</option>
												<option value="em_GLISM01SX">GLISM01SX (Strattera Managed Care (TX))</option>
												<option value="em_GLISM02SX">GLISM02SX (Strattera Managed Care (NY))</option>
												<option value="em_GLIZB02SX">GLIZB02SX (Zyprexa Bipolar Treatment)</option>
												<option value="em_GLIZB03SX">GLIZB03SX (Zyprexa Bipolar Diagnosis)</option>
												<option value="em_GLIZE00SX">GLIZE00SX (Zyprexa Pych/Endo)</option>
												<option value="em_GLIZS02SX">GLIZS02SX (Zyprexa Schizophrenia)</option>
												<option value="em_GLIZS03SX">GLIZS03SX (Zyprexa Schizophrenia Combo)</option>
												<option value="em_GLIZS06SX">GLIZS06SX (Zyprexa Schizophrenia Treatment)</option>
												<option value="em_PCERC00SX">PCERC00SX (Remicade)</option>
											</select>
										</td>
									</tr>
									<tr class="css23">
										<td colspan=2>Begin Date &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;End Date</td>
									</tr>
									<tr class="css23">
										<td colspan=2>
										<cfmodule template="#Application.TagPath#/ctags/CalInput.cfm" inputname="begin_date" htmlid="begindate" formvalue="#yesterday#" imgid="begindatebtn">

											<!--- <input type="text" name="begindate" id="sel1" size="12" maxlength="15" class="texth" value="<cfoutput>#DateFormat(DateAdd('d',-1,Now()),'mm/dd/yyyy')#</cfoutput>"><input type="image" align="center" valign="center" src="../images/calendar.gif" border=0 class="red" value=" ..." onclick="return showCalendar('sel1', '%m/%d/%Y');"> --->

<cfmodule template="#Application.TagPath#/ctags/CalInput.cfm" inputname="end_date" htmlid="enddate" formvalue="#today#" imgid="enddatebtn">
											<!--- <input type="text" name="enddate" id="sel3" size="12" maxlength="15" class="texth"   value="<cfoutput>#DateFormat(Now(),'mm/dd/yyyy')#</cfoutput>"><input type="image" align="center" valign="center" src="../images/calendar.gif" border=0 class="red" value=" ..." onclick="return showCalendar('sel3', '%m/%d/%Y');"> --->
										</td>
									</tr>
									<tr class="css23"><td colspan=3>&nbsp;</td></tr>
									<tr><td colspan=3 align="center"><input type="submit" name="submit" value="Submit" class="css23" onClick="return validateForm()">&nbsp;&nbsp;&nbsp;<input type="reset" name="refresh" value="Refresh" class="css23"></td>

								</table>
							</cfif>
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
