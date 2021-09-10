# frozen_string_literal: true

module HexletCode
  module FormInputs
    autoload :Base, 'hexlet_code/form_inputs/base'
    autoload :Input, 'hexlet_code/form_inputs/input'
    autoload :Select, 'hexlet_code/form_inputs/select'
    autoload :Textarea, 'hexlet_code/form_inputs/textarea'

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
