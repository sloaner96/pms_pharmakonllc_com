<cfsilent>
  <!-- Initialize the component -->
  <CFOBJECT COMPONENT="pms.com.repupdate"
	          NAME="repUpdate">
 <cfset allStoredProc = repUpdate.GetAllRepConfig()>
</cfsilent>
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Rep Update Configuration" showCalendar="0">
<script type="text/javascript">
  function askme(thisurl){
		msg = "Are you sure you would like to PERMANENTLY delete this procedure?"
		if (confirm(msg))
		   document.location.href(thisurl);
		else
		   return false;
  }
</script> 
  <br>
   <table border="0" cellpadding="4" cellspacing="0" width="100%">
      <tr>
          <td>The application below will allow you to update the Rep Update Configuration 
		      table with the correct Stored Procedure for the program.<br> 
		      To add a new procedure or a new program, click the "Add a New Program" link 
			  below. To Edit a Program or a Stored Procedure, enter it in the text box provided and click the Update bottom on the bottom of the page. 
			  To delete a procedure, click the "[REMOVE]" link to the left of the program name.
		  </td>
      </tr>
   </table><br>
   <div align="right"><a href="dsp_repUpdConfigAdd.cfm">Add a New Program >></a></div>
   <cfform name="configUpd" action="act_RepUpdConfig.cfm?action=UPDATE" method="POST">
	   <table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="6e6e6e">
	      <cfoutput query="AllStoredProc" group="ProcessType">
		    <tr>
			  <td colspan="6" bgcolor="##444444"><strong style="color:##ffffff;"><cfif AllStoredProc.ProcessType EQ "RO">Rosters<cfelse>Confirmed Invitees</cfif></strong></td>
			</tr>
			<tr class="highlight">
			     <td width="1"></td>
		         <td><strong>Program Code</strong></td>
				 <td><strong>Stored Procedure</strong></td>
				 <td><strong>Date Added</strong></td>
				 <td><strong>Last Updated</strong></td>
				 <td><strong>Last Run</strong></td>
			 </tr>
			  <cfoutput>
				  <tr <cfif AllStoredProc.currentrow MOD(2) EQ 0>bgcolor="ffffff"<cfelse>bgcolor="eeeeee"</cfif>>
			         <td><a href="act_RepUpdConfig.cfm?action=DELETE&SpID=#AllStoredProc.RepConfigID#" style="color:red;font-size:10px;" onclick="askme(this.href); return false;">[REMOVE]</a></td>
					 <td><input type="text" name="ProgramCode_#AllStoredProc.RepConfigID#" size="15" maxlength="25" value="#AllStoredProc.ProgramCode#" style="font-family:verdana; font-size:11px;background-color:##ffff99;"></td>
					 <td><input type="text" name="StoredProc_#AllStoredProc.RepConfigID#" size="25" maxlength="100" value="#AllStoredProc.StoredProcTxt#" style="font-family:verdana; font-size:11px;background-color:##ffff99;"></td>
					 <td>#DateFormat(AllStoredProc.DateAdded, 'mm/dd/yyyy')# at #TimeFormat(AllStoredProc.DateAdded, 'hh:mm tt')#</td>
					 <td><cfif AllStoredProc.LastUpdated NEQ "">#DateFormat(AllStoredProc.LastUpdated, 'mm/dd/yyyy')# at #TimeFormat(AllStoredProc.LastUpdated, 'hh:mm tt')#</cfif></td>
			         <td><cfif AllStoredProc.LastRun NEQ "">#DateFormat(AllStoredProc.LastRun, 'mm/dd/yyyy')# at #TimeFormat(AllStoredProc.LastRun, 'hh:mm tt')#<cfelse><font color="##990000">Never Run</font></cfif></td>  
				  </tr>
			  </cfoutput>
			  <tr>
			    <td bgcolor="##ffffff" colspan="6">&nbsp;</td>
			  </tr>
		  </cfoutput>
		  <tr>
		    <td colspan="6" bgcolor="ffffff" align="center"><input type="submit" name="submit" value="Update Stored Procedures >>"></td>
		  </tr>
	   </table>
   </cfform>                        
<cfmodule template="#Application.tagpath#/ctags/footer.cfm"> 