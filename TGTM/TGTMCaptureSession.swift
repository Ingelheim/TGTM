import UIKit
import AVFoundation

class TGTMCaptureSession : AVCaptureSession {
    var captureDevice : AVCaptureDevice?
    
    override init() {
        super.init()
        setGeneralSettings()
        
        if captureDevice != nil {
            beginSession()
        }
    }
    
    func setGeneralSettings() {
        sessionPreset = AVCaptureSessionPresetMedium
        let devices = AVCaptureDevice.devices()
        
        // Loop through all the capture devices on this phone
        for device in devices {
            // Make sure this particular device supports video
            if (device.hasMediaType(AVMediaTypeVideo)) {
                // Finally check the position and confirm we've got the back camera
                if(device.position == AVCaptureDevicePosition.Front) {
                    println("RECORDING FRONT")
                    captureDevice = device as? AVCaptureDevice
                }
            }
        }
    }
    
    func beginSession() {
        var err : NSError? = nil
        self.addInput(AVCaptureDeviceInput(device: captureDevice!, error: &err))
        println("Session started")
    }
}
