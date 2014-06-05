class CameraController < UIViewController
  attr_accessor :captureManager

  def init
    super
  end

  def viewDidLoad
    self.view.backgroundColor = UIColor.whiteColor

    self.setCaptureManager(CaptureSessionManager.alloc.init.autorelease)
    self.captureManager.addVideoInput
    self.captureManager.addVideoPreviewLayer
    screen_width = UIScreen.mainScreen.bounds.size.width;
    layerRect = CGRectMake(0, self.navigationController.toolbar.frame.size.height,
                           screen_width, screen_width)

    self.captureManager.previewLayer.setBounds(layerRect)
    self.captureManager.previewLayer.setPosition(CGPointMake(CGRectGetMidX(layerRect), CGRectGetMidY(layerRect)))
    self.view.layer.addSublayer(self.captureManager.previewLayer)

    #TODO Get cat's image
    overlayImageView = UIImageView.alloc.initWithImage(UIImage.imageNamed("overlaygraphic.png"))
    overlayImageView.frame = [[30, 100], [260, 200]]
    self.view.addSubview overlayImageView

    take_picture_button = UIButton.buttonWithType UIButtonTypeRoundedRect
    # take_picture_button.setImage(UIImage.imageNamed("scanbutton.png"), forState:UIControlStateNormal)
    take_picture_button.setTitle("Meow!", forState: UIControlStateNormal)
    take_picture_button.setFrame(CGRectMake(130, 450, 60, 30))
    take_picture_button.addTarget(self, action:'take_picture', forControlEvents:UIControlEventTouchUpInside)
    self.view.addSubview take_picture_button

    captureManager.captureSession.startRunning
  end

  def take_picture
    #TODO get current image

    image_editing_controller = ImageEditingController.alloc.initWithImage(nil)
    self.navigationController.pushViewController(image_editing_controller, animated: true)
  end
end
