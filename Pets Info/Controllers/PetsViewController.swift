//
//  PetsViewController.swift
//  Pets Info
//
//  Created by Yurii on 13.12.2022.
//

import UIKit

class PetsViewController: UIViewController {

    @IBOutlet weak var petsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        petsTableView.dataSource = self
        petsTableView.delegate = self
        let dataFetcher = DownloadService()
        dataFetcher.fetchData()
    }
}

extension PetsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var petTableViewCell = UITableViewCell.init(style: .default, reuseIdentifier: "petTableViewCell")
        petTableViewCell = petsTableView.dequeueReusableCell(withIdentifier: "petTableViewCell")!
//        carTableViewCell.textLabel?.text = generateBrands()[indexPath.row].name
        return petTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
