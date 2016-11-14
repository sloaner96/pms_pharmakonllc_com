<cfset SaveToPath = "#Application.sitepath#\Uploads\OnlineMaterials">
<cfif URL.Action EQ "ADD">
  <cfif Len(trim(Form.MatTitle)) EQ 0>
    <cflocation url="DSP_AddCreativeMaterials.cfm?E=1&PID=#form.ProjectID#" addtoken="NO">
  </cfif>
  
  <cfif Len(trim(Form.MatType)) EQ 0>
    <cflocation url="DSP_AddCreativeMaterials.cfm?E=2&PID=#form.ProjectID#" addtoken="NO">
  </cfif>
  
  <cfif Len(trim(Form.FileToLoad)) EQ 0>
    <cflocation url="DSP_AddCreativeMaterials.cfm?E=3&PID=#form.ProjectID#" addtoken="NO">
  </cfif>
  
   <cfif NOT DirectoryExists("#SaveToPath#\#trim(Form.ProjectID)#\")>
	   	<cfdirectory action="CREATE" directory="#SaveToPath#\#trim(Form.ProjectID)#\"> 
   </cfif>
  
  <cffile action="UPLOAD" 
          filefield="form.FileToLoad" 
		  destination="#SaveToPath#\#trim(Form.ProjectID)#\"
		  nameconflict="MAKEUNIQUE">
		  
	<cfset OldFileName = File.ServerFile>
	<cfset ThisFileSize = File.FileSize>
	
	<cfset FileNameWithoutExtension = ReplaceNocase(OldFileName, ".pdf", "", "ALL")>
	<cfset NewFileName = ReplaceList(FileNameWithoutExtension, '-, ,_,(,),##,!,$,%,&,*,~,`,.', '')>  
   		  
	<cfif len(NewFileName) GT 145>
	   <cfset newFileName = Left(NewFileName, 145) & ".pdf">
	<cfelse>
	    <cfset newFileName = NewFileName & ".pdf">   
	</cfif>	  
	
	<cffile action="RENAME" 
	        source="#SaveToPath#\#trim(Form.ProjectID)#\#OldFileName#" 
			destination="#SaveToPath#\#trim(Form.ProjectID)#\#NewFileName#">
	
   <cfinvoke component="PMS.COM.CreativeInfo" method="AddCreativeInfo" returnvariable="AddedInfo">
      <cfinvokeargument name="ProjectCode" value="#trim(Form.ProjectID)#">
	  <cfinvokeargument name="MaterialTitle" value="#trim(form.MatTitle)#">
	  <cfinvokeargument name="MaterialType" value="#trim(form.MatType)#">
	  <cfinvokeargument name="FileName" value="#newFileName#">
	  <cfinvokeargument name="FileSize" value="#ThisFileSize#">
	  <cfinvokeargument name="MaterialDesc" value="#Trim(form.MaterialDesc)#">
	  <cfinvokeargument name="addedBy" value="#session.userinfo.rowid#">
	  
   </cfinvoke>    
   
   <cflocation url="dsp_adminCreative.cfm?PID=#form.ProjectID#" addtoken="NO">
<cfelseif URL.Action EQ "UPDATE">
	  <cfif Len(trim(Form.MatTitle)) EQ 0>
	    <cflocation url="DSP_EditCreativeMaterials.cfm?E=1" addtoken="NO">
	  </cfif>
	  
	  <cfif Len(trim(Form.MatType)) EQ 0>
	    <cflocation url="DSP_EditCreativeMaterials.cfm?E=2" addtoken="NO">
	  </cfif>
	  
	  <cfif len(trim(form.FileToLoad)) GT 0>
		   <cfif NOT DirectoryExists("#SaveToPath#\#trim(Form.ProjectID)#\")>
		   	   <cfdirectory action="CREATE" directory="#SaveToPath#\#trim(Form.ProjectID)#\"> 
	       </cfif>
	  
	        <cffile action="UPLOAD" 
	            filefield="form.FileToLoad" 
			    destination="#SaveToPath#\#trim(Form.ProjectID)#\#trim(Form.ProjectID)#\"
			    nameconflict="MAKEUNIQUE">
				  
			 <cfset OldFileName = File.ServerFile>
			 <cfset ThisFileSize = File.FileSize>
			
			 <cfset FileNameWithoutExtension = ReplaceNocase(OldFileName, ".pdf", "", "ALL")>
			 <cfset NewFileName = ReplaceList(OldFileName, '-, ,_,(,),##,!,$,%,&,*,~,`,.', '')>	  
		   		  
			 <cfif len(NewFileName) GT 145>
			   <cfset newFileName = Left(NewFileName, 145) & ".pdf">
			 <cfelse>
			    <cfset newFileName = NewFileName & ".pdf">   
			 </cfif>	 
		  
		  
		  <cffile action="RENAME" 
		        source="#SaveToPath#\#trim(Form.ProjectID)#\#OldFileName#" 
				destination="#SaveToPath#\#trim(Form.ProjectID)#\#NewFileName#">
	   </cfif>
	   <cfinvoke component="PMS.COM.CreativeInfo" method="UpdateCreativeInfo" returnvariable="UpdatedInfo">
		  <cfinvokeargument name="MaterialID" value="#trim(Form.MaterialID)#">
		  <cfinvokeargument name="MaterialTitle" value="#trim(form.MatTitle)#">
		  <cfinvokeargument name="MaterialType" value="#trim(form.MatType)#">
		  <cfinvokeargument name="UpdatedBy" value="#session.userinfo.rowid#">
		  <cfif len(trim(form.FileToLoad)) GT 0>
			  <cfinvokeargument name="FileName" value="#newFileName#">
			  <cfinvokeargument name="FileSize" value="#ThisFileSize#">
		  </cfif>
		  
		  <cfinvokeargument name="MaterialDesc" value="#Trim(form.MaterialDesc)#">
	   </cfinvoke>  
	   <cflocation url="dsp_adminCreative.cfm?PID=#Form.projectCode#" addtoken="NO">
<cfelseif action EQ "DELETE">
   <cfobject name="CreativeInfo" component="PMS.COM.CreativeInfo">
   <cfset DeleteCreativeInfo = CreativeInfo.deleteCreativeInfo(URL.MaterialID, URL.ProjectCode)>	
   <cflocation url="dsp_adminCreative.cfm?PID=#URL.ProjectCode#" addtoken="NO">   
</cfif>
