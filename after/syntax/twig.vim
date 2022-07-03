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
syn keyword twigLogic contained for if not endif endfor in include with

let b:twigjm = "twigjm"

hi! def link twigLogic Yellow
hi! def link outPutRegion Constant
hi! def link twigLogicRegion Constant
hi! twigLogic guibg=transparent guifg='#FF5D62'
