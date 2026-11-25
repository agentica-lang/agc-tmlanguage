# SYNTAX TEST "source.agentica" "safe navigation and function references"

def main() -> Void
  city = user&.address&.city
#            ^^ keyword.operator.safe-navigation.agentica
#              ^^^^^^^ variable.other.property.agentica
#                     ^^ keyword.operator.safe-navigation.agentica
#                       ^^^^ variable.other.property.agentica
  user&.save(1)
#     ^^ keyword.operator.safe-navigation.agentica
#       ^^^^ entity.name.function.member.agentica
  done = list&.empty?
#            ^^ keyword.operator.safe-navigation.agentica
#              ^^^^^^ entity.name.function.member.agentica
  name = a.address&.city.unwrap_or("?")
#                 ^^ keyword.operator.safe-navigation.agentica
#                   ^^^^ variable.other.property.agentica
#                        ^^^^^^^^^ entity.name.function.member.agentica
  total = xs.map(&double)&.size
#                ^ keyword.operator.reference.agentica - keyword.operator.safe-navigation.agentica
#                 ^^^^^^ entity.name.function.agentica
#                        ^^ keyword.operator.safe-navigation.agentica
#                          ^^^^ variable.other.property.agentica
  both = a && b
#          ^^ keyword.operator.logical.agentica
  items&.each do |item|
#      ^^ keyword.operator.safe-navigation.agentica
#        ^^^^ entity.name.function.member.agentica
    puts(item)
  end
  road = user
    &.address
#   ^^ keyword.operator.safe-navigation.agentica
#     ^^^^^^^ variable.other.property.agentica
end
