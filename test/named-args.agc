# SYNTAX TEST "source.agentica" "named arguments in calls, and their neighbours"

check(gen, verbose: true)
#     ^^^ variable.other.readwrite.agentica - variable.parameter.named.agentica
#          ^^^^^^^ variable.parameter.named.agentica
#                 ^ punctuation.separator.key-value.agentica
#                   ^^^^ constant.language.boolean.agentica

p = q.with(x: 2)
#     ^^^^ entity.name.function.member.agentica
#          ^ variable.parameter.named.agentica
#           ^ punctuation.separator.key-value.agentica

x = items.slice(start: 1, count: 2)
#         ^^^^^ entity.name.function.member.agentica
#               ^^^^^ variable.parameter.named.agentica
#                         ^^^^^ variable.parameter.named.agentica
#                              ^ punctuation.separator.key-value.agentica

r = Process.wait(process: p)
#   ^^^^^^^ entity.name.namespace.agentica
#           ^^^^ entity.name.function.agentica
#                ^^^^^^^ variable.parameter.named.agentica
#                       ^ punctuation.separator.key-value.agentica

y = M.f(a: 1)
#   ^ entity.name.namespace.agentica
#     ^ entity.name.function.agentica
#       ^ variable.parameter.named.agentica
#        ^ punctuation.separator.key-value.agentica

z = x |> f(a: 1) |> g(b: 2, c: 3)
#     ^^ keyword.operator.pipe.agentica
#        ^ entity.name.function.agentica
#          ^ variable.parameter.named.agentica
#                   ^ entity.name.function.agentica
#                     ^ variable.parameter.named.agentica
#                           ^ variable.parameter.named.agentica

xs.each(limit: 2) do |x|
#       ^^^^^ variable.parameter.named.agentica
#                 ^^ keyword.control.agentica
#                     ^ variable.parameter.agentica - variable.parameter.named.agentica
  puts(x, sep: " ")
#         ^^^ variable.parameter.named.agentica
end

ys = xs.map(offset: 1) { |x| x + 1 }
#           ^^^^^^ variable.parameter.named.agentica
#                         ^ variable.parameter.agentica - variable.parameter.named.agentica

ws = xs |> map(offset: 1) { |x| x }
#          ^^^ entity.name.function.agentica
#              ^^^^^^ variable.parameter.named.agentica
#                            ^ variable.parameter.agentica - variable.parameter.named.agentica

outer(inner(a: 1), b: 2)
# <----- entity.name.function.agentica
#     ^^^^^ entity.name.function.agentica
#           ^ variable.parameter.named.agentica
#                  ^ variable.parameter.named.agentica

l = f(1, run: ->(x) { x * 2 })
#        ^^^ variable.parameter.named.agentica
#             ^^ keyword.operator.arrow.agentica
#                ^ variable.parameter.agentica - variable.parameter.named.agentica

m = f(opts: {a: 1, b: 2})
#     ^^^^ variable.parameter.named.agentica
#            ^ variable.parameter.named.agentica
#                  ^ variable.parameter.named.agentica

n = f({a: 1}, b: 2)
#      ^ variable.parameter.named.agentica
#             ^ variable.parameter.named.agentica
#             ^ variable.parameter.named.agentica

o = f(1,2, tight:3)
#          ^^^^^ variable.parameter.named.agentica
#               ^ punctuation.separator.key-value.agentica
#                ^ constant.numeric.integer.agentica

q = build(
  name: "app",
# ^^^^ variable.parameter.named.agentica
#     ^ punctuation.separator.key-value.agentica
  mode: Mode.Fast,
# ^^^^ variable.parameter.named.agentica
  retries: n + 1,
# ^^^^^^^ variable.parameter.named.agentica
  limit: a <= b,
# ^^^^^ variable.parameter.named.agentica
  strict: a != b,
# ^^^^^^ variable.parameter.named.agentica
)

e = error("unique failed", kind: "db.constraint", code: 19)
#                          ^^^^ variable.parameter.named.agentica
#                                                 ^^^^ variable.parameter.named.agentica
#                                                       ^^ constant.numeric.integer.agentica

s = Shelf(label: "apples", count: n)
#         ^^^^^ variable.parameter.named.agentica
#                          ^^^^^ variable.parameter.named.agentica

# a map key is scoped like a named argument (a known limit); a quoted key is a string

k = {"a": 1}
#    ^^^ string.quoted.double.agentica - variable.parameter.named.agentica
#       ^ punctuation.separator.colon.agentica

# typed names keep their own scopes

def f(a: Int, name: Int) -> Int = a + name
#     ^ variable.parameter.agentica - variable.parameter.named.agentica
#      ^ punctuation.separator.type.agentica
#             ^^^^ variable.parameter.agentica - variable.parameter.named.agentica

count: Int = 0
# <----- variable.other.readwrite.agentica - variable.parameter.named.agentica
#    ^ punctuation.separator.type.agentica

struct Box
  label: String
# ^^^^^ variable.other.property.agentica - variable.parameter.named.agentica
end

t = x.f(a: 1) + y.g(b: 2)
#       ^ variable.parameter.named.agentica
#                   ^ variable.parameter.named.agentica

u = "a: 1"
#    ^ string.quoted.double.agentica - variable.parameter.named.agentica
v = f(a: "b: 2") # c: 3
#     ^ variable.parameter.named.agentica
#         ^ string.quoted.double.agentica - variable.parameter.named.agentica
#                  ^ comment.line.number-sign.agentica - variable.parameter.named.agentica
w = "#{f(a: 1)}"
#        ^ meta.embedded.line.agentica variable.parameter.named.agentica
