import UIKit

enum ButtonState {
    case BS_NORMAL, BS_COUNTDOWN, BS_RECORDING, BS_PLAY
}

class RecordButton : UIButton {
    var images : [ButtonState : String] = [
        .BS_NORMAL : "RecordButtonNormal",
        .BS_COUNTDOWN : "RecordButtonCountdown",
        .BS_RECORDING : "RecordButtonRecording",
        .BS_PLAY : "RecordButtonPlay"
    ]
    var currentState : ButtonState = .BS_NORMAL
    var countDownLabel : CounterLabel?
    var countdownTime = 3
    var recordCount = 5
    var recordCallback : (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: Selector("handleClick"), forControlEvents: UIControlEvents.TouchUpInside)
        self.enabled = true
        setCurrenImage()
        
        countDownLabel = CounterLabel(frame: CGRectMake(0, 34, 88, 20)).withCount(countdownTime)
        self.addSubview(countDownLabel!)
    }
    
    func handleClick() {
        switch currentState {
        case .BS_NORMAL :
            currentState = .BS_COUNTDOWN
            startCounter()
        case .BS_COUNTDOWN :
            currentState = .BS_RECORDING
            startRecording()
        case .BS_RECORDING :
            currentState = .BS_PLAY
        case .BS_PLAY :
            currentState = .BS_PLAY
        }
        
        setCurrenImage()
    }
    
    private func setCurrenImage() {
        self.setImage(UIImage(named: images[currentState]!), forState: UIControlState.Normal)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func startCounter() {
        self.userInteractionEnabled = false
        countDownLabel?.startCounter(handleClick)
    }
    
    private func startRecording() {
        recordCallback?()
        self.userInteractionEnabled = false
        countDownLabel = countDownLabel?.withCount(self.recordCount)
        countDownLabel?.startCounter(handleClick)
    }
}