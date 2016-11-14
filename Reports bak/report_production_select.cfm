<!--- *****************************************************************************************
	Name:		report_production_select.cfm
	
	Function:	This page displays selection criteria that can be used for a customized report. 
				This form data goes to report_production_bridge.cfm where session variables are
				set, and based on the criteria selected, the user is relocated to the 
				appropriate forms(reports) 
	History:	lb111202 - complete
	
	*****************************************************************************************--->


<HTML>
<HEAD>
<TITLE>Production Schedule</TITLE>
<SCRIPT LANGUAGE="JavaScript" src="../popup_help.js"></script>
<LINK REL=STYLESHEET HREF="../PIW1STYLE.CSS" TYPE="TEXT/CSS">
<STYLE>
TD 
{
	font-family : Verdana, Geneva, Arial;
	font-size : xx-small;
	text-align: left;
	background-color: #FFFFFF;
}

.DAYS 
{
	font-family : Verdana, Geneva, Arial;
	font-size : xx-small;
	font-weight: bold;
	text-align: center;
}
.WEEKS 
{
	font-family : ArialBold;
	font-size : xx-small;
	text-align: center;
}
TD.RadioCell
{
	font-size: 11px;
	background-color: #FFFFFF;
	text-align: center;
	padding-right: 2px;
	padding-left: 2px;
	border-bottom: solid 1px navy;
}	
</STYLE>		


<TITLE>Meeting Count Select</TITLE>
<!--- Pull project codes for drop down --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qprojects">
SELECT client_proj, description, client_code 
FROM client_proj 
ORDER BY client_code
</CFQUERY>

<!--- Pull moderators for drop down --->
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="qmods">
SELECT lastname, firstname, speaker_id
FROM spkr_table
WHERE type = 'MOD' AND active = 'ACT' 
ORDER BY lastname, firstname
</CFQUERY>

<!--- Pull speakers for drop down --->
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="qspeakers">
SELECT lastname, firstname, speaker_id
FROM spkr_table
WHERE type = 'SPKR' AND active = 'ACT' 
ORDER BY lastname, firstname
</CFQUERY>

<!--- Pull recruiters for drop down --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qrecruiter">
SELECT ID, recruiter_name 
FROM recruiter 
ORDER BY recruiter_name
</CFQUERY>

<!--- Pull teleconference companies for drop down --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qteleconference">
SELECT ID, conf_company_name 
FROM conference_company 
ORDER BY conf_company_name
</CFQUERY>

<!--- Pull client codes for drop down --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qclient">
SELECT client_code 
FROM client_code 
ORDER BY client_code
</CFQUERY>				

<SCRIPT>
//create select boxes based on what type of report the user wants
function createSelect() {
data = "";    
inter = "'";

if (document.form_select.query_id.value == 1) {
spaces="    ";
data = data + "Select Criteria:" + spaces
+ "<SELECT name=" + inter
+ "select_criteria" + inter + "'><option value=0>(All Projects)<cfoutput query="qprojects"><option value=#qprojects.client_proj#>#qprojects.client_proj#</cfoutput></select><br>";
}

if (document.form_select.query_id.value == 2) {
spaces="    ";
data = data + "Select Criteria:" + spaces
+ "<SELECT name=" + inter
+ "select_criteria" + inter + "'><option value=0>(All Moderators)<cfoutput query="qmods"><option value=#qmods.speaker_id#>#qmods.lastname#, #qmods.firstname#</cfoutput></select><br>";
}

if (document.form_select.query_id.value == 3) {
spaces="    ";
data = data + "Select Criteria:" + spaces
+ "<SELECT name=" + inter
+ "select_criteria" + inter + "'><option value=0>(All Speakers)<cfoutput query="qspeakers"><option value=#qspeakers.speaker_id#>#qspeakers.lastname#, #qspeakers.firstname#</cfoutput></select><br>";
}

if (document.form_select.query_id.value == 4) {
spaces="    ";
data = data + "Select Criteria:" + spaces
+ "<SELECT name=" + inter
+ "select_criteria" + inter + "'><cfoutput query="qrecruiter"><option value=#qrecruiter.ID#>#qrecruiter.recruiter_name#</cfoutput></select><br>";
}

if (document.form_select.query_id.value == 5) {
spaces="    ";
data = data + "Select Criteria:" + spaces
+ "<SELECT name=" + inter
+ "select_criteria" + inter + "'><cfoutput query="qteleconference"><option value=#qteleconference.ID#>#qteleconference.conf_company_name#</cfoutput></select><br>";
}

if (document.form_select.query_id.value == 6) {
spaces="    ";
data = data + "Select Criteria:" + spaces
+ "<SELECT name=" + inter
+ "select_criteria" + inter + "'><option value=0>(All Clients)<cfoutput query="qclient"><option value=#qclient.client_code#>#qclient.client_code#</cfoutput></select><br>";
}

if (document.layers) {
document.layers.select_item.document.write(data);
document.layers.select_item.document.close();
}
else {
if (document.all) {
select_item.innerHTML = data;
      }
   }
}


