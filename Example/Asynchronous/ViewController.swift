//
//  ViewController.swift
//  Async
//
//  Created by fpg1503 on 11/02/2017.
//  Copyright (c) 2017 fpg1503. All rights reserved.
//

import UIKit
import Asynchronous
import Result

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        testAfterDelay().async { (value, error) in
            print(value as Any)
            print(error as Any)
        }
        
        test().async { (value, error) in
            print(value as Any)
            print(error as Any)
        }
        
        testResolveThenReject().async { (value, error) in
            print(value as Any)
            print(error as Any)
        }
    }
    
    func test() -> Async<Int> {
        return Async { resolve, reject in
            resolve(3)
        }
    }
    
    func testAfterDelay(delay: TimeInterval = 5) -> Async<Int> {
        return Async { resolve, reject in
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                resolve(42)
            }
        }
    }
    
    func testResolveThenReject() -> Async<Int> {
        return Async { resolve, reject in
            resolve(1234)
            //TODO: Find out a way to avoid type errasing errors (and importing result)
            reject(AnyError(NSError(domain: "com.fpg1503.Asynchronous", code: 1234, userInfo: nil)))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

