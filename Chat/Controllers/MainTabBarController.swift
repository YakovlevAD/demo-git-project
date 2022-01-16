//
//  MainTabBarController.swift
//  Chat
//
//  Created by Alexandr Yakovlev on 12.12.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            UITabBar.appearance().standardAppearance = tabBarAppearance

            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        }

        let strubEditorViewController = StrubEditorViewController()
        let listViewController = ListViewController()
        let peopleViewController = PeopleViewController()
        let swipePeopleViewController = SwipePeopleViewController()
        
        tabBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tabBar.shadowImage = UIImage()
        let boldConfig = UIImage.SymbolConfiguration(weight: .medium)
        let plusImage = UIImage(systemName: "plus", withConfiguration: boldConfig)!
        let convImage = UIImage(systemName: "list.bullet", withConfiguration: boldConfig)!
        let peopleImage = UIImage(systemName: "person.2", withConfiguration: boldConfig)!
        
        viewControllers = [
            
        generateNavigationController(rootViewController: peopleViewController, title: "People", image: peopleImage),
        generateNavigationController(rootViewController: swipePeopleViewController, title: "People", image: peopleImage),
        generateNavigationController(rootViewController: strubEditorViewController, title: "Create", image: plusImage),
        generateNavigationController(rootViewController: listViewController, title: "List", image: convImage)
        
        ]
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage)  -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}
