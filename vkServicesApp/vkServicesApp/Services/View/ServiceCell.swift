//
//  ServiceCell.swift
//  vkServicesApp
//
//  Created by Дмитрий Миронов on 13.07.2022.
//

import UIKit

class ServiceCell: UITableViewCell {

    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configurate(with service: Service) {
        self.nameLabel.text = service.name
        self.descriptionLabel.text = service.description
        
        guard let stringUrl: String = service.iconUrl else { return }
        let url = URL(string: stringUrl)
        
        if let data = try? Data(contentsOf: url!) {
            self.logoImage.image = UIImage(data: data)
        }
    }
}
