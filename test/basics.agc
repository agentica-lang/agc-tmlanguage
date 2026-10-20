# SYNTAX TEST "source.agentica" "declarations, calls and literals"

import Models from "models"
# <------ keyword.control.import.agentica
#      ^^^^^^ entity.name.namespace.agentica
#             ^^^^ keyword.control.import.agentica
#                  ^^^^^^^^ string.quoted.double.agentica

import {parse, Item as Entry} from "items"
#       ^^^^^ variable.other.readwrite.agentica
#              ^^^^ entity.name.type.agentica
#                   ^^ keyword.control.import.agentica
#                      ^^^^^ entity.name.type.agentica

import {
#      ^ punctuation.section.braces.begin.agentica
  BARE, Square as Sq, # names
# ^^^^ variable.other.constant.agentica
#       ^^^^^^ entity.name.type.agentica
#              ^^ keyword.control.import.agentica
#                 ^^ entity.name.type.agentica
#                     ^^^^^^^ comment.line.number-sign.agentica
  as,
# ^^ variable.other.readwrite.agentica - keyword
} from "builtins"
# <- punctuation.section.braces.end.agentica
# ^^^^ keyword.control.import.agentica
#      ^^^^^^^^^^ string.quoted.double.agentica

LIMIT = 10
# <----- variable.other.constant.agentica
#       ^^ constant.numeric.integer.agentica

export Max: Int = 3
# <------ keyword.control.export.agentica
#      ^^^ variable.other.constant.agentica
#           ^^^ support.type.builtin.agentica

type UserId = Int
# <---- storage.type.type.agentica
#    ^^^^^^ entity.name.type.alias.agentica
#             ^^^ support.type.builtin.agentica

## A point on the plane.
# <-- comment.line.documentation.agentica
#  ^^^^^^^^^^^^^^^^^^^^^ comment.line.documentation.agentica
struct Point
# <------ storage.type.struct.agentica
#      ^^^^^ entity.name.type.struct.agentica
  x: Int
# ^ variable.other.property.agentica
#    ^^^ support.type.builtin.agentica
  label: Models.Label
# ^^^^^ variable.other.property.agentica
#        ^^^^^^ entity.name.type.agentica
end
# <--- keyword.control.agentica

enum Shape[T]
# <---- storage.type.enum.agentica
#    ^^^^^ entity.name.type.enum.agentica
#          ^ entity.name.type.agentica
  Circle(Float)
# ^^^^^^ variable.other.enummember.agentica
#        ^^^^^ support.type.builtin.agentica
  Empty
# ^^^^^ variable.other.enummember.agentica
end

def area(shape: Shape, p: Point, width: Int = 80) -> Float
# <--- storage.type.function.agentica
#   ^^^^ entity.name.function.agentica
#        ^^^^^ variable.parameter.agentica
#               ^^^^^ entity.name.type.agentica
#                      ^ variable.parameter.agentica
#                                ^^^^^ variable.parameter.agentica
#                                             ^^ constant.numeric.integer.agentica
#                                                 ^^ keyword.operator.arrow.agentica
#                                                    ^^^^^ support.type.builtin.agentica
  total = p.x + 1
# ^^^^^ variable.other.readwrite.agentica
#       ^ keyword.operator.assignment.agentica
#          ^ punctuation.accessor.agentica
#           ^ variable.other.property.agentica
#             ^ keyword.operator.arithmetic.agentica
  count: Int = 0
# ^^^^^ variable.other.readwrite.agentica
#        ^^^ support.type.builtin.agentica
  xs = [1].map do |item| item * 2 end
#          ^^^ entity.name.function.member.agentica
#              ^^ keyword.control.agentica
#                  ^^^^ variable.parameter.agentica
#                                 ^^^ keyword.control.agentica
  ys = xs.filter do |n: Int| n > 0 end
#                    ^ variable.parameter.agentica
#                       ^^^ support.type.builtin.agentica
  puts(total)
# ^^^^ entity.name.function.agentica
  IO.puts(total)
# ^^ support.type.builtin.agentica
#    ^^^^ entity.name.function.agentica
  rows = Models.load!(LIMIT)
#        ^^^^^^ entity.name.namespace.agentica
#               ^^^^^ entity.name.function.agentica
  c = Shape.Circle(1.0)
#     ^^^^^ entity.name.type.agentica
#           ^^^^^^ variable.other.enummember.agentica
#                  ^^^ constant.numeric.float.agentica
  item = Point(x: 1, label: nil)
#              ^ variable.parameter.named.agentica
#                    ^^^^^ variable.parameter.named.agentica
#                           ^^^ constant.language.nil.agentica
  f = &area
#     ^ keyword.operator.reference.agentica
#      ^^^^ entity.name.function.agentica
  g = &Models.load
#      ^^^^^^ entity.name.namespace.agentica
#             ^^^^ entity.name.function.agentica
  n = xs.size
#        ^^^^ variable.other.property.agentica
  e = xs.empty?
#        ^^^^^^ entity.name.function.member.agentica
  sum = xs |> List.sum()
#          ^^ keyword.operator.pipe.agentica
  case shape
# ^^^^ keyword.control.conditional.agentica
    Shape.Circle(r) if r > 0 -> return r
#                   ^^ keyword.control.conditional.agentica
#                            ^^ keyword.operator.arrow.agentica
#                               ^^^^^^ keyword.control.return.agentica
    ok(v) -> return 1.5
#   ^^ entity.name.function.agentica
    _ -> return nil
#   ^ variable.language.anonymous.agentica
  end
  for x in 1..3 do
# ^^^ keyword.control.loop.agentica
#       ^^ keyword.control.loop.agentica
#           ^^ keyword.operator.range.agentica
    next
#   ^^^^ keyword.control.loop.agentica
  end
  while not done? and true
# ^^^^^ keyword.control.loop.agentica
#       ^^^ keyword.operator.logical.agentica
#           ^^^^^ variable.other.readwrite.agentica
#                 ^^^ keyword.operator.logical.agentica
#                     ^^^^ constant.language.boolean.agentica
    break # stop
#   ^^^^^ keyword.control.loop.agentica
#         ^^^^^^ comment.line.number-sign.agentica
  end
  r = try parse(row)
#     ^^^ keyword.control.exception.agentica
  return total
end
