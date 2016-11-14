<cfinclude template="/ajax/core/cfajax.cfm">
<cferror template="/ajax/error.cfm" type="exception">
<cffunction name="Clientlookup" returntype="array" hint="type='keyvalue' jsreturn='array'">
	<cfargument name="Company" required="yes" type="string">
	
	<cfset getClients = request.util.getCompanyClients(arguments.Company)> 
	
	    <cfset model = ArrayNew(1)>
		<cfloop query="getClients">
			<cfset ArrayAppend(model, "#trim(getClients.client_abbrev)#,#trim(getClients.client_name)#")>
		</cfloop> 
		
		<cfreturn model />
</cffunction>

<cffunction name="getclient" returntype="array" hint="type='keyvalue' jsreturn='array'">
	<cfargument name="Company" required="yes" type="string">
	
	<cfset getClients = request.util.getCompanyClients()> 
	
	    <cfset model = ArrayNew(1)>
		<cfloop query="getClients">
			<cfset ArrayAppend(model, "#trim(getClients.client_abbrev)#,#trim(getClients.client_name)#")>
		</cfloop> 
		
		<cfreturn model />
</cffunction>

<cffunction name="getallclients" returntype="array" hint="type='keyvalue' jsreturn='array'">
	<cfargument name="Company" required="yes" type="string">
	
	<cfset getClients = request.util.getClients()> 
	
	    <cfset model = ArrayNew(1)>
		<cfloop query="getClients">
			<cfset ArrayAppend(model, "#trim(getClients.client_abbrev)#,#trim(getClients.client_name)#")>
		</cfloop> 
		
		<cfreturn model />
</cffunction>


<cffunction name="Serieslookup" returntype="array" hint="type='keyvalue' jsreturn='array'">
	<cfargument name="Company" required="yes" type="string">
	<cfargument name="Client" required="yes" type="string">
	
	<cfinvoke component="pms.com.projects" method="getClientSeries" returnvariable="getSeries">
		<cfinvokeargument name="SellingCompany" value="#Arguments.Company#">
		<cfinvokeargument name="ClientCode" value="#Arguments.Client#">
	</cfinvoke> 
	
	    <cfset seriesArray = ArrayNew(1)>
		<cfif getSeries.recordcount GT 0>
			 <cfloop query="getSeries">
				<cfset ArrayAppend(seriesArray, "#Trim(getSeries.SeriesID)#,#Trim(getSeries.SeriesLabel)#")>
			</cfloop>
		<cfelse>
		  	<cfset ArrayAppend(seriesArray, "0, No Results")>
	    </cfif>
		    		
		
		<cfreturn seriesArray />
</cffunction>

<cffunction name="programlookup" returntype="array" hint="type='keyvalue' jsreturn='array'">
	<cfargument name="Series" required="yes" type="numeric">
	
	<cfinvoke component="pms.com.projects" method="getSeriesPrograms" returnvariable="getPrograms">
		<cfinvokeargument name="SeriesID" value="#Arguments.Series#">
		<!--- <cfinvokeargument name="Status" value="3"> --->
	</cfinvoke> 
	
	    <cfset programArray = ArrayNew(1)>
		    
			<cfif getPrograms.recordcount GT 0>
				<cfloop query="getPrograms">
					<cfset ArrayAppend(programArray, "#Trim(getPrograms.project_code)#,#Trim(getPrograms.project_code)#")>
				</cfloop>
			<cfelse>
			
			   	<cfset ArrayAppend(programArray, "0, No Programs available")>
            </cfif>
		    		
		
		<cfreturn programArray />
</cffunction>

<cffunction name="Productlookup" returntype="array" hint="type='keyvalue' jsreturn='array'">
	<cfargument name="client" required="yes" type="string">
	<cfset productArray = ArrayNew(1)>
	<cfinvoke component="pms.com.Utilities" method="getClientProducts" returnvariable="getProduct">
		<cfinvokeargument name="ClientCode" value="#trim(Arguments.Client)#">
	</cfinvoke>  
	
	    
		    
			<cfif getProduct.recordcount GT 0>
				<cfloop query="getProduct">
					<cfset ArrayAppend(productArray, "#Trim(getProduct.product_code)#,#Trim(getProduct.product_description)#")>
				</cfloop>
			<cfelse>
			
			   	<cfset ArrayAppend(productArray, "0, No Products available")>
            </cfif>
		    		
		
		<cfreturn productArray />
</cffunction>

<!--- <cffunction name="SeriesStatus" returntype="array" hint="type='keyvalue' jsreturn='array'">
	<cfargument name="Series" required="yes" type="numeric">
	
	 <cfset DSeriesStatus = request.projects.getDistinctSeries(Arguments.Series)>
	
	    <cfset seriesStatusArray = ArrayNew(1)>

		<cfif DSeriesStatus.recordcount GT 0>
			 <cfloop query="DSeriesStatus">
				<cfset ArrayAppend(seriesStatusArray, "#Trim(DSeriesStatus.status)#,#Trim(DSeriesStatus.StatusDesc)#")>
			</cfloop>
		<cfelse>
		  	<cfset ArrayAppend(seriesStatusArray, "0, No Results")>
	    </cfif>
		    		
		
		<cfreturn seriesStatusArray />
</cffunction>
 --->