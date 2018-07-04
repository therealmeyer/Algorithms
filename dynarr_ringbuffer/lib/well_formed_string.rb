# def well_formed(string) 
#   count_paren = 0 
#   count_curly = 0
#   count_bracket = 0

#   string.split("").each do |el|
#     case el 
#     when el === "(" && count_paren.even? 
#       count_paren += 1
#     when el === ")" && count_paren.odd?
#       count_paren += 1
#     when el === "[" && count_bracket.even?
#       count_bracket += 1
#     when el === "]" && count_bracket.odd?
#       count_bracket += 1
#     when el === "{" && count_curly.even?
#       count_curly += 1
#     when el === "}" && count_curly.odd?
#       count_curly += 1
#     end 
#   end
#   count = [count_paren, count_curly, count_bracket] 
#   p count
#     count.all? { |el| el.even? }
# end 


def well_formed(str)
  left_chars = []
  lookup = { '(' => ')', '[' => ']', '{' => '}' }

  str.chars.each do |char|
    if lookup.keys.include?(char)
      left_chars << char
    elsif left_chars.length == 0 || lookup[left_chars.pop] != char 
      return false 
    end 
  end 
  return left_chars.empty?
end 
