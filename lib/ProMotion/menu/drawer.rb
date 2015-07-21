module ProMotion
  module Menu
    class Drawer < LGSideMenuController
      include ::ProMotion::ScreenModule
      include Visibility

      attr_accessor :leftViewController, :rightViewController, :centerViewController

      def self.new(center, options={})
        menu = alloc.initWithRootViewController(center.navigationController)
        menu.send(:auto_setup, center, options)
        menu.prepare_screens
        menu
      end

      def auto_setup(center, options={})
        options[:center] ||= center if center
        set_attributes self, options
        self.send(:setupDefaults) if self.respond_to?(:setupDefaults)
      end

      def prepare_screens
        self.setLeftViewEnabledWithWidth(250.0, presentationStyle:LGSideMenuPresentationStyleSlideAbove, alwaysVisibleOptions:0)

        self.leftViewBackgroundColor = UIColor.colorWithWhite(1.0, alpha:0.9)
        self.leftViewSwipeGestureEnabled = false

        self.leftView.addSubview(self.leftViewController.view)

      end

      def left_controller=(c)
        self.leftViewController = prepare_controller_for_pm(c)
      end
      alias_method :left=, :left_controller=

      def left_controller
        self.leftViewController
      end
      alias_method :left, :left_controller

      def center_controller=(c)
        self.centerViewController = prepare_controller_for_pm(c)
        self.centerViewController
        open self.centerViewController
      end
      alias_method :content_controller=, :center_controller=
      alias_method :center=, :center_controller=
      alias_method :content=, :center_controller=

      def center_controller
        self.centerViewController
      end
      alias_method :content_controller, :center_controller
      alias_method :center, :center_controller
      alias_method :content, :center_controller

      def leftViewWillLayoutSubviewsWithSize(size)
        super
        self.leftViewController.view.autoresizesSubviews = true
        self.leftViewController.view.frame = CGRectMake(0.0 , 0.0, size.width, size.height)
        self.leftViewController.view.layer.masksToBounds = true
      end

      protected

      def prepare_controller_for_pm(controller)
        unless controller.nil?
          controller = set_up_screen_for_open(controller, {})
          ensure_wrapper_controller_in_place(controller, {})
          controller.navigationController || controller
        end
      end

      def default_completion_block
        -> (completed) { true }
      end

    end
  end
end
