<!----------------------------
report_modspkr_calendar.cfm

Merge letter that allows speaker invoices to be generated and exported to MS Word.
--------------------------------->
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Moderator/Speaker Calendar" showCalendar="0">

<style>

TD.DropDownShow
{
	display: table-cell;
}

TD.DropDownHide
{
	display: none;
}

</style>
<script language="JavaScript">
function CheckInput(oForm)
{
	return true;
}

function ShowDropDown(ArrayIndex)
{
	var maxLength = document.all.DropDown.length
	
	for(i=0; i<maxLength; i++)
	{
		document.all.DropDown[i].className = "DropDownHide";
	}
	
	document.all.DropDown[ArrayIndex].className = "DropDownShow";
	document.all.DropDown[maxLength - 1].className = "DropDownShow";
}
</script>
</head>

<CFQUERY datasource="#application.speakerDSN#" NAME="getSpeaker">
	SELECT DISTINCT speakerid, firstname, lastname
	FROM Speaker
	WHERE active = 'yes' and type = 'SPKR'
	order by firstname
	
</CFQUERY>

<CFQUERY datasource="#application.speakerDSN#" NAME="getModerator">
	SELECT DISTINCT speakerid, firstname, lastname
	FROM Speaker
	WHERE active = 'yes' and type = 'MOD'
	order by firstname
</CFQUERY>

<!--- <cfset SpeakerArray = ArrayNew(1)>
<cfoutput query="getSpeaker">
	<cfset SpeakerArray[currentrow] = #getSpeaker.speakerid#>
</cfoutput>
<cfset SpeakerList = #ArrayToList(SpeakerArray, ",")#>  --->


<!--- <cfset ModeratorArray = ArrayNew(1)>
<cfoutput query="getModerator">
	<cfset ModeratorArray[currentrow] = #getModerator.speakerid#>
</cfoutput>
<cfset ModeratorList = #ArrayToList(ModeratorArray, ",")#> --->


<!--- <CFQUERY datasource="#application.speakerDSN#" NAME="getModeratorName">
	SELECT firstname, lastname, speakerid
	FROM SPEAKER
	WHERE speakerid IN ('#ModeratorList#')
	ORDER BY lastname
</CFQUERY> --->

<body>


<form action="report_modspkr_calendar3.cfm?no_menu=1" method="post" onsubmit="return CheckInput(this)">		
	<TABLE ALIGN="Center" BORDER="0" WIDTH="100%" CELLSPACING="0" CELLPADDING="4">
		<cfoutput>
		  <TR>
			<TD ALIGN="Center" style="padding-top: 4px; padding-bottom: 4px;  border-bottom:">
				<font color="##990000"><strong>Month</strong></font>&nbsp;&nbsp;
				<select name="select_month">
					<cfloop index="thismonth" from="1" to="12">
					  <option value="#thismonth#" <cfif month(now()) EQ thismonth>Selected</cfif>>#MonthasString(thisMonth)#</option>
					</cfloop>
				</select>
				&nbsp;&nbsp; &nbsp; 
				<font color="##990000"><strong>Year</strong></font>&nbsp;&nbsp;
				<select name="select_year">
				  
				      <cfloop index="thisyear" from="#year(DateAdd('YYYY', -2, now()))#" to="#year(DateAdd('YYYY', 3, now()))#">
					    <option value="#thisyear#" <cfif year(now()) EQ thisyear>Selected</cfif>>#thisyear#</option>
					  </cfloop> 
				   
				    
					<!--- <option value="2002">2002</option>
					<option value="2003">2003</option>
					<option value="2004">2004</option>
					<option value="2005">2005</option>
					<option value="2006">2006</option>
					<option value="2007">2007</option> --->
				</select>	</cfoutput>
			</td>
		</tr>
		<!--- <TR>
			<TD ALIGN="Center" style="padding-top: 6px; padding-bottom: 6px;"><font color="##990000"><strong>Select Report Type:</strong></font>&nbsp;&nbsp;<input type="radio" name="report_type" value="meeting"> Show Meeting Schedule&nbsp; &nbsp; &nbsp; &nbsp; <input type="radio" name="report_type" value="unavailable"> Show Times Unavailable</TD>
		</TR> --->
		<TR>
			<TD ALIGN="Center" style="padding-top: 6px; padding-bottom: 6px;"><font color="##990000"><strong>Run Report For:</strong></font>&nbsp;&nbsp;<input type="radio" name="sm_type" value="SPKR" onclick="ShowDropDown(1)"> Speaker &nbsp; &nbsp; &nbsp; &nbsp; <input type="radio" name="sm_type" value="MOD" onclick="ShowDropDown(2)"> Moderator</TD>
		</TR>
		<TR>
			<TD ALIGN="Center" id="DropDown" class="DropDownShow" style="padding-top: 4px; padding-bottom: 4px;">Please Select Moderator or Speaker</TD>
			<TD ALIGN="Center" id="DropDown" class="DropDownHide" style="padding-top: 4px; padding-bottom: 4px;">
			<font color="##990000"><strong>Speaker</strong></font>&nbsp;&nbsp;
			<select name="speakers">
				<option value="NULL">(Select a Speaker)</option>
				<cfoutput query="getSpeaker">
					<CFQUERY datasource="#application.speakerDSN#" NAME="getSpeakerName">
						SELECT firstname, lastname, speakerid
						FROM Speaker
						WHERE speakerid = #getSpeaker.speakerid#
						ORDER BY lastname
					</CFQUERY>					
					<option value="#getSpeaker.speakerid#">#getSpeakerName.lastname#, #getSpeakerName.firstname#</option>
				</cfoutput>
			</select>
			</TD>
			<TD ALIGN="Center" id="DropDown" class="DropDownHide" style="padding-top: 4px; padding-bottom: 4px;">
			<font color="##990000"><strong>Moderator</strong></font>&nbsp;&nbsp;
			<select name="moderators">
				<option value="NULL">(Select a Moderator)</option>
				<cfoutput query="getModerator">
					<option value="#getModerator.speakerid#">#getModerator.lastname#, #getModerator.firstname#</option>
				</cfoutput>
			</select>
			</TD>
		</TR>
		<TR>
			<TD id="DropDown" class="DropDownHide" ALIGN="Center" style="padding-top: 4px; padding-bottom: 4px;"><input type="submit"  value=" Generate Report "></TD>
		</TR>
	</table>
</form>
<p>&nbsp;</p>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

