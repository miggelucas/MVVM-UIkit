//
//  IMCViewModel.swift
//  IMC
//
//  Created by Juliano Cezar Teles Vaz on 24/11/21.
//

import Foundation

protocol IMCViewControlerDelegate: AnyObject {
    func showVC2(_ mass: Double, _ height: Double)
}

protocol IMCViewModelProtocol {
    func IMC(_ mass: Double, _ height: Double) -> Double
    func changeTextAndImageResult(_ resultIMC: Double) -> (subtitleResultLabel: String, imageName: String)
    func converterButtonPressed()
    func userDidUpdateHeitgh(newValue: String)
    func userDidUpdateMass(newValue: String)
}

class IMCViewModel: IMCViewModelProtocol {
    
    weak var delegate: IMCViewControlerDelegate?
    
    var mass: Double?
    var height: Double?
    
    func converterButtonPressed() {
        guard let safeMass = mass else { return }
        guard let safeHeight = height else { return }
        delegate?.showVC2(safeMass, safeHeight)
        
    }
    
    func IMC(_ mass: Double, _ height: Double) -> Double{
        return mass/pow(height, 2) * 10000.0
    }
    
    func changeTextAndImageResult(_ resultIMC: Double) -> (subtitleResultLabel: String, imageName: String){
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
