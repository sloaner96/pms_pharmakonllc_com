<!--- THIS IS STEP 1 --->
<font size="-2" face="verdana">
<!--- <cfquery name="DeleteSeriesLoad" datasource="PMS">
  Delete from SeriesLoad
</cfquery>
<cfquery name="DeletePrgmLoad" datasource="PMS">
  Delete from ProgramSeries
</cfquery>


<!--- Create Program Series --->
<cfquery name="GetProjects" datasource="PMS">
  Select rowID, client_code, project_code, recruit_start, program_start, program_end, proj_program_start
  From PIW
  Order By client_code, project_code, recruit_start, program_end
</cfquery>

<cfoutput><strong>Pulled #GetProjects.recordcount#</strong><br /></cfoutput>

<cfoutput query="GetProjects">
  <cfif trim(len(GetProjects.project_code)) GT 0>
     
	  <cfset SellingCompany = left(trim(GetProjects.project_code), 1)> 
	  <cfset ClientCode = Mid(Trim(GetProjects.project_code), 2,2)> 
	  <cfset productCode = Mid(trim(GetProjects.project_code), 4,2)>
	  <cfset ProgramType = right(Trim(GetProjects.project_code), 2)>
	 Adding  SeriesLoad #GetProjects.project_code#<br>
	  <cfquery name="InsertProj" datasource="PMS">
	    Insert Into SeriesLoad(
		   SellingCompany, 
		   ClientCode, 
		   productCode,
		   programtype, 
		   projectCode,
		   PIWClientCode, 
		   RecruitStart, 
		   ProgramEnd,
		   ProjRowID
		   )
		Values(
		   '#SellingCompany#', 
		   '#ClientCode#', 
		   '#ProductCode#', 
		   '#ProgramType#',
		   '#GetProjects.project_code#',
		   '#GetProjects.Client_Code#', 
		   <cfif IsDate(getProjects.proj_program_start)>
		      #createODBCDateTime(getProjects.proj_program_start)#
		   <cfelseif Not IsDate(getProjects.proj_program_start) AND ISDate(getProjects.recruit_start)>
		      #createODBCDateTime(getProjects.recruit_start)#
		   <cfelseif Not IsDate(getProjects.recruit_start) AND ISDate(getProjects.program_start)>
		   	  #createODBCDateTime(getProjects.program_start)# 
		   <cfelse>
			  NULL	  
		   </cfif>,
		   <cfif IsDate(getProjects.program_end)>
		      #createODBCDateTime(getProjects.program_end)#,
		   <cfelse>
		     NULL	,  
		   </cfif> 
		    #getProjects.RowID#
		    )
	  </cfquery>
  </cfif>
</cfoutput> --->
<!--- 
<!--- STEP 2 --->
<cfquery name="getSeries2" datasource="PMS">
  Select ProjID, SellingCompany+''+ClientCode+''+ProductCode+''+SeriesCode as newcode 
  From SeriesLoad
  order By ProjID
</cfquery>

<cfoutput>#getSeries2.Recordcount# Series Pulled<br></cfoutput>
<cfdump var="#getSeries2#">
 
<cfoutput query="getSeries2">
   <cfquery name="NewSeries2" datasource="PMS">
     Update dbo.SeriesLoad
	 Set NewSeriesCode = '#trim(getSeries2.newcode)#'
	 Where projID = #getSeries2.ProjID#
   </cfquery>
</cfoutput>
 --->
 <!--- STEP THREE --->
<!--- <cfquery name="getSeries2" datasource="PMS">
Select Distinct NewSeriesCode
From SeriesLoad
</cfquery> 

<cfoutput>#getSeries2.recordcount#</cfoutput>

<cfdump var="#getSeries2#">


