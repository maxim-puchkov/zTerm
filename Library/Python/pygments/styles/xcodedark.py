# -*- coding: utf-8 -*-
"""
    pygments.styles.xcode_dark
    ~~~~~~~~~~~~~~~~~~~~~~~~~~

    Style similar to the `Xcode` default theme.

    :copyright: Copyright 2006-2019 by the Pygments team, see AUTHORS.
    :license: BSD, see LICENSE for details.
"""

from pygments.style import Style
from pygments.token import Keyword, Name, Comment, String, Error, \
     Number, Operator, Literal


class XcodeDarkStyle(Style):
    """
    Style similar to a dark Xcode colouring theme.
    """

    default_style = ''

    styles = {
        Comment:                '#41FF45',
        Comment.Preproc:        '#00FF00',

        String:                 '#FF2600',
        String.Char:            '#786DFF',

        Operator:               '#DDDDDD',

        Keyword:                '#FC00B4',

        Name:                   '#FFFFFF',
        Name.Attribute:         '#836C28',
        Name.Class:             '#3F6E75',
        Name.Function:          '#FFFFFF',
        Name.Builtin:           '#FF40FF',
        # In Obj-C code this token is used to colour Cocoa types
        Name.Builtin.Pseudo:    '#5B269A',
        Name.Variable:          '#9988DD',
        Name.Tag:               '#FFFFFF',
        Name.Decorator:         '#FFFFFF',
        # Workaround for a BUG here: lexer treats multiline method signatres as labels
        Name.Label:             '#FFFFFF',

        Literal:                '#1CBFFF',
        Number:                 '#1CBFFF',
        Error:                  '#FFFFFF',
    }
