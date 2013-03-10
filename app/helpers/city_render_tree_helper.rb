module CityRenderTreeHelper
  class Render
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        @h, @options = h, options

        node = options[:node]
        node.root? ? "
          <div class='span3'><div class='well well-small'>
            <h2 class='no-margin'>#{ show_link }</h2>
            #{ children }
          </div></div>
        "
            : "<li>#{ show_link }</li>"
      end

      def show_link
        "#{ h.link_to_category(options[:node], options[:city]) }"
      end

      def children
        unless options[:children].blank?
          "<ul>#{ options[:children] }</ul>"
        end
      end

    end
  end
end
