require 'redcarpet/compat'

module ApplicationHelper

  def get_cart
    @cart = current_cart
  end
  
  def markdown(text)  
    options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis]  
    Markdown.new(text, *options).to_html.html_safe  
  end


end
