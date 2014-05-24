class CameraController < UIViewController
  def viewDidLoad
    super

    self.view.backgroundColor = UIColor.whiteColor
    self.title = "Camera Controller"

    def send_to_image_editor(image)
        image_editing_viewcontroller = ImageEditingController.alloc.initWithImage(image)
        self.navigationController.pushViewController(image_editing_viewcontroller, animated:true)
    end

    if(BW::Device.camera.rear?)
      BW::Device.camera.rear.picture(media_types: [:image]) do |result|
        image = result[:original_image] # This is an UIImage

        self.send_to_image_editor(image)
      end
    else
      puts "no camera, yo"

      nsdata_of_image = NSData.dataWithContentsOfFile(File.join(NSBundle.mainBundle.resourcePath, 'nyancat.jpg'))

      # Make UIImage of it
      image = UIImage.imageWithData(nsdata_of_image, scale: 4)

      self.send_to_image_editor(image)
    end
  end
end
