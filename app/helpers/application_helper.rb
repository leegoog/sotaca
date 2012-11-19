require 'redcarpet/compat'

module ApplicationHelper

  def get_cart
    @cart = current_cart
  end
  
  def markdown(text)  
    options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis]  
    
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
        :hard_wrap => true, :filter_html => true, :autolink => true, :no_intraemphasis => true)
    markdown.render(text).html_safe  
  end


end
