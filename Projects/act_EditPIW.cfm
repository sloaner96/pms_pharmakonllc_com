<!--- error check the form variables exist --->
 <cfobject name="projectUpdate" component="pms.com.projectUpdate">
<!--- Pass the Update Component the project code and the form structure --->
<cfset Error = ArrayNew(1)>
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Project Initiation WorkSheet for #session.project_code#" showCalendar="1">

<br>
<cfswitch expression="#form.section#">
  <!--- Main Project Information Worksheet Section --->
  <cfcase value="1">
     <cfif Len(trim(form.ProjStatus)) EQ 0>
	   <cfset x = ArrayAppend(Error, "Error! You must select a project status for this program")>
	 </cfif>
     <cfif Len(trim(form.corpName)) EQ 0>
	  <cfset x = ArrayAppend(Error, "Error! You must select a selling company for this program")>
	 </cfif>
	 <cfif Len(trim(form.accountExec)) EQ 0>
	   <cfset x = ArrayAppend(Error, "Error! You must select a account exec for this program")>
	 </cfif>
	 <cfif Len(trim(form.accountSupervisor)) EQ 0>
	  <cfset x = ArrayAppend(Error, "Error! You must select a account supervisor for this program")>
	 </cfif>
	 <cfif Len(trim(form.Client)) EQ 0>
	   <cfset x = ArrayAppend(Error, "Error! You must select a client for this program")>
	 </cfif>
	 <cfif Len(trim(form.Product)) EQ 0>
	   <cfset x = ArrayAppend(Error, "Error! You must select a product for this program")>
	 </cfif>
	 <cfif Len(trim(form.guidetopic)) EQ 0>
	   <cfset x = ArrayAppend(Error, "Error! You must enter a guide topic for this program")>
	 </cfif>
	 <cfif Len(trim(form.guidetopic)) LT 5>
	   <cfset x = ArrayAppend(Error, "Error! You must enter a guide topic for this program and the topic must be greater than 5 characters long.")>
	 </cfif>
	 
	 <cfif Len(trim(form.ProjProgramStart)) EQ 0>
	   <cfset x = ArrayAppend(Error, "Error! You must enter a Projected start date for this program")>
	 </cfif>
	 <cfif Len(trim(form.ProgramEnd)) EQ 0>
	   <cfset x = ArrayAppend(Error, "Error! You must enter a Projected end date for this program")>
	 </cfif>
	 <cfif Len(trim(form.Recruiter)) EQ 0>
	   <cfset x = ArrayAppend(Error, "Error! You must select a recruiter for this program")>
	 </cfif>
	 
	 <cfif ArrayLen(Error) EQ 0>
         <cfset ThisUpdate = projectupdate.UpdatePIWSectionOne(session.Project_code, form)>
     <cfelse>
	    <cfoutput>
	    <table border="0" cellpadding="4" cellspacing="0" width="100%">
          <tr>
		    <td>The following issues were found while attempting to save your PIW.</td>
		  </tr>
		  <cfloop index="e" from="1" to="#ArrayLen(Error)#">
		     <tr>
                <td style="color:##cc0000;"><li><strong>#Error[e]#</strong></td>
             </tr>
		  </cfloop>
		    <tr>
			  <td><strong>Please <a href="##" onclick="javascript:history.go(-1);">go back</a> an correct this issue</strong></td>
			</tr>
        </table>           
	    </cfoutput>
	   <cfmodule template="#Application.tagpath#/ctags/footer.cfm"> 
	   <cfabort>
	 </cfif>
  </cfcase>
  
  <!--- Project/Program Section --->
  <cfcase value="2">
     <cfif Len(trim(form.programParticpants)) EQ 0>
	   <cfset x = ArrayAppend(Error, "Error! You must enter the number of participants per program")>
	 </cfif>
	 <cfif Len(trim(form.MeetingNumber)) EQ 0>
	   <cfset x = ArrayAppend(Error, "Error! You must enter the number of meetings per program")>
	 </cfif>
	 <cfif Len(trim(form.TargetParticipant)) EQ 0>
	   <cfset x = ArrayAppend(Error, "Error! You must enter the meeting participant target")>
	 </cfif>
	 <cfif Len(trim(form.ParticipantRecruit)) EQ 0>
	   <cfset x = ArrayAppend(Error, "Error! You must enter the meeting participant recruit")>
	 </cfif>
	 <cfif Len(trim(form.ProgLengthHrs)) EQ 0>
	   <cfset x = ArrayAppend(Error, "Error! You must enter the program length hours. If it is less than 1 hour enter 0.")>
	 </cfif>
	 <cfif Len(trim(form.ProgLengthMin)) EQ 0>
	   <cfset x = ArrayAppend(Error, "Error! You must enter the program length minutes. If it is 0 enter 0.")>
	 </cfif>
	 <cfif Len(trim(form.attendeeHonoraria)) EQ 0>
	   <cfset x = ArrayAppend(Error, "Error! You must enter the attendee honoraria. If it is nothing enter 0.00")>
	 </cfif>
	 <cfif Len(trim(form.HonorariaType)) EQ 0>
	   <cfset x = ArrayAppend(Error, "Error! You must select a honororaria fullfillment vendor.")>
	 </cfif>
	 <cfif Len(trim(form.surveyComp)) EQ 0>
	   <cfset x = ArrayAppend(Error, "Error! You must enter the survey compensation.")>
	 </cfif>
	 <cfif Len(trim(form.SurveyCompType)) EQ 0>
	   <cfset x = ArrayAppend(Error, "Error! You must enter the survey compensation type.")>
	 </cfif>

	 
	 <cfif ArrayLen(Error) EQ 0>
        <cfset ThisUpdate = projectupdate.UpdatePIWSectionTwo(session.Project_code, form)>
	 <cfelse>
	    <cfoutput>
	    <table border="0" cellpadding="4" cellspacing="0" width="100%">
          <tr>
		    <td>The following issues were found while attempting to save your PIW.</td>
		  </tr>
		  <cfloop index="e" from="1" to="#ArrayLen(Error)#">
		     <tr>
                <td style="color:##cc0000;"><li><strong>#Error[e]#</strong></td>
             </tr>
		  </cfloop>
		    <tr>
			  <td><strong>Please <a href="##" onclick="javascript:history.go(-1);">go back</a> an correct this issue</strong></td>
			</tr>
        </table>           
	    </cfoutput>
	   <cfmodule template="#Application.tagpath#/ctags/footer.cfm"> 
	   <cfabort>
	 </cfif>
  </cfcase>
  
  <!--- Reporting Needs Section --->
  <cfcase value="3">
     <cfset ThisUpdate = projectupdate.UpdatePIWSectionThree(session.Project_code, form)>
  </cfcase>
  
  <!--- Creative Services Information Section --->
  <cfcase value="4">
     <cfif IsDefined("AllowOnline")>
	     <!--- If the Guidebook File is there upload it --->
		 <cfif Len(Trim(form.GuidebookFile)) GT 0>
		    <cffile action="UPLOAD" 
			    filefield="form.guidebookfile" 
				destination="#application.SitePath#\Uploads\onlineMaterials" 
				nameconflict="MAKEUNIQUE">
		    <cfset GuidebookFileName= file.serverfile>  
		 </cfif>
		 
		 <!--- If the Guidebook File is there upload it --->
		 <cfif Len(Trim(form.ModeratorGuidefile)) GT 0>
		    <cffile action="UPLOAD" 
			    filefield="form.ModeratorGuidefile" 
				destination="#application.SitePath#\Uploads\onlineMaterials" 
				nameconflict="MAKEUNIQUE">
			<cfset ModeratorGuidefileName= file.serverfile> 
		 </cfif>
		 
		 <!--- If the Guidebook File is there upload it --->
		 <cfif Len(Trim(form.AdminGuidefile)) GT 0>
		    <cffile action="UPLOAD" 
			    filefield="form.AdminGuidefile" 
				destination="#application.SitePath#\Uploads\onlineMaterials" 
				nameconflict="MAKEUNIQUE">
			<cfset AdminGuidefileName= file.serverfile> 
		 </cfif>
	 </cfif>
	 <!--- Invoke the project Update component and pass the form variables to it --->
	 <cfinvoke component="pms.com.projectupdate" 
	           method="UpdatePIWSectionFour" 
			   returnvariable="ThisUpdate">
		   <cfinvokeargument name="projectCode" value="#Session.Project_Code#">
		   <cfif Len(Trim(form.ModDiscGuideDate)) GT 0>
		     <cfinvokeargument name="ModGuideDate" value="#form.ModDiscGuideDate#">
		   </cfif>
		   
		   <cfif Len(Trim(form.AdminMaterialsDate)) GT 0>
		       <cfinvokeargument name="AdminMatDate" value="#form.AdminMaterialsDate#">
		   </cfif>
		   
		   <cfif Len(Trim(form.GuidebookDate)) GT 0>
		        <cfinvokeargument name="GuideBookDate" value="#form.GuidebookDate#">
		   </cfif>
		   
		   <cfif Len(Trim(form.ComponentsDate)) GT 0>
		        <cfinvokeargument name="ComponentsDate" value="#form.ComponentsDate#">
		   </cfif>
		   
		   <cfif IsDefined("form.guidebooknew")>
		     <cfinvokeargument name="guidebookNew" value="#form.guidebooknew#">
		   <cfelse>
		     <cfinvokeargument name="guidebookNew" value="0">	 
		   </cfif>
		   
		   <cfif IsDefined("form.guidebookRevised")>
		     <cfinvokeargument name="guidebookRevised" value="#form.guidebookRevised#">
		   <cfelse>
		   	 <cfinvokeargument name="guidebookRevised" value="0">
		   </cfif>
		   
		   <cfif IsDefined("form.guidebookcharts")>
		     <cfinvokeargument name="guidebookCharts" value="#form.guidebookcharts#">
		   <cfelse>
		     <cfinvokeargument name="guidebookCharts" value="0">	 
		   </cfif>
		   
		   <cfif IsDefined("form.GuideBookReviseWording")>
		     <cfinvokeargument name="ReviseWording" value="#form.GuideBookReviseWording#">
		   <cfelse>
		     <cfinvokeargument name="ReviseWording" value="0">	 
		   </cfif>
		   
		   <cfif IsDefined("form.guidebookChartRevised")>
		     <cfinvokeargument name="reviseCharts" value="#form.guidebookChartRevised#">
		   <cfelse>
		   	 <cfinvokeargument name="reviseCharts" value="0">
		   </cfif>
		   
		   <cfif IsDefined("form.guidebooknewcharts")>
		     <cfinvokeargument name="newCharts" value="#form.guidebooknewcharts#">
		   <cfelse>
		     <cfinvokeargument name="newCharts" value="0">	 
		   </cfif>
		   
		   <cfinvokeargument name="SpecialInstr" value="#form.SpecialInstructions#">
		   
		   <cfif IsDefined("AllowOnline")>
		     <cfinvokeargument name="AllowOnline" value="#form.AllowOnline#">
		     <cfinvokeargument name="GuideBookFile" value="#GuidebookFileName#">
		     <cfinvokeargument name="ModGuideFile" value="#ModeratorGuidefileName#">
		     <cfinvokeargument name="AdminGuideFile" value="#AdminGuidefileName#">
	       </cfif>
		    
	 </cfinvoke>
  </cfcase>
  
  <!--- Recruiting Information Section --->
  <cfcase value="5">
    <cfinvoke component="pms.com.projectupdate" 
	           method="UpdatePIWSectionFive" 
			   returnvariable="ThisUpdate">
			   
		   <cfinvokeargument name="projectCode" value="#Session.Project_Code#">
		   <cfinvokeargument name="RecruitMailingInfo" Value="#form.RecruitMailingInfo#">
		   <cfinvokeargument name="AddtionalInfo" Value="#form.AddtionalInfo#">
		   <cfinvokeargument name="DirectMailInfo" Value="#form.DirectMailInfo#">
		   <cfinvokeargument name="MrktDrugInfo" Value="#form.MrktDrugInfo#">
		   <cfinvokeargument name="MrktDrugScript" Value="#form.MrktDrugScript#">	
		   
		   <cfif ISDefined("form.repnom")>
		       <cfinvokeargument name="repnom" Value="#form.repnom#">
		   <cfelse>
		       <cfinvokeargument name="repnom" Value="0">	   
		   </cfif>
		   
		   <cfif ISDefined("form.PAOK")>
		      <cfinvokeargument name="PAOK" Value="#form.PAOK#">
		   <cfelse>
		       <cfinvokeargument name="PAOK" Value="0">		  
		   </cfif>
		   
		   <cfif ISDefined("form.NPOK")>
		      <cfinvokeargument name="NPOK" Value="#form.NPOK#">
		   <cfelse>
		       <cfinvokeargument name="NPOK" Value="0">		  
		   </cfif>
		   
		   <cfif ISDefined("form.OTHEROK")>
		      <cfinvokeargument name="OTHEROK" Value="#form.OTHEROK#">
		   <cfelse>
		       <cfinvokeargument name="OTHEROK" Value="0">		  
		   </cfif>
		   
		   <cfinvokeargument name="OtherDesc" Value="#form.OtherDesc#">
		    
	 </cfinvoke>
  </cfcase>
</cfswitch>

<cfif ThisUpdate EQ "">
  <cflocation url="dsp_reportPIW.cfm?project_code=#Session.Project_code#" addtoken="No">
<cfelse>
	<!--- If there is a problem, throw a message and kick the back to the previous page --->
	<br>There was a problem with the following field(s):<br><br>
	<cfoutput><strong class="errorText">#ThisUpdate#</strong></cfoutput>
	<br><br>
	Please <a href="##" onclick="javascript:history.go(-1);">go back</a> an correct this issue
	<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
</cfif>
