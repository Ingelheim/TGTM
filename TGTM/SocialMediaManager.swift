import UIKit
import MessageUI

class SocialMediaManager : NSObject, MFMessageComposeViewControllerDelegate {
    var whatsAppURL = "whatsapp://send?text=Hello%2C%20World!"
    let sharedApplication = UIApplication.sharedApplication()
    var messageComposeVC = MFMessageComposeViewController()
    var parentVC : UIViewController?
    
    init(parentVC: UIViewController) {
        super.init()
        self.parentVC = parentVC
        self.messageComposeVC.messageComposeDelegate = self
    }
    
    func canShareWithWhatsapp() -> Bool {
        return sharedApplication.canOpenURL(NSURL(string: whatsAppURL)!)
    }
    
    func shareWithWhatsapp() {
        if canShareWithWhatsapp() {
            sharedApplication.openURL(NSURL(string: whatsAppURL)!)
        }
    }
    
    func shareWithSMS() {
        messageComposeVC.body = "text"
        parentVC?.presentViewController(messageComposeVC, animated: true, completion: nil)
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
    }
}