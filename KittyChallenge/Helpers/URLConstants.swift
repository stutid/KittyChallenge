//
//  URLConstants.swift
//  KittyChallenge
//
//  Created by Stuti Dobhal on 16.02.20.
//  Copyright © 2020 Stuti Dobhal. All rights reserved.
//

import Foundation

enum URLConstants {
    private static let BASE_URL = "https://api.thecatapi.com/v1/"
    case getAllCats, markFavourite, deleteFavourite(Int), getAllFavourites
    var url: URL? {
        return URL(string: "\(URLConstants.BASE_URL)\(endPoint)")
    }
    
    private var endPoint: String {
        switch self {
        case .getAllCats:
            return "images/search?limit=20"
        case .markFavourite:
            return "favourites"
        case .deleteFavourite(let id):
            return "favourites/\(id)"
        case .getAllFavourites:
            return "favourites?sub_id=\(Key.SubId.title)"
        }
    }
}

enum HTTPMethod {
    case get, post, delete
    var type: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .delete:
            return "DELETE"
        }
    }
}
