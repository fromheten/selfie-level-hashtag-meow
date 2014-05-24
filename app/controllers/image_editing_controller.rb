class ImageEditingController < UIViewController
  attr_accessor :image

  def initWithImage(image)
    initWithNibName(nil, bundle:nil)
    scaled_image = UIImage.imageWithCGImage(image.CGImage, scale: 6, orientation:image.imageOrientation)
    self.image = scaled_image
    self
  end
  def viewDidLoad
    super
    self.title = "Meow View"
    self.view.backgroundColor = UIColor.whiteColor

    # Make one container view where the image is shown
    # image_view_container should be a square, with the width of the device screen
    device_width = Device.screen.width
    @image_view_container = UIView.alloc.initWithFrame(CGRect.new([0, 50], [device_width, device_width]))
    @image_view_container.backgroundColor = UIColor.grayColor
    self.view.addSubview(@image_view_container)
    # Make a view with the image, and place it into the container
    @image_view = UIImageView.alloc.initWithImage(self.image)
    @image_view.contentMode = UIViewContentModeScaleAspectFit

    @image_view_container.addSubview(@image_view)
    # Make one button that will add and remove filter. Above view should update

  end
end
