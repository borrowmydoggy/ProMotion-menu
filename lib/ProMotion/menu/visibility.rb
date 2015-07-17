module ProMotion; module Menu
  module Visibility

    def show(side, animated=true)
      self.show_left(animated) if side == :left
      self.show_right(animated) if side == :right
    end

    def show_left(animated=true)
      self.showLeftViewAnimated(animated, completionHandler:nil)
    end

    def show_right(animated=true)
      openDrawerSide MMDrawerSideRight, animated: animated, completion: default_completion_block
    end

    def hide(animated=true)
      self.hideLeftViewAnimated(animated, completionHandler:nil)
    end

    def toggle(side, animated=true)
      toggle_left(animated) if side == :left
      toggle_right(animated) if side == :right
    end

    def toggle_left(animated=true)
      show_left(animated)
    end

    def toggle_right(animated=true)
      show_right(animated)
    end

  end
end; end
