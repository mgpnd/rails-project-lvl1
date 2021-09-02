# frozen_string_literal: true

module HexletCode
  class Form
    attr_reader :object, :output

    def initialize(object)
      @object = object
      @output = []
    end

    def input(name, options = {})
      output << Tag.build('label', for: name) { humanize_name(name) }
      output << input_for(name, options)
    end

    def submit(value: 'Save')
      output << Tag.build('input', type: 'submit', name: 'commit', value: value)
    end

    def select(name, collection, value: nil, **attributes)
      Tag.build('select', name: name, options: { multiline: true }, **attributes) do
        collection.map do |opt_value|
          option_attrs = { value: opt_value }
          option_attrs[:selected] = true if opt_value == value
          Tag.build('option', option_attrs) { opt_value }
        end.join("\n")
      end
    end

    def textarea(name, value, cols: 20, rows: 40, **attributes)
      Tag.build(
        'textarea',
        name: name,
        cols: cols,
        rows: rows,
        **attributes
      ) { value }
    end

    def to_s
      output.join("\n")
    end

    private

    def input_for(name, as: nil, collection: nil, cols: 20, rows: 40, **attributes)
      value = object.public_send(name)

      case as
      when :select
        select(name, collection, value: value, **attributes)
      when :text
        textarea(name, value, cols: cols, rows: rows, **attributes)
      else
        Tag.build('input', type: 'text', name: 'name', value: value, **attributes)
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
