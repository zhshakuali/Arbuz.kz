//
//  MainTabBarViewController.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 16.05.2024.
//

import UIKit
import SwiftUI

class MainTabBarViewController: UITabBarController {
    
    let cartManager = CartManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViewControllers()
        tabBar.tintColor = .green
    }
    
    private func addViewControllers() {
        let mainViewController = MainScreenViewController(cartManager: cartManager)
        mainViewController.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "house"), tag: 0)
        
        let cartViewController = BasketViewController(cartManager: cartManager)
        cartViewController.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(systemName: "cart"), tag: 1)
        
        viewControllers = [mainViewController, cartViewController]
    }
}
