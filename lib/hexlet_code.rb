# frozen_string_literal: true

require_relative 'hexlet_code/version'
require_relative 'hexlet_code/tag'
require_relative 'hexlet_code/form'

module HexletCode
  class Error < StandardError; end

  def self.form_for(object, url: nil)
    form = Form.new(object)
    yield form

    action = url.nil? ? '#' : url

    Tag.build('form', action: action, method: 'post', options: { multiline: true }) do
      form.to_s
    end
  end
end
