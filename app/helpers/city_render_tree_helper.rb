module CityRenderTreeHelper
  class Render
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        @h, @options = h, options

        node = options[:node]
        node.root? ? "
          <div class='span3'><div class='well'>
            <h4>#{ show_link }</h4>
            #{ children }
          </div></div>
        "
            : "<li>#{ show_link }</li>"
      end

      def show_link
        node = options[:node]
        url  = h.city_category_path(:city_id =>options[:city].friendly_id, :caturlpath => node.caturlpath)
        title_field = options[:title]

        "#{ h.link_to(node.send(title_field), url) }"
      end

      def children
        unless options[:children].blank?
          "<ol>#{ options[:children] }</ol>"
        end
      end

    end
  end
end
