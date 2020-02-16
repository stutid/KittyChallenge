//
//  KittyVC.swift
//  KittyChallenge
//
//  Created by Stuti Dobhal on 16.02.20.
//  Copyright © 2020 Stuti Dobhal. All rights reserved.
//

import UIKit
import SVProgressHUD

class KittyVC: UIViewController {
    //MARK:- Outlets and Properties
    @IBOutlet weak var collectionView: UICollectionView!
    var kittyVM: KittyVM!
    
    //MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        kittyVM.uidelegate = self
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.show(withStatus: Key.Loading.title)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        kittyVM.fetchAllFavouriteCats()
    }
}

//MARK:- UICollectionView Data Source and Delegate
extension KittyVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kittyVM.getCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: KittyCell.self), for: indexPath) as? KittyCell else { return UICollectionViewCell() }
        cell.favDelegate = self
        let catListType = kittyVM.getObject(at: indexPath.row)
        cell.set(barType: kittyVM.getType(), and: catListType)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let newWidth = (collectionView.frame.size.width / 2) - 10
        return CGSize(width: newWidth, height: newWidth)
    }
}

//MARK:- Custom UI Delegate
extension KittyVC: UIDelegate {
    func updateUI() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            self.collectionView.reloadData()
        }
    }
    
    func updateUI(atIndex index: Int) {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            self.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
        }
    }
    
    func show(message: String) {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            self.showAlert(with: message)
        }
    }
}

//MARK:- Custom Favourite Delegate
extension KittyVC: FavouriteDelegate {
    func mark(for listType: ListType?) {
        kittyVM.createData(from: listType)
    }
    
    func delete(for listType: ListType?) {
        kittyVM.delete(for: listType)
    }
}
