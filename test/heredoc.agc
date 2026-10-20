# SYNTAX TEST "source.agentica" "heredocs"

def usage(name: String) -> String
  return <<~TEXT.strip
#        ^^^^^^^ string.unquoted.heredoc.agentica punctuation.definition.string.begin.agentica
#               ^ punctuation.accessor.agentica - string.agentica
#                ^^^^^ variable.other.property.agentica - string.agentica
    Usage: #{name} "quoted" \t
#   ^^^^^^^ string.unquoted.heredoc.agentica
#          ^^ punctuation.section.interpolation.begin.agentica
#            ^^^^ variable.other.readwrite.agentica
#                  ^^^^^^^^ string.unquoted.heredoc.agentica - string.quoted.agentica
#                           ^^ constant.character.escape.agentica
    # not a comment
#   ^^^^^^^^^^^^^^^ string.unquoted.heredoc.agentica - comment.agentica
    TEXTUAL is not the end
#   ^^^^^^^ string.unquoted.heredoc.agentica - punctuation.agentica
  TEXT
# ^^^^ string.unquoted.heredoc.agentica punctuation.definition.string.end.agentica
end
# <--- keyword.control.agentica - string.agentica

def two() -> Int
  puts(<<~LEFT.length + <<~RIGHT.length) # both
#      ^^^^^^^ punctuation.definition.string.begin.agentica
#              ^^^^^^ variable.other.property.agentica - string.agentica
#                       ^^^^^^^^ punctuation.definition.string.begin.agentica
#                                ^^^^^^ variable.other.property.agentica - string.agentica
#                                        ^^^^^^ comment.line.number-sign.agentica
    ab
#   ^^ string.unquoted.heredoc.agentica
  LEFT
# ^^^^ punctuation.definition.string.end.agentica
    RIGHT is still text
#   ^^^^^^^^^^^^^^^^^^^ string.unquoted.heredoc.agentica - punctuation.agentica
  RIGHT
# ^^^^ punctuation.definition.string.end.agentica
  return 1
# ^^^^^^ keyword.control.return.agentica - string.agentica
end

def hidden() -> String
  a = <<~TEXT # like <<~EOF
#             ^^^^^^^^^^^^^ comment.line.number-sign.agentica
    one
  TEXT
# ^^^^ punctuation.definition.string.end.agentica
  b = f(<<~SRC, "<<~X")
#               ^^^^^^ string.quoted.double.agentica
    two
  SRC
# ^^^ punctuation.definition.string.end.agentica
  c = g(<<~ONE, "x", <<~TWO)
#                    ^^^^^^ punctuation.definition.string.begin.agentica
    three
  ONE
    four
  TWO
# ^^^ punctuation.definition.string.end.agentica
  return a
# ^^^^^^ keyword.control.return.agentica - string
end
