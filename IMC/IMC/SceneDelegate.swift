//
//  SceneDelegate.swift
//  IMC
//
//  Created by Juliano Cezar Teles Vaz on 19/11/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - PUBLIC PROPERTIES
    
    var window: UIWindow?
    var coordinator: CoordinatorManager?
    
    // MARK: - PUBLIC FUNCTIONS
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        let rootNavigationController = UINavigationController()
        
        coordinator = CoordinatorManager(navigationController: rootNavigationController)
       
        coordinator?.start()
      
        self.window?.rootViewController = rootNavigationController
        self.window?.makeKeyAndVisible()
        
    }
}

