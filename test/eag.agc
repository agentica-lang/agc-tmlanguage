# SYNTAX TEST "source.agentica" "EAG templates"

import EAG from "std/eag"

def page(names: List[String]) -> String
  return <<~EAG
#        ^^^^^^ string.unquoted.heredoc.agentica punctuation.definition.string.begin.agentica
#        ^^^^^^ meta.heredoc.eag.agentica
    <ul class="a\q"> \t
#   ^^^^^^^^^^^^^^^^^^^ string.unquoted.heredoc.agentica
#               ^^ string.unquoted.heredoc.agentica - constant.character.escape.agentica
#                    ^^ string.unquoted.heredoc.agentica - constant.character.escape.agentica
    #{ b: 1 } and #{name} stay text
#   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ string.unquoted.heredoc.agentica - meta.interpolation.agentica
#   ^^^^^^^^^ string.unquoted.heredoc.agentica - variable.parameter.named.agentica
#                 ^^^^^^^ string.unquoted.heredoc.agentica - punctuation.section.interpolation.begin.agentica
    <% for name in names %>
#   ^^ punctuation.section.embedded.begin.agentica
#      ^^^ keyword.control.loop.agentica
#                  ^^^^^ meta.embedded.line.agentica variable.other.readwrite.agentica
#                        ^^ punctuation.section.embedded.end.agentica
      <li><%= EAG.html_escape(name) -%>
#     ^^^^ string.unquoted.heredoc.agentica - meta.tag.eag.agentica
#         ^^^ punctuation.section.embedded.begin.agentica
#             ^^^ entity.name.namespace.agentica
#                 ^^^^^^^^^^^ entity.name.function.agentica
#                                   ^^^ punctuation.section.embedded.end.agentica
      </li> <%== name %> <%# kept: #{x} \n %> <%% raw
#           ^^^^ punctuation.section.embedded.begin.agentica
#                ^^^^ meta.embedded.line.agentica variable.other.readwrite.agentica
#                     ^^ punctuation.section.embedded.end.agentica
#                        ^^^ meta.tag.eag.agentica comment.block.eag.agentica punctuation.section.embedded.begin.agentica
#                            ^^^^^^^^^^^^^ comment.block.eag.agentica - meta.interpolation.agentica
#                                          ^^ comment.block.eag.agentica punctuation.section.embedded.end.agentica
#                                             ^^^ constant.character.escape.eag.agentica
#                                                ^^^^ string.unquoted.heredoc.agentica - meta.tag.eag.agentica
    <%- end -%>
#   ^^^ punctuation.section.embedded.begin.agentica
#       ^^^ keyword.control.agentica
#           ^^^ punctuation.section.embedded.end.agentica
    <%@ escape &EAG.html_escape %>
#   ^^^ punctuation.section.embedded.begin.agentica
#       ^^^^^^ keyword.other.directive.eag.agentica
#              ^ keyword.operator.reference.agentica
#                               ^^ punctuation.section.embedded.end.agentica
    </ul>
#   ^^^^^ string.unquoted.heredoc.agentica
  EAG
# ^^^ string.unquoted.heredoc.agentica punctuation.definition.string.end.agentica
end
# <--- keyword.control.agentica - string.agentica

def other(name: String) -> String
  return <<~EAGLE
#        ^^^^^^^^ string.unquoted.heredoc.agentica punctuation.definition.string.begin.agentica
    <%= #{name} \t
#   ^^^ string.unquoted.heredoc.agentica - meta.tag.eag.agentica
#       ^^ punctuation.section.interpolation.begin.agentica
#               ^^ constant.character.escape.agentica
  EAGLE
end
