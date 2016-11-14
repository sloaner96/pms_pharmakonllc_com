<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Add New Speaker" showCalendar="1">
<script src="/includes/libraries/validation.js" language="JavaScript"></script>
<script LANGUAGE=JAVASCRIPT>

<!--

function init(){
		//example define('field_1','num','Display','min','max');
		define('firstname','string','Firstname');
		define('lastname','string','Lastname');
		define('client_code','string','Client');
		define('client_fee','num','Fee');
		
	}



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
	
	-->

</script>	
</head>



<BODY OnLoad="init()">


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

<!--- fetch all client codes and product codes --->
<cfquery name="qfetchclients" datasource="#application.projdsn#">
	SELECT c.client_code, c.client_code_description
	from client_code c
	where c.status = 1
	order by c.client_code
</cfquery>	
<br>
         
<form name="AddSpeaker" action="spkr_AddSpeakeraction.cfm?no_menu='1'" method="POST" onSubmit="validate();return returnVal;">
<table width="100%" border="0" cellspacing="0" cellpadding="4">
	<tr BGCOLOR="#eeeeee">
		<td><strong>Status:</strong></td>

		<td colspan="4">
			<select name="active">
			<cfoutput query="qactive">
			<option value="#qactive.code#">#qactive.description#
			</cfoutput>
			</select>
		</td>
	</tr>
	<tr>
		<td><strong>Region:</strong></td>
		<td colspan="4">
			<select name="travel">
			<OPTION value="">(Select)
			<cfoutput query="qtravel">
			<option value="#qtravel.code#">#qtravel.description#
			</cfoutput>
			</select>
		</td>
	</tr>
	<tr BGCOLOR="#eeeeee">
		<td><strong>Specialty:</strong></td>
		<td colspan="4">
			<select name="specialty">
			<OPTION value="">(Select)
			<cfoutput query="qspecialty">
			<option value="#qspecialty.code#">#qspecialty.description#
			</cfoutput>
			</select>
		</td>
	</tr>
	<tr>
		<td><strong>First Name:</strong></td>
		<td colspan="4">
			<input type="Text" name="firstname" size="25">&nbsp;&nbsp;
	<strong>Middle Init:</strong>&nbsp;<input type="Text" name="middlename"  size="1" maxlength="3">
		</td>
	</tr>
	<tr BGCOLOR="#eeeeee">
		<td><strong>Last Name:</strong></td>
		<td colspan="4">
			<input type="Text" name="lastname" size="25">
		</td>
	</tr>
	<tr>
		<td><strong>Degree:</strong></td>
		<td colspan="4">
			<input type="Text" name="degree" size="25">
		</td>
	</tr>
	<tr BGCOLOR="#eeeeee">
		<td><strong>Sex:</strong></td>
		<td colspan="4">
			<select name="sex">
			<OPTION value="">(Select)
			<cfoutput query="qsex">
			<option value="#qsex.code#">#qsex.description#
			</cfoutput>
			</select>
		</td>
	</tr>
	<tr>
		<td><strong>SS No./Tax Id:</strong></td>
		<td colspan="4">
			<input type="Text" name="ss" size="25">
		</td>
	</tr>
	<tr BGCOLOR="#eeeeee">
		<td><strong>Affiliation:</strong></td>
		<td colspan="4" valign="top">
			<textarea cols="60" rows="2" name="affil" onkeyup="return _checkLimitContent(this)"></textarea> 
		</td>
	</tr>
	<tr>
		<td><strong>Clients:</strong></td>
		<td colspan="3">
		<select name="client_code">
		<option value="">(Select)
		<cfoutput query="qfetchclients">
		<option value="#client_code#">#client_code#
		</cfoutput>
		</select>
	</td></tr>
	<tr>
	<td class="collabel"><strong>Fee:</strong></td>
	<td>$<input type="text" name="client_fee" size="10"></td>
	</tr>
	<tr>
	<!--- comments is named dynamically with cclient_id as suffix--->
	<td class="collabel"><strong>Comments:</strong></td>
	<td><textarea cols="20" rows="1" name="clientcomments"onkeyup="return _checkLimitContent(this)"></textarea>
	</td>
