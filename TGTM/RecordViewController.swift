import UIKit
import AVFoundation


class TGTMCaptureSession : AVCaptureSession {
    var captureDevice : AVCaptureDevice?
    
    override init() {
        super.init()
        setGeneralSettings()
        configureDevice()
        
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
    
    func configureDevice() {
//        if let device = captureDevice {
//            device.lockForConfiguration(nil)
//            device.focusMode = .Locked
//            device.unlockForConfiguration()
//        }
    }
    
    func beginSession() {
        var err : NSError? = nil
        self.addInput(AVCaptureDeviceInput(device: captureDevice!, error: &err))
        println("Session started")
    }
}

class RecordViewController: TGTMViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        recordButton?.recordCallback = startRecording
        initVideo()
    }
    
    func initVideo() {
        var video = UIView(frame: self.view.frame)
        var captureSession = TGTMCaptureSession()
        
        self.view.addSubview(video)
        self.view.sendSubviewToBack(video)
        
        var previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        video.layer.addSublayer(previewLayer)
        previewLayer?.frame = video.layer.frame

        captureSession.startRunning()
    }
    
    private func animateFlashIn() {
        flashImage?.hidden = false
        UIView.animateWithDuration(0.15, animations: { () -> Void in
            self.flashImage?.alpha = 1.0
            }) { (done) -> Void in
                self.animateFlashOut()
        }
    }
    
    private func animateFlashOut() {
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.flashImage?.alpha = 0.0
            }) { (done) -> Void in
                self.flashImage?.hidden = true
        }
    }
    
    private func startRecording() {
        println("recording")
        
        animateFlashIn()
    }
}