import UIKit
import AVFoundation

class TGTMCaptureSession : AVCaptureSession {
    var captureVideoDevice : AVCaptureDevice?
    var captureAudioDevice : AVCaptureDevice?
    
    override init() {
        super.init()
        setGeneralSettings()
        
        if bothDevicesSet() {
            beginSession()
        }
    }
    
    func setGeneralSettings() {
        sessionPreset = AVCaptureSessionPresetMedium
        let devices = AVCaptureDevice.devices()
        
        for device in devices {
            if (isVideo(device)) {
                if(isFrontCamera(device)) {
                    setCamera(device)
                }
            }
        }
        
        if let audioDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeAudio) {
            setMicrophone(audioDevice)
        }
    }
    
    private func isVideo(device: AnyObject) -> Bool {
        return device.hasMediaType(AVMediaTypeVideo)
    }
    
    private func isFrontCamera(device: AnyObject) -> Bool {
        return device.position == AVCaptureDevicePosition.Front
    }
    
    private func setCamera(device: AnyObject) {
        captureVideoDevice = device as? AVCaptureDevice
    }
    
    private func setMicrophone(device: AnyObject) {
        captureAudioDevice = device as? AVCaptureDevice
    }
    
    private func bothDevicesSet() -> Bool {
        return captureAudioDevice != nil && captureVideoDevice != nil
    }
    
    private func addCamera() {
        var err : NSError? = nil
        self.addInput(AVCaptureDeviceInput(device: captureVideoDevice!, error: &err))
    }
    
    private func addMicrophone() {
        var err : NSError? = nil
        self.addInput(AVCaptureDeviceInput(device: captureAudioDevice!, error: &err))
    }
    
    private func beginSession() {
        addCamera()
        addMicrophone()
    }
}
