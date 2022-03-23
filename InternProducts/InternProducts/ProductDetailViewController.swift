//
//  ProductDetailViewController.swift
//  InternProducts
//
//  Created by Cristina Mihaela on 23.03.2022.
//

import UIKit

class ProductDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

   }
    
    @IBAction func didCloseButton(_ sender: UIButton) {
    }

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var productImageView: UIImageView!

    @IBOutlet weak var descriptionTextView: UITextView!

    @IBOutlet weak var tagsLabel: UILabel!
}
