<cfobject component="PMS.Com.Scheduling" name="Schedule">

<cfswitch expression="#URL.action#">
   <cfcase value="savemtg">
     <!--- Validate Form --->
	 
	 
	 <cfif form.startMeridian EQ "PM">
	   <cfset form.starthour = (form.starthour + 12)>
	 </cfif>
	 
	 <cfif form.endMeridian EQ "PM">
	   <cfset form.endhour = (form.endhour + 12)>
	 </cfif>
	 
	 <cfset thisDate = createdate(form.year, form.month, form.day)>
	 <cfset thisStartTime = createdatetime(form.year, form.month, form.day, form.StartHour, form.StartMinute, 0)>
	 <cfset thisEndTime = createdatetime(form.year, form.month, form.day, form.endHour, form.endMinute, 0)>
	 
	 <cfinvoke component="PMS.COM.Scheduling" method="CreateSchedule">
	    <cfinvokeargument name="PROJECTCODE" value="#Trim(form.project)#">
	    <cfinvokeargument name="MTGDATE" value="#CreateODBCDate(thisdate)#">
	    <cfinvokeargument name="STARTTIME" value="#thisStartTime#">
	    <cfinvokeargument name="ENDTIME" value="#thisEndTime#">
		<cfif len(trim(form.password)) GT 0>
	        <cfinvokeargument name="password" value="#trim(form.password)#">
		</cfif>
		<cfif len(trim(form.user2)) GT 0>
	        <cfinvokeargument name="USER2" value="#Trim(form.User2)#">
		</cfif>
		<cfif len(trim(form.user3)) GT 0>
	       <cfinvokeargument name="USER3" value="#form.User3#">
		</cfif>
		<cfinvokeargument name="COMMENTS" value="#trim(form.remarks)#">
	    <cfinvokeargument name="ADDEDBY" value="#Session.userinfo.rowid#">
	 </cfinvoke>
	  
	  <cflocation url="dsp_globalSchedule.cfm?month=#Month(thisdate)#&year=#Year(thisdate)#" addtoken="NO">
   </cfcase>
</cfswitch>