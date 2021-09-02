# frozen_string_literal: true

module HexletCode
  module Tag
    def self.build(tag, attributes = {}, &block)
      options = attributes[:options] || {}

      html_attributes = attributes.compact.except(:options)

      output = tag_opening(tag)
      html_attributes.each { |name, value| output += tag_attribute(name, value) }

      return output + tag_self_close if block.nil?

      output += tag_content(multiline: options[:multiline], &block)
      output += tag_close(tag)
      output
    end

    def self.tag_opening(tag)
      "<#{tag}"
    end

    def self.tag_attribute(name, value)
      return " #{name}" if value == true

      " #{name}=\"#{value}\""
    end

    def self.tag_content(multiline: false, &block)
      content = block.call
      output = '>'

      if multiline
        output += "\n"
        output += content.split("\n")
                         .map { |line| "  #{line}" }
                         .join("\n")
        output += "\n"
      else
        output += content
      end

      output
    end

    def self.tag_close(tag)
      "</#{tag}>"
    end

    def self.tag_self_close
      ' />'
    end
  end
end
