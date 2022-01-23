# This file is part of ranger, the console file manager.
# License: GNU GPL version 3, see the file "AUTHORS" for details.

from __future__ import (absolute_import, division, print_function)

from ranger.gui.colorscheme import ColorScheme
from ranger.gui.context import Context
from ranger.gui.color import (
    black, blue, cyan, green, magenta, red, white, yellow, 
    normal, bold, reverse, underline, BRIGHT
)


#base16 setup
black   = black
darkgrey= green      + BRIGHT
lightgrey= yellow      + BRIGHT
grey    = black     + BRIGHT
white   = magenta   + BRIGHT
red     = red
orange  = red       + BRIGHT
yellow  = yellow
green   = green
cyan    = cyan
blue    = blue
purple  = magenta
crimson = cyan      + BRIGHT

CONTEXT_KEYS = [
    'reset', 'error',
    'in_browser', 'in_statusbar', 'in_titlebar',
    'in_taskview',
    'active_pane', 'inactive_pane',
    'directory', 'file', 'hostname',
    'executable', 'media', 'link', 'fifo', 'socket', 'device',
    'video', 'audio', 'image', 'media', 'document', 'container',
    'selected', 'empty', 'main_column', 'message',
    'good', 'bad',
    'permissions', 'owner', 'group', 'mtime', 'nlink',
    'scroll', 'all', 'bot', 'top', 'percentage', 'filter',
    'flat', 'marked', 'tagged', 'tag_marker', 'cut', 'copied', 'frozen',
    'title', 'text', 'highlight', 'tab', 'loaded',
    'keybuffer',
    'infostring',
    'vcsfile', 'vcsremote', 'vcsinfo', 'vcscommit', 'vcsdate',
    'vcsconflict', 'vcschanged', 'vcsunknown', 'vcsignored', 'vcsuntracked',
    'vcsstaged', 'vcssync', 'vcsnone', 'vcsbehind', 'vcsahead', 'vcsdiverged'
]

class MyOwn(ColorScheme):

    def use(self, context):  # pylint: disable=too-many-branches,too-many-statements
        
        default_colors = (grey, black, normal)
        fg, bg, attr = default_colors
        default = white

        if context.reset:
            return default_colors

        elif context.in_browser:
            if context.selected:
                attr = reverse
            else:
                attr = normal
            if context.empty or context.error:
                fg = black
                bg = crimson
            if context.border:
                fg = grey
            if context.media:
                fg = yellow
            if context.container:
                fg = red
            if context.directory:
                attr |= bold
                fg = white
            elif context.executable and not \
                    any((context.media, context.container,
                         context.fifo, context.socket)):
                attr |= bold
            if context.document:
                fg = purple
            if context.readme:
                fg = green
            if context.code:
                fg = orange
            if context.git:
                fg = lightgrey
            if context.socket:
                attr |= bold
                fg = magenta
            if context.fifo or context.device:
                fg = yellow
                attr |= bold
            if context.link:
                fg = cyan if context.good else purple
            if context.tag_marker and not context.selected:
                attr |= bold
                if fg in (red, orange):
                    fg = white
                else:
                    fg = orange
            if not context.selected and (context.cut or context.copied):
                attr |= bold
                fg = grey
            if context.main_column:
                if context.selected:
                    attr |= bold
                if context.marked:
                    attr |= bold
                    fg = yellow

            if context.inactive_pane:
                fg = cyan

        elif context.in_titlebar:
            if context.hostname:
                fg = red if context.bad else green
            elif context.directory:
                fg = white
            elif context.tab:
                if context.good:
                    fg = black
                    bg = orange
            elif context.link:
                fg = cyan
            attr |= bold

        elif context.in_statusbar:
            bg = darkgrey
            fg = white
            if context.permissions:
                if context.good:
                    fg = green
                    attr |= underline
                elif context.bad:
                    fg = red
                    attr |= underline
            if context.owner:
                fg = grey
                attr |= bold
                attr |= underline
            if context.group:
                fg = grey
                attr |= underline
            if context.mtime:
                fg = purple
                attr |= underline
            if context.nlink or context.link:
                fg = cyan
                attr |= bold
                attr |= underline
            if context.marked:
                attr |= bold | reverse
                fg = yellow
            if context.frozen:
                attr |= bold | reverse
                fg = cyan
            if context.message:
                if context.bad:
                    attr |= bold
                    fg = crimson
            if context.loaded:
                fg = white
                bg = blue
            if context.scroll:
                if context.top or context.bot:
                    fg = red
                if context.all or context.percentage:
                    fg = green
            if context.vcsinfo:
                fg = blue
                attr &= ~bold
            if context.vcscommit:
                fg = yellow
                attr &= ~bold
            if context.vcsdate:
                fg = blue
                attr &= ~bold

        if context.text:
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            if context.title:
                fg = blue
            if context.selected:
                attr |= reverse
            if context.loaded:
                if context.selected:
                    fg = blue
                else:
                    bg = blue

        if context.vcsfile and not context.selected:
            attr &= ~bold
            if context.vcsconflict:
                fg = crimson
            elif context.vcsuntracked:
                fg = grey
            elif context.vcschanged:
                fg = orange
            elif context.vcsunknown:
                fg = orange
            elif context.vcsstaged:
                fg = green
            elif context.vcssync:
                fg = green
            elif context.vcsignored:
                fg = default

        elif context.vcsremote and not context.selected:
            attr &= ~bold
            if context.vcssync or context.vcsnone:
                fg = green
            elif context.vcsbehind:
                fg = crimson
            elif context.vcsahead:
                fg = blue
            elif context.vcsdiverged:
                fg = orange
            elif context.vcsunknown:
                fg = orange

        return fg, bg, attr

