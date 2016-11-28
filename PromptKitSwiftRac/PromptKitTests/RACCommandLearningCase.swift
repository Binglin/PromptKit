//
//  RACCommandLearningCase.swift
//  PromptKit
//
//  Created by ET|冰琳 on 16/8/18.
//  Copyright © 2016年 IB. All rights reserved.
//

import XCTest
import ReactiveCocoa

class RACCommandLearningCase: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        
        let expect = expectationWithDescription("command")
        
        let command = RACCommand{ (input) -> RACSignal! in
            
            return RACSignal.createSignal({ (subscribe) -> RACDisposable! in
                RACScheduler.currentScheduler().afterDelay(1, schedule: {
                    
                    print("signal executions")
                    subscribe.sendNext("next value")
                    
                    subscribe.sendError(NSError(domain: "", code: 1, userInfo: [NSLocalizedFailureReasonErrorKey : "aaaa"]))
                })
                return nil
            })
            
        }
        
        command.executing.subscribeNext { (ob) in
            print("executing \(ob)")
        }
        
        command.executionSignals.doNext { (ob) in
            print("do on next first")
        }.replay()
        
        command.executionSignals.doNext { (ob) in
            print("do on next second")
        }.replay()
        
        let innerSignal = command.executionSignals.concat()
            
        innerSignal.subscribeNext { (obj) in
            
            print("concat next")
            
        }
        
        innerSignal.doNext { (obj) in
            print("inner first do on next subscribe \(obj)")
        }
        innerSignal.subscribeNext { (obj) in
            print("inner first subscribe \(obj)")
        }
        
        innerSignal.subscribeNext { (obj) in
            print("inner second subscribe \(obj)")
        }
        
        command.errors.subscribeNext { (err) in
            print("errors signals \(err)")
        }
        
        command.execute("test command")
        
        waitForExpectationsWithTimeout(30, handler: nil)
    }

}