</tr>

	<tr>
		<td></td>
	</tr>
	<tr BGCOLOR="#eeeeee">
		<td><strong>Mail To Address:</strong></td>
		<td colspan="3">
			<input type="Text" name="add1" size="35">
		</td>
	</tr>
	<tr BGCOLOR="#eeeeee">
		<td></td>
		<td colspan="3">
			<input type="Text" name="add2" size="35">
		</td>
	</tr>
	<tr BGCOLOR="#eeeeee">
		<td></td>
		<td colspan="3">
			<input type="Text" name="add3" size="35">
		</td>
	</tr>
	<tr BGCOLOR="#eeeeee">
		<td><strong>City/State/Zip:</strong></td>
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
	<tr BGCOLOR="#eeeeee">
		<td><strong>Country:</strong></td>
		<td colspan="3"><input type="Text" name="mailtocountry" value="USA" size="35">
		</td>
	</tr>
	<tr BGCOLOR="#eeeeee">
		<td colspan="4"><hr noshade size="1"></td>
	</tr>
	<tr BGCOLOR="#eeeeee">
		<td><strong>Business Address:</strong></td>
		<td colspan="4"><input type="Text" name="busadd_1" size="35">
		</td>
	</tr>
	<tr BGCOLOR="#eeeeee">
		<td></td>
		<td colspan="3">
			<input type="Text" name="busadd_2" size="35">
		</td>
	</tr>
	<tr BGCOLOR="#eeeeee">
		<td></td>
		<td colspan="3">
			<input type="Text" name="busadd_3" size="35">
		</td>
	</tr>
	<tr BGCOLOR="#eeeeee">
		<td><strong>City/State/Zip:</strong></td>
		<td colspan="4">
			<input type="Text" name="buscity" size="35">&nbsp;&nbsp;<select name="busstate">
			<OPTION value="">(Select)
			<cfoutput query="qstate">
			<option value="#qstate.code#">#qstate.description#
			</cfoutput>
		</select>&nbsp;&nbsp;<input type="Text" name="buszip" size="10">
		</td>
	</tr>
	<tr BGCOLOR="#eeeeee">
		<td><strong>Country:</strong></td>
		<td colspan="3"><input type="Text" name="buscountry" value="USA" size="35">
		</td>
	</tr>
	<tr>
		<td><strong>Phone Numbers:</strong></td>
		<td colspan="2"></td>
	</tr>	
	<tr>	
		<td align="right"><strong>Primary Phone:</strong></td>
		<td><input type="Text" name="phone1" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right"><strong>Primary Fax:</strong></td>
		<td><input type="Text" name="fax1" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right"><strong>Primary Cell:</strong></td>
		<td><input type="Text" name="cell1" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right"><strong>Primary Pager:</strong></td>
		<td><input type="Text" name="pager1" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right"><strong>Primary Service:</strong></td>
		<td><input type="Text" name="service1" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right"><strong>Primary E-Mail:</strong></td>
		<td><input type="Text" name="email1" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right"><strong>Secondary Phone:</strong></td>
		<td><input type="Text" name="phone2" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right"><strong>Secondary Fax:</strong></td>
		<td><input type="Text" name="fax2" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right"><strong>Secondary Cell:</strong></td>
		<td><input type="Text" name="cell2" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right"><strong>Secondary Pager:</strong></td>
		<td><input type="Text" name="pager2" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right"><strong>Secondary Service:</strong></td>
		<td><input type="Text" name="service2" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right"><strong>Secondary E-Mail:</strong></td>
		<td><input type="Text" name="email2" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr BGCOLOR="#eeeeee">
		<td><strong>CV Received Date:</strong></td>
		<td colspan="4">
			<!--- <input type="Text" name="CVdatebox" size="15"><a href="javascript:show_calendar('AddSpeaker.CVdatebox');" onmouseover="window.status='Date Picker';return true;" onmouseout="window.status='';return true;"><img src="/images/btn_formcalendar.gif" border=0 hspace="3" align="absmiddle"> --->
			<input type="text" 
			   name="CVdatebox" 
			   id="CVdate" 
			   style="font-size:11px;" 
			   value="" 
			   size="10" maxlength="10">&nbsp;
			   <img src="/images/btn_formcalendar.gif" 
			     id="CVdatebtn" 
				 border="0" 
				 alt="Click to view calendar" 
				 onclick="Calendar.setup({inputField:'CVdatebox' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'CVdatebtn',singleClick:true,step:1})">
			
		</td>
	</tr>
	<tr>
		<td><strong>W9 Received Date:</strong></td>
		<td colspan="4">
			<!--- <input type="Text" name="W9datebox" size="15"><a href="javascript:show_calendar('AddSpeaker.W9datebox');" onmouseover="window.status='Date Picker';return true;" onmouseout="window.status='';return true;"><img src="/images/btn_formcalendar.gif" border=0 hspace="3" align="absmiddle"></a> --->
		   <input type="text" 
			   name="W9datebox" 
			   id="W9date" 
			   style="font-size:11px;" 
			   value="" 
			   size="10" maxlength="10">&nbsp;
			   <img src="/images/btn_formcalendar.gif" 
			     id="W9datebtn" 
				 border="0" 
				 alt="Click to view calendar" 
				 onclick="Calendar.setup({inputField:'W9datebox' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'W9datebtn',singleClick:true,step:1})">
		</td>
	</tr>
	<tr BGCOLOR="#eeeeee">
		<td><strong>Contryes<br>Received Date:</strong></td>
		<td colspan="4">
			<!--- <input type="Text" name="consult_agreedatebox" size="15"><a href="javascript:show_calendar('AddSpeaker.consult_agreedatebox');" onmouseover="window.status='Date Picker';return true;" onmouseout="window.status='';return true;"><img src="/images/btn_formcalendar.gif" border=0 hspace="3" align="absmiddle"></a>
		 --->
		 <input type="text" 
			   name="consult_agreedatebox" 
			   id="consultagreedate" 
			   style="font-size:11px;" 
			   value="" 
			   size="10" maxlength="10">&nbsp;
			   <img src="/images/btn_formcalendar.gif" 
			     id="consultagreedatebtn" 
				 border="0" 
				 alt="Click to view calendar" 
				 onclick="Calendar.setup({inputField:'consult_agreedatebox' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'consultagreedatebtn',singleClick:true,step:1})">
		
		</td>
	</tr>
	<tr>
		<td><strong>Contact Info:</strong></td>
		<td colspan="4" valign="top"><textarea cols="60" rows="2" name="Contact_info" onkeyup="return _checkLimitContent(this)"></textarea> 
		</td>
	</tr>
	<tr BGCOLOR="#eeeeee">
		<td><strong>Comments:</strong></td>
		<td colspan="4" valign="top"><textarea cols="60" rows="2" name="comment"onkeyup="return _checkLimitContent(this)"></textarea> 
		</td>
	</tr>
    <tr>
	  <td></td>
	</tr>
	<tr>
	  <td>
	    <table border="0">
			<cfoutput>
			<tr>
				<td align="center" valign="top">
					<INPUT TYPE="submit"  NAME="submit" VALUE="Add new Speaker >>">
				</td></cfoutput>
			</tr>
			
		
		</table>
	  </td>
	</tr>
</table>
</form>

<cfmodule template="#Application.tagpath#/ctags/footer.cfm">