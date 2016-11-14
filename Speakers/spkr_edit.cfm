
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Speaker Edit" showCalendar="1">
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

 		   	<script type="text/javascript">
function openpopup4(popurl){
var winpops=window.open(popurl,"","top=200,left=300,width=540,height=610,scrollbars=yes,resizable=yes")
}
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
		
<!--- fetch all client codes and product codes --->
<cfquery name="qfetchclients" datasource="#application.projdsn#">
	SELECT c.client_code, c.client_code_description
	from client_code c
	where c.status = 1
	order by c.client_code
</cfquery>	

<!--- fetch all speaker info --->
<cfquery name="speaker" datasource="#application.speakerDSN#">
	SELECT *
	from Speaker
	where SpeakerID = '#url.speakerid#'
	</cfquery>
	
	<cfquery name="speakeradd" datasource="#application.speakerDSN#">
	SELECT *
	from SpeakerAddress
	where SpeakerID = '#url.speakerid#'
	</cfquery>
<br>
         
<cfoutput><form name="AddSpeaker" action="spkr_Edit_Action.cfm" method="POST">
<table width="100%" border="0" cellspacing="0" cellpadding="4">
	<tr BGCOLOR="eeeeee">
		<td><strong>Active:</strong></td>

		<td colspan="4">
			<select name="active">			
			<option value="yes"<cfif #trim(speaker.active)# is 'yes'>selected</cfif>>Yes
			<option value="no"<cfif #Trim(speaker.active)# is 'no'>selected</cfif>>No
			</select>
		</td>
	</tr>
	<tr>
		<td><strong>Speaker ID:</strong></td>
		<td colspan="4">
			#speaker.speakerid#
		</td>
	</tr> 
	<tr BGCOLOR="eeeeee">
		<td><strong>Specialty:</strong></td>
		<td colspan="4">
			<select name="specialty">
			<OPTION value="">-Select-</option>
			<cfloop query="qspecialty">
			<option value="#qspecialty.code#"<cfif #qspecialty.code# is #speaker.specialty#>selected</cfif>>#qspecialty.description#</option>
			</cfloop>
			</select>
		</td>
	</tr>
	<tr>
		<td><strong>First Name:</strong></td>
		<td colspan="4">
			<input type="Text" name="firstname" size="25" value="#speaker.firstname#">&nbsp;&nbsp;
	<strong>Middle Init:</strong>&nbsp;<input type="Text" name="middlename"  size="1" maxlength="3" value="#Left(speaker.middlename, 1)#">
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td><strong>Last Name:</strong></td>
		<td colspan="4">
			<input type="Text" name="lastname" size="25" value="#speaker.lastname#">
		</td>
	</tr>
	<tr>
		<td><strong>Degree:</strong></td>
		<td colspan="4">
			<input type="Text" name="degree" size="25" value="#speaker.degree#">
		</td>
	</tr>
		<tr BGCOLOR="eeeeee">
		<td><strong>Travel:</strong></td>
		<td colspan="4">
			<select name="travel">
			<option value="">-Select-</option>
			<option value="Local" <cfif #speaker.travel# is 'LOCAL'>selected</cfif>>Local</option>
			<option value="Nat" <cfif #speaker.travel# is 'NAT'>selected</cfif>>National</option>
						</select>
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td><strong>Sex:</strong></td>
		<td colspan="4">
			<select name="sex">
			<option value="M" <cfif #speaker.sex# is 'm'>selected</cfif>>Male</option>
			<option value="F" <cfif #speaker.sex# is 'f'>selected</cfif>>Female</option>
						</select>
		</td>
	</tr>
	<tr>
		<td><strong>SS No./Tax Id:</strong></td>
		<td colspan="4">
		<cfif speaker.taxidtype is 'SS'>
			S.S. <input type="Text" name="ss" size="25" value="#speaker.taxid#">
			<cfelse>
			S.S. <input type="Text" name="ss" size="25" value="">
			</cfif>&nbsp;&nbsp;
			<cfif speaker.taxidtype is 'TIN'>
			Tax ID: <input type="Text" name="tin" size="25" value="#speaker.taxid#">
			<cfelse>
			Tax ID: <input type="Text" name="tin" size="25" value="">
			</cfif>
						
		<input type = "hidden" name ="taxidtype" value ="#speaker.taxidtype#">
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td valign="top"><strong>Affiliation:</strong></td>
		<td colspan="4" valign="top">
			<textarea cols="60" rows="5" name="affil" onkeyup="return _checkLimitContent(this)">#speaker.affil#</textarea> 
		</td>
	</tr>
	<tr>
		<td valign="top"><strong>Clients:</strong></td>
		<td colspan="3"><br>
		<a href="javascript:openpopup4('edit_spkr_clients.cfm?speakerid=#url.speakerid#')"><u>Click Here</u></a> <em>to edit Clients and Fee's</em><br><br>
			<cfquery name="all_prods" datasource="#application.speakerDSN#">
	 Select 
