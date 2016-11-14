<!--- 
	*****************************************************************************************
	Name:		PIWadd2.cfm 12/12/2001
	
	Function:	Allows input of new project codes

	History:	bj12/12/01 - initial code
	
	*****************************************************************************************
--->
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Add New Project Code - Select Meeting Types" showCalendar="0">

	<CFPARAM NAME="URL.corp" DEFAULT="">
	<CFPARAM NAME="URL.client" DEFAULT="">
	<CFPARAM NAME="URL.product" DEFAULT="">
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
	
<!--- <script src="validation.js" language="JavaScript"></script> --->
<!-- Rules explained in more detail at author's site: -->
<!-- http://www.hagedesign.dk/scripts/js/validation/ -->
<script language="JavaScript">	
function checkCheckBox(f)
{
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

<!--- get select client info --->
<cfif isdefined("form.select_client")>
	<!--- valiable 'cc' is used by some of the following included queries --->
	<cfset cc = #form.select_client#>
	<!--- get the selected client code information --->
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="qcc_one">
	  EXEC GET_ONE_CLIENT_CODE '#cc#'
    </CFQUERY>
	
	<!--- Pull projects for the selected client code --->
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="qcp">
		EXEC GET_CLIENT_PROJECTS '#cc#'
	</CFQUERY>	
	
	<!--- Pull meeting types for check boxes --->
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="qmeeting_types">
		SELECT meeting_type, meeting_type_value, meeting_type_description
		FROM meeting_type
		WHERE status = '1' 
		ORDER BY meeting_type_value
	</CFQUERY>	

<TABLE ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="100%">
<tr>
	<td>The following project codes currently exist for this client.<br>Please select the additional meeting types you wish to add.
		<br><br>
	</td>
</tr>
<TR>
	<TD>
	<!--- Table containing input fields --->
	<FORM ACTION="PIWadd3.cfm" METHOD="post" onSubmit="return checkCheckBox(this);">
	<TABLE width=755 ALIGN="center" BORDER="0" CELLPADDING="4" CELLSPACING="5">						
	<tr><td colspan=6>Contact information for this client code is:</td></tr>
	<tr align="left">
		<cfoutput>
		<td width=150 align=right><b>Client:</b></td>
		<td colspan=5>#cc# - #qcc_one.client_code_description#</td>
		<!--- parse the client code, used in PIWprojectsdetail.cfm --->
		<input type=hidden name=corp value="#left(cc, 1)#">
		<input type=hidden name=client value="#mid(cc, 2, 2)#">
		<input type=hidden name=product value="#mid(cc, 4, 2)#">
	</tr>
	<tr>
		<td width=150 align="right"><b>Contact Name:</b></td>
		<td width=150>#qcc_one.product_manager#<input type=hidden name=contact_name value="#qcc_one.product_manager#">&nbsp;</td>
		<td width=280 colspan=4>&nbsp;</td>
		</tr>
		<tr>
			<td width=150 align="right"><b>Address Line 1:</b></td>
			<td width=150>#qcc_one.address1#<input type=hidden name=contact_add value="#qcc_one.address1#">&nbsp;</td>
			<td width=280 colspan=4>&nbsp;</td>			
		</tr>
		<tr>
			<td width=150 align="right"><b>Address Line 2:</b></td>
			<td width=150>#qcc_one.address2#<input type=hidden name=contact_add2 value="#qcc_one.address2#">&nbsp;</td>
			<td width=280 colspan=4>&nbsp;</td>						
		</tr>
		<tr>
			<td width=150 align="right"><b>City/State/Zip Code:</b></td>
			<td colspan=5>#qcc_one.city#,&nbsp;&nbsp;#qcc_one.state#&nbsp;&nbsp;#qcc_one.zipcode#
				<input type=hidden name=contact_city value="#qcc_one.city#">
				<input type=hidden name=contact_state value="#qcc_one.state#">
				<input type=hidden name=contact_zip value="#qcc_one.zipcode#">
			</td>
		</tr>
		<tr>
			<td width=150 align="right"><b>Phone:</b></td>
			<input type=hidden name=contact_phone value="#qcc_one.phone#">
				<input type=hidden name=contact_fax value="#qcc_one.fax#">
				<input type=hidden name=contact_email value="#qcc_one.email#">
				<input type=hidden name=caller value="PIWadd.cfm">
			<td colspan=5>
			<cfif  Len(Trim(qcc_one.phone)) EQ 10>
							(#Left(qcc_one.phone, 3)#) #Mid(qcc_one.phone, 4, 3)# - #Mid(qcc_one.phone, 6,4)# 
							<CFELSE>
							#trim(qcc_one.phone)#
							</cfif>
			&nbsp;&nbsp;<b>Fax:</b>&nbsp;
			<cfif  Len(Trim(qcc_one.fax)) EQ 10>
							(#Left(qcc_one.fax, 3)#) #Mid(qcc_one.fax, 4, 3)# - #Mid(qcc_one.fax, 6,4)# 
							<CFELSE>
							#trim(qcc_one.fax)#
							</cfif>
			&nbsp;&nbsp;<b>E-mail:</b>&nbsp;#qcc_one.email#
				&nbsp;
			</td>
		</tr>
		</cfoutput>
		<tr><td colspan=6><hr></td></tr>
		<cfif qcp.recordcount GT 0>
			<tr>
			  <td colspan="6">To Copy the contents of one project to another, select a project below.</td>
			</tr>
		</cfif>
			<tr><td colspan=6 class=highlight><strong>The current projects assigned to this client are:</strong></td></tr>
			<!--- list the current projects for this client code --->
			<cfoutput query="qcp">
				<TR ALIGN="left">
				    <td><input type="radio" name="CloneProject" value="#qcp.rowid#"> <strong style="color:##993300; font-weight:normal;">Clone this Project</strong></td>
					<td width=150>#qcp.client_proj# - <font color=green>#qcp.status_description#</font></td>
					<td colspan=5>#qcp.description#</td>
				</TR>
			</cfoutput>
			
		<tr>
		  <td colspan="6">
		    <cfinvoke component="pms.com.projects" method="getClientSeries" returnvariable="getSeries">
		        <cfinvokeargument name="SellingCompany" value="#Left(trim(cc), 1)#">
		        <cfinvokeargument name="ClientCode" value="#Mid(trim(cc), 2, 2)#">
				<cfinvokeargument name="ProductCode" value="#RIGHT(trim(cc),2)#">
	        </cfinvoke> 
		    <table border="0" cellpadding="3" cellspacing="0" width="100%">
               <tr>
			     <td colspan="2" class="highlight"><strong>PROGRAM SERIES</strong></td>
			   </tr>
			   <cfif getSeries.recordcount GT 0>
			   <tr>
                  <td>Add Program to a Series:</td>
				  <td width="75%"><select name="Series">
				        <cfoutput query="getSeries">
				         <option value="#Trim(getSeries.SeriesID)#">#GetSeries.SellingCompany##GetSeries.ClientCode##GetSeries.ProductCode##GetSeries.SeriesCode#-#Trim(getSeries.SeriesLabel)#</option>
					    </cfoutput>
					  </select>
				  </td>
               </tr>
			   <cfelse>
			     <input type="hidden" name="Series" value="0">
			     <tr>
				    <td colspan="2">THERE ARE NO SERIES CODES AVAILABLE FOR THIS PROJECT. <a href="mailto:rsloan@pharmakonllc.com?subject=Request for new Series">CONTACT IT</a> TO ADD A NEW PROJECT SERIES.</td>
				 </tr>
			   </cfif>
            </table>           
		  </td>
		</tr>	
		<tr><td colspan=6><hr></td></tr>
		<tr align="left"><td colspan=5 align="left"><SPAN CLASS="required"><b>Check All Meeting Types you would like to add to this project:</b></SPAN></td></tr>
		<table width="94%" border="0">
			<tr>
			<td>&nbsp;</td>
			<!--- create check boxes by the meeting types queried --->
			<cfloop query="qmeeting_types">
			<td>
			<cfoutput>
		<table border=0>
		<tr>
			<td><b>#qmeeting_types.meeting_type_value#</b>
			<input type="checkbox" name="meeting_type" value="#trim(qmeeting_types.meeting_type_value)#" 
			<cfloop from="1" to="#ListLen(url.meeting_type)#" index="i"><cfif #ListGetAt(url.meeting_type,i)# is #trim(qmeeting_types.meeting_type_value)#> checked</cfif></cfloop>>
				</tr>
				<tr>
					<td>#qmeeting_types.meeting_type_description#</td>
				</tr>
				</table>
				<cfif qmeeting_types.CurrentRow MOD 6 IS 0>
					</tr>
					<tr><td>&nbsp;</td>
				</cfif>
				</cfoutput>
			</cfloop>
			</td>
		</tr>
		<tr><td>&nbsp;</td></tr>
		<TR>
			<td colspan="2" align="center"><INPUT TYPE="submit" NAME="submit" VALUE="Continue"></td>
			</FORM>
			<FORM ACTION="index.cfm" METHOD="post">
			<td colspan="2" align="center"><INPUT TYPE="submit" NAME="submit" VALUE="Cancel"></td>
			</form>
			<td colspan=6>&nbsp;</td>
		</TR>
		<tr height=20><td>&nbsp;</td></tr>			
	</TABLE>
	</TD>
	</TR>
	</TABLE>
<cfelse>
	<TABLE ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="500">
	<tr><td>An error occured while attempting to process your request.  Please click the CONTINUE button to try again.</td></tr>	
	<tr>
		<cfoutput>
		<td>
		<form action="dsp_addProject.cfm?#Rand()#" method="post">
		<INPUT TYPE="submit" NAME="continue" value="  Continue  ">
		</form>
		</td>
		</cfoutput>
	</tr>
	</table>
</cfif>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
