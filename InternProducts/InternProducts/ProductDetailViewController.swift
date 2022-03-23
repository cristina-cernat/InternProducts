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

        titleLabel.text = titleText
        productImageView.image = productImage
        descriptionTextView.text = descriptionText
        tagsLabel.text = tagsText
   }

    var titleText = ""
    var productImage = UIImage()
    var descriptionText = ""
    var tagsText = ""

    @IBAction func didCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var productImageView: UIImageView!

    @IBOutlet weak var descriptionTextView: UITextView!

    @IBOutlet weak var tagsLabel: UILabel!

}