sc.ClientCode, EventFee, TrainingFee
From Speaker sp, 
SpeakerClients sc 
Where 
sp.speakerid = '#url.speakerid#' and
sc.SpeakerId = sp.speakerid		
order by ClientCode asc
           </cfquery> 

<table border="1" cellpadding="2" cellspacing="0" width="100%">
<tr>
<td align="left" valign="top"><font face="verdana" size="1"><strong>Product</strong></td>
<td align="left" valign="top"><font face="verdana" size="1"><strong>Event Fee</strong></td>
<td align="left" valign="top"><font face="verdana" size="1"><strong>Training Fee</strong></td></tr>


<cfloop query="all_prods"><tr>

<cfquery name="get_desc_all" datasource="#application.projdsn#"> 
Select project_code, product
From PIW
Where project_code like '#Left(all_prods.ClientCode,5)#%'
			 </cfquery> 

<td align="left" valign="top"><font face="verdana" size="1">
<font face="verdana" size="1" color="maroon">#get_desc_all.product#</font></td>
<td align="left" valign="top"><font face="verdana" size="1">
<font face="verdana" size="1" color="maroon">#all_prods.EventFee#</font></td>
<td align="left" valign="top"><font face="verdana" size="1">
<font face="verdana" size="1" color="maroon">#all_prods.trainingFee#</font></td>
</tr>
</cfloop>
</table>

	</td></tr>
	
	<tr>
		<td></td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td><strong>Mail To Address:</strong></td>
		<td colspan="3">
			<input type="Text" name="address1" size="35" value="#speakeradd.address1#">
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td></td>
		<td colspan="3">
			<input type="Text" name="address2" size="35" value="#speakeradd.address2#">
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td></td>
		<td colspan="3">
			<input type="Text" name="address3" size="35" value="#speakeradd.address3#">
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td><strong>City/State/Zip:</strong></td>
		<td colspan="3">
		<input type="Text" name="city" size="35" value="#speakeradd.city#">&nbsp;&nbsp;
			<select name="state">
			<OPTION value="">-Select-</option>
			<cfloop query="qstate">
			<option value="#qstate.code#" <cfif #speakeradd.state# is '#qstate.code#'>selected</cfif>>#qstate.description#</option>
			</cfloop>
			</select>&nbsp;&nbsp;<input type="Text" name="zipcode" size="10" value="#speakeradd.zipcode#">
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td><strong>Country:</strong></td>
		<td colspan="3"><input type="Text" name="mailtocountry" value="USA" size="35">
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td colspan="4"><hr noshade size="1"></td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td><strong>Shipping Address:</strong></td>
		<td colspan="3">
			<input type="Text" name="shipaddress1" size="35" value="#speakeradd.shipaddress1#">
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td></td>
		<td colspan="3">
			<input type="Text" name="shipaddress2" size="35" value="#speakeradd.shipaddress2#">
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td></td>
		<td colspan="3">
			<input type="Text" name="shipaddress3" size="35" value="#speakeradd.shipaddress3#">
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td><strong>City/State/Zip:</strong></td>
		<td colspan="3">
		<input type="Text" name="shipcity" size="35" value="#speakeradd.shipcity#">&nbsp;&nbsp;
			<select name="shipstate">
			<OPTION value="">(Select)
			<cfloop query="qstate">
			<option value="#qstate.code#" <cfif #speakeradd.shipstate# is '#qstate.code#'>selected</cfif>>#qstate.description#
			</cfloop>
			</select>&nbsp;&nbsp;<input type="Text" name="shipzipcode" size="10" value="#speakeradd.shipzipcode#">
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td><strong>Country:</strong></td>
		<td colspan="3"><input type="Text" name="shiptocountry" value="USA" size="35">
		</td>
	</tr>
	<tr>
		<td><strong>Phone Numbers:</strong></td>
		<td colspan="2"></td>
	</tr>	
	<tr>	
		<td align="right"><strong>Phone1:</strong></td>
		<td><input type="Text" name="phone1" size="25" value="#speakeradd.phone1#"></td>
		<td colspan="2"></td>
	</tr>
	<tr>	
		<td align="right"><strong>Phone2:</strong></td>
		<td><input type="Text" name="phone2" size="25" value="#speakeradd.phone2#"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right"><strong>Fax1:</strong></td>
		<td><input type="Text" name="fax1" size="25" value="#speakeradd.fax1#"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right"><strong>Fax2:</strong></td>
		<td><input type="Text" name="fax2" size="25" value="#speakeradd.fax2#"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right"><strong>Cell:</strong></td>
		<td><input type="Text" name="cell" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right"><strong>Pager:</strong></td>
		<td><input type="Text" name="pager" size="25" value="#speakeradd.cell#"></td>
		<td colspan="2"></td>
	</tr>
	
		<td align="right"><strong>Primary E-Mail:</strong></td>
		<td><input type="Text" name="email1" size="25" value="#speakeradd.email1#"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td align="right"><strong>Secondary Email:</strong></td>
		<td><input type="Text" name="email2" size="25"  value="#speakeradd.email2#"></td>
		<td colspan="2"></td>
	</tr>
	
	<tr BGCOLOR="eeeeee">
		<td><strong>CV Received Date:</strong></td>
		<td colspan="4">
			<!--- <input type="Text" name="CVdatebox" size="15"><a href="javascript:show_calendar('AddSpeaker.CVdatebox');" onmouseover="window.status='Date Picker';return true;" onmouseout="window.status='';return true;"><img src="/images/btn_formcalendar.gif" border=0 hspace="3" align="absmiddle"> --->
			<input type="text" 
			   name="cv" 
			   id="CVdate" 
			   style="font-size:11px;" 
			   value="#DateFormat(speaker.cv, "m/d/yyyy")#" 
			   size="10" maxlength="10">&nbsp;&nbsp;<em>e.g 1/12006</em>
			   <!--- <img src="/images/btn_formcalendar.gif" 
			     id="CVdatebtn" 
				 border="0" 
				 alt="Click to view calendar" 
				 onclick="Calendar.setup({inputField:'CVdatebox' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'CVdatebtn',singleClick:true,step:1})"> --->
			
		</td>
	</tr>
	<tr>
		<td><strong>W9 Received Date:</strong></td>
		<td colspan="4">
			<!--- <input type="Text" name="W9datebox" size="15"><a href="javascript:show_calendar('AddSpeaker.W9datebox');" onmouseover="window.status='Date Picker';return true;" onmouseout="window.status='';return true;"><img src="/images/btn_formcalendar.gif" border=0 hspace="3" align="absmiddle"></a> --->
		   <input type="text" 
			   name="W9" 
			   id="W9date" 
			   style="font-size:11px;" 
			   value="#DateFormat(speaker.w9, "m/d/yyyy")#" 
			   size="10" maxlength="10">&nbsp;&nbsp;<em>e.g 1/12006</em>
			 <!---   <img src="/images/btn_formcalendar.gif" 
			     id="W9datebtn" 
				 border="0" 
				 alt="Click to view calendar" 
				 onclick="Calendar.setup({inputField:'W9datebox' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'W9datebtn',singleClick:true,step:1})"> --->
		</td>
	</tr>
	<tr BGCOLOR="eeeeee">
		<td><strong>Contryes<br>Received Date:</strong></td>
		<td colspan="4">
			<!--- <input type="Text" name="consult_agreedatebox" size="15"><a href="javascript:show_calendar('AddSpeaker.consult_agreedatebox');" onmouseover="window.status='Date Picker';return true;" onmouseout="window.status='';return true;"><img src="/images/btn_formcalendar.gif" border=0 hspace="3" align="absmiddle"></a>
		 --->
		 <input type="text" 
			   name="consult_agree" 
			   id="consultagreedate" 
			   style="font-size:11px;" 
			   value="#DateFormat(speaker.consultagree, "m/d/yyyy")#" 
			   size="10" maxlength="10">&nbsp;&nbsp;<em>e.g 1/12006</em>
			  <!---  <img src="/images/btn_formcalendar.gif" 
			     id="consultagreedatebtn" 
				 border="0" 
				 alt="Click to view calendar" 
				 onclick="Calendar.setup({inputField:'consult_agreedatebox' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'consultagreedatebtn',singleClick:true,step:1})"> --->
		
		</td>
	</tr>
	
	<tr>
	  <td align="right" colspan ="2">
	    <table border="0">
			
			<tr>
				<td align="right" valign="top">
				<input type = "hidden" name ="speakerid" value ="#url.speakerid#">
					<INPUT TYPE="submit"  NAME="submit" VALUE="Update Speaker">
				</td>
			</tr>
			
		
		</table>

</form></cfoutput>

<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
