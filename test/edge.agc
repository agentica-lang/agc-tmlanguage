# SYNTAX TEST "source.agentica" "suffixes and contextual words"

ne = a!=b
#    ^ variable.other.readwrite.agentica
#     ^^ keyword.operator.comparison.agentica
yes = nil!=x
#     ^^^ constant.language.nil.agentica
#        ^^ keyword.operator.comparison.agentica
ok = contains? (s, part)
#    ^^^^^^^^^ entity.name.function.agentica
line = gets!()
#      ^^^^^ entity.name.function.agentica
bang = !ready
#      ^ keyword.operator.logical.agentica
next = 1
# <---- variable.other.readwrite.agentica - keyword.agentica
type = "word"
# <---- variable.other.readwrite.agentica - storage.agentica
from = as + with
# <---- variable.other.readwrite.agentica - keyword.agentica
#      ^^ variable.other.readwrite.agentica - keyword.agentica
#           ^^^^ variable.other.readwrite.agentica
p2 = p.with(x: 2)
#      ^^^^ entity.name.function.member.agentica
xs = xs.push(1)
  .map do |x| x + 1 end
# ^ punctuation.accessor.agentica
#  ^^^ entity.name.function.member.agentica
index = endings
# <----- variable.other.readwrite.agentica - keyword.agentica
#       ^^^^^^^ variable.other.readwrite.agentica - keyword.agentica
m = {"a": 1, "b": [2, 3]}
#   ^ punctuation.section.braces.agentica
#                 ^ punctuation.section.brackets.agentica

export def run() -> Void
# <------ keyword.control.export.agentica
end

r = run(
  limit: a <= b,
# ^^^^^ variable.parameter.named.agentica
  strict: a != b,
# ^^^^^^ variable.parameter.named.agentica
)
v = Models.Shape.Circle
#   ^^^^^^ entity.name.type.agentica
#         ^ punctuation.accessor.agentica
#          ^^^^^ entity.name.type.agentica
#               ^ punctuation.accessor.agentica
#                ^^^^^^ variable.other.enummember.agentica
