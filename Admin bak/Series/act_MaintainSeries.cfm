<!--- Initialize Series Admin Component --->
<CFOBJECT COMPONENT="pms.com.SeriesAdmin"
		   NAME="SeriesAdmin">
		   
<cfswitch expression="#URL.Action#">
  <cfcase value="ADD">
	
	<!--- Check Form for Errors --->
	  <!--- Check to see if a Pharmakon company is selected --->
	  <cfif Not IsDefined("form.company")>
	     <cflocation url="dsp_AddSeries.cfm?E=1" addtoken="NO">
	  <cfelse>
	      <cfif Len(Trim(form.company)) EQ 0>
		      <cflocation url="dsp_AddSeries.cfm?E=1" addtoken="NO">
		  </cfif>
	  </cfif>
	  
	  <!--- Check to see if a client is selected --->
	  <cfif Not IsDefined("form.client")>
	     <cflocation url="dsp_AddSeries.cfm?E=2" addtoken="NO">
	  <cfelse>
	      <cfif Len(Trim(form.client)) EQ 0>
		      <cflocation url="dsp_AddSeries.cfm?E=2" addtoken="NO">
		  </cfif>
	  </cfif>
	  
	  <!--- Check to see if a product is selected --->
	  <cfif Not IsDefined("form.products")>
	     <cflocation url="dsp_AddSeries.cfm?E=3" addtoken="NO">
	  <cfelse>
	      <cfif Len(Trim(form.products)) EQ 0>
		      <cflocation url="dsp_AddSeries.cfm?E=3" addtoken="NO">
		  </cfif>
	  </cfif>
	  
	  <!--- Check to see if a series Label is selected --->
	  <cfif Not IsDefined("form.Serieslabel")>
	     <cflocation url="dsp_AddSeries.cfm?E=4" addtoken="NO">
	  <cfelse>
	      <cfif Len(Trim(form.Serieslabel)) EQ 0>
		      <cflocation url="dsp_AddSeries.cfm?E=4" addtoken="NO">
		  </cfif>
	  </cfif>
	  
	  <!--- Check to see if a startDate is Defined, 
	        Start date is required, EndDate is not to allow for open ended  --->
	  <cfif Not IsDefined("form.seriesStartdate")>
	     <cflocation url="dsp_AddSeries.cfm?E=5" addtoken="NO">
	  <cfelse>
	      <cfif Len(Trim(form.seriesStartdate)) EQ 0>
		      <cflocation url="dsp_AddSeries.cfm?E=5" addtoken="NO">
		  </cfif>
	  </cfif>
	  
	<!--- Get NextSeriesID --->
	  <cfset nextCode = SeriesAdmin.GetSeriesCode(trim(form.company), trim(form.client), trim(form.products))>
	
	<!--- Insert Into DB --->
	  <cfinvoke component="pms.com.SeriesAdmin" method="AddSeriesCode" returnvariable="NewSeriesID">
	     	<cfinvokeargument name="SellingCompany" value="#Trim(form.company)#">
	  		<cfinvokeargument name="ClientCode" value="#trim(form.client)#">
	  		<cfinvokeargument name="productCode" value="#trim(form.products)#">
	  		<cfinvokeargument name="SeriesCode" value="#NextCode#">
	  		<cfinvokeargument name="Serieslabel" value="#trim(form.Serieslabel)#">
	  		<cfinvokeargument name="SeriesBegin" value="#CreateODBCDate(form.seriesStartdate)#">
	  		<cfif form.seriesEnddate NEQ "">
			   <cfinvokeargument name="SeriesEnd" value="#CreateODBCDate(form.seriesEnddate)#">
	        </cfif>
			<cfinvokeargument name="UserID" value="#Session.userInfo.RowID#">
	        
	  </cfinvoke>
	  
	<!--- Send to DSP_EditSeries.cfm Screen --->
	   <cflocation url="dsp_EditSeries.cfm?SeriesID=#NewSeriesID#" addtoken="NO">
  </cfcase>
  
  <cfcase value="EDITSERIES">
  
  </cfcase>
  
  <cfcase value="UPDATESERIESPROG">
     <cfif IsDefined("form.availPrograms")>
	    <cfloop index="i" list="#form.availPrograms#" delimiters=",">
		   <cfset UpdPrg = SeriesAdmin.InsertProgram(form.SeriesID, i)>
		</cfloop>
		<cflocation url="dsp_EditSeries.cfm?SeriesID=#form.SeriesID#" addtoken="NO">
	 <cfelse>
	    <cflocation url="dsp_EditSeries.cfm?SeriesID=#form.SeriesID#&E=1" addtoken="NO">
	 </cfif>
  </cfcase>
  <!--- /////////// DELETE PROGRAM FROM SERIESGROUP /////////// --->
  <cfcase value="DELETE">
     <cfset Deleteprog = SeriesAdmin.deleteProgram(URL.SeriesID, URL.SGroupID)>
	 <cflocation url="dsp_EditSeries.cfm?SeriesID=#URL.SeriesID#" addtoken="NO">
  </cfcase>
  
  <cfdefaultcase>
     <cflocation url="DSP_ViewSeries.cfm" addtoken="NO">
  </cfdefaultcase>
</cfswitch>