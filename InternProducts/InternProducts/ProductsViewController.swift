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


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: Constant.productCellIdentifier)

        

        let url = URL(string: "http://localhost:8080/products?loginToken=668961808.772846")!

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
                    print("failed to convert \(error.localizedDescription)")
                }

                // json = our serialized data
                guard let json = result else {
                    return
                }
                print(json.status)
                print(json.products[0].title)
                self.myProducts = json.products
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }


            } else {
                print("Request error, unexpected condition")
            }
        }

        dataTask.resume()
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

//        var title: String?
//        var description: String?

//        let products = dictionary["products"] as? [[String: Any]]
//        print(products)

        let product = myProducts[indexPath.row]
        productCell.titleLabel.text = product.title
        productCell.descriptionLabel.text = product.description
        let tagsString: String = "taggg"
        productCell.tagsLabel.text = tagsString
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
    let image: URL
    let description: String
    let date: Date
}

