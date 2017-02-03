class HtmlDateInput < SimpleForm::Inputs::Base

  def input(wrapper_options)
    template.content_tag(:div, class: 'input-group') do
      template.concat content_tag(:div, simbol, class: 'input-group-addon')
      template.concat @builder.text_field(attribute_name, input_html_options)
    end
  end

  def input_html_options
    super.merge class: 'form-control', type: 'date'
  end

  def simbol
    content_tag(:i, '', class: 'fa fa-calendar-o', 'aria-hidden' => true)
  end

end
