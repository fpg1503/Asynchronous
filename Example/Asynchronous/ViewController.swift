//
//  ViewController.swift
//  Async
//
//  Created by fpg1503 on 11/02/2017.
//  Copyright (c) 2017 fpg1503. All rights reserved.
//

import UIKit
import Asynchronous

struct User: Decodable {
    let id: String
}

enum Endpoint: String {
    case users
}

struct APIRouter {
    static func route(for endpoint: Endpoint, id: String) -> URL {
        return URL(string: "https://myapi.com/\(endpoint.rawValue)/\(id)")!
    }
}

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
            reject(NSError(domain: "com.fpg1503.Asynchronous", code: 1234, userInfo: nil))
        }
    }

    func getUser(by id: String) -> Async<User> {
        return Async { resolve, reject in
            let url = APIRouter.route(for: .users, id: id)
            let request = URLRequest(url: url)

            let session = URLSession.shared
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    reject(error)
                } else if let data = data {
                    do {
                        let user = try JSONDecoder().decode(User.self, from: data)
                        resolve(user)
                    } catch (let error) {
                        reject(error)
                    }
                } else {
                    reject(NSError(domain: "my.domain", code: 123))
                }
            }
            task.resume()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

