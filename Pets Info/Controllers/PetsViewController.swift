//
//  PetsViewController.swift
//  Pets Info
//
//  Created by Yurii on 13.12.2022.
//

import UIKit

class PetsViewController: UIViewController {
    @IBOutlet weak var petsTableView: UITableView!
    
    private let downloadService = DownloadService()
    
    private var petsArray: [Pet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        downloadService.fetchDataFromFile { [self] result in
            switch result {
            case .success(let pets):
                petsArray = pets
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupTableView() {
        petsTableView.dataSource = self
        petsTableView.delegate = self
        //petsTableView.estimatedRowHeight = 150
    }
    
}

extension PetsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = petsTableView.dequeueReusableCell(withIdentifier: "petTableViewCell", for: indexPath) as! PetTableViewCell
        cell.congfigureCell(pet: petsArray[indexPath.row])
        downloadService.downloadImage(imageURL: petsArray[indexPath.row].image) { result in
            switch result {
            case .success(let image):
                cell.configureImage(image: image)
            case .failure(let error):
                print(error)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
