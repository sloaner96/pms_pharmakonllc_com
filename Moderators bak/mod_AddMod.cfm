
<!----------------------------------------------------------------------------
	mod_AddModerator.cfm
	Form fields to add a new moderator
	
	lb070201-  Initial code.
	rws101505 - added new header, cleaned up HTML
--------------------------------------------------------------------------------->
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Add a Moderator" showCalendar="0">


<script src="validation.js" language="JavaScript"></script>

<!-- Rules explained in more detail at author's site: -->
<!-- http://www.hagedesign.dk/scripts/js/validation/ -->
<script LANGUAGE=JAVASCRIPT>

<!--
	//limit comments to 245
	function  _checkLimitContent(_CF_this)
	{
		if (_CF_this.value.length > 245)
		{
			alert("Please limit your comments to 250 charyesers");
    		return false;
  		}
    	return true;
	}
	
	function init(){
		//example define('field_1','num','Display','min','max');
		define('firstname','string','Firstname');
		define('lastname','string','Lastname');
		define('client_code','string','Client');
		define('client_fee','num','Fee');
		
	}
	
//-->

</script>	
</head>


<BODY bgcolor="#dbe3e5">

<!--- pulls state descriptions for codes --->
<cfquery name="qstate" datasource="#application.speakerDSN#">
	SELECT code, description
	FROM codes
	WHERE code_type = 'STATE'
	ORDER BY description
	</cfquery>
	
<!--- pulls travel descriptions for codes --->
<cfquery name="qtravel" datasource="#application.speakerDSN#">
	SELECT code, description
	FROM codes
	WHERE code_type = 'TRAVL'
	ORDER BY description
	</cfquery>
	
<!--- pulls specialty descriptions for codes --->
<cfquery name="qspecialty" datasource="#application.speakerDSN#">
	SELECT code, description
	FROM codes
	WHERE code_type = 'SPEC'
	ORDER BY description
	</cfquery>
	
<!--- pulls sex descriptions for codes --->
<cfquery name="qsex" datasource="#application.speakerDSN#">
	SELECT code, description
	FROM codes
	WHERE code_type = 'SEX'
	ORDER BY description DESC
	</cfquery>
		
<!--- Pulls status codes --->	
<cfquery name="qactive" datasource="#application.speakerDSN#">
	SELECT DISTINCT description, code
	FROM  codes
	WHERE code_type = 'SSTAT'
	ORDER BY codes.description
	</cfquery>	

<!--- pulls clients and clients that moderator works for --->	
<cfquery name="qfetchclients" datasource="#application.projdsn#">
	SELECT c.client_code, c.client_code_description
	from client_code c
	where c.status = 1
	order by c.client_code
</cfquery>		

<table width="90%" border="0" cellspacing="0" cellpadding="2">
	<tr BGCOLOR="eeeeee">
		<td>Status:</td>
<form name="AddMod" action="mod_AddModaction.cfm?no_menu='1'" method="POST" onSubmit="validate();return returnVal;">
		<td colspan="4">
			<select name="active">
			<cfoutput query="qactive">
			<option value="#qactive.code#">#qactive.description#</option>
			</cfoutput>
			</select>
		</td>
	</tr>
	<tr>
		<td>Region:</td>
		<td colspan="4">
			<select name="travel">
			<OPTION value="">(Select)
			<cfoutput query="qtravel">
			<option value="#qtravel.code#">#qtravel.description#</option>
			</cfoutput>
			</select>
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td>Specialty:</td>
		<td colspan="4">
			<select name="specialty">
			<OPTION value="">(Select)
			<cfoutput query="qspecialty">
			<option value="#qspecialty.code#">#qspecialty.description#</option>
			</cfoutput>
			</select>
		</td>
	</tr>
	<tr>
		<td>First Name:</td>
		<td colspan="4">
			<input type="Text" name="firstname" size="25">&nbsp;&nbsp;
	        <strong>Middle Init:</strong>&nbsp;<input type="Text" name="middlename"  size="1" maxlength="3">
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td>Last Name:</td>
		<td colspan="4">
			<input type="Text" name="lastname" size="25">
		</td>
	</tr>
	<tr>
		<td>Degree:</td>
		<td colspan="4">
			<input type="Text" name="degree" size="25">
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td>Sex:</td>
		<td colspan="4">
			<select name="sex">
			<OPTION value="">(Select)</option>
			<cfoutput query="qsex">
			<option value="#qsex.code#">#qsex.description#</option>
			</cfoutput>
			</select>
		</td>
	</tr>
	<tr>
		<td>SS No./Tax Id:</td>
		<td colspan="4">
			<input type="Text" name="ss" size="25">
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td>Affiliation:</td>
		<td colspan="4" valign="top">
			<textarea cols="60" rows="2" name="affil" onkeyup="return _checkLimitContent(this)"></textarea> 
		</td>
	</tr>
	<tr>
		<td>Clients:</td>
		<td colspan="3">
		<select name="client_code">
		<option value="">(Select)</option>
		<cfoutput query="qfetchclients">
		<option value="#client_code#">#client_code#</option>
		</cfoutput>
		</select>
	</td></tr>
	<tr>
	<td class="collabel">Fee:</td>
	<td>$<input type="text" name="client_fee" size="10"></td>
	</tr>
	<tr>
	<!--- comments is named dynamically with cclient_id as suffix--->
	<td class="collabel">Comments:</td>
	<td><textarea cols="20" rows="1" name="clientcomments" onkeyup="return _checkLimitContent(this)"></textarea>
	</td>
