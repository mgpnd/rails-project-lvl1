# frozen_string_literal: true

module HexletCode
  module Tag
    def self.build(tag, attributes = {}, &block)
      options = attributes[:options] || {}
      multiline = !!options[:multiline]

      html_keys = attributes.keys.reject { |key| key == :options }
      html_attributes = attributes.slice(*html_keys)

      output = ''
      output += tag_opening(tag)
      html_attributes.each { |name, value| output += tag_attribute(name, value) }

      if block.nil?
        output += tag_self_close
      else
        output += tag_content(multiline: multiline, &block)
        output += tag_close(tag)
      end

      output
    end

    def self.tag_opening(tag)
      "<#{tag}"
    end

    def self.tag_attribute(name, value)
      " #{name}=\"#{value}\""
    end

    def self.tag_content(multiline: false, &block)
      content = block.call
      '>' \
      "#{multiline ? "\n  " : ''}" \
      "#{content}" \
      "#{multiline ? "\n" : ''}"
    end

    def self.tag_close(tag)
      "</#{tag}>"
    end

    def self.tag_self_close
      ' />'
    end
  end
end