<cfoutput query="getSeries2">
	<!--- Insert Codes Into ProgramSeries Table --->
	<cfquery name="CreateProdSeries" datasource="PMS">
	  Insert Into ProgramSeries(
	      SellingCompany, 
		  ClientCode, 
		  ProductCode, 
		  SeriesCode
		  )
	  Values(
	    '#Left(getSeries2.NewSeriesCode, 1)#', 
		'#Mid(getSeries2.NewSeriesCode, 2, 2)#', 
		'#Mid(getSeries2.NewSeriesCode, 4, 2)#', 
		'#Right(getSeries2.NewSeriesCode, 3)#'
		)
	</cfquery>
</cfoutput> --->
<!--- 
<cfquery name="getSeries2" datasource="PMS">
Select S.SeriesID, S.SellingCompany, S.ClientCode, S.ProductCode,
  (Select Top 1 client_name
    From dbo.clients C
    Where C.client_abbrev = S.ClientCode) as ClientName,
  (Select Top 1 product_description
    From products P
    Where P.client_abbrev = S.ClientCode
     AND P.Product_Code = S.ProductCode) as ProductName
From programSeries S  
</cfquery>

<cfdump var="#getSeries2#">

<cfoutput query="getSeries2">
   <cfif getSeries2.ProductName NEQ "">
      <cfset ThisLabel = getSeries2.Clientname&Chr(32)&trim(getSeries2.productName)&chr(32)&"Series">
   <cfelse>
      <cfset ThisLabel = getSeries2.Clientname&Chr(32)&trim(getSeries2.ProductCode)&chr(32)&"Series">
   </cfif>	
	<!--- Insert Codes Into ProgramSeries Table --->
	<cfquery name="CreateProdSeries" datasource="PMS">
	  Update programSeries
	   Set SeriesLabel = '#thislabel#'
	   Where SeriesID = '#getSeries2.SeriesID#'
	</cfquery>
</cfoutput>   ---> 

<!---  <cfquery name="getProj" datasource="PMS">
	 Select S.SeriesID, L.ProjROWID
	 From SeriesLoad L, ProgramSeries S
	 Where (L.SellingCompany = S.SellingCompany
	 AND L.ClientCode = S.ClientCode
	 AND L.ProductCode = S.ProductCode
	 AND L.SeriesCode = S.SeriesCode)
</cfquery> 


<cfloop query="getProj">
  <cfquery name="CreateProdSeriesgroup" datasource="PMS">
	  Insert into dbo.ProgramSeriesGroup(SeriesCode, ProgramID)
	  VALUES(#getProj.SeriesID#, #getProj.ProjROWID#)
	</cfquery>
</cfloop> --->
<!---LAST STEP---> 

 <cfquery name="GetProjects" datasource="PMS">
Select MIN(RecruitStart) as StartDate,  Max(ProgramEnd) as EndDate, L.NewSeriesCode
From SeriesLoad L, ProgramSeries S
Where L.SellingCompany = S.SellingCompany
AND L.ClientCode = S.ClientCode
AND L.ProductCode = S.ProductCode
AND L.SeriesCode = S.SeriesCode
Group By NewSeriesCode
</cfquery>

<cfdump var="#getProjects#">
<cfloop query="getProjects">
    <cfquery name="UpdateProjects" datasource="PMS">
	  Update ProgramSeries
	    Set DateUpdated = #CreateODBCDateTime(now())#
		<cfif getProjects.STARTDATE NEQ "">,SeriesBegin = #CreateODBCDateTime(getProjects.STARTDATE)#</cfif>
	        <cfif getProjects.ENDDATE NEQ "">,SeriesEnd = #CreateODBCDateTime(getProjects.ENDDATE)#</cfif>
			
	  Where SellingCompany = '#Left(getProjects.NewSeriesCode, 1)#'
      AND ClientCode       = '#MID(getProjects.NewSeriesCode, 2, 2)#'
      AND ProductCode      = '#MID(getProjects.NewSeriesCode, 4, 2)#'
      AND SeriesCode       = '#Right(getProjects.NewSeriesCode,3)#'	
	</cfquery>
</cfloop>
</font>