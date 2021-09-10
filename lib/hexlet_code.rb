# frozen_string_literal: true

require_relative 'hexlet_code/version'

module HexletCode
  autoload :Configuration, 'hexlet_code/configuration'
  autoload :Error, 'hexlet_code/error'
  autoload :Form, 'hexlet_code/form'
  autoload :FormInputs, 'hexlet_code/form_inputs'
  autoload :Tag, 'hexlet_code/tag'
  autoload :Serializers, 'hexlet_code/serializers'

  def self.form_for(object, url: nil)
    (raise Error, 'Missing block in HexletCode.form_for') unless block_given?

    form = Form.new(object)
    yield form

    action = url.nil? ? '#' : url

    form_tag = Tag.new(
      'form',
      action: action,
      method: 'post',
      options: { multiline: true }
    )
    form_tag.content = form.output
    config.default_serializer.serialize(form_tag)
  end

  def self.config
    @config ||= Configuration.new
  end

  def self.configure
    yield config
  end
end
