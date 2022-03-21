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
     }
//    private func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
//        //let url = myProducts[index].image
//        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
//    }
//    private func downloadImage(from url: URL) {
//        print("Downloading image...")
//        getImageData(from: url) { data, response, error in
//            guard let data = data, error == nil else { return }
//            print("Download finished")
//
//            DispatchQueue.main.async() { [weak self] in
//                self?.tableView.reloadData()
//            }
//        }
//    }

    @discardableResult private func downloadImage(url: URL, with completionHandler: @escaping (Data)->()) -> URLSessionDataTask {
        //let url = URL(string: image.url)!
        let imageDataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            // ASYNC-Called CODE
            if let error = error {
                print("Download image error received: \(error)")
            } else if let data = data {
                DispatchQueue.main.async {
                    completionHandler(data)
                }
            } else {
                print("Download image error: Unexpected condition!")
            }
        }
        imageDataTask.resume()
        return imageDataTask
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
        return productCell
//        downloadImage(from: product.image)

         if let imageData = product.imageData {
            productCell.productImageView?.image = UIImage(data: imageData)
        } else {
            downloadImage(url: product.image) {[weak self] data in
            // ASYNC-Called CODE
            self?.myProducts[indexPath.row].imageData = data
            tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
        //productCell.productImageView.image = try! UIImage(data: Data(contentsOf: product.image))

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

    var imageData: Data?
}


