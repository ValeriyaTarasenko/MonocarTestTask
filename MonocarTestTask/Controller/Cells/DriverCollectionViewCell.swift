//
//  DriverCollectionViewCell.swift
//  MonocarTestTask
//
//  Created by User on 05.08.2020.
//  Copyright © 2020 ValeriiaTarasenko. All rights reserved.
//

import UIKit

class DriverCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var driverImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var seatsLabel: UILabel!
    
    var driverImageString: String? {
        didSet {
            driverImageView.image = nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        driverImageView.layer.cornerRadius = driverImageView.bounds.size.width / 2
        driverImageView.layer.masksToBounds = true
    }
    
    func setup(with driver: Driver) {
        driverImageString = driver.pictureUrl
        guard let driverImage = driverImageString, let url = URL(string: driverImage) else { return }
        DispatchQueue.global(qos: .userInitiated).async {
            let contenst = try? Data(contentsOf: url)
            DispatchQueue.main.async { [weak self] in
                guard driverImage == self?.driverImageString,
                    let imageData = contenst else { return }
                self?.driverImageView.image = UIImage(data: imageData)
            }
        }
        nameLabel.text = driver.name
        rateLabel.text = "\(driver.rating)"
        timeLabel.text = driver.dateFromStart
        priceLabel.text = "\(driver.amount) ₴"
        dateLabel.text = driver.timeFromStart
        seatsLabel.text = "\(driver.seatsCount)"
    }
}
