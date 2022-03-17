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
    var products = [[String: Any]]()

    let session = URLSession(configuration: .default)
    var dictionary = [String:Any]()

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


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProductsViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //products.count
        return 1
    }
}

extension ProductsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let productCell = tableView.dequeueReusableCell(withIdentifier: Constant.productCellIdentifier, for: indexPath) as? ProductTableViewCell else {
            print("UI error: Cell dequeing resulted in an unexpected instance")
            return UITableViewCell()
        }

        productCell.titleLabel.text = "It works!"
        return productCell
    }
}
