# frozen_string_literal: true

module HexletCode
  class Form
    attr_reader :object, :output

    def initialize(object)
      @object = object
      @output = []
    end

    def input(name, as: nil, collection: nil)
      output << Tag.build('label', for: name) { humanize_name(name) }
      output << input_for(name, as: as, collection: collection)
    end

    def submit(value: 'Save')
      output << Tag.build('input', type: 'submit', name: 'commit', value: value)
    end

    def select(name, options, value: nil)
      Tag.build('select', name: name, options: { multiline: true }) do
        options.map do |opt_value|
          attributes = { value: opt_value }
          attributes[:selected] = true if opt_value == value
          Tag.build('option', attributes) { opt_value }
        end.join("\n")
      end
    end

    def textarea(name, value, cols: 20, rows: 40)
      Tag.build(
        'textarea',
        name: name,
        cols: cols,
        rows: rows
      ) { value }
    end

    def to_s
      output.join("\n")
    end

    private

    def input_for(name, as: nil, collection: nil)
      value = object.public_send(name)

      case as
      when :select
        select(name, collection, value: value)
      when :text
        textarea(name, value)
      else
        Tag.build('input', type: 'text', name: 'name', value: value)
      end
    end

    def humanize_name(name)
      result = name.to_s.dup
      result.gsub!(/_id$/, '')
      result.gsub!(/_/, ' ')
      result.gsub!(/^\w/) { Regexp.last_match(0).upcase }
    end
  end
end
