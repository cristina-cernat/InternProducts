//
//  ViewController.swift
//  InternProducts
//
//  Created by Cristina Mihaela on 11.03.2022.
//

import UIKit

class ViewController: UIViewController {

    let session = URLSession(configuration: .default)

    override func viewDidLoad() {
        super.viewDidLoad()


        let url = URL(string: "http://localhost:8080/login?username=admin&password=1234")!
        // MARK: - treat the request
        let dataTask = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Request error. Received: \(error)")
            } else if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                print("Request error, no 200 status. Received: \(response.statusCode)")
            } else if let data = data {
                // MARK: - process data
                print(data)
            } else {
                print("Request error, unexpected condition")
            }
        }

        dataTask.resume()
    }


}

