module HomeHelper
  def link_active?(link_path)
    current_page?(link_path)
  end

  def link_active_to(name = nil, options = nil, html_options = nil, &block)
    html_options[:class] << " active" if link_active?(options)
    link_to(name, options, html_options, &block)
  end
  
  def bell_block
    icon_color = current_user.has_new_items? ? "text-warning" : "text-secondary"
    data_content = "New items: #{current_user.new_items.count}"
    options = {"data-count" => current_user.new_items.count, "data-toggle" => "popover","data-placement" => "bottom", "data-content" => data_content, :class => "#{icon_color} nav-link fa-lg",}
    icon("far", "bell", options)
  end

  def avatar_block
    title_block = content_tag("div", current_user.email, class: "text-center")
    links = [link_to("Profile", edit_user_registration_path, class: "btn btn-profile btn-outline-primary"),
              link_to("Sign out", destroy_user_session_path, class: "btn btn-outline-primary btn-sign-out-js", method: :delete)]
    content_block = content_tag "div", class: "text-center" do |c|
      links.collect { |l| content_tag(:span, l, class: "p-1")}.join.html_safe
    end
    options = {"data-content" => "#{content_block}", "data-toggle" => "popover","data-placement" => "bottom", :title => "#{title_block}", :class => "rounded-circle avatar img-thumbnail", :size => "60x60"} 
    image_tag(avatar_url(current_user), options)
  end
end
