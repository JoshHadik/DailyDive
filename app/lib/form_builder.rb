class FormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::CaptureHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Context

  def field_for(attribute)
    content_tag(:div, class: "form-field #{attribute}-field") do
      yield +
      (any_errors_for?(attribute) ? error_tag(attribute) : nil.to_s)
    end
  end

  def any_errors_for?(attribute)
    self.object.errors.include?(attribute)
  end

  def error_tag(attribute)
    content_tag(:span, class: "error-tag", style: "display: none;") do
      self.object.errors.full_messages_for(attribute).first
    end
  end
end
