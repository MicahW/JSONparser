require_relative 'json_parser'

test_hash = { "key1" => "value1", "key2" => ["1",["a","b"],"3"]}
#test_hash["hash_key"] = { "inner_key" => "inner_value" }
#test_hash["hash_key2"] = { "inner_key" => "inner_value" }
#test_hash["hash_key"]["x"] = { "inner_key" => "inner_value" }
puts(toJSON(test_hash))
