require 'redcarpet'

module ReceipesHelper
  
  def description_as_html(description)
    options = {
        filter_html:     true,
        hard_wrap:       true,
        link_attributes: { rel: 'nofollow', target: "_blank" , class: "underline"},
        space_after_headers: true,
        fenced_code_blocks: true,
        safe_links_only: true,
        tables: true,
    }
    extensions = {
        autolink:           true,
        superscript:        true,
        disable_indented_code_blocks: true,
        strikethrough: true,
        space_after_headers: true,
        tables: true,
        quote: true,
        hard_wrap:       true,
    }
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(options), extensions)
    return if description.nil? || description.empty?
    markdown.render(description).html_safe
  end
end
