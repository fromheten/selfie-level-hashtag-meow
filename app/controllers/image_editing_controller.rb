class ImageEditingController < UIViewController
  attr_accessor :image

  def initWithImage(image)
    initWithNibName(nil, bundle:nil)
    if image == nil
      self.image = UIImage.imageNamed("nyancat.jpg")
    else
      # scaled_image = UIImage.imageWithCGImage(image.CGImage, scale: 6, orientation:image.imageOrientation)
      # self.image = scaled_image
      self.image = image
    end
    self
  end
  def viewDidLoad
    super
    self.title = "Image Editor"
    self.view.backgroundColor = UIColor.whiteColor

    # Make one container view where the image is shown
    # image_view_container should be a square, with the width of the device screen
    device_width = UIScreen.mainScreen.bounds.size.width
    @image_view_container = UIView.alloc.initWithFrame(CGRect.new([0, 50], [device_width, device_width]))
    @image_view_container.backgroundColor = UIColor.grayColor
    self.view.addSubview(@image_view_container)
    # Make a view with the image, and place it into the container
    @image_view = UIImageView.alloc.initWithImage(self.image)
    # UIImageWriteToSavedPhotosAlbum(self.image, nil, nil, nil)
    # @image_view.contentMode = UIViewContentModeScaleToFill

    @image_view_container.addSubview(@image_view)
    # Make one button that will add and remove filter. Above view should update

  end
end
