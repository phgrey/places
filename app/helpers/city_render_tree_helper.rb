module CityRenderTreeHelper
  class Render
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        @h, @options = h, options

        node = options[:node]
        node.root? ? "
          <div class='span3'><div class='well well-small'>
            <h4>#{ show_link }</h4>
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
          "<ol>#{ options[:children] }</ol>"
        end
      end

    end
  end
end
