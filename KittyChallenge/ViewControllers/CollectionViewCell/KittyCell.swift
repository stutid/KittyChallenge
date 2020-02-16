//
//  KittyCell.swift
//  KittyChallenge
//
//  Created by Stuti Dobhal on 16.02.20.
//  Copyright © 2020 Stuti Dobhal. All rights reserved.
//

import UIKit

class KittyCell: UICollectionViewCell {
    //MARK:- Outlets and Properties
    @IBOutlet private weak var imgView: UIImageView!
    @IBOutlet private weak var btn: UIButton!
    private var listType: ListType?
    weak var favDelegate: FavouriteDelegate?
    
    //MARK:- Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .white
        contentView.roundCorners()
        imgView.roundCorners()
    }
    
    func set(barType: TabBarItem, and listType: ListType) {
        self.listType = listType
        imgView.downloadImage(from: listType.url)
        var buttonIsSelected = true
        var buttonUserInteraction = true
        if barType == TabBarItem.allList {
            buttonIsSelected = listType.favouriteId != nil
        } else {
            buttonIsSelected = true
            buttonUserInteraction = false
        }
        btn.isSelected = buttonIsSelected
        setIcon(buttonIsSelected)
        btn.isUserInteractionEnabled = buttonUserInteraction
    }
    
    @IBAction func btnClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            setIcon(true)
            favDelegate?.mark(for: listType)
        } else {
            setIcon(false)
            favDelegate?.delete(for: listType)
        }
    }
    
    private func setIcon(_ isFav: Bool) {
        if isFav {
            btn.setImage(UIImage(named: "fav_icon"), for: .normal)
        } else {
            btn.setImage(UIImage(named: "unfav_icon"), for: .normal)
        }
    }
}
