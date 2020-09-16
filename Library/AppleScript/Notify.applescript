#!/usr/bin/osascript

#  Close Back Windows
#  Services
#
#  Created by Maxim Puchkov on 2020-04-15.
#  Copyright © 2020 Maxim Puchkov. All rights reserved.


on run {message_text, title_text, subtitle_text}
	display notification message_text Â
		with title title_text Â
		subtitle subtitle_text
end run
