//
//  ProductsViewController.swift
//  InternProducts
//
//  Created by Cristina Mihaela on 17.03.2022.
//

import UIKit

class ProductsViewController: UIViewController {

    struct Constant {
        static let productCellIdentifier = "ProductCell"
    }


    @IBOutlet weak var tableView: UITableView!
    var myProducts = [Product]()

    let session = URLSession(configuration: .default)
    var token = ""
    var urlString = "http://localhost:8080/products?loginToken="

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: Constant.productCellIdentifier)

        self.urlString += token
        let url = URL(string: urlString)!
        print("in viewDidLoad()")
        print(self.urlString)

        // MARK: - treat the request
        let dataTask = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Request error. Received: \(error)")
            } else if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                print("Request error, no 200 status. Received: \(response.statusCode)")
            } else if let data = data {

                // MARK: - have data

                var result: Response?
                do {
                    result = try JSONDecoder().decode(Response.self, from: data)
                } catch {
                    print("failed to convert JSON \(error.localizedDescription)")
                }

                // json = our decoded data
                guard let json = result else {
                    return
                }
                print(json.status)
                self.myProducts = json.products

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }


            } else {
                print("Request error, unexpected condition")
            }
        }
        dataTask.resume()

        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        tableView.backgroundView = spinner
     }


    func convertBase64ToImage(imageString: String) -> UIImage {
        let imageData = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imageData)!
    }

//prepare
}

extension ProductsViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myProducts.count
    }
}

extension ProductsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let productCell = tableView.dequeueReusableCell(withIdentifier: Constant.productCellIdentifier, for: indexPath) as? ProductTableViewCell else {
            print("UI error: Cell dequeing resulted in an unexpected instance")
            return UITableViewCell()
        }

        let product = myProducts[indexPath.row]
        productCell.titleLabel.text = product.title
        productCell.descriptionLabel.text = product.description
        let joined = product.tags.joined(separator: ", ")
        productCell.tagsLabel.text = joined

        productCell.productImageView.image = convertBase64ToImage(imageString: product.image)
        return productCell


    }

}

struct Response: Codable {
    let status: String
    let products: [Product]
}

struct Product: Codable {
    let tags: [String]
    let title: String
    let image: String
    let description: String
    let date: Date
}


