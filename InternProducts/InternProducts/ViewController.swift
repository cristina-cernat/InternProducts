//
//  ViewController.swift
//  InternProducts
//
//  Created by Cristina Mihaela on 11.03.2022.
//

import UIKit

class ViewController: UIViewController {

    
    let requestHandler = RequestHandler()

    override func viewDidLoad() {
        super.viewDidLoad()

        requestHandler.handler()
    }


    @IBOutlet weak var usernameTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func loginButton(_ sender: UIButton) {

    }

    @IBAction func registerButton(_ sender: UIButton) {
    }
}

