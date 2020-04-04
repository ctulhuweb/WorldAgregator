module HomeHelper
  def link_active?(link_path)
    current_page?(link_path)
  end

  def link_active_to(name = nil, options = nil, html_options = nil, &block)
    html_options[:class] << " active" if link_active?(options)
    link_to(name, options, html_options, &block)
  end
end
