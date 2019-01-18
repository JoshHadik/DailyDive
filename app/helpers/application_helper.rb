module ApplicationHelper
  def editable_text(resource, attribute, placeholder: "Enter #{attribute}...")
    attribute = attribute.to_s
    value = resource.send(attribute)
    resource_type = resource.class.name.downcase
    url = send("resource_#{resource_type}_path", resource)
    resource_id = resource.id

    content_tag(:span, class: "editable-text-container") do
      content_tag(:span, value, class: "editable-text", contenteditable: true, placeholder: placeholder, data: {"dynamic-tag": "#{resource_type}-#{resource_id}-#{attribute}"}) +
      hidden_field_tag("_action", "put", url: url, attribute: attribute, resourcetype: resource_type)
    end
  end

  def dynamic_text(resource, attribute, placeholder: "N/A")
    attribute = attribute.to_s
    value = resource.send(attribute)
    value = placeholder if value.empty?
    resource_type = resource.class.name.downcase
    resource_id = resource.id


    content_tag(:span, value, class: "dynamic-text", data: {"dynamic-tag": "#{resource_type}-#{resource_id}-#{attribute}"})
  end
end
