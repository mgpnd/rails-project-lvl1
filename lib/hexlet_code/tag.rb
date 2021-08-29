module HexletCode
  module Tag
    def self.build(tag, attributes = {}, &block)
      output = ""
      output += tag_opening(tag)
      attributes.each { |name, value| output += tag_attribute(name, value) }

      if block.nil?
        output += tag_self_close
      else
        output += tag_content(&block)
        output += tag_close(tag)
      end

      output
    end

    private

    def self.tag_opening(tag)
      "<#{tag}"
    end

    def self.tag_attribute(name, value)
      " #{name}=\"#{value}\""
    end

    def self.tag_content(&block)
      content = block.call
      ">#{content}"
    end

    def self.tag_close(tag)
      "</#{tag}>"
    end

    def self.tag_self_close
      " />"
    end
  end
end
