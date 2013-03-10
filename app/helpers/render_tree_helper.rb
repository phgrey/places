# DOC:
# We use Helper Methods for tree building,
# because it's faster than View Templates and Partials

# SECURITY note
# Prepare your data on server side for rendering
# or use h.html_escape(node.content)
# for escape potentially dangerous content
module RenderTreeHelper
  class Render
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        @h, @options = h, options
        cls = !options[:selected].nil? && ((options[:node].id == options[:selected].id) || (options[:node].id == options[:selected].parent_id)) ? 'active' : ''
        "<li class='#{cls}'>#{ show_link }#{ children }</li>"
      end

      def show_link
        h.link_to_category(options[:node], options[:city])
      end

      def children
        unless options[:children].blank?
          '<ul>' + options[:children] + '</ul>'
        end
      end

    end
  end
end