//
//  MainTabBarViewController.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 16.05.2024.
//

import UIKit
import SwiftUI

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
           super.viewDidLoad()
           
           let mainViewController = UIHostingController(rootView: MainView())
           mainViewController.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "house"), tag: 0)
           
           let cartViewController = UIHostingController(rootView: HomeView())
           cartViewController.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(systemName: "cart"), tag: 1)
           
           viewControllers = [mainViewController, cartViewController]
           
           // Установка цвета для активной вкладки
           tabBar.tintColor = .green
       }

}
