# SYNTAX TEST "source.agentica" "regex literals and division"

word = /\w+\/x/im
#      ^ string.regexp.agentica punctuation.definition.string.begin.agentica
#       ^^ string.regexp.agentica constant.character.escape.agentica
#         ^ string.regexp.agentica - constant.character.escape.agentica
#          ^^ constant.character.escape.agentica
#             ^ punctuation.definition.string.end.agentica
#              ^^ keyword.other.regexp-flag.agentica

half = total / 2 / count
#            ^ keyword.operator.arithmetic.agentica - string.regexp.agentica
#                ^ keyword.operator.arithmetic.agentica - string.regexp.agentica

n /= 2
# ^^ keyword.operator.assignment.compound.agentica

ratio = (a)/2 + xs[0]/3
#          ^ keyword.operator.arithmetic.agentica
#                    ^ keyword.operator.arithmetic.agentica

found = Regex.match?(text, /# not a comment/) and Regex.match?(text, /=x/)
#                           ^^^^^^^^^^^^^^^ string.regexp.agentica - comment.line.number-sign.agentica
#                                                                     ^^ string.regexp.agentica

xs = [/a/, /b/i]
#     ^^^ string.regexp.agentica
#          ^^^^ string.regexp.agentica

label = "#{/q/}"
#          ^^^ string.regexp.agentica

def f() -> Regex.Regex
  return /r/
# ^^^^^^ keyword.control.return.agentica
#        ^^^ string.regexp.agentica
end

  /line start/
# ^^^^^^^^^^^^ string.regexp.agentica

// not a regex
# <- keyword.operator.arithmetic.agentica
