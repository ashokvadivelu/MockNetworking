//
//  ViewController.swift
//  MockNetworkingExample
//
//  Created by ashok on 02/04/20.
//  Copyright © 2020 ashok. All rights reserved.
//

import UIKit
import Foundation

public struct userEncode: Codable {
    var first_name: String
    var last_name: String
    var age: Int
}

//Note: Enable the line 48 and 49 to check mock response data
class ViewController: UIViewController {

    // url
    let url = URL(string: "https://learnappmaking.com/ex/users.json")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

         neworkingApiRequest()

    }

    var mockEncoderValue: Data {
        let encode = userEncode(first_name: "ashok", last_name: "kumar", age: 27)
        let arrayEncode = [encode]
        let encoderValue =  try! JSONEncoder().encode(arrayEncode)
        return encoderValue
    }

 // Networking Setup
    private func neworkingApiRequest() {
        // Networking Api

        // now set up a configuration
        let config = URLSessionConfiguration.ephemeral


        // Enable the below two line to check mock data response
        //MockURLProtocol.stub = [url: mockEncoderValue]
       // config.protocolClasses = [MockURLProtocol.self]

        // and create the URLSession from that

        let session = URLSession(configuration: config)
        let urlString = URL(string: "https://learnappmaking.com/ex/users.json")!
        let task = session.dataTask(with: urlString) { data, response, error in
            do {
                if let userData = data {
                print(userData)
                let decodedValue =  try JSONDecoder().decode([userEncode].self, from: userData)
                    print(decodedValue[0].first_name)
                }
            }
            catch {
                    print("catch")
            }
            }
        task.resume()
    }

}


//Mock protocol class

