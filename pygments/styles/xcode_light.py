# -*- coding: utf-8 -*-
"""
    pygments.styles.xcode_light
    ~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    Light style similar to the `Xcode` default theme.

    Created by Maxim Puchkov on 2020-06-14.
    :copyright: Copyright © 2020 Maxim Puchkov. All rights reserved.
"""

from pygments.style import Style
from pygments.token import Keyword, Name, Comment, String, Error, \
     Number, Operator, Literal


class XcodeLightStyle(Style):
    """
    Light style similar to the `Xcode` default theme.
    """

    default_style = ''

    styles = {
        Comment:                '#339900',
        Comment.Preproc:        '#267507',

        String:                 '#CC0000',
        String.Char:            '#1C00CF',

        Operator:               '#222222',
        Keyword:                'bold #CC00CC',

        Name:                   '#000000',
        Name.Attribute:         '#836C28',
        Name.Class:             '#1C464A',
        Name.Function:          '#326D74',
        Name.Builtin:           '#FF40FF',
        Name.Builtin.Pseudo:    '#5B269A',
        Name.Variable:          '#9988DD',
        Name.Tag:               '#000000',
        Name.Decorator:         '#000000',
        Name.Label:             '#000000',

        Literal:                '#1CBFFF',
        Number:                 '#1C00CF',
        Error:                  '#FF0000',
    }
