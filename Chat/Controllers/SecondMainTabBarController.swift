//
//  SecondMainTabBarController.swift
//  Chat
//
//  Created by Alexandr Yakovlev on 29.01.2022.
//

import UIKit

class SecondMainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contactViewController = ContactViewController()
        let contactImage = UIImage(systemName: "plus")!
        
        
        viewControllers = [
            generateNavigationController(rootViewController: contactViewController, title: "Contact", image: contactImage)
        ]
        
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title:String, image:UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}

//// MARK: - SwiftUI
//import SwiftUI
//
//struct ContacVCProvider: PreviewProvider {
//    static var previews: some View {
//        ContainerView().edgesIgnoringSafeArea(.all)
//    }
//    
//    struct ContainerView: UIViewControllerRepresentable {
//        
//        
//        let contactVC = SecondMainTabBarController()
//        
//        func makeUIViewController(context: UIViewControllerRepresentableContext<ContacVCProvider.ContainerView>) ->  SecondMainTabBarController {
//            return contactVC
//        }
//        
//        func updateUIViewController(_ uiViewController: ContacVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ContacVCProvider.ContainerView>) {
//            
//        }
//    }
//}
