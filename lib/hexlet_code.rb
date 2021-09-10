# frozen_string_literal: true

require_relative 'hexlet_code/version'

module HexletCode
  autoload :Configuration, 'hexlet_code/configuration'
  autoload :Error, 'hexlet_code/error'
  autoload :Form, 'hexlet_code/form'
  autoload :FormBuilder, 'hexlet_code/form_builder'
  autoload :FormInputs, 'hexlet_code/form_inputs'
  autoload :Tag, 'hexlet_code/tag'
  autoload :Serializers, 'hexlet_code/serializers'

  def self.form_for(object, url: nil, &block)
    form_tag = config.form_builder.build(object, url: url, &block)
    config.serializer.serialize(form_tag)
  end

  def self.config
    @config ||= Configuration.new
  end

  def self.configure
    yield config
  end
end
