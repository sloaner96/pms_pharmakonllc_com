<!--- initialize the repupdate --->
<CFOBJECT COMPONENT="pms.com.repupdate"
          NAME="repupdate">
<cfflush interval="10">
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Rep Update Results" showCalendar="0">
		  
<cfparam name="error" default="0">
<!--- Check to see if the dates exist --->
<cfif Len(Trim(form.begindate)) EQ 0 OR Len(Trim(form.enddate)) EQ 0>
  <cfset error = 1>
</cfif>		
  

						
<br>          
<blockquote>
<cfflush interval="25">
<cfoutput>   
<font face="arial" size="-1">
<cfif IsDefined("form.projectcode") GT 0 AND Error EQ 0>
   <strong><cfif form.UpdateType EQ "RO">Roster<cfelse>CI</cfif> Rep Update for #DateFormat(now(), 'DDDD MMMM YYYY')# at #TimeFormat(now(), 'hh:mm tt')#</strong><br><br>
	<cfloop index="x" list="#form.ProjectCode#" delimiters=",">
	   <cfset ThisProgramConfig = RepUpdate.GetRepConfig(x, form.UpdateType)>
	   <cfif ThisProgramConfig NEQ "">
		   Running Update For #x#....<br>
		   
		   <cfset thisBeginDate = form.begindate>
		   <cfset thisEndDate = form.enddate>
		   <cfset thisUpdateType = form.UpdateType>

		   <cfset RunthisProcedure = RepUpdate.UpdateRepTables(x, ThisprogramConfig, thisbegindate, thisenddate, ThisUpdateType)>
		  
		   <cfif RunThisProcedure>
		     Update Complete for #x#<br>
		   <cfelse>
		    <strong style="color:##ff0000;"> Update Failed for #x#</strong><br>
			  
		   </cfif>
	   
	   <cfelse>
	       <font color="##cc0000">#x# does not have a procedure in place to update this program</font><br>
	   </cfif>
    <br></cfloop>
	<p><strong><a href="dsp_repupdate.cfm">Click Here</a> to go back and update more programs</strong></p>
   <cfelse>
       <p style="font-size:12px;color:##cc0000;"><img src="/Images/Error.gif" width="26" height="26" alt="An error occurred" border="0" align="absmiddle"> <strong>ERROR!</strong></p>
      <cfif Error EQ 1>
	    <strong style="color:##cc0000;">You must choose a start date and an end date for the programs you would like to update.</strong><br>
	  </cfif>
	  <cfif NOT IsDefined("form.projectcode")>
      	<strong style="color:##cc0000;">You must choose a program to update, please go back an click one program to update.</strong><br>
      </cfif>
	  <p><strong><a href="##" onclick="javascript:history.go(-1);">Click Here</a> to go back and correct these Errors.</strong></p>
   </cfif>	
   
</cfoutput>
</font>
</blockquote>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

