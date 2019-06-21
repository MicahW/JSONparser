# PRIVATE METHODS
def indent(depth)
    space_string=""
    (0...depth).each do |i|
        space_string += "  "
    end
    return space_string
end

def writeElement(element,depth)
    json = ""
    if element.is_a?(Hash) # Hash
        json += "{\n"
        keys = element.keys
        (0...keys.size).each do |i|
            key = keys[i]
            if !key.is_a?(String)
                raise "Each key within a hash must be of type string"
            end
            json += indent(depth+1) + "\"#{key}\": "
            json += writeElement(element[key],depth+1)
            if i != keys.size-1
                json += ","
            end
            json += "\n"
        end
        json += indent(depth) + "}"
    end

    if element.is_a?(Array) # Array
        json += "[\n"
        (0...element.size).each do |i|
            json += indent(depth+1)
            json += writeElement(element[i],depth+1)
            if i != element.size-1
                json += ","
            end
            json += "\n"
        end
        json += indent(depth) + "]"
    end

    if element.is_a?(String) # String
        json += "\"#{element}\""
    end

    if element.is_a?(Integer) || element.is_a?(TrueClass) || 
            element.is_a?(FalseClass) # Integer, Boolean
        json += "#{element}"
    end
    
    if element.is_a?(NilClass) # Nil
        json += "null"
    end

    return json
end

class Tockenizer

    def initialize(str)
        @tockens = str.split("")
        @tockens.delete(" ")
        @tockens.delete("\n")
        @tockens.delete("\t")
        @size = @tockens.size()
        @index = 0
    end

    def next()
        if @index >= @size
            return Nil
        end
        return @tockens[@index]
    end

    def pop()
        if @index >= @size
            return Nil
        end
        @index += 1
        return @tockens[@index-1]
    end

    def expect(char)
        if @index >= @size
            raise "Expected #{char} but end of input"
        end
        
        if @tockens[@index] != char
            raise "Expected #{char} but got #{@tockens[@index]}"
        end
    end
end






# PUBLIC METHODS
def toJSON(object)
    if !object.is_a?(Hash)
        raise "The object passed here must be of type hash"
    end
    json = writeElement(object,0) + "\n"
end