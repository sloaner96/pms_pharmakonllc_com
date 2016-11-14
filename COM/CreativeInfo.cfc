<cfcomponent displayname="CreativeInfo" hint="This Component is used for the Creative Services Admin">

   <!--- lock name is the name used to wrap file io/data ops --->
	<cfset LOCK_NAME = "repupdate_cfc">

   <!--- Constructor --->
	 <cfset init()>
	
   <!--- Create Instance Structure --->
	  <cfset instance = StructNew()>
	  
   <!--- Initialize datasources --->
	<cfset instance.rosterdsn = "PMS">
	
	<cfset instance.SaveToPath = "c:\InetPub\wwwroot\pms_pharmakonllc_com\Uploads\OnlineMaterials">
	
	<cfsetting requesttimeout="1000">
    
	 <!---------------------------- 
      Initialize the component 
     --------------------------->
	 <cffunction name="init" output="true" returnType="boolean" access="public">
	   <cfset instance.initialized = true>
	   <cfreturn instance.initialized />
     </cffunction>
	 
	 <!---------------------------- 
      
     --------------------------->
	 <cffunction name="GetActivePrograms" returnType="query" access="public">
	   <cfquery name="getPrograms" datasource="#instance.rosterdsn#">
	     Select *
		 From client_proj
		 Where Status IN (1,2,3)
		 Order BY client_code, client_proj, status
	   </cfquery>
	   
	   <cfreturn getPrograms />
     </cffunction>
	 
	 <!---------------------------- 
      Get the Creative Info
     --------------------------->
	 <cffunction name="getCreativeInfo" returnType="query" access="public">
	   <cfargument name="programCode" type="String" required="YES">
	   <cfquery name="getCreativeInfo" datasource="#instance.rosterdsn#">
	     Select *
		 From Materials_Info
		 Where projectcode = '#Arguments.programCode#'
		 Order By ProjectCode, MaterialType, LastSync
	   </cfquery>
	   
	   <cfreturn getCreativeInfo />
     </cffunction>
	 
	 <!---------------------------- 
      Add the Creative Info
     --------------------------->
	 <cffunction name="AddCreativeInfo" returnType="string" access="public">
	   <cfargument name="ProjectCode" type="string" required="YES">
	   <cfargument name="MaterialTitle" type="string" required="YES">
	   <cfargument name="MaterialType" type="string" required="YES">
	   <cfargument name="FileName" type="string" required="YES">
	   <cfargument name="FileSize" type="numeric" required="YES">
	   <cfargument name="MaterialDesc" type="string" required="NO">
	   <cfargument name="addedBy" type="numeric" required="YES">
	   <cfset Msg = "">
	   
	   <cfquery name="addCreativeInfo" datasource="#instance.rosterdsn#">
	     Insert Into Materials_info(
		         ProjectCode,
				 MaterialTitle,
				 MaterialType,
				 FileName,
				 FileSize,
				 MaterialDesc,
				 DateAdded,
				 addedBY
			   )
		  VALUES (
		         '#Arguments.ProjectCode#',
				 '#Arguments.MaterialTitle#',
				 '#Arguments.MaterialType#',
				 '#Arguments.FileName#',
				 '#Arguments.FileSize#',
				 '#Arguments.MaterialDesc#',
				 #CreateODBCDateTime(NOW())#,
				 #Arguments.addedBy#
		  )	     
	   </cfquery>
	   
	   <cfreturn Msg />
     </cffunction>
	 
	 <!---------------------------- 
      Update Creative Info
     --------------------------->
	 <cffunction name="updateCreativeInfo" returnType="string" access="public">
	    <cfargument name="MaterialID" type="Numeric" required="YES">
	    <cfargument name="MaterialTitle" type="string" required="YES">
	    <cfargument name="MaterialType" type="string" required="YES">
	    <cfargument name="FileName" type="string" required="NO">
	    <cfargument name="FileSize" type="numeric" required="NO">
	    <cfargument name="MaterialDesc" type="string" required="NO">
	   <cfargument name="UpdatedBY" type="numeric" required="YES">
	   <cfset Msg = "">
	   
	   <cfquery name="UpdateCreative" datasource="#instance.rosterdsn#">
	     Update Materials_info
		    Set  MaterialTitle = '#Arguments.MaterialTitle#',
				 MaterialType = '#Arguments.MaterialType#',
				 <cfif IsDefined("Arguments.FileName")>FileName = '#Arguments.FileName#',</cfif>
				 <cfif IsDefined("Arguments.FileSize")>FileSize = '#Arguments.FileSize#',</cfif>
				 MaterialDesc = '#Arguments.MaterialDesc#',
				 LastUpdated = #CreateODBCDateTime(NOW())#,
				 UpdatedBY = #Arguments.UpdatedBy#
		    Where MaterialID =  #arguments.MaterialID#     
	   </cfquery>
	  <cfreturn Msg /> 
     </cffunction>
	 
	 <!---------------------------- 
      Delete the Creative Info
     --------------------------->
	 <cffunction name="DeleteCreativeInfo" returnType="string" access="public">
	   <cfargument name="MaterialID" type="Numeric" required="YES">
	   <cfargument name="programCode" type="String" required="YES">
	   
	   <cfset Msg = "">
	  
	   <cfset MaterialFile = getMaterialFiles(Arguments.MaterialID)>
	  
	  <cfset FilePath = "#lcase(instance.SaveToPath)#\#lcase(Trim(Arguments.ProgramCode))#\#MaterialFile.FileName#">
	   <cfif FileExists("#trim(FilePath)#")>
	     <cffile action="Delete" file="#trim(FilePath)#">
	   </cfif>
	   
	   <cfquery name="deleteCreativeInfo" datasource="#instance.rosterdsn#">
	    Delete From Materials_info
		Where MaterialID = #arguments.MaterialID#
	   </cfquery>
	   
	   
	   <cfreturn Msg />
     </cffunction>
	 
	 
	 <cffunction name="getMaterialFiles" access="public" returntype="query" displayname="getMeetingDates" description="This function retreives the Materials.">
      <cfargument name="MaterialID" type="string" required="YES">
	  
	  <cfquery name="getmaterialInfo" datasource="#instance.rosterdsn#">
	    SELECT M.*
		 From Materials_info M
		 Where MaterialID = #Arguments.MaterialID#
	  </cfquery>
	  
	  <cfreturn getmaterialInfo />
     </cffunction>
	 
	 
</cfcomponent>