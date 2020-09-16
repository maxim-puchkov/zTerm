#!/usr/bin/osascript

#  clos-man.applescript
#  clos
#
#  Created by mpuchkov on 2020-01-24.
#  Copyright © 2020 Maxim Puchkov. All rights reserved.


property manual_profile_name : "Manual"
property command_wrapper : ". Manual"
property x_offset : 20


# If both arguments are empty string, close all manuals.
#   profile_name  - name of Terminal profile for new windows
#   man_page      - name of munual page to open
on run {profile_name, man_page}
	if (profile_name is "" and man_page is "") then
		close_all_manuals()
	else
		open_manual(profile_name, man_page)
	end if
end run


#MARK: - Manual Page profile
on term_profile(profile_name)
	tell application "Terminal"
		set profile to (settings set named profile_name)
		tell profile
			set custom title to "Manual"
			set clean commands to {"man", "sh", "less"}
			set font name to "SFMono-Regular"
			set font antialiasing to true
			set number of rows to 60
			set number of columns to 80
			set title displays custom title to true
			set title displays device name to false
			set title displays window size to false
			set title displays settings name to false
			set title displays shell path to false
		end tell
		return profile
	end tell
end term_profile


#MARK: - Open Manual Page
on open_manual(profile_name, man_page)
	set npos to next_position()
	set profile to term_profile(profile_name)
	set commands to ("colored -t 'light' man" & space & man_page)
	tell application "Terminal"
		# Window from which this script is called
		set main_window to front window
		
		# Open new terminal window and change its profile
		set the new_term_tab to (do script "")
		set current settings of the new_term_tab to profile
		tell the new_term_tab to Â
			set {number of rows, number of columns} to {60, 80}
		
		# Move manual page window to the top left corner
		tell front window to set its position to npos
		#       tell main_window to set frontmost to true
		
		# Display manual page in the new tab
		do script commands in the new_term_tab
		return 0
	end tell
end open_manual


#MARK: - Close All Openned Pages
on close_all_manuals()
	# Find windows with manual pages
	set num to windows_count(manual_profile_name)
	if (num = 0) then
		# Return -1 if manual pages are not open
		return -1
	else
		# Close and return number of closed windows
		windows_close(manual_profile_name)
		return num
	end if
end close_all_manuals


#MARK: - Windows.
# Number of open windows.
on windows_count(profile_name)
	tell application "Terminal"
		return count (every window where Â
			(name of current settings = profile_name))
	end tell
end windows_count
# Close open windows.
on windows_close(profile_name)
	tell application "Terminal"
		close (every window where Â
			(name of current settings = profile_name))
	end tell
end windows_close



#MARK: - Position of next window
on next_position()
	set num to windows_count(manual_profile_name)
	tell application "Terminal"
		set current_position to position of front window
		set current_x to item 1 of current_position
		set nx to current_x + (num * x_offset)
	end tell
	set ny to 0
	return {nx, ny}
end next_position

# Horizontal offset
on next_x(num)
	return (num * x_offset)
end next_x
