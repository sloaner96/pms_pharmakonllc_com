<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Rep Update Configuration" showCalendar="0">
<!--- <cfsilent> --->
<cfparam name="url.action" default="">
<!-- Initialize the component -->
	<CFOBJECT COMPONENT="pms.com.repupdate"
		        NAME="repUpdate">
	<CFOBJECT COMPONENT="pms.com.utilities"
		        NAME="util"> 
				
<!--- Initialize Components --->
<cfif url.action EQ "ADD">
	<!--- Check that the Form Fields exist --->
	<cfif form.programCode EQ "">
	  <cflocation url="dsp_RepUpConfig.cfm?e=1" addtoken="NO">
	</cfif>
	<cfif form.StoredProc EQ "">
	  <cflocation url="dsp_RepUpConfig.cfm?e=2" addtoken="NO">
	</cfif>

	
	<!--- Set the Local Variables --->			
	<cfset Error = ArrayNew(2)>			
	<cfset Datasource = "CBARoster">
	<cfset ThisArrayRow = 1>
	<cfset storedProc = trim(Form.StoredProc)>
	<cfset ProgramCode = trim(Form.programCode)>
	<cfset ProgType = trim(Form.PType)>
    <!--- 
	      Call the repUpdate.CheckDup(ProgramCode) Method to make sure 
	      the ProgramCode is Unique. 
	 --->
	  <cfset DupProgCheck = repUpdate.CheckDup(ProgramCode, ProgType)>
			 
			 <cfif DupProgCheck>
			   <cfset Error[#ThisArrayRow#][1] = 0>
			   <cfset Error[#ThisArrayRow#][2] = "Program Code Already Exists">
			   <cfset Error[#ThisArrayRow#][3] = programCode>
			   <cfset ThisArrayRow = ThisArrayRow + 1> 
			 </cfif>
	 
	<!--- 
	      Call the Util.CheckProcedure(datasource, storedProcedure) Method to make sure 
	      the Stored Procedure exists on the Database 
	 --->
	   <cfset DupSPCheck =  Util.CheckProcedure(storedProc, datasource)>
	   
	   <cfif NOT DupSPCheck>
		 <cfset Error[#ThisArrayRow#][1] = 0>
		 <cfset Error[#ThisArrayRow#][2] = "Stored Procedure Does Not Exist">
		 <cfset Error[#ThisArrayRow#][3] = storedProc>
		 <cfset ThisArrayRow = ThisArrayRow + 1> 
	   </cfif> 
	   
	 <!--- Call the RepUpdate.AddConfig(ProgramCode, StoredProcTxt, UserID) to update the procedure --->
      <cfif Not DupProgCheck AND DupSPCheck>
	   <!--- Call the RepUpdate.UpdateConfig(RepConfigID, ProgramCode, StoredProcTxt) to update the procedure --->
	      <cfset AddNewConfig = RepUpdate.AddConfig(ProgramCode, storedProc, ProgType, Session.userinfo.rowid)>
	   </cfif> 
  <cfif Arraylen(Error) EQ 0>
     <!--- Kick the User back to the Main page --->
     <cflocation url="dsp_RepUpdConfig.cfm" addtoken="NO">
  <cfelse>
   <cfoutput>
   <br>
    <strong class="errorText">We found the following problems while attempting to update the system:</strong> <br>  
     <table border="0" cellpadding="3" cellspacing="1">
	   <tr bgcolor="eeeee">
	     <td><strong>ProcedureID</strong></td>
		 <td><strong>Message</strong></td>
		 <td><strong>Value</strong></td>
	   </tr> 
	 <cfloop index="i" from="1" to="#ArrayLen(Error)#">
	   <tr>
          <td>#Error[i][1]#</td>
		  <td>#Error[i][2]#</td>
		  <td>#Error[i][3]#</td>
       </tr>
	 </cfloop>
   </table><br><br>
   <a href="javascript:history.go(-1);">Please go back and correct these errors</a>           
   </cfoutput>
  </cfif>
<cfelseif url.action EQ "UPDATE">
<!--- Initialize Components --->

 <cfset allStoredProc = repUpdate.GetAllRepConfig()>


<cfset Error = ArrayNew(2)>
<cfset Datasource = "CBARoster">
<cfset ThisArrayRow = 1>

  <cfloop query="AllStoredProc">
	<!--- Check that the Form Fields exist --->
	<cfif IsDefined("form.ProgramCode_#AllStoredProc.RepConfigID#")>
	
	<cfif Evaluate("form.ProgramCode_#AllStoredProc.RepConfigID#") EQ "">
	    <cfset Error[#ThisArrayRow#][1] = AllStoredProc.RepConfigID>
		<cfset Error[#ThisArrayRow#][2] = "Program Code Does Not Exist">
		<cfset Error[#ThisArrayRow#][3] = "">
		
		<cfset ThisArrayRow = ThisArrayRow + 1> 
	</cfif> 
	
	<cfif ArrayLen(Error) EQ 0>
		<!--- Loop over the list of Updates --->
		<cfset programCode = Evaluate("form.ProgramCode_#AllStoredProc.RepConfigID#")>
		<cfset storedProc =  Evaluate("form.StoredProc_#AllStoredProc.RepConfigID#")>
		    
			 <!--- 
			      Call the repUpdate.CheckDup(ProgramCode) Method to make sure 
			      the ProgramCode is Unique. 
			 --->
			 <cfset DupProgCheck = repUpdate.CheckDup(ProgramCode, allStoredProc.ProcessType)>
			 
			 <cfif DupProgCheck>
			   <cfset Error[#ThisArrayRow#][1] = AllStoredProc.RepConfigID>
			   <cfset Error[#ThisArrayRow#][2] = "Program Code Already Exists">
			   <cfset Error[#ThisArrayRow#][3] = programCode>
			   <cfset ThisArrayRow = ThisArrayRow + 1> 
			 </cfif>
			 
			<!--- 
			      Call the Util.CheckProcedure(datasource, storedProcedure) Method to make sure 
			      the Stored Procedure exists on the Database 
			 --->
			 <cfif storedProc NEQ "">
			   <cfset DupSPCheck =  Util.CheckProcedure(storedProc, datasource)>
			 
				 <cfif NOT DupSPCheck>
				   <cfset Error[#ThisArrayRow#][1] = AllStoredProc.RepConfigID>
				   <cfset Error[#ThisArrayRow#][2] = "Stored Procedure Does Not Exist">
				   <cfset Error[#ThisArrayRow#][3] = storedProc>
				   <cfset ThisArrayRow = ThisArrayRow + 1> 
				 </cfif>
			 
			 <cfelse>
			    <cfset Error[#ThisArrayRow#][1] = AllStoredProc.RepConfigID>
			    <cfset Error[#ThisArrayRow#][2] = "Stored Procedure was not entered">
			    <cfset Error[#ThisArrayRow#][3] = "">
			    <cfset ThisArrayRow = ThisArrayRow + 1> 
			    <cfset DupSPCheck = false>
			 </cfif>
			 <cfif Not DupProgCheck AND DupSPCheck>
			   <!--- Call the RepUpdate.UpdateConfig(RepConfigID, ProgramCode, StoredProcTxt) to update the procedure --->
		       <cfset UpdateRec = RepUpdate.UpdateConfig(AllStoredProc.RepConfigID, ProgramCode, storedProc)>
			 </cfif> 
	  </cfif>	 
    </cfif>
  </cfloop>
  <cfif Arraylen(Error) EQ 0>
     <!--- Kick the User back to the Main page --->
     <cflocation url="dsp_RepUpdConfig.cfm" addtoken="NO">
  <cfelse>
   <cfoutput>
   <br>
    <strong class="errortext">We found the following problems while attempting to update the system:</strong> <br>  
     <table border="0" cellpadding="3" cellspacing="1">
	   <tr bgcolor="eeeee">
	     <td><strong>ProcedureID</strong></td>
		 <td><strong>Message</strong></td>
		 <td><strong>Value</strong></td>
	   </tr> 
	 <cfloop index="i" from="1" to="#ArrayLen(Error)#">
	   <tr>
          <td>#Error[i][1]#</td>
		  <td>#Error[i][2]#</td>
		  <td>#Error[i][3]#</td>
       </tr>
	 </cfloop>
   </table><br><br>
   <a href="javascript:history.go(-1);">Please go back and correct these errors</a>           
   </cfoutput>
  </cfif>
  
<cfelseif url.action EQ "DELETE">
	<!--- Check that the RepConfigID is being passed --->
    <cfif Not IsDefined("URL.SPID")>
	<br>
    <strong class="errortext">We found the following problems while attempting to delete the procedure:</strong> <br>  
     <table border="0" cellpadding="3" cellspacing="1">
	   <tr>
	     <td>We could not find the unique ID.</td>
	   </tr>
   </table><br><br>
   <a href="javascript:history.go(-1);">Please go back and correct these errors</a>   
	<cfelse>
	  <!--- Call the RepUpdate.DeleteConfig(RepConfigID) Method --->
      <cfset Delete = RepUpdate.DeleteConfig(URL.SPID)>
	</cfif>
	
	
</cfif>	  
<!--- </cfsilent> --->
<cfmodule template="#Application.tagpath#/ctags/footer.cfm"> 