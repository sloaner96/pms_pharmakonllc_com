<CFIF IsDefined("form.submit")>
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qspec_req">
	UPDATE special_request 
	SET client = '#trim(left(form.select_client, 30))#',
	project_code = '#trim(left(form.select_project, 15))#'
	WHERE job_number= '#url.job_number#'
</cfquery>
<script language="JavaScript" type="text/javascript">opener.location.reload(true);self.close();</script>
<cfelse>
<HTML>
	<HEAD>
		<TITLE>IT Special Request</TITLE>
		<LINK REL="stylesheet" HREF="piw1style.css" TYPE="text/css">
		<style>
		td{vertical-align:middle;}
		</style>
	</HEAD>

	<BODY MARGINWIDTH="0" MARGINHEIGHT="0" STYLE="MARGIN: 0" BGCOLOR="WHITE">
		<br>
		
		<TABLE BGCOLOR="#000080" ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="400">
		<TR>
			<TD CLASS="tdheader">IT Special Request Administrator</TD>
		</TR>		
		<TR>
			<TD>
				<!--- Table containing input fields --->
				<TABLE ALIGN="left" BORDER="0" CELLPADDING="0" CELLSPACING="5" WIDTH="400" >
				<tr><td >
				<cfoutput>You were planning on editing: <br>Client Code: #url.Client# & Project Code: #Url.project_code#</cfoutput>
				</td></tr>
				<tr><td >
				<br>
				</td></tr>						
				<TR>
					<cfoutput><td style="text-indent:2cm">
					
					<CFQUERY DATASOURCE="#application.projdsn#" NAME="qspec_req">
						SELECT client, project_code
						FROM special_request 
						where job_number= '#url.job_number#'
					</cfquery>

					</cfoutput>
					
					
						<CFQUERY DATASOURCE="#application.projdsn#" NAME="qprojects">
							SELECT client_proj, description, client_code 
							FROM client_proj ORDER BY client_code
						</CFQUERY>
					
					<cfoutput><form action="IT_SpecialRequestAdminEditCC.cfm?no_menu=1&job_number=#url.job_number#" method="post"></cfoutput>
					<cfoutput><b>Client Name:</b>&nbsp;&nbsp;
						<CF_TwoSelectsRelated1
							QUERY="qprojects"
							NAME1="select_client"
							NAME2="select_project"
							DISPLAY1="client_code"
							DISPLAY2="client_proj"
							VALUE1="client_code"
							VALUE2="client_proj"
							SIZE1="1"
							SIZE2="1"
							HTMLBETWEEN="</td></tr><tr><td style=text-indent:2cm><b>Project Code:&nbsp;</b>"
							AUTOSELECTFIRST="Yes"
							EMPTYTEXT1="(Select)"
							EMPTYTEXT2="(Select)">
						</cfoutput>
						
				</TR>
				<tr>
				<td>
					<br>
				</td>
				</tr>
				<tr>
				<td align="center">
					<input type="button" name="close" value=" Cancel " onClick="javascript:window.close()" style="vertical-align:text-middle;">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="submit" name="Submit" value=" Submit " style="vertical-align:text-middle;">
				</form>
				</td>
				</tr>
				<tr>
				<td >	
				<hr noshade>Note: This window will close right after you press select, 
				and a dialog box might pop up and ask if you wish to REFRESH the content. <br><b>SELECT RETRY!</b> 
				</td></tr>
				
			</table>
		</td></tr></table></body></html>
</cfif>