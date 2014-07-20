class CaptureSessionManager
  attr_accessor :captureSession, :previewLayer, :stillImageOutput, :stillImage #obj c properties

  def init
    super
    self.setCaptureSession(AVCaptureSession.alloc.init)
    self
  end

  def addStillImageOutput
    self.setStillImageOutput(AVCaptureStillImageOutput.alloc.init)
    outputSettings = {AVVideoCodecKey => AVVideoCodecJPEG }

    self.stillImageOutput.outputSettings = outputSettings

    videoConnection = nil

    self.stillImageOutput.connections.each do |connection|
      connection.inputPorts.each do |port|
        if (port.mediaType == AVMediaTypeVideo)
          videoConnection = connection
          break;
        end
      end
      if videoConnection
        break
      end
    end
    self.captureSession.addOutput(self.stillImageOutput)
  end

  def captureStillImage
    videoConnection = nil;
    self.stillImageOutput.connections.each do |connection|
      connection.inputPorts.each do |port|
        if port.mediaType == AVMediaTypeVideo
          videoConnection = connection
          break;
        end
      end
      if (videoConnection)
        break;
      end
    end
    self.stillImageOutput.captureStillImageAsynchronouslyFromConnection(videoConnection,
      completionHandler: lambda do |imageDataSampleBuffer, error|
        # exifAttachments = CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, nil)

        imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
        image = UIImage.alloc.initWithData(imageData)
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)

        # Ugly hack: open the next viewcontroller in the app's flow
        UIApplication.sharedApplication.delegate.instance_variable_get("@window").rootViewController.topViewController.open_image_editor(image)
        self.setStillImage(image)
      end
                                                                       )
  end
  ## END OF NEW

  def addVideoPreviewLayer
    self.setPreviewLayer(AVCaptureVideoPreviewLayer.alloc.initWithSession(self.captureSession))
    self.previewLayer.setVideoGravity(AVLayerVideoGravityResizeAspectFill)
  end

  def addVideoInput
    videoDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    if videoDevice
      error = Pointer.new("@")
      if videoDevice.isWhiteBalanceModeSupported(AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance)
        if videoDevice.lockForConfiguration nil
          videoDevice.setWhiteBalanceMode(AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance)
          videoDevice.unlockForConfiguration()
        end
      end
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
