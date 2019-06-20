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


    


# PUBLIC METHODS
def toJSON(object)
    if !object.is_a?(Hash)
        raise "The object passed here must be of type hash"
    end
    json = writeElement(object,0) + "\n"
end