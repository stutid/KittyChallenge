//
//  Protocols.swift
//  KittyChallenge
//
//  Created by Stuti Dobhal on 16.02.20.
//  Copyright © 2020 Stuti Dobhal. All rights reserved.
//

import Foundation

protocol UIDelegate: class {
    func updateUI()
    func updateUI(atIndex index: Int)
    func show(message: String)
}

protocol FavouriteDelegate: class {
    func mark(for listType: ListType?)
    func delete(for listType: ListType?)
}

protocol ListType {
    var id: String? { get set }
    var url: URL? { get set }
    var favouriteId: Int? { get set }
}
