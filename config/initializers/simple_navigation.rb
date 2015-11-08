require "#{Rails.root}/lib/simple_navigation/renderer/bootstrap_renderer.rb"

SimpleNavigation.register_renderer bootstrap_renderer:  SimpleNavigation::Renderer::BootstrapRenderer
