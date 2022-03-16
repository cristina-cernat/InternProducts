//
//  ViewController.swift
//  InternProducts
//
//  Created by Cristina Mihaela on 11.03.2022.
//

import UIKit

class ViewController: UIViewController {

    
    let requestHandler = RequestHandler()
    //var dict = [String: Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://localhost:8080/login?username=admin&password=1234")!
        requestHandler.handler(url: url, completion: { dict in
            var dict = dict
            dict = self.requestHandler.dictionary
            
            DispatchQueue.main.async {
                print(dict) // nothing prints
               }

        })


        //print(requestHandler.dictionary)
    }


    @IBOutlet weak var usernameTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func loginButton(_ sender: UIButton) {
        print("login touched")
    }

    @IBAction func registerButton(_ sender: UIButton) {
    }
}

