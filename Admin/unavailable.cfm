<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Sceduling Admin" showCalendar="0">
<br><br>



 <table width="100%" border="0" cellspacing="0" cellpadding="8" align="center" frame="below" frame="rhs">
       
	    <tr><td valign="top" nowrap colspan="2" align="left">
	   <strong><font face="Verdana" size="3">Please Select a Speaker or Moderator</font></strong><br><br>
	   </td></tr>
	   <tr><td valign="top" nowrap align="center">
<cfoutput><cfquery name="getactivespkr" datasource="#application.speakerDSN#">
		SELECT DISTINCT speakerid, 
		                lastname, 
						firstname
						From Speaker
						Where type ='SPKR' 
						and active ='yes'
						order by lastname
						</cfquery> 
 <form method="POST" action="unavailable_edit.cfm">
	    <font face="verdana" size="1"><strong>Speaker Profiles:</strong></font><br>
	    <select name="speakerid" onchange="this.form.submit();">	
		 <option value="">-SELECT-</option>	   
		   <cfloop query="getactivespkr">
	        <option value="#getactivespkr.speakerid#">#getactivespkr.lastname#, #getactivespkr.firstname#</option>
		   </cfloop>
	    </select>
	  </form>
	  
	  </td>
	  <td valign="top" nowrap align="left">
<cfquery name="getactivemod" datasource="#application.speakerDSN#">
		SELECT DISTINCT speakerid, 
		                lastname, 
						firstname
						From Speaker
						Where type ='MOD' 
						and active ='yes'
						order by lastname
						</cfquery> 
 <form method="POST" action="unavailable_edit.cfm">
	    <font face="verdana" size="1"><strong>Moderator Profiles:</strong></font><br>
	    <select name="speakerid" onchange="this.form.submit();">		
		 <option value="">-SELECT-</option>	   
		   <cfloop query="getactivemod">
	        <option value="#getactivemod.speakerid#">#getactivemod.lastname#, #getactivemod.firstname#</option>
		   </cfloop>
	    </select>
	  </form>
</cfoutput>
</td>
</tr>
</table>
</center>



<br><br><br><br>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">