import XCTest
import UIKit

class RecordButtonTest : XCTestCase {
    var button = RecordButton()
    
    override func setUp() {
        button = RecordButton(frame: CGRectZero)
    }
    
    func testThatButtonGetsInitializedWithRightButtonImage() {
        XCTAssertEqual(button.userInteractionEnabled, true)
        XCTAssertEqual(button.currentState, .BS_NORMAL)
        XCTAssertEqual(button.imageForState(UIControlState.Normal)!, UIImage(named: "RecordButtonNormal")!)
    }
    
    func testThatClickingButtonInNormalStateTransitionsToCountdownState() {
        button.currentState = .BS_NORMAL
        
        button.handleClick()
        
        XCTAssertEqual(button.currentState, .BS_COUNTDOWN)
        XCTAssertEqual(button.imageForState(UIControlState.Normal)!, UIImage(named: "RecordButtonCountdown")!)
        XCTAssertEqual(button.countDownLabel!.count, button.countdownTime)
    }
    
    func testThatButtonGetsDisabledWhenClickedInNormalMode() {
        button.currentState = .BS_NORMAL
        
        button.handleClick()
        
        XCTAssertFalse(button.userInteractionEnabled)
    }
    
    func testThatCountdownLabelIsInitializedEmptyOnInit() {
        XCTAssertNotNil(button.countDownLabel)
    }
    
    func testThatButtonTransitionsToRecordStateAfterTimerIsDone() {
        button.currentState = .BS_COUNTDOWN
        
        button.handleClick()
        
        XCTAssertEqual(button.currentState, .BS_RECORDING)
        XCTAssertFalse(button.userInteractionEnabled)
        XCTAssertNotNil(button.countDownLabel)
        XCTAssertEqual(button.imageForState(UIControlState.Normal)!, UIImage(named: "RecordButtonRecording")!)
    }
    
    func testResetsCounterWhenRecordingStarts() {
        button.currentState = .BS_COUNTDOWN
        
        button.handleClick()
        
        XCTAssertEqual(button.countDownLabel!.count, button.recordCount)
        XCTAssertTrue(button.countDownLabel!.counting)
    }
    
    func testButtonTransitionsToPlayStateAfterRecording() {
        button.currentState = .BS_RECORDING
        
        button.handleClick()
        
        XCTAssertEqual(button.currentState, .BS_PLAY)
        XCTAssertTrue(button.userInteractionEnabled)
        XCTAssertEqual(button.imageForState(UIControlState.Normal)!, UIImage(named: "RecordButtonPlay")!)
    }
    
    func testThatRecordCallbackGetsExecutedWhenStartingRecording() {
        button.currentState = .BS_COUNTDOWN
        var expectation = expectationWithDescription("should call record callback")
        button.recordCallback = {
            expectation.fulfill()
        }
        
        button.handleClick()
        
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
}