" Vim Syntax File
" For K- Language
" email: hyungmo@aces.snu.ac.kr

if exists("b:current_syntax")
  finish
endif

syn keyword snuUnit           unit
syn keyword snuBool           true false
syn keyword snuCond           if then else
syn keyword snuLoop           for while do
syn keyword snuBind           let proc in
syn keyword snuIO             read write
syn keyword snuMisc           end to

syn keyword snuTodo           TODO FIXME NOTE XXX contained

syn match snuNumber           "-\=\<\d\+"
syn match snuOperator         ":="
syn match snuOperator         "[+-\*/<>=.;]"

syn region snuParenRegion     transparent matchgroup=snuRegion start="(" matchgroup=snuRegion end=")" contains=ALLBUT,@snuContained,snuParenError
syn region snuBrackRegion     transparent matchgroup=snuRegion start="\[" matchgroup=snuRegion end="\]" contains=ALLBUT,@snuContained,snuBrackError
syn region snuCurlyRegion     transparent matchgroup=snuRegion start="{" matchgroup=snuRegion end="}" contains=ALLBUT,@snuContained,snuCurlyError
syn region snuComment         start="(\*" end="\*)" contains=snuTodo

syn match snuParenError       ")" display
syn match snuBrackError       "\]" display
syn match snuCurlyError       "}" display

hi link snuUnit               Keyword
hi link snuBool               Keyword
hi link snuCond               Keyword
hi link snuLoop               Keyword
hi link snuBind               Keyword
hi link snuIO                 Keyword
hi link snuMisc               Keyword

hi link snuBool               Boolean
hi link snuNumber             String
hi link snuOperator           Keyword

hi link snuParenError         Error
hi link snuBrackError         Error
hi link snuCurlyError         Error

hi link snuRegion             Keyword
hi link snuComment            Comment

let b:current_syntax="k-"
