<!------Login Component for Project Management System----------->


<cfcomponent hint="Validates Users and Sets Sessions for Application">
	<cffunction name="getUser" access="public" returntype="query" hint="Validates User">
		<cfargument name="Username" type="string" required="true"/>
		<cfargument name="Password" type="string" required="true"/>
		
		<CFQUERY DATASOURCE="#session.login_dbs#" NAME="Validation">
			SELECT user_login, password, first_name, last_name, position, ulevel1, ulevel2, ulevel3, user_dept, rowid
			FROM user_id
			WHERE user_login='#arguments.Username#' AND password='#arguments.Password#';
		</CFQUERY>
	
		<cfreturn getUser>
	</cffunction>
	
	<cffunction name="updateDateStamp" access="public" returntype="void" hint="Updates Time Stamp">
		<cfargument name="current_row" type="numeric" required="true"/>
		
		<CFQUERY DATASOURCE="#session.login_dbs#" NAME="UpdateTimeStamp">
			UPDATE	dbo.user_id
			SET 	ulevel3_last_access='#DateFormat(Now(),"mm/dd/yyyy")#'
			WHERE	rowid = '#arguments.current_row#'
		</CFQUERY>
	</cffunction>

	<cffunction name="setSession" access="public" returntype="void" hint="Sets Sessions for Application">
		<cfargument name="LastName" type="string" required="true"/>
		<cfargument name="FirstName" type="string" required="true"/>
		<cfargument name="UserDept" type="string" required="true"/>
		<cfargument name="User_ID" type="numeric" required="true"/>
		<cfargument name="Ulevel_13" type="numeric" required="true"/>
		<cfargument name="Pos" type="string" required="true"/>
		
		
		<CFLOCK SCOPE="session" TIMEOUT="30" type="exclusive">
			<CFSET session.last_name= "#arguments.LastName#">
			<CFSET session.first_name= "#arguments.FirstName#">
			<CFSET session.user_dept= "#arguments.UserDept#">
			<CFSET session.userid= "#arguments.User_ID#">
			<CFSET session.ulevel3= "#arguments.Ulevel_13#">
			<CFSET session.position= "#arguments.Pos#">
			<CFCOOKIE NAME="ulevel3" VALUE="#arguments.Ulevel_13#">
			<CFCOOKIE NAME="Validated" Value="1">
		</CFLOCK>	
	</cffunction>
	
	<cffunction name="updatePassword" access="public" returntype="void" hint="Updates Users Password if User is 'newuser'">
		<cfargument name="pass" type="string" required="true"/>
		<cfargument name="Row_ID" type="numeric" required="true"/>
		
		<CFQUERY DATASOURCE="#session.login_dbs#" NAME="UpdatePass">
			UPDATE	dbo.user_id
			SET	password='#arguments.pass#'
			WHERE (rowid = '#arguments.Row_ID)#')
		</cfquery>
	</cffunction>
	
	<cffunction name="getUser2" access="public" returntype="query" hint="Gets Users based on row id">
		<cfargument name="Row_ID" type="numeric" required="true"/>
		
		<CFQUERY DATASOURCE="#session.login_dbs#" NAME="Validation">
			SELECT user_login, password, first_name, last_name, position, ulevel1, ulevel2, ulevel3, user_dept, Rowid
			FROM user_id
			WHERE rowid='#arguments.rowid#'
		</CFQUERY>
	
		<cfreturn getUser2>
	</cffunction>

</cfcomponent>