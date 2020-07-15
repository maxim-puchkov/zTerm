#  Close Back Windows
#  Services
#
#  Created by Maxim Puchkov on 2020-04-15.
#  Copyright © 2020 Maxim Puchkov. All rights reserved.


on run {message_text, title_text, subtitle_text}
	display notification message_text ¬
		with title title_text ¬
		subtitle subtitle_text
end run
