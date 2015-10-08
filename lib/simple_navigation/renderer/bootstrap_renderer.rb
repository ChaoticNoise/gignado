module SimpleNavigation
  module Renderer
    class BootstrapRenderer < SimpleNavigation::Renderer::Base
      def render(item_container)
        if skip_if_empty? && item_container.empty?
          ''
        else
          tag = options[:ordered] ? :ol : :ul
          content = list_content(item_container)
          content_tag(tag, content, item_container.dom_attributes.merge({class: ["nav", "navbar-nav"]}))
        end
      end

      private

      def list_content(item_container)
        item_container.items.map { |item|
          li_options = item.html_options.except(:link)
          li_content = tag_for(item)
          if include_sub_navigation?(item)
            li_content << render_sub_navigation_for(item)
          end
          content_tag(:li, li_content, li_options)
        }.join
      end
    end
  end
end
