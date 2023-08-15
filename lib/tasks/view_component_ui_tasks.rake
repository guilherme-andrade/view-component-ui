# frozen_string_literal: true

def add_pseudo_elements(payload, property_name, value)
  ViewComponentUI.config.pseudo_elements.map { :"_#{_1}" }.each do |pseudo_element|
    payload[pseudo_element] ||= {}
    payload[pseudo_element][property_name] = value
  end
end

def add_pseudo_classes(payload, property_name, value)
  ViewComponentUI.config.pseudo_classes.map { :"_#{_1}" }.each do |pseudo_class|
    payload[pseudo_class] ||= {}
    payload[pseudo_class][property_name] = value
    add_pseudo_elements(payload[pseudo_class], property_name, value)
  end
end

def add_breakpoints(payload, property_name, value)
  ViewComponentUI.config.breakpoints.each do |breakpoint|
    payload[breakpoint] ||= {}
    payload[breakpoint][property_name] = value
    add_pseudo_classes(payload[breakpoint], property_name, value)
    add_pseudo_elements(payload[breakpoint], property_name, value)
  end
end

namespace :view_component_ui do
  task export: :environment do
    style_option_properties = ViewComponentUI::StyledComponent.style_option_properties
    class_builder = ViewComponentUI::ClassListBuilder.new

    classes = style_option_properties.each_with_object([]) do |(property_name, properties), class_memo|
      options = properties[:options]

      options.each do |option|
        builder_payload = {}
        builder_payload[property_name] = option

        # add_pseudo_classes(builder_payload, property_name, option)
        # add_pseudo_elements(builder_payload, property_name, option)
        # add_breakpoints(builder_payload, property_name, option)

        class_memo << class_builder.call(**builder_payload)
      end
    end

    File.open('tmp/style_option_classes.txt', 'w') do |file|
      file.puts(classes.flatten)
    end
  end
end
