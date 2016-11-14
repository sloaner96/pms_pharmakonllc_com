<cfcomponent>
      
   <!--- lock name is the name used to wrap file io/data ops --->
	<cfset LOCK_NAME = "seriesadmin_cfc">

	<cfset instance = StructNew()>
				
	<!--- Initialize datasources --->
	<cfset instance.projdsn = "pms">
	<cfset instance.rosterdsn = "CBARoster">
	
	<!--- Constructor --->
	<cfset init()>
	
   <!---************************* 
      Initialize the component 
     ************************--->
   <cffunction name="init" returnType="boolean" access="public"
				hint="Handles initialization.">
	      <cfset instance.initialized = true>
	      <cfreturn instance.initialized />
   </cffunction>
     <!---************************* 
      Initialize the component 
     ************************--->
	 
   <cffunction name="AddSeriesCode" returnType="numeric" access="public">
	  <cfargument name="SellingCompany" required="YES" type="String">
	  <cfargument name="ClientCode" required="YES" type="String">
	  <cfargument name="productCode" required="YES" type="String">
	  <cfargument name="SeriesCode" required="YES" type="String">
	  <cfargument name="Serieslabel" required="YES" type="String">
	  <cfargument name="SeriesBegin" required="YES" type="date">
	  <cfargument name="SeriesEnd" required="NO" type="date">
	  <cfargument name="userId" required="YES" type="Numeric">
	  
	  <cfquery name="InsertSeries" datasource="#instance.projdsn#">
	    SET NOCOUNT ON
		Insert Into ProgramSeries(
		    SellingCompany,
		    ClientCode,
		    ProductCode,
		    SeriesCode,
		    SeriesLabel,
		    SeriesBegin,
		    SeriesEnd,
		    DateCreated,
		    UpdatedBy
		 )
		 VALUES(
		    '#Arguments.SellingCompany#',
		    '#Arguments.ClientCode#',
		    '#Arguments.productCode#',
		    '#Arguments.SeriesCode#',
			'#Arguments.SeriesLabel#',
		     #CreateODBCDateTime(Arguments.SeriesBegin)#,
			 <cfif IsDefined("Arguments.SeriesEnd")>
		     #CreateODBCDateTime(Arguments.SeriesEnd)#,
			 <cfelse>
			  NULL,
			 </cfif>
		     #CreateODBCDateTime(now())#,
		     #Arguments.userID#
		 )
		 SELECT @@Identity as NewSeriesID
		 SET NOCOUNT OFF
	  </cfquery>
	  
	  <cfreturn InsertSeries.NewSeriesID/>
   </cffunction>
   
   <cffunction name="GetSeriesCode" returnType="String" access="public">
	  <cfargument name="SellingCompany" required="YES" type="String">
	  <cfargument name="ClientCode" required="YES" type="String">
	  <cfargument name="productCode" required="YES" type="String">
	  
	  <cfset var NewSeriesCode = "">
	  
	  <cfquery name="GetSeries" datasource="#instance.projdsn#">
	    Select Max(SeriesCode) as lastCode
		  From programSeries
		  WHERE SellingCompany =  '#Arguments.SellingCompany#'
		  AND   ClientCode     =  '#Arguments.ClientCode#'
		  AND   ProductCode    =  '#Arguments.productCode#'
	  </cfquery>
	  
	  <cfif getseries.recordcount GT 0 AND getSeries.LastCode NEQ "">
	    <cfset NewSeriesCode = NumberFormat((getSeries.lastCode) + 1, 000)>
	  <cfelse>
	    <cfset NewSeriesCode = NumberFormat(001, 000)>	
	  </cfif>
	   <cfreturn NewSeriesCode />
   </cffunction>
   
   <cffunction name="GetSeriesInfo" returnType="Query" access="public">
     <cfargument name="SeriesID" required="Yes" Type="Numeric">
	  
	  <cfset var SeriesInfo = "">
	  
	  <cfquery name="SeriesInfo" datasource="#instance.projdsn#">
	    Select *
		From ProgramSeries
		Where SeriesID = #Arguments.SeriesID#
	  </cfquery>
	  
	   <cfreturn SeriesInfo />
   </cffunction>
   
   <cffunction name="GetSeriesPrograms" returnType="Query" access="public">
     <cfargument name="SeriesID" required="Yes" Type="Numeric">
	  
	  <cfset var SeriesProgInfo = "">
	  
	  <cfquery name="SeriesProgInfo" datasource="#instance.projdsn#">
	    Select G.SeriesCode, G.SeriesGroupID, P.RowID, rtrim(P.project_code) as ProjectCode
		From ProgramSeriesGroup G, PIW P
		Where G.ProgramID = P.RowID
		AND G.SeriesCode = #Arguments.SeriesID#
		order By P.Project_Code
	  </cfquery>
	  
	   <cfreturn SeriesProgInfo />
   </cffunction>
   
   <cffunction name="GetEligibleProg" returnType="Query" access="public">
     <cfargument name="SeriesID" required="Yes" Type="Numeric">
	  
	  <cfset var SeriesEInfo = "">
	  
	  <cfquery name="SeriesEInfo" datasource="#instance.projdsn#">
	    Select P.RowID, rtrim(P.project_code) as ProjectCode
		From ProgramSeries S, PIW P
		Where S.SeriesID                    = #Arguments.SeriesID#
		AND Left(P.Project_Code, 1)         = S.SellingCompany
		AND substring(P.Project_code, 2, 2) = S.ClientCode
		AND substring(P.Project_code, 4, 2) = S.ProductCode
		AND P.RowID NOT IN (Select ProgramID
	               FROM ProgramSeriesGroup G
	                         WHERE SeriesCode = S.SeriesID)
	  </cfquery>
	  
	   <cfreturn SeriesEInfo />
   </cffunction>
   
   <cffunction name="deleteProgram" returnType="void" access="public">
     <cfargument name="SeriesID" required="Yes" Type="Numeric">
	 <cfargument name="GroupID" required="Yes" Type="Numeric">

	  <cfquery name="SeriesEInfo" datasource="#instance.projdsn#">
	    Delete From ProgramSeriesGroup
		Where SeriesCode = #Arguments.SeriesID#
		AND SeriesGroupID = #Arguments.GroupID#
	  </cfquery>

   </cffunction>
   
   <cffunction name="InsertProgram" returnType="void" access="public">
     <cfargument name="SeriesID" required="Yes" Type="Numeric">
	 <cfargument name="programID" required="Yes" Type="Numeric">

	  <cfquery name="insertInfo" datasource="#instance.projdsn#">
	    Insert Into ProgramSeriesGroup(SeriesCode, ProgramID)
	    Values(#Arguments.SeriesID#, #Arguments.programID#)
	  </cfquery>

   </cffunction>
   
</cfcomponent>