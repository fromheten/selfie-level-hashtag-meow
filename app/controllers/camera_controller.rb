class CameraController < UIViewController
  attr_accessor :captureManager

  def init
    super
  end

  def initWithForegroundImage(image)
    # This controller shows a camera, and overlays a pet on there. Kawaii!
    self.init
    self.foregroundUIImage = image
    self
  end

  def viewDidLoad
    self.view.backgroundColor = UIColor.whiteColor

    self.setCaptureManager(CaptureSessionManager.alloc.init)#.autorelease)
    self.captureManager.addVideoInput
    self.captureManager.addVideoPreviewLayer

    screen_width = UIScreen.mainScreen.bounds.size.width;
    layerRect = CGRectMake(0, self.navigationController.toolbar.frame.size.height,
                           screen_width, screen_width)

    self.captureManager.previewLayer.setBounds(layerRect)
    self.captureManager.previewLayer.setPosition(CGPointMake(CGRectGetMidX(layerRect), CGRectGetMidY(layerRect)))
    self.view.layer.addSublayer(self.captureManager.previewLayer)

    #TODO Get cat's image
    overlayImageView = UIImageView.alloc.initWithImage(UIImage.imageNamed("nyancat.jpg"))
    overlayImageView.frame = [[30, 100], [260, 200]]
    self.view.addSubview overlayImageView

    take_picture_button = UIButton.buttonWithType UIButtonTypeRoundedRect
    take_picture_button.setTitle("Meow!", forState: UIControlStateNormal)
    take_picture_button.setFrame(CGRectMake(130, 450, 60, 30))
    take_picture_button.addTarget(self, action:'take_picture', forControlEvents:UIControlEventTouchUpInside)
    self.view.addSubview(take_picture_button)

    flash_toggle_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    flash_toggle_button.setTitle("Flash", forState: UIControlStateNormal)
    flash_toggle_button.setFrame CGRectMake(70, 450, 60, 30)
    flash_toggle_button.addTarget(self, action:'toggle_flash', forControlEvents: UIControlEventTouchUpInside)
    self.view.addSubview(flash_toggle_button)

    captureManager.captureSession.startRunning
  end

  def toggle_flash
    device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    if (device.hasTorch)
      device.lockForConfiguration(nil)
      if (device.torchMode.to_s == "1") #ON
        device.setTorchMode(AVCaptureTorchModeOff)
      else
        device.setTorchMode(AVCaptureTorchModeOn)
      end
      device.unlockForConfiguration()
    end
  end

  def take_picture
    self.captureManager.addStillImageOutput
    self.captureManager.captureStillImage
    # image = self.captureManager.stillImage
  end

  def open_image_editor(ui_image)
    image_editing_controller = ImageEditingController.alloc.initWithImage(ui_image)
    self.navigationController.pushViewController(image_editing_controller, animated: true)
  end
end
