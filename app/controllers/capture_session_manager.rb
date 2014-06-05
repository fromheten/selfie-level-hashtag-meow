class CaptureSessionManager
  attr_accessor :captureSession, :previewLayer

  def init
    super
    self.setCaptureSession(AVCaptureSession.alloc.init)
    self
  end

  def addVideoPreviewLayer
    self.setPreviewLayer(AVCaptureVideoPreviewLayer.alloc.initWithSession(self.captureSession))
    self.previewLayer.setVideoGravity(AVLayerVideoGravityResizeAspectFill)
  end

  def addVideoInput
    videoDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    if videoDevice
      error = Pointer.new("@")
      videoIn = AVCaptureDeviceInput.deviceInputWithDevice(videoDevice, error: error)
      if !error[0]
        if self.captureSession.canAddInput(videoIn)
          self.captureSession.addInput(videoIn)
        else
          NSLog "Could not add video input"
        end
      else
        NSLog "Could not create video input: #{error}"
      end
    else
      NSLog "Could not create video capture device"
    end
  end
end
