//
//  TabbarController.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 13.11.25.
//

import UIKit

class TabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let homevc = UINavigationController(rootViewController: HomeController(vm: HomeViewModel()))
        
        homevc.tabBarItem = .init(title: nil, image: UIImage(systemName: "house.fill"), tag: 0)
        viewControllers = [homevc]
        tabBar.tintColor = UIColor(named: "buttonStart")
        tabBar.unselectedItemTintColor = .lightGray
    }
}
