import UIKit
import AVFoundation

class RecordViewController: TGTMViewController {
    var captureSession : TGTMCaptureSession?

    override func viewDidLoad() {
        super.viewDidLoad()
        recordButton?.recordStartCallback = startRecording
        recordButton?.recordDoneCallback = stopRecording
        initVideo()
    }
    
    func initVideo() {
        var video = UIView(frame: self.view.frame)
        captureSession = TGTMCaptureSession()
        captureSession!.parent = self
        
        self.view.addSubview(video)
        self.view.sendSubviewToBack(video)
        
        var previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        video.layer.addSublayer(previewLayer)
        previewLayer?.frame = video.layer.frame

        captureSession!.startRunning()
    }
    
    private func animateFlashIn() {
//        flashImage?.hidden = false
//        UIView.animateWithDuration(0.15, animations: { () -> Void in
//            self.flashImage?.alpha = 1.0
//            }) { (done) -> Void in
//                self.animateFlashOut()
//        }
    }
    
    private func animateFlashOut() {
//        UIView.animateWithDuration(0.1, animations: { () -> Void in
//            self.flashImage?.alpha = 0.0
//            }) { (done) -> Void in
//                self.flashImage?.hidden = true
//        }
    }
    
    private func startRecording() {
        println("start recording")
//        SocialMediaManager(parentVC: self).openShareDialog()
        captureSession!.startRecording()
        
        animateFlashIn()
    }
    
    private func stopRecording() {
        println("stop recording")
        captureSession!.stopRecording()
        animateFlashIn()
        self.shareButton?.hidden = false
        self.undo?.hidden = false
    }
}