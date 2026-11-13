# SYNTAX TEST "source.agentica" "guards and consecutive one-line defs"

def double(x: Int) -> Int = x * 2
def triple(x: Int) -> Int = x * 3
# <--- storage.type.function.agentica
#   ^^^^^^ entity.name.function.agentica
#                         ^ keyword.operator.assignment.agentica
def parse(text: String) -> Result[Int] = try text.to_i
#                                        ^^^ keyword.control.exception.agentica
#                                            ^^^^ variable.other.readwrite.agentica
def squares(xs: List[Int]) -> List[Int] = xs.map { |x| x * x }
#                                            ^^^ entity.name.function.member.agentica
def greeting(name: String) -> String = "hello #{name}"
#                                      ^^^^^^^^^^^^^^^^ string.quoted.double.agentica

def clamp(x: Int, limit: Int) -> Int
  return limit if x > limit
# ^^^^^^ keyword.control.return.agentica
#        ^^^^^ variable.other.readwrite.agentica
#              ^^ keyword.control.conditional.agentica
  return if x < 0
# ^^^^^^ keyword.control.return.agentica
#        ^^ keyword.control.conditional.agentica
  return x
end

def scan(xs: List[Int]) -> Int
  total = 0
  for x in xs
    next if x < 0
#   ^^^^ keyword.control.loop.agentica
#        ^^ keyword.control.conditional.agentica
    break if x > 100
#   ^^^^^ keyword.control.loop.agentica
#         ^^ keyword.control.conditional.agentica
    total += x
  end
  return total
end

# the rules above are closed: this line is a top-level def again

def after() -> Int = 1
# <--- storage.type.function.agentica
