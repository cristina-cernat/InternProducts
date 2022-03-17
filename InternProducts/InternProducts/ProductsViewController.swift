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

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: Constant.productCellIdentifier)

        //self.tableView.delegate = self
       // self.tableView.dataSource = self

       // self.view.addSubview(tableView)

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
