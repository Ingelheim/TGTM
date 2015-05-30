import UIKit

class TGTMViewController : UIViewController {
    let lipOffRed = UIColor(red: 0.937, green: 0.333, blue: 0.31, alpha: 1)
    
    var recordButton : RecordButton?
    var flashImage : UIView?
    var countdownLabel : UILabel?
    var shareButton : UIButton?
    var shareDialog : ShareDialog?
    var undo : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    private func setupUI() {
        createRyanImage()
        createLogoBar()
        createBottomBar()
        createRecordButton()
        createFlashImage()
        createShareView()
        createCountDownCounter()
    }
    
    private func createRyanImage() {
        var ryan = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 84 - 69))
        ryan.image = UIImage(named: "Ryan")
        self.view.addSubview(ryan)
    }
    
    // LOGO TOP BAR
    private func createLogoBar() {
        self.createLogoTopBar()
        self.createLogoDivider()
        self.addLipOffLogo()
    }
    
    private func createLogoTopBar() {
        var logoTopBar = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 35))
        logoTopBar.backgroundColor = lipOffRed
        self.view.addSubview(logoTopBar)
    }
    
    private func createLogoDivider() {
        var logoDivider = UIView(frame: CGRect(x: 0, y: 35, width: self.view.frame.width, height: 3))
        logoDivider.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(logoDivider)
    }
    
    private func addLipOffLogo() {
        let widthOfTotal = 0.55
        let heightToWidth = 0.22
        
        var width = widthOfTotal * Double(self.view.frame.width)
        var height = width * heightToWidth
        var xValue = Double(self.view.frame.width / 2) - Double(width / 2)
        
        var lipOffLogo = UIImageView(frame: CGRect(x: Int(xValue), y: 11, width: Int(width), height: Int(height)))
        lipOffLogo.image = UIImage(named: "Logo")
        self.view.addSubview(lipOffLogo)
    }
    
    private func createBottomBar() {
        var bottomBar = UIImageView(frame: CGRect(x: 0, y: self.view.frame.maxY - 69, width: self.view.frame.width, height: 69))
        bottomBar.image = UIImage(named: "BottomBar")
        self.view.addSubview(bottomBar)
    }
    
    private func createRecordButton() {
        recordButton = RecordButton(frame: CGRect(x: self.view.frame.midX - 44, y: self.view.frame.maxY - 113, width: 88, height: 88))
        self.view.addSubview(recordButton!)
    }
    
    private func createFlashImage() {
        flashImage = UIView(frame: self.view.frame)
        flashImage?.backgroundColor = UIColor.whiteColor()
        flashImage?.alpha = 0.0
        flashImage?.hidden = true
        self.view.addSubview(flashImage!)
    }
    
    func toggleShareDialog() {
        shareDialog!.hidden = !shareDialog!.hidden
    }
    
    private func createShareView() {
        shareButton = UIButton(frame: CGRect(x: 50, y: self.view.frame.maxY - 54, width: 36, height: 39))
        shareButton!.setImage(UIImage(named: "Share"), forState: UIControlState.Normal)
        shareButton!.addTarget(self, action: Selector("toggleShareDialog"), forControlEvents: UIControlEvents.TouchUpInside)
        shareButton!.hidden = true
        self.view.addSubview(shareButton!)
        
        shareDialog = ShareDialog(frame: CGRect(x: 5, y: self.view.frame.maxY - 136, width: 134, height: 76))
        shareDialog!.image = UIImage(named: "ShareDialog")
        shareDialog!.hidden = true
        self.view.addSubview(shareDialog!)
        
        undo = UIButton(frame: CGRect(x: self.view.frame.maxX - 86, y: self.view.frame.maxY - 50, width: 36, height: 29))
        undo!.setImage(UIImage(named: "undo"), forState: UIControlState.Normal)
        undo!.addTarget(self, action: Selector("toggleShareDialog"), forControlEvents: UIControlEvents.TouchUpInside)
        undo!.hidden = true
        self.view.addSubview(undo!)
    }
    
    private func createCountDownCounter() {
        countdownLabel = UILabel(frame: self.view.frame)
        countdownLabel!.text = "3"
        countdownLabel!.textAlignment = .Center
        countdownLabel!.font = UIFont(name: "SignPainter", size: 300)
        countdownLabel!.textColor = UIColor.whiteColor()
        countdownLabel!.hidden = true
        
        self.view.addSubview(countdownLabel!)
        recordButton?.bigLabel = countdownLabel!
    }
}