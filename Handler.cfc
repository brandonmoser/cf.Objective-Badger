<cfcomponent extends="BasePlugin">

    <cffunction name="init" access="public" output="false" returntype="any">
        <cfargument name="mainManager" type="any" required="true" />
        <cfargument name="preferences" type="any" required="true" />

        <cfset setManager(arguments.mainManager) />
        <cfset setPreferencesManager(arguments.preferences) />
        <cfset setPackage("com/brandonmoser/mango/plugins/CFObjectiveBadger") />

        <!--- Default preferences --->
		<cfset variables.defaults = structnew() />
        <cfset variables.defaults.CFObjectiveBadgerTitle = "cf.Objective() 2011" />
		<cfset variables.defaults.CFObjectiveBadgerShowTitle = true />
		<cfset variables.defaults.CFObjectiveBadgerBadge = "CFObjective11_attendee_125x125" />
		<cfset variables.defaults.CFObjectiveBadgerBadgeWidth = "125" />

		<cfset initSettings(argumentCollection = variables.defaults) />

        <cfreturn this/>
    </cffunction>

    <cffunction name="setup" hint="This is run when a plugin is activated" access="public" output="false" returntype="any">
        <cfreturn "Plugin activated." />
    </cffunction>

    <cffunction name="unsetup" hint="This is run when a plugin is de-activated" access="public" output="false" returntype="any">
        <cfreturn "Plugin deactivated." />
    </cffunction>

    <cffunction name="handleEvent" hint="Asynchronous event handling" access="public" output="false" returntype="any">
        <cfargument name="event" type="any" required="true" />
        <cfreturn />
    </cffunction>

	<cffunction name="processEvent" hint="Synchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />

			<cfset var CFObjectiveBadgerContainer = "" />
			<cfset var CFObjectiveBadgerJS = "" />
			<cfset var data =  "" />
			<cfset var eventName = arguments.event.name />
			<cfset var pod = "" />
			<cfset var link = "" />
			<cfset var page = "" />

			<cfswitch expression="#eventName#">
				<cfcase value="getPods">

					<cfif event.allowedPodIds EQ "*" OR listfindnocase(event.allowedPodIds, "CFObjectiveBadger")>

						<cfsavecontent variable="CFObjectiveBadgerContainer">
							<cfoutput>
								<a href="http://www.CFObjective.com/" target="_blank">
								<img src="#request.blogManager.getBlog().getUrl()#assets/plugins/CFObjectiveBadger/images/badges/#getSetting('CFObjectiveBadgerBadge')#.gif" width="#getSetting("CFObjectiveBadgerBadgeWidth")#" height="#getSetting("CFObjectiveBadgerBadgeWidth")#" />
								</a>
							</cfoutput>
						</cfsavecontent>

						<cfdump var="#CFObjectiveBadgerContainer#" />

						<cfset pod = structnew() />
						<cfif getSetting("CFObjectiveBadgerShowTitle")>
							<cfset pod.title = getSetting("CFObjectiveBadgerTitle") />
						<cfelse>
							<cfset pod.title = "" />
						</cfif>
						<cfset pod.content = CFObjectiveBadgerContainer />
						<cfset pod.id = "CFObjectiveBadger" />
						<cfset arguments.event.addPod(pod)>
					</cfif>
				</cfcase>

				<cfcase value="beforeHtmlHeadEnd">
					<cfsavecontent variable="CFObjectiveBadgerJS"></cfsavecontent>

					<cfset data = arguments.event.outputData />
					<cfset data = data & CFObjectiveBadgerJS />
					<cfset arguments.event.outputData = data />
				</cfcase>

				<cfcase value="settingsNav">
					<cfset link = structnew() />
					<cfset link.owner = "CFObjectiveBadger">
					<cfset link.page = "settings" />
					<cfset link.title = "CFObjective Badger" />
					<cfset link.eventName = "showCFObjectiveBadgerSettings" />
					<cfset arguments.event.addLink(link)>
				</cfcase>

				<cfcase value="showCFObjectiveBadgerSettings">
					<cfif getManager().isCurrentUserLoggedIn()>
						<cfset data = arguments.event.data />

						<cfif structkeyexists(data.externaldata,"apply")>

							<cfparam name="data.externaldata.CFObjectiveBadgerTitle" default="0" />
							<cfparam name="data.externaldata.CFObjectiveBadgerShowTitle" default="0" />
							<cfparam name="data.externaldata.CFObjectiveBadgerBadge" default="0" />
							<cfparam name="data.externaldata.CFObjectiveBadgerBadgeWidth" default="0" />

							<cfset LOCAL.newSettings = StructNew() />
							<cfloop collection="#variables.defaults#" item="LOCAL.key">
								<cfset LOCAL.newSettings[LOCAL.key] = data.externaldata[LOCAL.key] />
							</cfloop>

							<cfset setSettings(argumentCollection = LOCAL.newSettings) />

							<cfset persistSettings() />
							<cfset data.message.setstatus("success") />
							<cfset data.message.setType("settings") />
							<cfset data.message.settext("CFObjectiveBadger Settings Updated") />
						</cfif>
					</cfif>

					<cfsavecontent variable="page">
						<cfinclude template="admin/settingsForm.cfm">
					</cfsavecontent>

					<cfset data.message.setTitle("CFObjective Badger Settings") />
					<cfset data.message.setData(page) />
				</cfcase>

				<cfcase value="getPodsList">
					<cfset pod = structnew() />
					<cfset pod.title = "CFObjective Badger" />
					<cfset pod.id = "CFObjectiveBadger" />
					<cfset arguments.event.addPod(pod)>
				</cfcase>
			</cfswitch>

		<cfreturn arguments.event />
	</cffunction>

</cfcomponent>