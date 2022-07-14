//
//  Service.swift
//  vkServicesApp
//
//  Created by Дмитрий Миронов on 12.07.2022.
//

import Foundation

struct Service: Codable {
    var name: String
    var description: String?
    var link: String?
    var iconUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case link
        case iconUrl = "icon_url"
    }
}
