//
//  MainTabBarController.swift
//  Chat
//
//  Created by Alexandr Yakovlev on 12.12.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    private let currentUser: MUser

    init(currentUser: MUser = MUser(username: "userName",
                                    email: "fr",
                                    avatarStringURL: "fer",
                                    description: "fre",
                                    sex: "ewr",
                                    id: "fregtr")) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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

        //let strubEditorViewController = StrubEditorViewController()
        let listViewController = ListViewController(currentUser: currentUser)
        let peopleViewController = PeopleViewController(currentUser: currentUser)
        let swipePeopleViewController = SwipePeopleViewController()
        
        tabBar.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        tabBar.shadowImage = UIImage()
        let boldConfig = UIImage.SymbolConfiguration(weight: .medium)
        //let plusImage = UIImage(systemName: "plus", withConfiguration: boldConfig)!
        let convImage = UIImage(systemName: "list.bullet", withConfiguration: boldConfig)!
        let peopleImage = UIImage(systemName: "person.2", withConfiguration: boldConfig)!
        
        viewControllers = [
            
        generateNavigationController(rootViewController: peopleViewController, title: "People", image: peopleImage),
        generateNavigationController(rootViewController: swipePeopleViewController, title: "People", image: peopleImage),
        //generateNavigationController(rootViewController: strubEditorViewController, title: "Create", image: plusImage),
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