</tr>

	<tr>
		<td></td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td>Mail To Address:</td>
		<td colspan="3">
			<input type="Text" name="add1" size="35">
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td></td>
		<td colspan="3">
			<input type="Text" name="add2" size="35">
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td></td>
		<td colspan="3">
			<input type="Text" name="add3" size="35">
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td>City/State/Zip:</td>
		<td colspan="3">
		<input type="Text" name="city" size="35">&nbsp;&nbsp;
			<select name="state">
			<OPTION value="">(Select)
			<cfoutput query="qstate">
			<option value="#qstate.code#">#qstate.description#
			</cfoutput>
			</select>&nbsp;&nbsp;<input type="Text" name="zipcode" size="10">
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td>Country:</td>
		<td colspan="3"><input type="Text" name="mailtocountry" value="USA" size="35">
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td>Business Address:</td>
		<td colspan="4"><input type="Text" name="busadd_1" size="35">
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td></td>
		<td colspan="3">
			<input type="Text" name="busadd_2" size="35">
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td></td>
		<td colspan="3">
			<input type="Text" name="busadd_3" size="35">
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td>City/State/Zip:</td>
		<td colspan="4">
			<input type="Text" name="buscity" size="35">&nbsp;&nbsp;<select name="busstate">
			<OPTION value="">(Select)</option>
			<cfoutput query="qstate">
			<option value="#qstate.code#">#qstate.description#</option>
			</cfoutput>
		</select>&nbsp;&nbsp;<input type="Text" name="buszip" size="10">
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td>Country:</td>
		<td colspan="3"><input type="Text" name="buscountry" value="USA" size="35">
		</td>
	</tr>
	<tr>
		<td>Phone Numbers:</td>
		<td colspan="2"></td>
	</tr>	
	<tr>	
		<td align="right">Primary Phone:</td>
		<td><input type="Text" name="phone1" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right">Primary Fax:</td>
		<td><input type="Text" name="fax1" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right">Primary Cell:</td>
		<td><input type="Text" name="cell1" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right">Primary Pager:</td>
		<td><input type="Text" name="pager1" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right">Primary Service:</td>
		<td><input type="Text" name="service1" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right">Primary E-Mail:</td>
		<td><input type="Text" name="email1" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right">Secondary Phone:</td>
		<td><input type="Text" name="phone2" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right">Secondary Fax:</td>
		<td><input type="Text" name="fax2" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right">Secondary Cell:</td>
		<td><input type="Text" name="cell2" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right">Secondary Pager:</td>
		<td><input type="Text" name="pager2" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right">Secondary Service:</td>
		<td><input type="Text" name="service2" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right">Secondary E-Mail:</td>
		<td><input type="Text" name="email2" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td>CV Received Date:</td>
		<td colspan="4">
			<input type="Text" name="CVdatebox" size="15"><a href="javascript:show_calendar('AddMod.CVdatebox');" onmouseover="window.status='Date Picker';return true;" onmouseout="window.status='';return true;"><img src="../images/show-calendar.gif" width=24 height=22 border=0></a>
		</td>
	</tr>
	<tr>
		<td>W9 Received Date:</td>
		<td colspan="4">
			<input type="Text" name="W9datebox" size="15"><a href="javascript:show_calendar('AddMod.W9datebox');" onmouseover="window.status='Date Picker';return true;" onmouseout="window.status='';return true;"><img src="../images/show-calendar.gif" width=24 height=22 border=0></a>
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td>Contryes<br>Received Date:</td>
		<td colspan="4">
			<input type="Text" name="consult_agreedatebox" size="15"><a href="javascript:show_calendar('AddMod.consult_agreedatebox');" onmouseover="window.status='Date Picker';return true;" onmouseout="window.status='';return true;"><img src="../images/show-calendar.gif" width=24 height=22 border=0></a>
		</td>
	</tr>
	<tr>
		<td>Contact Info:</td>
		<td colspan="4" valign="top"><textarea cols="60" rows="2" name="Contact_info" onkeyup="return _checkLimitContent(this)"></textarea> 
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td>Comments:</td>
		<td colspan="4" valign="top"><textarea cols="60" rows="2" name="comment"onkeyup="return _checkLimitContent(this)"></textarea> 
		</td>
	</tr>

</table>
<br> 

<table border="0">
   <tr>
	<td width="83" align="center" valign="top"><INPUT TYPE="submit"  NAME="add" VALUE=" Save ">
		</td>
		<td width="83" align="center" valign="top"><INPUT TYPE="submit"  NAME="back" VALUE="Search Again" onclick="javascript:history.back(-1);"></td>
  </tr>
</table>
 </form>
</body>
</html>
