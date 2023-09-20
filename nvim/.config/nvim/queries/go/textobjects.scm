; extends

(literal_element) @parameter.inner

(keyed_element) @parameter.inner

(literal_element) @parameter.outer

(keyed_element) @parameter.outer

(return_statement
  (expression_list
    "," @_start .
    (_) @parameter.inner
  (#make-range! "parameter.outer" @_start @parameter.inner))
)

(return_statement
  (expression_list
    . (_) @parameter.inner
    . ","? @_end
   (#make-range! "parameter.outer" @parameter.inner @_end))
)

(if_statement 
  condition: (_)  @parameter.inner)

(expression_list) @expression_list

(call_expression) @call_expression
