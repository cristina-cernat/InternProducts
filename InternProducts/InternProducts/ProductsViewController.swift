//
//  ProductsViewController.swift
//  InternProducts
//
//  Created by Cristina Mihaela on 17.03.2022.
//

import UIKit

class ProductsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var products = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()


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
        products.count
    }
}

extension ProductsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
