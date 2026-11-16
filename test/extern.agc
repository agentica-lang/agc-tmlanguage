# SYNTAX TEST "source.agentica" "extern blocks and extern modules"

extern "demo"
# <----- storage.type.extern.agentica
#      ^^^^^^ string.quoted.double.agentica
  struct DemoPair
#        ^^^^^^^^ entity.name.type.struct.agentica
    x: C.Int32
#   ^ variable.other.property.agentica
#      ^ entity.name.type.agentica
#        ^^^^^ entity.name.type.agentica
  end
  resource Acc, free: demo_acc_close
# ^^^^^^^^ storage.type.resource.agentica
#          ^^^ entity.name.type.resource.agentica
#               ^^^^ variable.parameter.named.agentica
#                   ^ punctuation.separator.key-value.agentica
#                     ^^^^^^^^^^^^^^ entity.name.function.agentica
  resource Conn, free_ref: PQfinish
#          ^^^^ entity.name.type.resource.agentica
#                ^^^^^^^^ variable.parameter.named.agentica
#                           ^^^^^^^^ entity.name.function.agentica - entity.name.type.agentica
  resource Thing, free: C.Function
#                       ^ entity.name.type.agentica
#                        ^ punctuation.accessor.agentica
#                         ^^^^^^^^ entity.name.type.agentica - entity.name.function.agentica
  callback Visit(item: C.Pointer, depth: C.Int32) -> C.Bool
# ^^^^^^^^ storage.type.callback.agentica
#          ^^^^^ entity.name.type.callback.agentica
#                ^^^^ variable.parameter.agentica
#                    ^ punctuation.separator.type.agentica
#                               ^ punctuation.separator.comma.agentica
#                                 ^^^^^ variable.parameter.agentica
#                                                 ^^ keyword.operator.arrow.agentica
  ## Opens it.
# ^^^^^^^^^^^^ comment.line.documentation.agentica
  def demo_acc_open(start: C.Int64) -> Acc
# ^^^ storage.type.function.agentica
#     ^^^^^^^^^^^^^ entity.name.function.agentica
#                   ^^^^^ variable.parameter.agentica
  def demo_fill(out: C.Pointer, n: C.Int32) -> Void
#               ^^^ variable.parameter.agentica - storage.modifier.out.agentica
  def sqlite3_open(path: C.String, out db: Conn) -> C.Int32
#                                  ^^^ storage.modifier.out.agentica
#                                      ^^ variable.parameter.agentica
  def fcntl_int(fd: C.Int32, cmd: C.Int32, ..., arg: C.Int32) -> C.Int32 = "fcntl"
#                                          ^^^ keyword.operator.variadic.agentica - keyword.operator.range.agentica
#                                               ^^^ variable.parameter.agentica
#                                                                        ^         keyword.operator.assignment.agentica
#                                                                          ^^^^^^^ string.quoted.double.agentica
  compute def crunch(n: C.Int32) -> C.Int32
# ^^^^^^^ storage.modifier.compute.agentica
#         ^^^ storage.type.function.agentica
end
# <--- keyword.control.agentica

extern module "stats"
# <----- storage.type.extern.agentica
#      ^^^^^^ storage.type.module.agentica
#             ^^^^^^^ string.quoted.double.agentica
  resource Db # a handle
#          ^^ entity.name.type.resource.agentica
#             ^^^^^^^^^^ comment.line.number-sign.agentica
  ## The sum.
# ^^^^^^^^^^^^ comment.line.documentation.agentica
  def add(a: Int, b: Int) -> Int
# ^^^ storage.type.function.agentica
  compute def crunch?(n: Int) -> Int
# ^^^^^^^ storage.modifier.compute.agentica
#                 ^ entity.name.function.agentica
end
# <--- keyword.control.agentica

def resource(extern: Int, callback: Int, out: Int) -> Int
#   ^^^^^^^^ entity.name.function.agentica - storage.type.resource.agentica
#            ^^^^^^ variable.parameter.agentica - storage.type.extern.agentica
  resource = extern + callback + out
# ^^^^^^^^ variable.other.readwrite.agentica - storage.type.resource.agentica
#          ^ keyword.operator.assignment.agentica
  return resource
end
