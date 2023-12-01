//
//  CoordinatorManager.swift
//  IMC
//
//  Created by Juliano Cezar Teles Vaz on 19/11/21.
//

import Foundation
import UIKit

final class CoordinatorManager: Coordinator {
    
    // MARK: - PUBLIC PROPERTIES
    
    var navigationController: UINavigationController
    
    // MARK: - INITIALIZATION
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - FUNCTIONS
    
    func start() {
        
        let rootViewController = IMCViewController(IMCViewModel())
        rootViewController.delegate = self
        navigationController.pushViewController(rootViewController, animated: false)
    }
    
    func changeToVC2(_ mass: Double, _ height: Double) {

        let vc = ConverterViewController(ConverterViewModel(mass: mass, height: height))
        navigationController.pushViewController(vc, animated: true)
    }
}

// MARK: - EXTENSIONS

extension CoordinatorManager: IMCViewControlerDelegate {
    func showVC2(_ massLibra: Double, _ height: Double) {
        changeToVC2(massLibra, height)
    }
    

}

