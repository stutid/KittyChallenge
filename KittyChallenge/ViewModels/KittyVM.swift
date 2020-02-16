//
//  KittyVM.swift
//  KittyChallenge
//
//  Created by Stuti Dobhal on 16.02.20.
//  Copyright © 2020 Stuti Dobhal. All rights reserved.
//

import Foundation

class KittyVM {
    //MARK:- Properties
    private let kittyApiManager = KittyApiManager.shared
    private var cats = [Cat]()
    private var favouriteCats = [FavouriteCats]()
    private var type: TabBarItem
    weak var uidelegate: UIDelegate?
    
    //MARK:- Methods
    init(_ type: TabBarItem) {
        self.type = type
        if type == .allList {
            fetchAllCats()
        } else {
            fetchAllFavouriteCats()
        }
    }
    
    //MARK: Get type
    func getType() -> TabBarItem {
        return type
    }
    
    //MARK: Get all cats/favourites count
    func getCount() -> Int {
        return type == TabBarItem.allList ? cats.count : favouriteCats.count
    }
    
    //MARK: Get list type object
    func getObject(at index: Int) -> ListType {
        return type == TabBarItem.allList ? cats[index] : favouriteCats[index]
    }
    
    //MARK: Fetch all cats
    private func fetchAllCats() {
        kittyApiManager.fetchAllCats { [weak self] (catsArr, error) in
            guard let catsArr = catsArr else {
                self?.uidelegate?.show(message: error?.localizedDescription ?? Key.Error.message)
                return
            }
            self?.cats.removeAll()
            self?.cats.append(contentsOf: catsArr)
            self?.uidelegate?.updateUI()
        }
    }
    
    //MARK: Create data from list type
    func createData(from listType: ListType?) {
        guard let id = listType?.id else { return }
        guard let listType = listType else { return }
        guard let index = cats.firstIndex(of: listType as! Cat) else { return }
        
        let request = CatRequest(imageId: id, subId: Key.SubId.title)
        let encodedData = try? JSONEncoder().encode(request)
        markFavourite(with: encodedData, at: index)
    }
    
    //MARK: Mark cats as favourite
    private func markFavourite(with encodedData: Data?, at index: Int) {
        kittyApiManager.markFavourite(with: encodedData) { [weak self] (markedFavourite, error) in
            guard let markedFavourite = markedFavourite else {
                self?.uidelegate?.show(message: error?.localizedDescription ?? Key.Error.message)
                return
            }
            self?.cats[index].favouriteId = markedFavourite.favouriteId
            self?.uidelegate?.updateUI(atIndex: index)
            self?.uidelegate?.show(message: Key.MarkedAsFav.message)
        }
    }
    
    //MARK: Mark cats as unfavourite
    func delete(for listType: ListType?) {
        guard let id = listType?.favouriteId else { return }
        guard let listType = listType else { return }
        guard let index = cats.firstIndex(of: listType as! Cat) else { return }
        
        kittyApiManager.unmarkFavourite(for: id) { [weak self] (isSuccessful, error) in
            guard let _ = isSuccessful else {
                self?.uidelegate?.show(message: error?.localizedDescription ?? Key.Error.message)
                return
            }
            self?.cats[index].favouriteId = nil
            self?.uidelegate?.updateUI(atIndex: index)
            self?.uidelegate?.show(message: Key.UnmarkedFromFav.message)
        }
    }
    
    //MARK: Fetch all favourite cats
    func fetchAllFavouriteCats() {
        if type == .allList {
            return
        }
        kittyApiManager.fetchAllFavourites { [weak self] (favCatsArr, error) in
            guard let favCatsArr = favCatsArr else {
                self?.uidelegate?.show(message: error?.localizedDescription ?? Key.Error.message)
                return
            }
            self?.favouriteCats.removeAll()
            self?.favouriteCats.append(contentsOf: favCatsArr)
            self?.uidelegate?.updateUI()
        }
    }
}
