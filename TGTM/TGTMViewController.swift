import UIKit

class TGTMViewController : UIViewController {
    var recordButton : RecordButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        println(recordButton)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    private func setupUI() {
        createRyanImage()
        createLogoBar()
        createBottomBar()
        createRecordButton()
    }
    
    private func createRyanImage() {
        var ryan = UIImageView(frame: CGRect(x: 0, y: 84, width: self.view.frame.width, height: 514))
        ryan.image = UIImage(named: "Ryan")
        self.view.addSubview(ryan)
    }
    
    private func createLogoBar() {
        var logoBar = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 84))
        logoBar.image = UIImage(named: "LogoBar")
        self.view.addSubview(logoBar)
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
}