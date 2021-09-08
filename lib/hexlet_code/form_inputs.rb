# frozen_string_literal: true

require_relative 'form_inputs/base'
require_relative 'form_inputs/input'
require_relative 'form_inputs/select'
require_relative 'form_inputs/textarea'

module HexletCode
  module FormInputs
    INPUTS_MAP = {
      select: FormInputs::Select,
      text: FormInputs::Textarea
    }.freeze

    def self.input_for(key, name:, label: nil, **attributes)
      (INPUTS_MAP[key] || FormInputs::Input).new(
        name, label: label, **attributes
      )
    end
  end
end
