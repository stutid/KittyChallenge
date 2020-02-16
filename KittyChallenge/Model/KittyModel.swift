//
//  KittyModel.swift
//  KittyChallenge
//
//  Created by Stuti Dobhal on 16.02.20.
//  Copyright © 2020 Stuti Dobhal. All rights reserved.
//

import Foundation

struct Cat: Decodable, Equatable, ListType {
    var id: String?
    var url: URL?
    var favouriteId: Int?
}

struct CatRequest: Encodable {
    var imageId: String?
    var subId: String?
    
    private enum CodingKeys: String, CodingKey {
        case imageId = "image_id"
        case subId = "sub_id"
    }
}
