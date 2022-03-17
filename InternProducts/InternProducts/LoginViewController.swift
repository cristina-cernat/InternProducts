//
//  ViewController.swift
//  InternProducts
//
//  Created by Cristina Mihaela on 11.03.2022.
//

import UIKit

class LoginViewController: UIViewController {

    let session = URLSession(configuration: .default)
    var dictionary = [String:Any]()

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
               do {
                      guard let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                          print("Data serialization error: Unexpected data format")
                          return
                      }

                      self.dictionary = jsonObject
                      print(self.dictionary)

                  } catch {
                      print("Data serialization error: \(error)")
                  }
           } else {
               print("Request error, unexpected condition")
           }
       }

       dataTask.resume()
    }

    @IBOutlet weak var usernameTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func loginButton(_ sender: UIButton) {
        print("login touched")
    }

    @IBAction func registerButton(_ sender: UIButton) {
    }
}

