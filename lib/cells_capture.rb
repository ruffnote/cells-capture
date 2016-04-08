require 'cell/rails'

module Cell
  class Rails
    module Capture
      extend ActiveSupport::Concern
      included do
        include ContentForExtension
      end

      attr_accessor :global_tpl

      module RenderCellExtension
        def cell(*args, &block)
          super(*args) do |cell|
            block.call(cell) if block_given?
            cell.global_tpl = self if cell.is_a? ::Cell::Rails::Capture
          end
        end
      end

      module ContentForExtension
        def content_for(name, content=nil, options={}, &block)
          # this resembles rails' own #content_for INTENTIONALLY. Due to some internal rails-thing we have to call #capture on the cell's view, otherwise,
          # rails wouldn't suppress the captured output. uncomment next line to provoke.
          #cnt = @tpl.capture(&block)
          view_flow = controller.view_context.view_flow
          if content || block_given?
            if block_given?
              options = content if content
              content = capture(&block)
            end
            if content
              options[:flush] ? view_flow.set(name, content) : view_flow.append(name, content)
            end
            nil
          else
            view_flow.get(name).presence
          end
        end
      end

    end
  end
end

# TODO: can we avoid monkey-patching #cell?
ActionView::Base.class_eval do
  include Cell::Rails::Capture::RenderCellExtension
end
