#  Close Back Windows
#  Services
#
#  Created by Maxim Puchkov on 2020-04-06.
#  Copyright © 2020 Maxim Puchkov. All rights reserved.


property NTF_TITLE : "Finder Ð close background windows"
property NTF_SUBTITLE : "Success"


# Main Script Handler:
# Close only the background Finder windows.
on run
	tell application "Finder"
		# Count all Finder windows.
		set all_windows to its windows
		set n_windows to count of all_windows
		
		# Check number of openned windows. If none or only one window is open, then
		# 	ERROR(1): display an error and terminate script.
		if n_windows ² 1 then
			set exit_code to 1
			set ntf_custom_subtitle to "Error (code " & exit_code & ")"
			set ntf_text to "All background Finder windows are already closed."
			my ntf_full(NTF_TITLE, ntf_custom_subtitle, ntf_text)
			return exit_code
		end if
		
		# If there are open Finder windows, close them.
		set current_index to n_windows
		repeat until current_index = 1
			set w to item current_index of all_windows
			close w
			set current_index to current_index - 1
		end repeat
		
		# OK(0): display the number of closed windows and exit.
		set ntf_text to "Successfully closed " & n_windows & " background Finder windows."
		my ntf_message(ntf_text)
		log ntf_text
		return 0
	end tell
end run


# Full Notification Handler.
to ntf_full(ntf_custom_title, ntf_custom_subtitle, ntf_text)
	display notification ntf_text with title ntf_custom_title subtitle ntf_custom_subtitle
end ntf_full


# Notification Handler with default Title and Subtitle.
on ntf_message(ntf_text)
	display notification ntf_text with title NTF_TITLE subtitle NTF_SUBTITLE
end ntf_message
