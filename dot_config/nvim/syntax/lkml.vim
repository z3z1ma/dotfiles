if exists("b:current_syntax")
    finish
endif

let b:current_syntax = "lkml"

syntax sync fromstart

setlocal commentstring=#\ %s

" View Keywords
syntax keyword lkmlViewKeyword alias
syntax keyword lkmlViewKeyword alpha_sort
syntax keyword lkmlViewKeyword approximate
syntax keyword lkmlViewKeyword approximate_threshold
syntax keyword lkmlViewKeyword bypass_suggest_restrictions
syntax keyword lkmlViewKeyword can_filter
syntax keyword lkmlViewKeyword case
syntax keyword lkmlViewKeyword case_sensitive
syntax keyword lkmlViewKeyword convert_tz
syntax keyword lkmlViewKeyword datatype
syntax keyword lkmlViewKeyword default_value
syntax keyword lkmlViewKeyword derived_table
syntax keyword lkmlViewKeyword description
syntax keyword lkmlViewKeyword dimension
syntax keyword lkmlViewKeyword dimension_group
syntax keyword lkmlViewKeyword direction
syntax keyword lkmlViewKeyword distribution
syntax keyword lkmlViewKeyword distribution_style
syntax keyword lkmlViewKeyword drill_fields
syntax keyword lkmlViewKeyword fanout_on
syntax keyword lkmlViewKeyword field
syntax keyword lkmlViewKeyword fields
syntax keyword lkmlViewKeyword filter
syntax keyword lkmlViewKeyword filters
syntax keyword lkmlViewKeyword full_suggestions
syntax keyword lkmlViewKeyword group_label
syntax keyword lkmlViewKeyword hidden
syntax keyword lkmlViewKeyword html
syntax keyword lkmlViewKeyword icon_url
syntax keyword lkmlViewKeyword indexes
syntax keyword lkmlViewKeyword label
syntax keyword lkmlViewKeyword link
syntax keyword lkmlViewKeyword list_field
syntax keyword lkmlViewKeyword map_layer_name
syntax keyword lkmlViewKeyword measure
syntax keyword lkmlViewKeyword order_by_field
syntax keyword lkmlViewKeyword persist_for
syntax keyword lkmlViewKeyword primary_key
syntax keyword lkmlViewKeyword required_fields
syntax keyword lkmlViewKeyword set
syntax keyword lkmlViewKeyword skip_drill_filter
syntax keyword lkmlViewKeyword sortkeys
syntax keyword lkmlViewKeyword style
syntax keyword lkmlViewKeyword suggest_dimension
syntax keyword lkmlViewKeyword suggest_explore
syntax keyword lkmlViewKeyword suggest_persist_for
syntax keyword lkmlViewKeyword suggestable
syntax keyword lkmlViewKeyword suggestions
syntax keyword lkmlViewKeyword tiers
syntax keyword lkmlViewKeyword timeframes
syntax keyword lkmlViewKeyword type
syntax keyword lkmlViewKeyword url
syntax keyword lkmlViewKeyword value
syntax keyword lkmlViewKeyword value_format
syntax keyword lkmlViewKeyword value_format_name
syntax keyword lkmlViewKeyword view
syntax keyword lkmlViewKeyword view_label
syntax keyword lkmlViewKeyword when

highlight link lkmlViewKeyword Keyword

" Model keywords
syntax keyword lkmlModelKeyword access_filter_fields
syntax keyword lkmlModelKeyword always_filter
syntax keyword lkmlModelKeyword always_join
syntax keyword lkmlModelKeyword cancel_grouping_fields
syntax keyword lkmlModelKeyword case_sensitive
syntax keyword lkmlModelKeyword conditionally_filter
syntax keyword lkmlModelKeyword connection
syntax keyword lkmlModelKeyword description
syntax keyword lkmlModelKeyword explore
syntax keyword lkmlModelKeyword field
syntax keyword lkmlModelKeyword fields
syntax keyword lkmlModelKeyword filters
syntax keyword lkmlModelKeyword foreign_key
syntax keyword lkmlModelKeyword from
syntax keyword lkmlModelKeyword hidden
syntax keyword lkmlModelKeyword include
syntax keyword lkmlModelKeyword join
syntax keyword lkmlModelKeyword label
syntax keyword lkmlModelKeyword named_value_format
syntax keyword lkmlModelKeyword persist_for
syntax keyword lkmlModelKeyword relationship
syntax keyword lkmlModelKeyword required_joins
syntax keyword lkmlModelKeyword symmetric_aggregates
syntax keyword lkmlModelKeyword type
syntax keyword lkmlModelKeyword unless
syntax keyword lkmlModelKeyword value
syntax keyword lkmlModelKeyword value_format
syntax keyword lkmlModelKeyword view_label
syntax keyword lkmlModelKeyword view_name
syntax keyword lkmlModelKeyword week_start_day

highlight link lkmlModelKeyword Keyword

" Comment
syntax match lkmlComment /\v#.*$/

highlight link lkmlComment Comment

" String
syntax region lkmlString start=/\v"/ skip=/\v\\./ end=/\v"/

highlight link lkmlString String

" SQL
syntax match lkmlSql /\<sql\w*:\_.\{-};;/ contains=lkmlSqlStatement,lkmlSqlBody

