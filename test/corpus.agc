# SYNTAX TEST "source.agentica" "type positions and cases from the tree-sitter-agentica corpus"

def f(a: Map[String, List[Int]], b: Models.User) -> Result[Domain.Option[Int]] # types
#                                   ^^^^^^ entity.name.type.agentica
#                                          ^^^^ entity.name.type.agentica - variable.other.enummember.agentica
#                                                          ^^^^^^ entity.name.type.agentica
#                                                                 ^^^^^^ entity.name.type.agentica - variable.other.enummember.agentica
#                                                                              ^^^^^^^ comment.line.number-sign.agentica
end

def label(
  text: String,
# ^^^^ variable.parameter.agentica
#       ^^^^^^ support.type.builtin.agentica
  level: Level = Level.Info,
# ^^^^^ variable.parameter.agentica
#                ^^^^^ entity.name.type.agentica
#                      ^^^^ variable.other.enummember.agentica
) -> Models.Label
# ^^ keyword.operator.arrow.agentica
#           ^^^^^ entity.name.type.agentica - variable.other.enummember.agentica
end

export type UserList = List[Models.User]
#           ^^^^^^^^ entity.name.type.alias.agentica
#                    ^ keyword.operator.assignment.agentica
#                                  ^^^^ entity.name.type.agentica - variable.other.enummember.agentica

def main() -> Void # trailing
#             ^^^^ support.type.builtin.agentica
#                  ^^^^^^^^^^ comment.line.number-sign.agentica
  o = Domain.Option.Some(1)
#            ^^^^^^ entity.name.type.agentica
#                   ^^^^ variable.other.enummember.agentica
  receiver: Ast.Optional[Ast.Expr] = Ast.Optional.Absent
#               ^^^^^^^^ entity.name.type.agentica - variable.other.enummember.agentica
#                            ^^^^ entity.name.type.agentica - variable.other.enummember.agentica
#                                                 ^^^^^^ variable.other.enummember.agentica
  IO.puts(IO.gets!)
#            ^^^^^ entity.name.function.agentica
  e = &Util.f!=x
#      ^^^^ entity.name.namespace.agentica
#           ^ entity.name.function.agentica
#            ^^ keyword.operator.comparison.agentica
  run() do
# ^^^ entity.name.function.agentica
#       ^^ keyword.control.agentica
    out = xs.filter do |c| c != "" end.push(last)
#                                  ^^^ keyword.control.agentica
#                                      ^^^^ entity.name.function.member.agentica
  end
  y: Float = 2.5
# ^ variable.other.readwrite.agentica
#    ^^^^^ support.type.builtin.agentica
#            ^^^ constant.numeric.float.agentica
  while !IO.eof?
#       ^ keyword.operator.logical.agentica
#           ^^^^ entity.name.function.agentica
    break
#   ^^^^^ keyword.control.loop.agentica
  end
  case shape do
# ^^^^ keyword.control.conditional.agentica
#            ^^ keyword.control.agentica
    -2 -> 2
#   ^ keyword.operator.arithmetic.agentica
#    ^ constant.numeric.integer.agentica
    Shape.Pair(-1, _) -> 5
#         ^^^^ variable.other.enummember.agentica
#                  ^ variable.language.anonymous.agentica
  end
  puts("a #{ {"k": 1}.size }")
#         ^^ punctuation.section.interpolation.begin.agentica
#            ^ punctuation.section.braces.begin.agentica
#                     ^^^^ variable.other.property.agentica
  x = f(<<~A,
#       ^^^^ punctuation.definition.string.begin.agentica
    one
#   ^^^ string.unquoted.heredoc.agentica
    two
  A
# ^ punctuation.definition.string.end.agentica
    2)
#   ^ constant.numeric.integer.agentica - string.agentica
end
# <--- keyword.control.agentica
