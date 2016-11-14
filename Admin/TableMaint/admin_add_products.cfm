<!--- 
	*****************************************************************************************
	Name:		piw_admin_add_meeting_type.cfm
	
	Function:	
	History:	11/16/01 TJS Developed This Page
	
	*****************************************************************************************
--->
<!--- <CFSET session.project_status=""> --->
<cfparam name="URL.Action" default="">
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Add Product Codes" showCalendar="0">

<!--- <CFSET session.project_admin=0> --->
<CFSWITCH EXPRESSION="#URL.action#">

<!--- Case to perform edit action that was selected --->
<CFCASE VALUE="add">
	<!--- look for existing product/client pair --->	
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="checkprod">
		select product_code, product_description, client_abbrev 
		FROM products WHERE product_code = '#trim(Left(form.new_product_code, 2))#' AND client_abbrev = '#trim(Left(form.client_abbrev, 2))#'
	</CFQUERY>
	<cfif checkprod.recordcount GT 0>
		<FORM ACTION="admin_add_products.cfm" METHOD="post">

				<!--- Table containing input fields --->
				<TABLE ALIGN="center" BORDER="0" CELLPADDING="0" CELLSPACING="15" WIDTH="85%">
				<TR>
					<TD colspan=2 ALIGN="center" VALIGN="middle">
					<cfoutput>
					<TABLE>
					<TR><TD colspan=2><b style="color:##CC0000;">This Product Code/Client Code combination (#form.new_product_code# - #form.new_product_description#) already exists as <strong>#trim(checkprod.product_description)#</strong>!!</b></td></TR>
					<TR><TD colspan=2>Click the <b><i>Try Again</i></b> button to try a new code or click the <b><i>Exit</i></b> button to exit.</td></TR>
					</TABLE>
					</cfoutput>
					</TD>
		    		<TD ALIGN="left"><br></TD>
				</TR>
				<TR>
					<TD ALIGN="Center">
						<INPUT TYPE="submit" NAME="tryagain" VALUE=" Try Again ">
					</TD>
						</form>
						<FORM ACTION="index.cfm" METHOD="post">
					<TD ALIGN="Center">
						<INPUT TYPE="submit" NAME="exit" VALUE=" Exit ">
					</td>
				</TR>
				</TABLE>
	<cfelse>
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="INSERTRECORD">
		INSERT products(product_code, product_description, client_abbrev , status) 
		VALUES ('#trim(Left(form.new_product_code, 2))#','#trim(Left(form.new_product_description, 50))#', '#trim(Left(form.client_abbrev, 2))#' ,'1')
		</CFQUERY>
		<FORM ACTION="admin_add_products.cfm" METHOD="post">
		<TABLE ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="60%">
		<TR>
			<TD>
				<!--- Table containing input fields --->
				<TABLE ALIGN="center" BORDER="0" CELLPADDING="0" CELLSPACING="15" WIDTH="85%">
				<TR>
					<TD colspan=2 ALIGN="center" VALIGN="middle">
					<cfoutput>
					<TABLE>
					<TR><TD colspan=2>The new Product Code <b>#form.new_product_code# - #form.new_product_description#</b> was added successfully.</td></TR>
					<TR><TD colspan=2>Click the <b><i>Add Another</i></b> button to add another product or click the <b><i>Finished</i></b> button to exit.</td></TR>
					</TABLE>
					</cfoutput>
					</TD>
		    		<TD ALIGN="left"><br></TD>
				</TR>
				<TR>
					<TD ALIGN="Center">
						<INPUT TYPE="submit" NAME="submit" VALUE=" Add Another ">
					</TD>
						</form>
						<FORM ACTION="index.cfm" METHOD="post">
					<TD ALIGN="Center">
						<INPUT TYPE="submit" NAME="submit" VALUE=" Finished ">
					</td>
				</TR>
				</TABLE>
				</TD>
			</TR>
			</TABLE>
	</cfif>
</CFCASE>

<!--- Default case to present edit selection form to user --->	
<CFDEFAULTCASE>
	<!--- Query to all Meeting Type and Populate a list for the User's reference --->
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="info">
			SELECT client_abbrev, client_name FROM clients	ORDER BY client_name
		</CFQUERY>
		<FORM ACTION="admin_add_products.cfm?action=add" METHOD="post">
						<TABLE cellpadding="4" cellspacing="0" border="0" align="center">
							<TR>
								<TD><strong>New Product Code:</strong></td>
								<td><INPUT TYPE="text" name="new_product_code" CLASS="text" size=2 MAXLENGTH="2"></SPAN></TD>
							</TR>
							<TR>
								<TD><strong>New Product Description:</strong></td>
								<td><INPUT TYPE="text" name="new_product_description" CLASS="text" size="50" MAXLENGTH="50"></SPAN></TD>
							</TR>
							<TR>
								<td><strong>Client Abbreviation:</strong></td>
								<td><select name="client_abbrev">
										<option value="">(Select)
											<CFOUTPUT query="info">
												<OPTION value="#info.client_abbrev#">#info.client_abbrev# - #info.client_name#
											</cfoutput>
										</SELECT>
								</td>
							</TR>
							<TR>
								<TD ALIGN="Center" COLSPAN="2"><INPUT TYPE="submit" NAME="submit" VALUE="  Submit  ">
								</TD>
							</TR>
						</TABLE>
				
	
			</FORM>
</CFDEFAULTCASE>
</CFSWITCH>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