function CheckFields(oForm)
{
	if(oForm.query_id.value != 0)
	{
		if(oForm.begin_month.value != 1 && oForm.begin_year.value != 1)
		{
			if(oForm.end_month.value != 1 && oForm.end_year.value != 1)
			{
				if(oForm.display[0].checked || oForm.display[1].checked)
				{
					return true;
				}
				else
				{
					alert("Please select a display type");
					return false;
				}
			}
			else
			{
				alert("Please select an Ending Date");
				return false;
			}
		}
		else
		{
			alert("Please select a Begining Date");
			return false;
		}
	}
	else
	{
		alert("Please select a Query Type");
		return false;
	}
}
				
</SCRIPT>
</HEAD>
		
<BODY>
<CFOUTPUT><FORM NAME="form_select" ACTION="report_production_bridge.cfm" METHOD="post" onsubmit="return CheckFields(this)"></CFOUTPUT>
				
<TABLE BGCOLOR="#000080" ALIGN="Center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="720">
<TR> 
	<TD CLASS="tdheader">Production Schedule</TD>
</TR>
<TR> 
	<TD>	<!--- Table containing input fields --->
		<TABLE ALIGN="Center" BORDER="0" WIDTH="99%" CELLSPACING="1" CELLPADDING="10">
			<TR>
				<TD ALIGN="Center">	
					<B>Query By:</B>&nbsp;&nbsp;&nbsp;&nbsp;
					<SELECT NAME="query_id" onChange="createSelect(form_select.query_id.value);">
						<OPTION value="0">(Select)
						<OPTION VALUE="1">Projects
						<OPTION VALUE="2">Moderators
						<OPTION VALUE="3">Speakers
						<OPTION VALUE="4">Recruiter
						<OPTION VALUE="5">Teleconference Co.
						<OPTION VALUE="6">Client
					</SELECT>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;				
					<span id="select_item" style="position:relative; font-weight: bold;"></span>					
				</TD>
			</TR>
			<TR>
				<TD ALIGN="Center">
				<B>Begin Date:</B>&nbsp;&nbsp;&nbsp;&nbsp;
					<SELECT NAME="begin_month">
						<OPTION SELECTED VALUE=1>Select Month</OPTION> 
						<OPTION>01</OPTION>	
						<OPTION>02</OPTION>
						<OPTION>03</OPTION>	
						<OPTION>04</OPTION>	
						<OPTION>05</OPTION>	
						<OPTION>06</OPTION>	
						<OPTION>07</OPTION>	
						<OPTION>08</OPTION>	
						<OPTION>09</OPTION>	
						<OPTION>10</OPTION>	
						<OPTION>11</OPTION>	
						<OPTION>12</OPTION>										 
					 </SELECT>
					&nbsp;&nbsp;
					<SELECT NAME="begin_year">
						<OPTION SELECTED VALUE=1>Select Year</OPTION> 
						<OPTION>2001</OPTION>	
						<OPTION>2002</OPTION>
						<OPTION>2003</OPTION>	
						<OPTION>2004</OPTION>
						<OPTION>2004</OPTION>
						<OPTION>2005</OPTION>
						<OPTION>2006</OPTION>	
						<OPTION>2007</OPTION>											 
					</SELECT>
				</TD>
			</TR>
			<TR>
				<TD ALIGN="Center">
				<B>End Date:</B>&nbsp;&nbsp;&nbsp;&nbsp;
				<SELECT NAME="end_month">
					<OPTION SELECTED VALUE=1>Select Month</OPTION> 
					<OPTION>01</OPTION>	
					<OPTION>02</OPTION>
					<OPTION>03</OPTION>	
					<OPTION>04</OPTION>	
					<OPTION>05</OPTION>	
					<OPTION>06</OPTION>	
					<OPTION>07</OPTION>	
					<OPTION>08</OPTION>	
					<OPTION>09</OPTION>	
					<OPTION>10</OPTION>	
					<OPTION>11</OPTION>	
					<OPTION>12</OPTION>										 
				  </SELECT>
				&nbsp;&nbsp;	
					<SELECT NAME="end_year">
						<OPTION SELECTED VALUE=1>Select Year</OPTION> 
						<OPTION>2001</OPTION>	
						<OPTION>2002</OPTION>
						<OPTION>2003</OPTION>	
						<OPTION>2004</OPTION>
						<OPTION>2004</OPTION>
						<OPTION>2005</OPTION>
						<OPTION>2006</OPTION>	
						<OPTION>2007</OPTION>											 
					  </SELECT>
				</TD>
			</TR>
			<tr>
				<td align="center"><strong>Display:</strong>&nbsp;&nbsp;
					<input style="border:none; background: #FFFFFF" type="radio" name="display" value="1" checked>Detail&nbsp;&nbsp;
					<input style="border:none; background: #FFFFFF" type="radio" name="display" value="2">Summary Only
				</td>
			</tr>
			<TR>
				<TD ALIGN="center">
					<INPUT TYPE="submit" NAME="submit"  VALUE="  Start Report  ">
				</TD>
			</TR>
		</TABLE>
	</TD>
</TR>	
</TABLE>
</FORM>
<p><center><a href="javascript:OpenWindow('schedule_help.htm#production_select')"><img src="../../images/help.gif" border="0"></a></center></p>			
</BODY>
</HTML>

