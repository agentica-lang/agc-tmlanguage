# SYNTAX TEST "source.agentica" "lambdas, blocks, one-line defs, guards, modules and nested names"

def double(n: Int) -> Int = n * 2
# <--- storage.type.function.agentica
#   ^^^^^^ entity.name.function.agentica
#                     ^^^ entity.name.type.agentica
#                         ^ keyword.operator.assignment.agentica

def list_text(items: List[String]) -> String = "[#{items.join(",")}]"
#                                              ^^^^^^^^^^^^^^^^^^^^^^^^ string.quoted.double.agentica

def main() -> Void
  twice = ->(x: Int) { x * 2 }
#         ^^ keyword.operator.arrow.agentica
#           ^ punctuation.definition.parameters.begin.agentica
#            ^ variable.parameter.agentica
#               ^^^ entity.name.type.agentica
  total = xs |> map(->(y) { y * 2 }) |> sum()
#                      ^ variable.parameter.agentica
  xs.each { |x| puts(x) }
#    ^^^^ entity.name.function.member.agentica
#         ^ punctuation.section.braces.begin.agentica
#           ^ punctuation.definition.parameters.begin.agentica
#            ^ variable.parameter.agentica
#             ^ punctuation.definition.parameters.end.agentica
  run do
# ^^^ entity.name.function.agentica
#     ^^ keyword.control.agentica
    puts("a")
  end
  n = twice do |x| x * 3 end
#     ^^^^^ entity.name.function.agentica
  twice { |x| x + 1 }
# ^^^^^ entity.name.function.agentica
  while ready do
#       ^^^^^ variable.other.readwrite.agentica
    break if n > 3
#   ^^^^^ keyword.control.loop.agentica
  end
  y = x |> upcase()
#          ^^^^^^ entity.name.function.agentica
  return n if n > 1
# ^^^^^^ keyword.control.return.agentica
#          ^^ keyword.control.conditional.agentica
end

module Stock
# <------ storage.type.module.agentica
#      ^^^^^ entity.name.namespace.agentica

export module Report
# <------ keyword.control.export.agentica
#      ^^^^^^ storage.type.module.agentica

  req = HTTP.Request(url: "x")
#       ^^^^ entity.name.type.agentica
#            ^^^^^^^ entity.name.type.agentica
  d: OpenSSL.Digest = OpenSSL.Digest.sha256("x")
#    ^^^^^^^ entity.name.type.agentica
#            ^^^^^^ entity.name.type.agentica
  level = Logger.Level.Info
#                      ^^^^ entity.name.type.agentica
  while a == ready do
#            ^^^^^ variable.other.readwrite.agentica
  end
  while a != ready do
#            ^^^^^ variable.other.readwrite.agentica
  end
  while a >= ready do
#            ^^^^^ variable.other.readwrite.agentica
  end
  while a <= ready do
#            ^^^^^ variable.other.readwrite.agentica
  end
  case x
    1 -> (a + b) * 2
#   ^ constant.numeric.integer.agentica
#        ^ punctuation.section.parens.agentica
  end
  g = ->(f: Fn(Int) -> Int, h: Int) { f(h) }
#       ^ punctuation.definition.parameters.begin.agentica
#        ^ variable.parameter.agentica
#                           ^ variable.parameter.agentica
#                                 ^ punctuation.definition.parameters.end.agentica
  xs.each { |x| puts(x) }
#                       ^ punctuation.section.braces.end.agentica
  s = HTTP.Stream(x)
#          ^^^^^^ entity.name.type.agentica

  e = Event.Level
#     ^^^^^ entity.name.type.agentica
#           ^^^^^ entity.name.type.agentica
  l = Logger.info("x")
#     ^^^^^^ entity.name.namespace.agentica
#            ^^^^ entity.name.function.agentica
