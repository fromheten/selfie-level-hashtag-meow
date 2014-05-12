class ImageEditingController < UIViewController
  attr_accessor :image

  def initWithImage(image)
    initWithNibName(nil, bundle:nil)
    self.image = image
    self.title = "Image Editing View"
    self
  end
  def viewDidLoad
    super


  end
end
