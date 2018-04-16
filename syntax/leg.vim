" Vim syntax file
" Language: Parser Expression Grammars (PEG) -- LEG dialect
" Maintainer: Gianni Chiappetta, Josh Junon
" Latest Revision: 2016-10-06

if exists("b:current_syntax")
  finish
endif

syn include @c syntax/cpp.vim

syn match   legRuleIdentifier   /^\v[-a-zA-Z_][-a-zA-Z_0-9]*/ skipwhite skipnl nextgroup=legSeperator

syn match   legSeperator        "=" skipwhite skipnl contained nextgroup=legExpression

syn match   legExpression       /\v[^\;]*/ contained skipwhite skipnl contains=legDelimiter,legOrderedChoice,legGrouping,legSpecial,legRange,legTerminal,legNonTerminal,legQuantifier,legRuleBody
syn match   legDelimiter        /[§]/ contained display
syn region  legGrouping         matchgroup=legDelimiter start=/(/ end=/)/ contained skipwhite keepend contains=legExpression display
syn match   legSpecial          /[!&ϵ^]/ contained display
syn match   legOrderedChoice    /\v\|/ display
syn region  legRange            matchgroup=legDelimiter start=/\[^/ start=/\[/ end=/\]/ contained skipwhite contains=legRangeValue,legUnicode display
syn match   legRangeValue       /\d\+-\d\+/ contained display
syn match   legRangeValue       /\a\+-\a\+/ contained display
syn region  legTerminal         matchgroup=legDelimiter start=/"/ end=/"/ contained display
syn region  legTerminal         matchgroup=legDelimiter start=/'/ end=/'/ contained display
syn match   legUnicode          /U+[A-F0-9]\{4,6}/ contained display
syn match   legNonTerminal      /\a+/ contained display
syn match   legQuantifier       /[+\*?]/ contained display
syn match   legQuantifier       /{\d\+,\d\+}/ contained display
syn match   legQuantifier       /{\d\+}/ contained display
syn match   legSpecialSymbol    /\v\$\$/ contained display
syn region  legRuleBody         matchgroup=legCDelimiter start=/\v([@~]\s*)?\{/ end=/}/ contains=legSpecialSymbol,@c

syn match   legComment          /#.*$/ contains=legTodo
syn keyword legTodo             TODO FIXME XXX NOTE contained

syn region  legCBlock           matchgroup=legCDelimiter start=/\v^\%\{/ end=/\v\%\}$/ keepend contains=@c
syn region  legCBlock           matchgroup=legCDelimiter start=/\v\%\%/ skip=/\v.*/ end=/$/ excludenl contains=@c

hi link legOrderedChoice  legSeperator

hi link legRuleIdentifier Statement
hi link legSeperator      Conditional
hi link legDelimiter      Delimiter
hi link legCDelimiter     Conditional
hi link legSpecial        Special
hi link legComment        Comment
hi link legRangeValue     Constant
hi link legTerminal       String
hi link legUnicode        Constant
hi link legQuantifier     Function
hi link legTodo           Todo
hi link legSpecialSymbol  Special

let b:current_syntax = "leg"
