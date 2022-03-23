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
    var loginToken: String?

    var username: String = ""
    var password: String = ""

    var urlString = "http://localhost:8080/"

    override func viewDidLoad() {
       super.viewDidLoad()
        usernameTextField.returnKeyType = .done
        passwordTextField.returnKeyType = .done


    }

    @IBOutlet weak var usernameTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func loginButton(_ sender: UIButton) {
        print("login touched")

        if let userText = usernameTextField.text {
            self.username += userText
            print(self.username)
            self.urlString += "login?username="
            self.urlString += self.username
        }

        if let passwordText = passwordTextField.text {
            self.password += passwordText
            print(self.password)
            self.urlString += "&password="
            self.urlString += self.password
        }


        request(url: urlString)


    }

    @IBAction func registerButton(_ sender: UIButton) {
    }

    func request(url: String) {
        let url = URL(string: url)!
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
                        print("func request: ")
                    self.loginToken = jsonObject["loginToken"] as? String
                    print(self.loginToken ?? "no token")
                    if let status = jsonObject["status"] as? String {
                        if status == "SUCCESS" {
                            DispatchQueue.main.async {
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "productScreen") as! ProductsViewController
                                vc.modalPresentationStyle = .fullScreen
                                vc.token = self.loginToken ?? "no"
                                self.present(vc, animated: true)
                            }
                        }
                    }

                   } catch {
                       print("Data serialization error: \(error)")
                   }
            } else {
                print("Request error, unexpected condition")
            }
        }
        dataTask.resume()
       // return dataTask

    }
}