syntax keyword lkmlSqlStatement sql               contained nextgroup=lkmlSqlBody
syntax keyword lkmlSqlStatement sql_trigger_value contained nextgroup=lkmlSqlBody
syntax keyword lkmlSqlStatement sql_on            contained nextgroup=lkmlSqlBody
syntax keyword lkmlSqlStatement sql_distinct_key  contained nextgroup=lkmlSqlBody
syntax keyword lkmlSqlStatement sql_latitude      contained nextgroup=lkmlSqlBody
syntax keyword lkmlSqlStatement sql_longitude     contained nextgroup=lkmlSqlBody
syntax keyword lkmlSqlStatement sql_table_name    contained nextgroup=lkmlSqlBody
syntax keyword lkmlModelKeyword sql_always_where  contained nextgroup=lkmlSqlBody
syntax keyword lkmlModelKeyword sql_table_name    contained nextgroup=lkmlSqlBody

syntax region lkmlSqlBody start=/:\zs/ end=/\ze;;/ contained contains=lkmlSqlReference,lkmlSqlComment

syntax region lkmlSqlReference start=/${/ end=/}/  contained contains=lkmlReferenceConstant,lkmlReferenceExpression

syntax match lkmlReferenceExpression /\w\+/ contained

syntax match lkmlSqlComment /\v--.*$/

syntax keyword lkmlReferenceConstant TABLE
syntax keyword lkmlReferenceConstant SQL_TABLE_NAME

highlight link lkmlSqlBody String
highlight link lkmlSqlStatement Keyword
highlight link lkmlReferenceExpression Identifier
highlight link lkmlReferenceConstant Constant
highlight link lkmlSqlComment Comment

highlight link lkmlComment Comment

" Bool
syntax keyword lkmlBoolean yes no

highlight link lkmlBoolean Boolean


" Looker 7.20
" While we have some redundancy below, this is a merger of 2 syntaxes and the
" combination covers more ground.

" String
syn region lkmlString contained start=+\v"+ skip=+\v\\.+ end=+\v"+
hi link lkmlString String

" Keyword
syn keyword lkmlKeyword contained dimension dimension_group measure
syn keyword lkmlKeyword contained drill_fields extends extension include test set view access_grant
syn keyword lkmlKeyword contained suggestions required_access_grants sql_table_name
syn keyword lkmlKeyword contained label case_sensitive map_layer named_format
syn keyword lkmlKeyword contained connection datagroup fiscal_month_offset persist_for persist_with week_start_day
hi link lkmlKeyword Keyword

" Constant
syn match lkmlNumeric contained /\v[0-9]+/
hi link lkmlNumeric Number

syn keyword lkmlBool contained yes no
hi link lkmlBool Boolean

syn keyword lkmlRequired contained required
hi link lkmlRequired Constant

syn keyword lkmlWeek contained monday tuesday wednesday thursday friday saturday sunday
hi link lkmlWeek Constant

" Common Parameters
syn match   lkmlLabel contained +label:+ contains=lkmlKeyword nextgroup=lkmlString skipwhite

" {{{ View
syn keyword lkmlViewIdent view              skipwhite nextgroup=lkmlViewSep
syn match   lkmlViewSep   contained +:+     skipwhite nextgroup=lkmlViewName
syn match   lkmlViewName  contained /\v\w+/ skipwhite nextgroup=lkmlViewParen
syn region  lkmlViewParen contained start=+{+ skip=+\v\{[^{]*\}+ end=+}+ contains=@lkmlViewParams

syn match   lkmlViewParam  +\v(suggestions):+ contains=lkmlKeyword nextgroup=lkmlBool skipwhite
syn match   lkmlViewParam  +\v(extension):+   contains=lkmlKeyword nextgroup=lkmlRequired skipwhite

syn cluster lkmlViewParams contains=lkmlComment,lkmlLabel,lkmlViewParam,lkmlDimension,lkmlDimensionGroup,lkmlMeasure

hi link lkmlViewIdent Keyword
" }}}

" {{{ - Dimension
syn match lkmlDimension +\v(dimension:)+ contains=lkmlKeyword
" }}}

" {{{ - Dimension Group
syn match lkmlDimensionGroup +\v(dimension_group:)+ contains=lkmlKeyword
" }}}
"
" {{{ - measure
syn match lkmlMeasure +\v(measure:)+ contains=lkmlKeyword
" }}}

" Explore {{{
syn keyword lkmlExploreIdent explore           skipwhite nextgroup=lkmlExploreSep
syn match   lkmlExploreSep   contained +:+     skipwhite nextgroup=lkmlExploreName
syn match   lkmlExploreName  contained /\v\w+/ skipwhite nextgroup=lkmlExploreParen
syn region  lkmlExploreParen contained start=+{+ end=+}+ contains=@lkmlExploreParams

syn cluster lkmlExploreParams contains=lkmlComment,lkmlLabel
hi link lkmlExploreIdent Keyword
" }}}

" Model {{{
syn match lkmlModelParams +\v(label|connection|include|persist_for):+ contains=lkmlKeyword nextgroup=lkmlString skipwhite
syn match lkmlModelParams +fiscal_month_offset:+ contains=lkmlKeyword nextgroup=lkmlNumeric skipwhite
syn match lkmlModelParams +case_sensitive:+ contains=lkmlKeyword nextgroup=lkmlBool   skipwhite
syn match lkmlModelParams +week_start_day:+ contains=lkmlKeyword nextgroup=lkmlWeek   skipwhite
syn match lkmlModelParams +persist_with:+ contains=lkmlKeyword skipwhite
" }}}
