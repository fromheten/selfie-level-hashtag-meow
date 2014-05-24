class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible

    @camera_controller = CameraController.alloc.initWithNibName(nil, bundle: nil)
    @navigation_controller = UINavigationController.alloc.initWithRootViewController(@camera_controller)
    @window.rootViewController = @navigation_controller
    true
  end
end