if __name__ == '__main__':
    print(MyOwn().use(Context(['in_titlebar', 'directory'])))


#        j = []
#        a = ['active_pane', 'all', 'audio', 'background', 'bad', 'badinfo', 'bars', 'border', 'bot', 'container', 'copied', 'cut', 'device','directory', 'document', 'empty', 'error', 'executable', 'fifo', 'file', 'filter', 'flat', 'frozen', 'good', 'group', 'help_markup', 'highlight', 'hostname', 'image', 'in_browser', 'in_console', 'in_pager', 'in_statusbar', 'in_taskview', 'in_titlebar', 'inactive_pane', 'infostring', 'key', 'keybuffer','link', 'loaded', 'main_column', 'marked', 'media', 'message', 'mtime', 'nlink', 'owner', 'percentage', 'permissions', 'quotes', 'reset', 'scroll', 'selected', 'seperator', 'socket','space', 'special', 'tab', 'tag_marker', 'tagged', 'text', 'title', 'top', 'vcsahead', 'vcsbehind', 'vcschanged', 'vcscommit', 'vcsconflict', 'vcsdate', 'vcsdiverged', 'vcsfile', 'vcsignored', 'vcsinfo', 'vcsnone', 'vcsremote', 'vcsstaged', 'vcssync', 'vcsunknown', 'vcsuntracked', 'video']
#        b = [context.active_pane, context.all, context.audio, context.background, context.bad, context.badinfo, context.bars, context.border, context.bot, context.container, context.copied, context.cut, context.device,context.directory, context.document, context.empty, context.error, context.executable, context.fifo, context.file, context.filter, context.flat, context.frozen, context.good, context.group, context.help_markup, context.highlight, context.hostname, context.image, context.in_browser, context.in_console, context.in_pager, context.in_statusbar, context.in_taskview, context.in_titlebar, context.inactive_pane, context.infostring, context.key, context.keybuffer,context.link, context.loaded, context.main_column, context.marked, context.media, context.message, context.mtime, context.nlink, context.owner, context.percentage, context.permissions, context.quotes, context.reset, context.scroll, context.selected, context.seperator, context.socket,context.space, context.special, context.tab, context.tag_marker, context.tagged, context.text, context.title, context.top, context.vcsahead, context.vcsbehind, context.vcschanged, context.vcscommit, context.vcsconflict, context.vcsdate, context.vcsdiverged, context.vcsfile, context.vcsignored, context.vcsinfo, context.vcsnone, context.vcsremote, context.vcsstaged, context.vcssync, context.vcsunknown, context.vcsuntracked, context.video]
#        c = [ 'normal', 'bold',  'reverse', 'dim']
#        d = [ normal, bold, reverse, dim]
#        for k, v in zip(a,b):
#            if v:
#                j.append(k)
#        att = ''
#        for k, v in zip(c,d):
#            if attr == v:
#                att = k
#        co = [                         
#            'black',
#            'red',
#            'green',
#            'yellow',
#            'blue',
#            'magenta',
#            'cyan',
#            'white',
#            'BRIGHT+black',
#            'BRIGHT+red',
#            'BRIGHT+green',
#            'BRIGHT+yellow',
#            'BRIGHT+blue',
#            'BRIGHT+magenta',
#            'BRIGHT+cyan',
#            'BRIGHT+white',
#        ]
#
#        co1 = [
#            'black',
#            'red',
#            'green',
#            'yellow',
#            'blue',
#            'purple',
#            'cyan',
#            'NO-white',
#            'grey',
#            'orange',
#            'NO-Bgreen',
#            'NO-Byellow',
#            'NO-Bblue',
#            'white',
#            'crimson',
#            'NO-Bwhite',
#            ]
#
#        #print(co, file=open('output.txt', 'a'))
#        print(('fgo:'+co[fg],'fgn:'+co1[fg],'bg:'+co[bg],'att:'+str(att)), 'con:'+str(j), file=open('~/output.txt', 'a'))
