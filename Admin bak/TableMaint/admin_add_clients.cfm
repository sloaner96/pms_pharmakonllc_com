<!--- 
	*****************************************************************************************
	Name:		piw_admin_add_clients.cfm
	
	Function:	
	History:	11/16/01 TJS Developed This Page
	
	*****************************************************************************************
--->
<cfparam name="URL.Action" default="">
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Add New Clients" showCalendar="0">

<!--- <CFSET session.project_admin=0> --->
<CFSWITCH EXPRESSION="#URL.action#">

<!--- Case to perform edit action that was selected --->
	<CFCASE VALUE="add">
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="INSERTRECORD">
			INSERT clients(client_abbrev , client_name, status) 
			VALUES ('#Left(form.new_client_abbrev, 2)#','#Left(form.new_client_name, 50)#','1')
		</CFQUERY>
		<cflocation URL="admin_add_clients.cfm" addtoken="NO">
	</CFCASE>

<!--- Default case to present edit selection form to user --->	
	<CFDEFAULTCASE>
		<!--- Query to all Meeting Type and Populate a list for the User's reference --->
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="info">
			SELECT client_abbrev, client_name FROM clients ORDER BY client_abbrev
		</CFQUERY>
		<FORM ACTION="admin_add_clients.cfm?action=add" METHOD="post">
		<TABLE ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="60%">
		<TR>
			<TD>
				<!--- Table containing input fields --->
				<TABLE ALIGN="center" BORDER="0" CELLPADDING="0" CELLSPACING="15" WIDTH="85%">
				<TR>
					<TD ALIGN="center" VALIGN="middle">
						<TABLE>
						<TR>
							<TD align=right><SPAN CLASS="required">New Client Abbreviation:</td>
							<td><INPUT TYPE="text" name="new_client_abbrev" CLASS="text" size=2 maxlength=2></SPAN></TD>
						</TR>
						<TR>
							<TD align=right><SPAN CLASS="required">New Client Name:</td>
							<td><INPUT TYPE="text" name="new_client_name" CLASS="text" size=30 maxlength=50></SPAN></TD>
						</TR>
						</TABLE>
					</TD>
	    			<TD ALIGN="left">
						<TABLE STYLE="border: 1px solid black" CELLPADDING="2" CELLSPACING="2">
						<TR><TD COLSPAN="4"><U>Existing Client Names</U></TD></TR>
							<CFOUTPUT QUERY="info"><TR><TD STYLE="border: 1px solid black">#Trim(client_abbrev)# - #trim(client_name)#</TD></TR></CFOUTPUT>
						</TABLE>
						<br>
					</TD>
				</TR>
				<TR>
					<TD ALIGN="Center"><INPUT TYPE="submit" NAME="submit" VALUE="  Submit  "></td>
						</form>
						<FORM ACTION="index.cfm" METHOD="post">
					<TD ALIGN="Center">
						<INPUT TYPE="submit" NAME="submit" VALUE="  Exit  ">
					</TD>
				</TR>
				</TABLE>
			</TD>
		</TR>
		</TABLE>
	</FORM>
	</CFDEFAULTCASE>
</CFSWITCH>

<cfmodule template="#Application.tagpath#/ctags/footer.cfm">


