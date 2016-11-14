<!--- 
	*****************************************************************************************
	Name:		projects.cfm 11/6/2001
	
	Function:	Allows input of new project code and client project codes

	History:	
	
	*****************************************************************************************
--->

	<CFPARAM NAME="URL.corp" DEFAULT="">
	<CFPARAM NAME="URL.client" DEFAULT="">
	<CFPARAM NAME="URL.product" DEFAULT="">
	<!--- <CFPARAM NAME="URL.ae" DEFAULT="">
	<CFPARAM NAME="URL.as" DEFAULT=""> --->
	<CFPARAM NAME="URL.meeting_type" DEFAULT="">
	<CFPARAM NAME="URL.contact_name" DEFAULT="">
	<CFPARAM NAME="URL.contact_add" DEFAULT="">
	<CFPARAM NAME="URL.contact_add2" DEFAULT="">
	<CFPARAM NAME="URL.contact_city" DEFAULT="">
	<CFPARAM NAME="URL.contact_state" DEFAULT="">
	<CFPARAM NAME="URL.contact_zip" DEFAULT="">
	<CFPARAM NAME="URL.contact_phone" DEFAULT="">
	<CFPARAM NAME="URL.contact_fax" DEFAULT="">
	<CFPARAM NAME="URL.contact_email" DEFAULT="">
	
	<script src="validation.js" language="JavaScript"></script>

<!-- Rules explained in more detail at author's site: -->
<!-- http://www.hagedesign.dk/scripts/js/validation/ -->


<script language="JavaScript">	
function init(){
		//example define('field_1','num','Display','min','max');
		define('corp','string','Selling Corporation');
		define('client','string','Client');
		define('product','string','Product');
		define('contact_add','string','Contact Address');
		define('contact_city','string','Contact City');
		define('contact_state','string','Contact State');
		define('contact_zip','string','Contact Zip Code');
		define('contact_phone','string','Contact Phone');
		//define('ae','string','Account Executive');
		//define('as','string','Account Superviser');
	}
	
function checkCheckBox(f){
	var return_val = false;
	for( x = 0; x < f.meeting_type.length; x++)
		{
		if (f.meeting_type[x].checked == true) return_val = true;
		}
	
	if (return_val == false )
		{
		alert('Please check one or more meeting types for this project');
		}
	return return_val;
}
</script>

		
<!--- Pull selling company names for select box 
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qcorp">
		SELECT corp_id, corp_value, corp_description, corp_abbrev
		FROM corp
		WHERE status = '1' 
		ORDER BY corp_value
</CFQUERY>	--->

<cfset qcorp = Request.Util.getCompany()>
		
<!--- Pull meeting types for check boxes --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qmeeting_types">
		SELECT meeting_type, meeting_type_value, meeting_type_description
		FROM meeting_type
		WHERE status = '1' 
		ORDER BY meeting_type_value
</CFQUERY>	

<!--- Pull clients and their product types for select boxes --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qclientproducts">
		SELECT c.client_abbrev, c.client_name, p.product_description, p.product_code
		FROM clients c, products p
		WHERE c.client_abbrev = p.client_abbrev AND c.status = '1' AND p.status = '1'
		ORDER BY c.client_name, p.product_description 
</CFQUERY>	
		
<!--- Pull states for select boxes 
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qstates">
		SELECT state, state_description
		FROM states
		ORDER By state_description
</CFQUERY>	--->
<cfset qstates = Request.Util.getStates()>

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Project Initiation Form - Create Project Code">
<br>
<TABLE ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" width="100%">
<tr>
	<td>Please complete the fields below and check the meeting types that apply to this project.<br>&nbsp;Required items are labeled in <font Style="color:#CC0000;">red</font>.
		<br><br>
	</td>
