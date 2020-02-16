//
//  KittyApiManager.swift
//  KittyChallenge
//
//  Created by Stuti Dobhal on 16.02.20.
//  Copyright © 2020 Stuti Dobhal. All rights reserved.
//

import Foundation

class KittyApiManager {
    static let shared = KittyApiManager()
    private let apiManager = ApiManager.shared
    private init() { }
    
    //MARK:- Fetch all cats API
    func fetchAllCats(completionHandler: @escaping ([Cat]?, Error?) -> ()) {
        let url = URLConstants.getAllCats.url
        let request = apiManager.createRequest(url: url, method: .get)
        apiManager.fetch(request: request) { (data, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            do {
                let allCats = try JSONDecoder().decode([Cat].self, from: data)
                completionHandler(allCats, nil)
            } catch {
                completionHandler(nil, error)
            }
        }
    }
    
    //MARK:- Fetch all favourite cats API
    func fetchAllFavourites(completionHandler: @escaping ([FavouriteCats]?, Error?) -> ()) {
        let url = URLConstants.getAllFavourites.url
        let request = apiManager.createRequest(url: url, method: .get)
        apiManager.fetch(request: request) { (data, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            do {
                let favCats = try JSONDecoder().decode([FavouriteCats].self, from: data)
                completionHandler(favCats, nil)
            } catch {
                completionHandler(nil, error)
            }
        }
    }
    
    //MARK:- Mark a cat as favourite API
    func markFavourite(with data: Data?, completionHandler: @escaping (MarkFavourite?, Error?) -> ()) {
        let url = URLConstants.markFavourite.url
        let request = apiManager.createRequest(url: url, method: .post, data: data)
        apiManager.fetch(request: request) { (data, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            do {
                let markedFavourite = try JSONDecoder().decode(MarkFavourite.self, from: data)
                completionHandler(markedFavourite, nil)
            } catch {
                completionHandler(nil, error)
            }
        }
    }
    
    //MARK:- Unmark a cat from favourites API
    func unmarkFavourite(for id: Int, completionHandler: @escaping (Bool?, Error?) -> ()) {
        let url = URLConstants.deleteFavourite(id).url
        let request = apiManager.createRequest(url: url, method: .delete)
        apiManager.fetch(request: request) { (data, error) in
            guard let data = data else {
                completionHandler(false, error)
                return }
            do {
                let unmarkedFavourite = try JSONDecoder().decode(UnmarkFavourite.self, from: data)
                if unmarkedFavourite.message == "SUCCESS" {
                    completionHandler(true, nil)
                } else {
                    completionHandler(false, error)
                }
            } catch {
                completionHandler(false, error)
            }
        }
    }
}
