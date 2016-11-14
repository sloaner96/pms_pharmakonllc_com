<!--- 
	*****************************************************************************************
	Name:		rpt_ShowProducts.cfm
	
	Function:	Displays current products and status by client

	History:	bj012302 - Initial code
	
	*****************************************************************************************
--->
<HTML>
<HEAD>
<TITLE>Show All Products</TITLE>
<LINK REL="stylesheet" HREF="piw1style.css" TYPE="text/css">
</HEAD>
<BODY  MARGINWIDTH="0" MARGINHEIGHT="0" STYLE="MARGIN: 0" BGCOLOR="WHITE">
<!--- fetch all client codes --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qprods">
	SELECT p.product_code, p.product_description, p.client_abbrev, p.status, c.client_name, s.status_description 
	FROM products p, clients c, project_status s 
	where p.client_abbrev = c.client_abbrev
	AND p.status = s.status_code
	order by p.client_abbrev, p.product_code
</CFQUERY>	
<!--- build an array of product and client info. --->
<cfset c_array = ArrayNew(2)>
<cfloop query="qprods" startrow="1" endrow="#qprods.recordcount#">
	<cfset c_array[currentrow][1] = #trim(qprods.client_abbrev)#> 
	<cfset c_array[currentrow][2] = #trim(qprods.client_name)#>
	<cfset c_array[currentrow][3] = #trim(qprods.product_code)#>
	<cfset c_array[currentrow][4] = #trim(qprods.product_description)#>
	<cfset c_array[currentrow][5] = #trim(qprods.status_description)#>
</cfloop>
<TABLE BGCOLOR="##000080" ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="500">
<TR><TD CLASS="tdheader">Current Products</TD></TR>
<TR>
	<td>
	<!--- Table containing input fields --->
	<TABLE width=450 ALIGN="center" BORDER=0 CELLPADDING="0" CELLSPACING="5">	
	<tr height=20><td colspan=4>&nbsp;</td></tr>
	<cfset thiscode = "">					
	<cfloop index="x" from="1" to="#arrayLen(c_array)#">
		<cfoutput>
		<!--- if new code --->
		<cfif thiscode NEQ #c_array[x][1]#>
			<TR ALIGN="left">
				<td width=10>&nbsp;</td>
				<td width=200 class=highlight>#c_array[x][1]# - #c_array[x][2]#</a></td>
				<td colspan = 2 class=highlight>&nbsp;</td>
			</TR>
			<cfset thiscode = #c_array[x][1]#>
		</cfif>
			<TR ALIGN="left">
				<td width=10>&nbsp;</td>
				<td width=200>&nbsp;</td>
				<td colspan=2>
					#c_array[x][3]# - #c_array[x][4]# - 
					<cfif c_array[x][5] EQ "Pending">
						<font color=orange>#c_array[x][5]#</font>
					<cfelse>
						<font color=green>#c_array[x][5]#</font>
					</cfif>
				</td>
			</TR>
		</cfoutput>	
	</cfloop>
	<tr height=20><td colspan=4>&nbsp;</td></tr>
	<TR>
		<td colspan=2 align=center><b><SCRIPT LANGUAGE="JavaScript">
		  <!-- Begin print button
		  if (window.print) {
		  document.write('<form>'
		  + '<input type=button  name=print value="  Print  " '
		  + 'onClick="javascript:window.print()"></form>');
		  }
		  // End print button-->
		  </script></b>
  		</td>
			<FORM ACTION="index.cfm" METHOD="post">
		<TD colspan=2 ALIGN="Center">
			<INPUT  TYPE="submit" NAME="submit" VALUE=" Finished ">
		</td>
	</TR>
	<tr height=20><td colspan=4>&nbsp;</td></tr>
	</TABLE>
	</TD>
</TR>
</TABLE>
</BODY>
</HTML>
