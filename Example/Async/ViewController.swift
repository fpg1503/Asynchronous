//
//  ViewController.swift
//  Async
//
//  Created by fpg1503 on 11/02/2017.
//  Copyright (c) 2017 fpg1503. All rights reserved.
//

import UIKit
import Async

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        test().async { (value, error) in
            print(value as Any)
            print(error as Any)
        }
    }
    
    func test() -> Async<Int> {
        return Async { (resolve, reject) in
            resolve(3)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