</tr>
</table>
	<!--- Table containing input fields --->
	<FORM ACTION="PIWprojectsdetail.cfm" METHOD="post" onSubmit="return checkCheckBox(this);" name="projman">
		    <TABLE width=width="100%" ALIGN="center" BORDER=0 CELLPADDING="1" CELLSPACING="5">						
				<TR ALIGN="left">
					<td><span Style="color:#CC0000;"><B>Select A Selling Company:</B></td></span>
					<td>
						<select name="corp">
						<option value="">(Select)
						<cfoutput query="qcorp">
						<option value="#qcorp.corp_abbrev#"<cfif #trim(qcorp.corp_abbrev)# is #trim(url.corp)#> Selected </cfif>>#qcorp.corp_value#
						</cfoutput>
						</select>
					</TD>
					<td colspan=3>&nbsp;</td>
				</TR>
				<tr align="left">
					<td width=150 align=right><SPAN Style="color:#CC0000;"><b>Select A Client:</b></SPAN></td>
					<td width=150>
						<!--- create dynamically populated select boxes with this custom tag --->
						<cfoutput>
						<CF_TwoSelectsRelated1
							QUERY="qclientproducts"
							NAME1="client"
							NAME2="product"
							CLIENT="#url.client#"
							DISPLAY1="client_name"
							DISPLAY2="product_description"
							VALUE1="client_abbrev"
							VALUE2="product_code"
							SIZE1="1"
							SIZE2="1"
							HTMLBETWEEN="</td><td align=right><SPAN Style='color:##CC0000;'><b>Select A Product:</b></SPAN></td><td>"
							AUTOSELECTFIRST="Yes"
							EMPTYTEXT1="(Select)"
							EMPTYTEXT2="(Select)"></cfoutput>
						</td>
						<td>&nbsp;</td>
					</tr>
					<cfoutput>
					<tr>
						<td width=150 align="right"><SPAN Style="color:##CC0000;"><b>Contact Name:</b></SPAN></td>
						<td width=150><input type="Text" name="contact_name" value="#url.contact_name#" size=20></td>
						<td width=280 colspan=3>&nbsp;</td>
					</tr>
					<tr>
						<td width=150 align="right"><SPAN Style="color:##CC0000;"><b>Address Line 1:</b></SPAN></td>
						<td width=150><input type="Text" name="contact_add" value="#url.contact_add#" size=20></td>
						<td width=280 colspan=3>&nbsp;</td>			
					</tr>
					<tr>
						<td width=150 align="right"><b>Address Line 2:</b></td>
						<td width=150><input type="Text" name="contact_add2" value="#url.contact_add2#" size=20></td>
						<td width=280 colspan=3>&nbsp;</td>						
					</tr>
					<tr>
						<td width=150 align="right"><SPAN Style="color:##CC0000;"><b>City:</b></SPAN></td>
						<td><input type="Text" name="contact_city" value="#url.contact_city#" size=20></td>
					
						<td align=right><SPAN Style="color:##CC0000;"><b>State:</b></SPAN></td>
						<td><select name="contact_state">
								<option value="">(Select)
								<cfloop query="qstates">
									<OPTION value="#qstates.StateAbbr#"<cfif trim(qstates.StateAbbr) is trim(url.contact_state)> Selected</cfif>>#qstates.StateDesc#</option>
								</cfloop>
							</SELECT>
						</td>
						
						<td align=right><SPAN Style="color:##CC0000;"><b>Zip:</b></SPAN></td>
						<td><input type="Text" name="contact_zip" value="#url.contact_zip#" size=5></td>
					</tr>
					<tr>
						<td align="right"><SPAN Style="color:##CC0000;"><b>Phone:</b></span></td>
						<td><input type="Text" name="contact_phone" value="#url.contact_phone#" size=20 onKeypress="if ((event.keyCode < 48 || event.keyCode > 57) && (event.keyCode!=46)) event.returnValue = false;"></td>
						<td align="right"><b>Fax:</b></td>
						<td><input type="Text" name="contact_fax" value="#url.contact_fax#" size=20 onKeypress="if ((event.keyCode < 48 || event.keyCode > 57) && (event.keyCode!=46)) event.returnValue = false;"></td>
						<td align="right"><b>E-mail:</b></td>
						<td><input type="Text" name="contact_email" value="#url.contact_email#" size=20 maxlength="80"></td>
					</tr>
		        </cfoutput>
		<tr><td colspan=6>&nbsp;</td></tr>
		<tr align="left" bgcolor="#eeeeee">
			<td colspan=6 align="left"><SPAN Style="color:#CC0000;"><b>Check All Meeting Types that might apply to this project:</b></SPAN></td>
		</tr>
		<tr>
		  <td colspan="6">
				<table width="99%" border="0">
					<tr>
					<td>&nbsp;</td>
					<!--- create check boxes by the meeting types queried --->
					<cfloop query="qmeeting_types">
					  <td>
						  <cfoutput>
							<table border=0>
							  <tr>
								<td><b>#qmeeting_types.meeting_type_value#</b>
								<input type="checkbox" name="meeting_type" value="#trim(qmeeting_types.meeting_type_value)#" <cfloop from="1" to="#ListLen(url.meeting_type)#" index="i"><cfif #ListGetAt(url.meeting_type,i)# is #trim(qmeeting_types.meeting_type_value)#> checked</cfif></cfloop>>
							  </tr>
							  <tr>
								<td>#qmeeting_types.meeting_type_description#</td>
							  </tr>
							</table>
							<cfif qmeeting_types.CurrentRow MOD 6 IS 0>
								</tr>
								<tr>
								  <td>&nbsp;</td>
							</cfif>
					      </cfoutput>
				     </cfloop>
					</td>
				  </tr>
				  <tr><td>&nbsp;</td></tr>
				  <tr>
				    <td colspan="7" align="center">
					  <table border="0" cellpadding="0" cellspacing="4">
					   <tr>
					       <td colspan="2" align="center">
							<INPUT TYPE="submit" NAME="submit" VALUE="Continue >>" onclick="validate(); return returnVal;">
						   </td>
						   <td>&nbsp;</td>
						   <td colspan="2" align="center">
							  <INPUT TYPE="button" NAME="submit" VALUE="Cancel" onlick="this.href('../index.cfm');">
						   </td>
					      </tr>
					   </table>           
					</td>
				  </tr>
				</TABLE>
					</td>
				  </tr>
				</TABLE>
			  </FORM>	        
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">	