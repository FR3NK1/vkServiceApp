//
//  ApiResult.swift
//  vkServicesApp
//
//  Created by Дмитрий Миронов on 13.07.2022.
//

import Foundation

struct ApiResult: Codable {
    let body: Body
    let status: Int
}

struct Body: Codable {
    let services: [Service]
}
