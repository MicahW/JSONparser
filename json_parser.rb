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
    if element.is_a?(Hash)
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
    if element.is_a?(String)
        json += "\"#{element}\""
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