# SYNTAX TEST "source.agentica" "strings, escapes and interpolation"

label = "n: #{total} \"q\" \# \x"
#       ^ string.quoted.double.agentica punctuation.definition.string.begin.agentica
#        ^^^ string.quoted.double.agentica
#           ^^ punctuation.section.interpolation.begin.agentica
#             ^^^^^ meta.interpolation.agentica variable.other.readwrite.agentica
#                  ^ punctuation.section.interpolation.end.agentica
#                    ^^ constant.character.escape.agentica
#                          ^^ constant.character.escape.agentica
#                             ^^ invalid.illegal.escape.agentica

literal = "\#{x} # not a comment"
#          ^^ constant.character.escape.agentica
#            ^^^ string.quoted.double.agentica - meta.interpolation.agentica
#                ^^^^^^^^^^^^^^^ string.quoted.double.agentica - comment.agentica

nested = "a #{f("b #{c}") + {"k": 1}.size} d"
#               ^^^^^^^^ meta.interpolation.agentica string.quoted.double.agentica
#                    ^ meta.interpolation.agentica meta.interpolation.agentica variable.other.readwrite.agentica
#                           ^ punctuation.section.braces.begin.agentica
#                                  ^ punctuation.section.braces.end.agentica
#                                    ^^^^ meta.interpolation.agentica variable.other.property.agentica
#                                        ^ punctuation.section.interpolation.end.agentica
#                                          ^ string.quoted.double.agentica - meta.interpolation.agentica

x = 1 ## trailing doc marker is a comment
#     ^^ comment.line.number-sign.agentica - comment.line.documentation.agentica

  ## indented doc line
# ^^^^^^^^^^^^^^^^^^^^ comment.line.documentation.agentica

big = 1_000.000_5 + 1_000.times + 1_000..2_000
#     ^^^^^^^^^^^ constant.numeric.float.agentica
#                   ^^^^^ constant.numeric.integer.agentica
#                        ^ punctuation.accessor.agentica
#                         ^^^^^ variable.other.property.agentica
#                                 ^^^^^ constant.numeric.integer.agentica
#                                      ^^ keyword.operator.range.agentica
#                                        ^^^^^ constant.numeric.integer.agentica
