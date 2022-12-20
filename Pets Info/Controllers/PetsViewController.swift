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
                petsArray = pets.sorted{$0.order < $1.order}
            case .failure(let error):
                print(error)
            }
        }
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
        let pet = petsArray[indexPath.row]
        switch pet.status {
        case .paid:
            showAlert(pet: pet, inViewController: self)
        case .free:
            showPetInfoVC(pet: pet)
        }
    }
    
}

extension PetsViewController {
    
    private func setupTableView() {
        petsTableView.dataSource = self
        petsTableView.delegate = self
    }
    
    func showAlert(pet: Pet, inViewController: UIViewController) {
        let alert = UIAlertController(title: " \(pet.title) are paid",
                                      message: "U need to purchase them",
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      inViewController.present(alert, animated: true, completion: nil)
    }
    
    func showPetInfoVC(pet: Pet) {
        
    }
}
