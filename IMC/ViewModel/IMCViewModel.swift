//
//  IMCViewModel.swift
//  IMC
//
//  Created by Juliano Cezar Teles Vaz on 24/11/21.
//

import Foundation


class IMCViewModel: IMCViewModelProtocol {
    
    weak var delegate: IMCViewControlerDelegate?
    
    var mass: Double?
    var height: Double?
    
    func converterButtonPressed(handler: @escaping ((IMCError) -> Void)) {
        guard let imc = IMC(mass: self.mass, height: self.height) else {
            handler(.missingData)
            return
        }
        delegate?.showVC2(data: imc)
        
    }
    
    func calculateButtonPressed() -> Result<(String, String), IMCError> {
        guard let imc = IMC(mass: self.mass, height: self.height) else { return .failure(.missingData) }
        
        let imcValue = imc.value()
        return .success(changeTextAndImageResult(imcValue))
        
    }
    
    
    internal func changeTextAndImageResult(_ resultIMC: Double) -> (subtitleResultLabel: String, imageName: String) {
        switch resultIMC {
        case 0...20:
            return ("Magro","Magro.png")
            
        case 20...25:
            return ("Normal","Normal.png")
            
        case 25...30:
            return ("Sobrepeso","Sobrepeso.png")
            
        case 30...40:
            return ("Obeso","Obeso.png")
            
        case 40...:
            return ("Obesidade mórbida", "ObesidadeMorbida.png")
            
        default:
            return("Erroooo!", "Erro.png")
        }
    }
    
    
    func userDidUpdateHeitgh(newValue: String) {
        self.height = Double(newValue)
    }
    
    func userDidUpdateMass(newValue: String) {
        self.mass = Double(newValue)
        
    }
}
