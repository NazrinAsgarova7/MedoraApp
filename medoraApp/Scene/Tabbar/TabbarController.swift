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
        let homevc = UINavigationController(rootViewController: HomeController())
        
        homevc.tabBarItem = .init(title: nil, image: UIImage(systemName: "house"), tag: 0)
        viewControllers = [homevc]
    }
}
