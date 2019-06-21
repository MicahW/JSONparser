require_relative 'json_parser'

test_hash = { "key1" => nil, "key2" => [1,"here",false,nil]}
test_hash["hash_key"] = { "inner_key" => "inner_value" }
test_hash["hash_key2"] = { "inner_key" => "inner_value" }
test_hash["hash_key"]["x"] = { "inner_key" => [1,nil] }
#puts(toJSON(test_hash))
str = IO.read("data/simple.json")
hash = fromJSON(str)
puts hash