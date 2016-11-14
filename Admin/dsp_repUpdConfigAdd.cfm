<cfparam name="url.e" default="0">
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Add New Stored Procedure" showCalendar="0">
<br>
<p>Use the Form below to add a new stored procedure to the rep update program. Please note, both fields must be valid and are required.</p>
<cfform name="addproc" action="act_RepUpdConfig.cfm?action=add" method="POST">
	<cfif url.E EQ 1>
	  <p style="color:#cc0000;">Error! You must include a Program Code</p>
	<cfelseif url.E EQ 2>
	  <p style="color:#cc0000;">Error! You must include a Stored Procedure to use.</p>
	</cfif>
	<table border="0" cellpadding="4" cellspacing="0">
	  <tr>
	     <td><strong>Type of Update:</strong></td>
		 <td><select name="PType">
		      <option value="CI">CI</option>
			  <option value="RO">Roster</option>
			      
			 </select>
		 </td>
	  </tr>
	  <tr>
	     <td><strong>Program Code:</strong></td>
		 <td><input type="text" name="programCode" value="" size="15" maxlength="25"></td>
	  </tr>
	  <tr>
	    <td><strong>Stored Procedure:</strong></td>
		<td><input type="text" name="StoredProc" value="" size="25" maxlength="100"></td>
	  </tr>
	  <tr>
	    <td colspan=2>&nbsp;</td>
	  </tr>
	  <tr>
	    <td colspan=2><input type="submit" name="submit" value="Add Procedure >>"></td>
	  </tr>
	</table>           
</cfform>                       
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">