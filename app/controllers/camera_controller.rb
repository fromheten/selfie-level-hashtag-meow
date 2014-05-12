class CameraController < UIViewController
  def viewDidLoad
    super

    self.view.backgroundColor = UIColor.whiteColor
    self.title = "Camera Controller"

    BW::Device.camera.rear.picture(media_types: [:image]) do |result|
      image_view = UIImageView.alloc.initWithImage(result[:original_image])
      self.view.addSubview(image_view)
    end
  end
end
