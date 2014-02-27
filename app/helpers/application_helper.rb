module ApplicationHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end
  def flash_class(level)
    case level
      when :notice then "alert-box"
      when :success then "alert-box success"
      when :error   then "alert-box warning"
      when :alert   then "alert-box alert"
    end
  end
end
