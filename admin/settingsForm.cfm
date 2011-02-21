<cfoutput>
<form method="post" action="#cgi.script_name#">
	<fieldset>
		<legend>General Settings</legend>
		<p>
			<label for="CFObjectiveBadgerTitle">CFObjective Title:</label>
			<span class="hint">Set the title of the pod</span>
			<span class="field">
				<input type="text" id="CFObjectiveBadgerTitle" name="CFObjectiveBadgerTitle" value="#getSetting('CFObjectiveBadgerTitle')#" size="20"/>
			</span>
		</p>
		<p>
			<label for="CFObjectiveBadgerShowTitle">Show CFObjective Title:</label>
			<span class="hint">Enable/Disable the pod title</span>
			<span class="field">
				<input type="checkbox" id="CFObjectiveBadgerShowTitle" name="CFObjectiveBadgerShowTitle" value="true" <cfif getSetting("CFObjectiveBadgerShowTitle")>checked="checked"</cfif> />
			</span>
		</p>
		<p>
			<label for="CFObjectiveBadgerIconSet">Icon set:</label>
			<span class="hint">Select which badge to use</span>
			<span class="field">
				<select id="CFObjectiveBadgerBadge" name="CFObjectiveBadgerBadge">
					<option value="CFObjective11_attendee_125x125_w" <cfif getSetting("CFObjectiveBadgerBadge") EQ "CFObjective11_attendee_125x125_w">selected="selected"</cfif>>Attendee Lite</option>
					<option value="CFObjective11_attendee_125x125" <cfif getSetting("CFObjectiveBadgerBadge") EQ "CFObjective11_attendee_125x125">selected="selected"</cfif>>Attendee Dark</option>
					<option value="CFObjective11_speaker_125x125_w" <cfif getSetting("CFObjectiveBadgerBadge") EQ "CFObjective11_speaker_125x125_w">selected="selected"</cfif>>Speaker Lite</option>
					<option value="CFObjective11_speaker_125x125" <cfif getSetting("CFObjectiveBadgerBadge") EQ "CFObjective11_speaker_125x125">selected="selected"</cfif>>Speaker Dark</option>
					<option value="CFObjective11_sponsor_125x125_w" <cfif getSetting("CFObjectiveBadgerBadge") EQ "CFObjective11_sponsor_125x125_w">selected="selected"</cfif>>Sponsor Lite</option>
					<option value="CFObjective11_sponsor_125x125" <cfif getSetting("CFObjectiveBadgerBadge") EQ "CFObjective11_sponsor_125x125">selected="selected"</cfif>>Sponsor Dark</option>
				</select>
			</span>
		</p>
		<p>
			<label for="CFObjectiveBadgerIconSize">Badge width:</label>
			<span class="hint">Width of the badge in px, height is the same as the width.</span>
			<span class="field">
				<input type="text" id="CFObjectiveBadgerBadgeWidth" name="CFObjectiveBadgerBadgeWidth" value="#getSetting('CFObjectiveBadgerBadgeWidth')#" size="5"/>px
			</span>
		</p>
	</fieldset>
	<p class="actions">
		<input type="submit" class="primaryAction" value="Submit"/>
		<input type="hidden" value="event" name="action" />
		<input type="hidden" value="showCFObjectiveBadgerSettings" name="event" />
		<input type="hidden" value="true" name="apply" />
		<input type="hidden" value="CFObjectiveBadger" name="selected" />
	</p>
</form>
</cfoutput>