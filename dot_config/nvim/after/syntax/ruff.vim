if exists('b:current_syntax') | finish | endif

" Header lines: path:line:col: CODE Message
"   k8sCronJob/foo.py:54:5: E722 Do not use bare `except`
syntax match ruffHeader '^\f\+:\d\+:\d\+:\s[A-Z]\d\{3\}\s.*$' contains=ruffPath,ruffLnum,ruffCnum,ruffCode
syntax match ruffPath   '^\f\+\ze:'           contained
syntax match ruffLnum   ':\zs\d\+\ze:'        contained
syntax match ruffCnum   ':\d\+\zs:'           contained
syntax match ruffCode   '\s\zs[A-Z]\d\{3\}\ze\>' contained

" Standalone code lines at block top:
"   E722 Do not use bare `except`
"   F541 [*] f-string without any placeholders
syntax match ruffCodeLine '^\s*[A-Z]\d\{3}\s\+\(\[\*\]\s\+\)\?.*$' contains=ruffTopCode,ruffFixMark
syntax match ruffTopCode  '^\s*\zs[A-Z]\d\{3}\ze\>' contained
syntax match ruffFixMark  '\[\*\]' contained

" Location arrow lines:
"   --> azure_billing_clickhouse.py:54:5
syntax match ruffLocation '^\s*-->\s\zs\S\+:\d\+:\d\+'

" Code gutter / caret block:
"   74 |   print_(f"...")
"      |         ^^^^^^^
syntax match ruffGutter '^\s*\d\+\s\+|'
syntax match ruffCaret  '^\s*|\s*\^\+\s*$'

" Help & summary lines:
"   help: Remove extraneous `f` prefix
syntax match ruffHelp    '^\s*\%(=\s\)\?help:\s\+.*$'
syntax match ruffSummary '^Found \d\+\s\w\+s\?\.\s*$'
syntax match ruffFixable '^\[\*\].*$'

" Link to common highlight groups
hi def link ruffHeader   DiagnosticError
hi def link ruffPath     Directory
hi def link ruffLnum     LineNr
hi def link ruffCnum     LineNr
hi def link ruffCode     Identifier

hi def link ruffCodeLine DiagnosticError
hi def link ruffTopCode  DiagnosticError
hi def link ruffFixMark  SpecialComment

hi def link ruffLocation Underlined
hi def link ruffGutter   Comment
hi def link ruffCaret    DiagnosticUnderlineError

hi def link ruffHelp     DiagnosticHint
hi def link ruffSummary  Title
hi def link ruffFixable  DiagnosticInfo

let b:current_syntax = 'ruff'
