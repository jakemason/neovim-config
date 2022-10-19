" Vim syntax file
" Language: Twig
" Maintainer: Jake Mason
" Latest Revision: 07/03/2022
if exists("b:twigjm")
 " finish
endif

" Regions
syn region twigLogicRegion start='{%' end='%}' fold transparent contains=twigLogic
syn region outPutRegion start='{{' end='}}'

" Keywords
syn keyword twigLogic containedin=twigLogicRegion for if elseif not endif endfor in include with set and or

" Matches
syn match twigKey "^\s*[A-Za-z].*:" containedin=twigLogicRegion
syn match twigStringLiteral "\v'([^']*)'" containedin=twigLogicRegion
syn match twigStringLiteral '\v"([^']*)"' containedin=twigLogicRegion

let b:twigjm = "twigjm"

hi! def link twigLogic Yellow
hi! def link outPutRegion Constant
hi! def link twigLogicRegion Constant
hi! twigLogic guibg=transparent guifg='#FF5D62'
hi! twigKey guibg=transparent guifg='#7AA89F'
hi! twigStringLiteral guibg=transparent guifg='#98BB6C'
