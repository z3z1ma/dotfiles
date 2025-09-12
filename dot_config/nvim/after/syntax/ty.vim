if exists('b:current_syntax') | finish | endif

" severities like: error[unresolved-import]:
syntax match tyError   '^error\(\[[^]]\+\]\)\?:' contains=tyCode
syntax match tyWarning '^warning\(\[[^]]\+\]\)\?:' contains=tyCode
syntax match tyInfo    '^info:'

" the [unresolved-import] bit
syntax match tyCode '\[[^]]\+\]' contained

" location lines: --> file.py:10:8
syntax match tyLocation '^\s*-->\s\zs\S\+:\d\+:\d\+'

" code gutter: 10 | import x
syntax match tyGutter  '^\s*\d\+\s\+|'
syntax match tyLineNr  '^\s*\d\+' contained containedin=tyGutter
syntax match tyBar     '^\s*\d\+\s\+\zs|' contained containedin=tyGutter

" underline caret line:   |        ^^^^^^^
syntax match tyCaret '^\s*|\s*\^\+\s*$'

" notes / paths / summary
syntax match tyNote   '^info: .*$'
syntax match tyScheme '\<vendored://\w\+\>'
syntax match tyPath   '\v(/\S+)+'
syntax match tySummary '^Found \d\+ diagnostics$'

" link highlights (leans on LSP groups where possible)
hi def link tyError     DiagnosticError
hi def link tyWarning   DiagnosticWarn
hi def link tyInfo      DiagnosticInfo
hi def link tyCode      Identifier
hi def link tyLocation  Underlined
hi def link tyLineNr    LineNr
hi def link tyBar       Comment
hi def link tyCaret     DiagnosticUnderlineError
hi def link tyNote      Comment
hi def link tyScheme    Special
hi def link tyPath      Directory
hi def link tySummary   Title

let b:current_syntax = 'ty'
