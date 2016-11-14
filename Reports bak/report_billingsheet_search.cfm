<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">


	<html>
<head>
	<title>Select Billing Sheet Report</title>
	
	<script src="validation.js" language="JavaScript"></script>

<!-- Rules explained in more detail at author's site: -->
<!-- http://www.hagedesign.dk/scripts/js/validation/ -->


<script language="JavaScript">	
function init(){
		//example define('field_1','num','Display','min','max');
		define('project_code','string','Project Code');
	}
	
	
	</script>
	
</head>

<LINK REL=stylesheet HREF="piw1style.css" TYPE="text/css">

<CFSET session.project_status="">

<!--- pull project codes --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qproject">
SELECT	project_code
FROM	piw
ORDER BY project_code
</cfquery>

<BODY OnLoad="init()" MARGINWIDTH="0" MARGINHEIGHT="0" STYLE="MARGIN: 0" BGCOLOR="WHITE">
			
<FORM ACTION="report_billingsheet.cfm?report='1'" METHOD="post" onSubmit="validate();return returnVal;">
	<TABLE BGCOLOR="##000080" ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="90%">
		<TR>
			<TD CLASS="tdheader">Billing Sheet Report Select </TD>
		</TR>
		<TR>
			<TD>
		<!--- Table containing input fields --->
	<TABLE ALIGN="center" BORDER="0" CELLPADDING="0" CELLSPACING="15" WIDTH="85%">
		<TR>
			<TD ALIGN="center">Select a project code:&nbsp;&nbsp;&nbsp;
				<SELECT NAME="project_code">
				<OPTION value="">(Select)
				<CFOUTPUT QUERY="qproject">
				<OPTION value="#project_code#">#trim(Project_code)#
				</CFOUTPUT>
				</SELECT>
			</TD>
		</TR>
		
</TABLE>
			</TD>
		</TR>
		<TR>
			<TD ALIGN="Center"><INPUT  TYPE="submit" NAME="submit" VALUE="  Submit  ">									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<INPUT  TYPE="submit" NAME="submit" VALUE="  Cancel  ">
			</TD>
		</TR>
</TABLE>
			</TD>
		</TR>
</TABLE>
</FORM>
</BODY>
</html>
	