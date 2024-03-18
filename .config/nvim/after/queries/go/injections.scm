; extends

(
 (comment) @_text
 (#eq? @_text "// language=sql")
 (const_declaration
  (const_spec value:
   (expression_list
    (raw_string_literal) @sql (#offset! @sql 0 1 0 -1)
   )
  )
 )*
)
