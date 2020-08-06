//
//  DriverCollectionViewCell.swift
//  MonocarTestTask
//
//  Created by User on 05.08.2020.
//  Copyright © 2020 ValeriiaTarasenko. All rights reserved.
//

import UIKit

class DriverCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var driverImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var seatsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        driverImageView.layer.cornerRadius = driverImageView.bounds.size.width / 2
        driverImageView.layer.masksToBounds = true
    }
    
    func setup(with driver: Driver) {
        guard let url = URL(string: driver.picture_url)else {
            return }
        DispatchQueue.global(qos: .userInitiated).async {
            let contenst = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if let imageData = contenst {
                    self.driverImageView.image = UIImage(data: imageData)
                }
            }
        }
        nameLabel.text = driver.name
        rateLabel.text = "\(driver.rating)"
        timeLabel.text = driver.dateFromStart
        priceLabel.text = "\(driver.amount) ₴"
        dateLabel.text = driver.timeFromStart
        seatsLabel.text = "\(driver.seats_count)"
    }
}
