//
//  PetTableViewCell.swift
//  Pets Info
//
//  Created by Yurii on 13.12.2022.
//

import UIKit

class PetTableViewCell: UITableViewCell {
    
    @IBOutlet var cellContentView: UIView!
    @IBOutlet var cellLabel: UILabel!
    @IBOutlet var cellImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func congfigureCell(pet: Pet) {
        cellLabel.text = pet.title
    }
    
    func configureImage(image: UIImage) {
        DispatchQueue.main.async {
            self.cellImageView.image = image
        }
        
    }
    
    private func setupView() {
        cellLabel.font = .italicSystemFont(ofSize: 16)
        cellImageView.layer.cornerRadius = 4
        cellImageView.image = .strokedCheckmark
    }

}
