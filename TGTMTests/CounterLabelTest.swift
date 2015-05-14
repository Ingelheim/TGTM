    import XCTest
import UIKit

class CounterLabelTest : XCTestCase {
    func testFluidAPIToSetCounterValue() {
        XCTAssertEqual(CounterLabel(frame: CGRectZero).withCount(5).count, 5)
    }
    
    func testCounterIsNotStartedByDefault() {
        XCTAssertFalse(CounterLabel(frame: CGRectZero).counting)
    }
    
    func testCountingIsTrueWhenCounterIsStarted() {
        var label = CounterLabel(frame: CGRectZero)
        
        label.startCounter({})
        
        XCTAssertTrue(label.counting)
    }
    
    func testShouldUpdateTimerLabelEverySecondWithCurrentValue() {
        var label = CounterLabel(frame: CGRectZero).withCount(2)

        label.startCounter({})
        XCTAssertEqual(label.text!, "2")
        
        label.updateTimer()
        
        XCTAssertEqual(label.text!, "1")
    }
    
    func testInvalidatesTimerWhenTimeIsZero() {
        var label = CounterLabel(frame: CGRectZero).withCount(1)
        
        label.startCounter({})
        XCTAssertTrue(label.timer!.valid)
        label.updateTimer()
        
        XCTAssertEqual(label.text!, "0")
        XCTAssertFalse(label.timer!.valid)
    }
    
    func testCounterTakesCallBackWhichIsExecutedAfterItRunsOut() {
        var label = CounterLabel(frame: CGRectZero).withCount(1)
        var called = false
        let expectation = expectationWithDescription("Should call callback")
        
        label.startCounter({
            expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(1, handler: nil)
    }
}