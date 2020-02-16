//
//  TabBarVC.swift
//  KittyChallenge
//
//  Created by Stuti Dobhal on 16.02.20.
//  Copyright © 2020 Stuti Dobhal. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class FirstTabBarVC: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let allCats = segue.destination  as? KittyVC {
            allCats.kittyVM = KittyVM(.allList)
        }
    }
}

class SecondTabBarVC: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let favCats = segue.destination as? KittyVC {
            favCats.kittyVM = KittyVM(.favourite)
        }
    }
}
