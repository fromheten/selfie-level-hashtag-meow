class CameraController < UIViewController
  def viewDidLoad
    super

    self.view.backgroundColor = UIColor.whiteColor
    self.title = "Camera Controller"

    BW::Device.camera.rear.picture(media_types: [:image]) do |result|
    end
  end
end
