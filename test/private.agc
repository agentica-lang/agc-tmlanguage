# SYNTAX TEST "source.agentica" "the private line, private as a name, export"

LIMIT = 10

def open(id: Int) -> Int = connect(id)

private
# <------- keyword.control.private.agentica

BUFFER = 4096

private # helpers
# <------- keyword.control.private.agentica
#      ^ - keyword.control.private.agentica
#       ^ punctuation.definition.comment.agentica
#       ^^^^^^^^^ comment.line.number-sign.agentica

private	
# <------- keyword.control.private.agentica
#      ^ - keyword.control.private.agentica

private   
# <------- keyword.control.private.agentica

private	# after a tab
# <------- keyword.control.private.agentica
#       ^^^^^^^^^^^^^^ comment.line.number-sign.agentica

def connect(id: Int) -> Int = id + BUFFER

module Counter
  private
# ^^^^^^^ keyword.control.private.agentica

  def start(initial: Int) -> Int = step(initial)

  private  # not for importers
# ^^^^^^^ keyword.control.private.agentica
#          ^^^^^^^^^^^^^^^^^^^^ comment.line.number-sign.agentica

  def step(count: Int) -> Int
    private
#   ^^^^^^^ variable.other.readwrite.agentica - keyword.control.private.agentica
  end

  private
# ^^^^^^^ keyword.control.private.agentica
end
# <--- keyword.control.agentica

module Tabbed
	private
#^^^^^^^ keyword.control.private.agentica
	def f() -> Int = 1
end

module Closed
  def f() -> Int = 1
end

private
# <------- keyword.control.private.agentica

def g() -> Int = 2

struct Conn
  host: String

  private # the socket stays inside
# ^^^^^^^ keyword.control.private.agentica
#         ^^^^^^^^^^^^^^^^^^^^^^^^^ comment.line.number-sign.agentica

  socket: Int
#         ^^^ entity.name.type.agentica
end

struct Hidden
  private
# ^^^^^^^ keyword.control.private.agentica
  token: String
  secret: String
  private
# ^^^^^^^ keyword.control.private.agentica
end

struct Flags
  private: Bool
# ^^^^^^^ variable.other.property.agentica - keyword.control.private.agentica
#        ^ punctuation.separator.type.agentica
#          ^^^^ entity.name.type.agentica
end

# private as a plain name

def private(private: Int) -> Int
#   ^^^^^^^ entity.name.function.agentica - keyword.control.private.agentica
#           ^^^^^^^ variable.parameter.agentica - keyword.control.private.agentica
  private = 1
# ^^^^^^^ variable.other.readwrite.agentica - keyword.control.private.agentica
  private
# ^^^^^^^ variable.other.readwrite.agentica - keyword.control.private.agentica
  private()
# ^^^^^^^ entity.name.function.agentica - keyword.control.private.agentica
  private?
# ^^^^^^^^ variable.other.readwrite.agentica - keyword.control.private.agentica
  private!
# ^^^^^^^^ variable.other.readwrite.agentica - keyword.control.private.agentica
  private_key = 1
# ^^^^^^^^^^^ variable.other.readwrite.agentica - keyword.control.private.agentica
  f(private: 1)
#   ^^^^^^^ variable.parameter.named.agentica - keyword.control.private.agentica
  m = {private: 2}
#      ^^^^^^^ variable.parameter.named.agentica - keyword.control.private.agentica
  x.private
#   ^^^^^^^ variable.other.property.agentica - keyword.control.private.agentica
  private.size
# ^^^^^^^ variable.other.readwrite.agentica - keyword.control.private.agentica
  y = private
#     ^^^^^^^ variable.other.readwrite.agentica - keyword.control.private.agentica
  private + 1
# ^^^^^^^ variable.other.readwrite.agentica - keyword.control.private.agentica
end

private = 1
# <------- variable.other.readwrite.agentica - keyword.control.private.agentica
private(2)
# <------- entity.name.function.agentica - keyword.control.private.agentica
private.size
# <------- variable.other.readwrite.agentica - keyword.control.private.agentica
private?
# <-------- variable.other.readwrite.agentica - keyword.control.private.agentica
private_key = 2
# <----------- variable.other.readwrite.agentica - keyword.control.private.agentica
privately
# <--------- variable.other.readwrite.agentica - keyword.control.private.agentica

# strings, comments and interpolation that contain the words

s = "private"
#    ^^^^^^^ string.quoted.double.agentica - keyword.control.private.agentica
t = "export def f"
#    ^^^^^^^^^^^^ string.quoted.double.agentica - invalid.illegal.export.agentica keyword.control.export.agentica
u = "#{private}"
#      ^^^^^^^ meta.embedded.line.agentica variable.other.readwrite.agentica - keyword.control.private.agentica
# private
# <--------- comment.line.number-sign.agentica - keyword.control.private.agentica
x = 1 # export def f
#       ^^^^^^ comment.line.number-sign.agentica - invalid.illegal.export.agentica keyword.control.export.agentica
## private
# <---------- comment.line.documentation.agentica - keyword.control.private.agentica
h = <<~TEXT
private
# <------- string.unquoted.heredoc.agentica - keyword.control.private.agentica
export def f
# <------ string.unquoted.heredoc.agentica - invalid.illegal.export.agentica
TEXT

# a re-export keeps its scope

import Util from "util"

export Util.helper
# <------ keyword.control.export.agentica
#      ^^^^ entity.name.namespace.agentica
#          ^ punctuation.accessor.agentica
#           ^^^^^^ entity.name.function.agentica
export Util.Address
# <------ keyword.control.export.agentica
#      ^^^^ entity.name.type.agentica
#           ^^^^^^^ entity.name.type.agentica

# export before a declaration (Agentica 0.30) is an error, and the declaration still reads as one

export def run() -> Void
# <------ invalid.illegal.export.agentica
#      ^^^ storage.type.function.agentica
#          ^^^ entity.name.function.agentica
end

export struct Point
# <------ invalid.illegal.export.agentica
#      ^^^^^^ storage.type.struct.agentica
#             ^^^^^ entity.name.type.struct.agentica
end

export enum Color
# <------ invalid.illegal.export.agentica
#      ^^^^ storage.type.enum.agentica
#           ^^^^^ entity.name.type.enum.agentica
end

export type Names = List[String]
# <------ invalid.illegal.export.agentica
#      ^^^^ storage.type.type.agentica
#           ^^^^^ entity.name.type.alias.agentica

export TOTAL = 3
# <------ invalid.illegal.export.agentica
#      ^^^^^ variable.other.constant.agentica

export module Report
# <------ invalid.illegal.export.agentica
#      ^^^^^^ storage.type.module.agentica
#             ^^^^^^ entity.name.namespace.agentica
  def go() -> Void
    private
#   ^^^^^^^ variable.other.readwrite.agentica - keyword.control.private.agentica
  end
end

extern "libc"
  export def close(fd: C.Int32) -> C.Int32
# ^^^^^^ invalid.illegal.export.agentica
#        ^^^ storage.type.function.agentica
end

export_all = 1
# <---------- variable.other.readwrite.agentica - invalid.illegal.export.agentica keyword.control.export.agentica
