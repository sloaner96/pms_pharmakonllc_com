
<CFPARAM NAME="URL.client" DEFAULT="">
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Notes: Client/Project Code Select" bodypassthrough="onload='init();'" showCalendar="0">


<script src="validation.js" language="JavaScript"></script>
<!-- Rules explained in more detail at author's site: -->
<!-- http://www.hagedesign.dk/scripts/js/validation/ -->
<script language="JavaScript">	
function init(){
		//example define('field_1','num','Display','min','max');
		define('client_code','string','Client Code');
	}
//--
//function Openme(newin) {
        //notes=window.open(newin,"notes","resizable=yes,scrollbars=auto,menubar=no,status=no,width=500,height=300,top=50,left=50")
	//}
</script>

<!--- pull project codes --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qproj">
	SELECT	project_code FROM piw ORDER BY project_code
</cfquery>

<FORM ACTION="Notes_bridge.cfm" METHOD="post" name="selectform" onSubmit="init();">
<TABLE ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="0">
<tr>
	<td align=right><SPAN CLASS="required"><b>Select A Client:</b></SPAN></td>
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="qprojects">
			SELECT client_proj, description, client_code 
				FROM client_proj ORDER BY client_code
		</CFQUERY>	
	<td>
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
			<TR>
			  <TD COLSPAN="2" ALIGN="center">&nbsp;</td>
			</tr>
			<tr>
			  <td colspan="2" align="center"><strong style="color:#CC0000;">* You must turn off any pop-up blocker</strong></td>
			</tr>
			<TR>
				<TD colspan=2 ALIGN="Center">
					<br/><br/>
					<INPUT TYPE="submit" NAME="notes" VALUE="Go to Notes">
					<br/><br/>
					<!--- onClick="Openme('NotesList.cfm?no_menu=1')" --->
					<!--- <INPUT onclick="Openme('NotesList.cfm')" TYPE=image src="#session.appfilepath#images/btn_notes.gif" name=notes> --->
				</TD>
			</TR>
	   </TABLE>
     </TD>
  </TR>
</TABLE>
</FORM>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
