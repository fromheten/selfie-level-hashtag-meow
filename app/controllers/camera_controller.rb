class CameraController < UIViewController
  def viewDidLoad
    super

    self.view.backgroundColor = UIColor.whiteColor
    self.title = "Camera Controller"

    BW::Device.camera.rear.picture(media_types: [:image]) do |result|
      # On the navigationController, push an ImageEditingController instance with result
      image = result[:original_image]

      # image_view = UIImageView.alloc.initWithImage(image)
      # self.view.addSubview(image_view)

      image_editing_viewcontroller = ImageEditingController.alloc.initWithImage(image)
      self.navigationController.pushViewController(image_editing_viewcontroller, animated:true)
    end
  end
end
