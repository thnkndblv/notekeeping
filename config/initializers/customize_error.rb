ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  html_tag.html_safe
end
