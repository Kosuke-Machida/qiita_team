module MarkdownHelper
  def markdown(text)
    unless @markdown
      renderer = Redcarpet::Render::HTML.new(renderer, tables: true)
      @markdown = Redcarpet::Markdown.new(renderer)
    end
    @markdown.render(text).html_safe
  end
end
