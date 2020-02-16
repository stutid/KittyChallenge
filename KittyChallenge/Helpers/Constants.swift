//
//  Constants.swift
//  KittyChallenge
//
//  Created by Stuti Dobhal on 16.02.20.
//  Copyright © 2020 Stuti Dobhal. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()
enum Key {
    case SubId, Error, OK, Loading, MarkedAsFav, UnmarkedFromFav
    var title: String {
        switch self {
        case .SubId:
            return "stuti101"
        case .OK:
            return "OK"
        case .Loading:
            return "Loading..."
        default:
            return ""
        }
    }
    
    var message: String {
        switch self {
        case .Error:
            return "There was an error"
        case .MarkedAsFav:
            return "Marked as Favourite"
        case .UnmarkedFromFav:
            return "Unmarked from Favourites"
        default:
            return ""
        }
    }
}

enum TabBarItem: Int {
    case allList
    case favourite
}
