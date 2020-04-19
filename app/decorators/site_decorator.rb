class SiteDecorator < Decorator

  def url_info
    "Url: #{url}"
  end

  def status_info
    "Status: #{active? ? 'Active' : 'Not active'}"
  end

  def active_btn_title
    active? ? "Disable" : "Enable"
  end

  def active_btn_style
    active? ? "danger" : "success"
  end
end