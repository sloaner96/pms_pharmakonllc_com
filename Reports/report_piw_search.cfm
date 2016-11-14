<CFPARAM NAME="URL.client" DEFAULT="">
<HTML>
<HEAD>
<TITLE>Project Management System || PIW Report</TITLE>
<LINK REL=stylesheet HREF="piw1style.css" TYPE="text/css">		
<SCRIPT SRC="confirm.js"></SCRIPT> 
</HEAD>
<BODY MARGINWIDTH="0" MARGINHEIGHT="0" STYLE="MARGIN: 0" BGCOLOR="WHITE">
<!--- Query to grab all Pending Project Codes and Populate a dropdown for the User --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="get_projectcode">
	SELECT project_code	FROM piw ORDER BY project_code
</CFQUERY>
	
<FORM ACTION="report_piw.cfm?report='1'" METHOD="post">
<!--- Table containing input fields --->
<TABLE BGCOLOR="##000080" ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="600">
<TR><TD CLASS="tdheader">PIW Report</TD></TR>
<TR>
	<TD>
	<!--- Table containing input fields --->
	<TABLE ALIGN="center" BORDER="0" CELLPADDING="0" CELLSPACING="5" WIDTH="500">								
	<TR><TD>&nbsp;</TD></TR>
	<tr>
		<td align=right><SPAN CLASS="required"><b>Select A Client:</b></SPAN></td>
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="qprojects">
				SELECT client_proj, description, client_code 
				FROM client_proj ORDER BY client_code
			</CFQUERY>	
			<td width=225>
				<!--- create dynamically populated select boxes with this custom tag --->
			<cfoutput>
			<CF_TwoSelectsRelated1
				QUERY="qprojects"
				NAME1="select_client"
				NAME2="select_project"
				CLIENT="#url.client#"
				DISPLAY1="client_code"
				DISPLAY2="client_proj"
				VALUE1="client_code"
				VALUE2="client_proj"
				SIZE1="1"
				SIZE2="1"
				HTMLBETWEEN="</td></tr><tr><td align=right><SPAN CLASS=required><b>Select A Project Code:</b></SPAN></td><td>"
				AUTOSELECTFIRST="Yes"
				EMPTYTEXT1="(Select)"
				EMPTYTEXT2="(Select)">
			</cfoutput>
		</tr>
		<TR><TD COLSPAN="2" ALIGN="center">&nbsp;</td></tr>
		<TR>
			<TD ALIGN=right>
				<INPUT TYPE="Submit"  VALUE=" Submit ">
			</td>
			<td align=center>
				<INPUT TYPE="Button"  VALUE=" Cancel " onClick="document.location.href='index.cfm'">
			</TD>
		</TR>
		</TABLE>
	</TD>
</TR>
</TABLE>
</FORM>
</BODY>
</HTML>
