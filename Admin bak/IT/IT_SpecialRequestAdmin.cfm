<!--- 
	*****************************************************************************************
	Name:		
	Function:	
	History:	
	
	*****************************************************************************************
--->

<CFPARAM NAME="URL.client" DEFAULT="">

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
		
		<TABLE BGCOLOR="#000080" ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="600">
		<TR>
			<TD CLASS="tdheader">IT Special Request Administrator</TD>
		</TR>		
		<TR>
			<TD>
				<!--- Table containing input fields --->
				<TABLE ALIGN="left" BORDER=0 CELLPADDING="0" CELLSPACING="5" WIDTH="600" >						
				<TR>
					<td width=150></td>
				</TR>
				<TR>
					<td align="center">
					<FORM action="IT_SpecialRequestAdminViewAll.cfm" method="post">
					<input type="submit" name="button" value=" View All Requests ">
					</form>
					</td>
					
				</tr>
				<TR>
					<td align="center">or Enter a Job Number to EDIT
					</td>
					
				</tr>
				<tr>
					<td  align="center">
					<FORM action="IT_SpecialRequestAdminEdit.cfm" method="post">
					<input type="text" CLASS="text" name="job_number" onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
					<INPUT TYPE="submit" NAME="submit" VALUE=" Submit ">
					</form>
					</td>
					
				</tr>
				</TABLE>
			</TD>
		</TR>
	
	</TABLE>
	</FORM>
	</BODY>
</HTML>