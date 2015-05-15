import UIKit
import MessageUI

class SocialMediaManager : NSObject, MFMessageComposeViewControllerDelegate, UIDocumentInteractionControllerDelegate {
    var whatsAppURL = "whatsapp://send?text=Hello%2C%20World!"
    var whatsAppTest = "whatsapp://app"
    let sharedApplication = UIApplication.sharedApplication()
    var messageComposeVC = MFMessageComposeViewController()
    var parentVC : UIViewController?
    
    init(parentVC: UIViewController) {
        super.init()
        self.parentVC = parentVC
        self.messageComposeVC.messageComposeDelegate = self
    }
    
    func canShareWithWhatsapp() -> Bool {
        return sharedApplication.canOpenURL(NSURL(string: whatsAppTest)!)
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
    
    func openShareDialog(url: NSURL) {
        if canShareWithWhatsapp() {
//            figure out how to get resource
//                        
//            var test = NSBundle.mainBundle().pathForResource("test", ofType: "mov")
//            var url = NSURL(fileURLWithPath: test!)
            var documentInteractionController = UIDocumentInteractionController(URL: url)
            documentInteractionController.UTI = "net.whatsapp.movie"
            
            
            
            documentInteractionController.delegate = self
            documentInteractionController.presentOpenInMenuFromRect(CGRectMake(0, 0, 0, 0), inView: parentVC!.view, animated: true)
        }
    }
    
    
//    if ([[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString:@"whatsapp://app"]]){
//    
//    NSString    *savePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mov"];
//    
//    _documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:savePath]];
//    
//    _documentInteractionController.UTI = @"net.whatsapp.movie";
//    
//    _documentInteractionController.delegate = (id)self;
//    
//    [_documentInteractionController presentOpenInMenuFromRect:CGRectMake(0, 0, 0, 0) inView:self.view animated: YES];
//    } else {
//    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"WhatsApp Not Installed." message:@" WhatsApp is not installed on your device." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alert show];
//    }
}