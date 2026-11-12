# SYNTAX TEST "source.agentica" "lambdas, blocks, one-line defs, guards, modules and nested builtin names"

def double(n: Int) -> Int = n * 2
# <--- storage.type.function.agentica
#   ^^^^^^ entity.name.function.agentica
#                     ^^^ support.type.builtin.agentica
#                         ^ keyword.operator.assignment.agentica

def list_text(items: List[String]) -> String = "[#{items.join(",")}]"
#                                              ^^^^^^^^^^^^^^^^^^^^^^^^ string.quoted.double.agentica

def main() -> Void
  twice = ->(x: Int) { x * 2 }
#         ^^ keyword.operator.arrow.agentica
#           ^ punctuation.definition.parameters.begin.agentica
#            ^ variable.parameter.agentica
#               ^^^ support.type.builtin.agentica
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
#       ^^^^ support.type.builtin.agentica
#            ^^^^^^^ support.type.builtin.agentica
  d: OpenSSL.Digest = OpenSSL.Digest.sha256("x")
#    ^^^^^^^ support.type.builtin.agentica
#            ^^^^^^ support.type.builtin.agentica
  level = Logger.Level.Info
#                      ^^^^ variable.other.enummember.agentica
