# frozen_string_literal: true

module HexletCode
  class Form
    attr_reader :object, :output

    def initialize(object)
      @object = object
      @output = []
    end

    def input(name, options = {})
      output << Tag.new('label', for: name) { humanize_name(name) }
      output << input_for(name, **options)
    end

    def submit(value = 'Save')
      output << Tag.new('input', type: 'submit', name: 'commit', value: value)
    end

    def select(name, collection: [], value: nil, **attributes)
      Tag.new('select', name: name, options: { multiline: true }, **attributes) do
        collection.map do |opt_value|
          option_attrs = { value: opt_value }
          option_attrs[:selected] = true if opt_value == value
          Tag.new('option', option_attrs) { opt_value }
        end
      end
    end

    def textarea(name, value: nil, cols: 20, rows: 40, **attributes)
      Tag.new(
        'textarea',
        name: name,
        cols: cols,
        rows: rows,
        **attributes
      ) { value }
    end

    private

    # rubocop:disable Naming/MethodParameterName
    def input_for(name, as: nil, **attributes)
      value = object.public_send(name)

      case as
      when :select
        select(name, value: value, **attributes)
      when :text
        textarea(name, value: value, **attributes)
      else
        Tag.new('input', type: 'text', name: name, value: value, **attributes)
      end
    end
    # rubocop:enable Naming/MethodParameterName

    def humanize_name(name)
      result = name.to_s.dup
      result.gsub!(/_id$/, '')
      result.gsub!(/_/, ' ')
      result.gsub!(/^\w/) { Regexp.last_match(0).upcase }
    end
  end
end
