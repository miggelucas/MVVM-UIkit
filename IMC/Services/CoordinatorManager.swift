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
        
        let viewModel = IMCViewModel()
        viewModel.delegate = self
        let rootViewController = IMCViewController(viewModel)
        navigationController.pushViewController(rootViewController, animated: false)
    }
    
    func navigateToConvertViewController(data imc: IMC) {
        let viewModel = ConverterViewModel(imc: imc)
        let vc = ConverterViewController(viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
}

// MARK: - EXTENSIONS

extension CoordinatorManager: IMCViewControlerDelegate {
    func showVC2(data: IMC) {
        navigateToConvertViewController(data: data)
    }


}

