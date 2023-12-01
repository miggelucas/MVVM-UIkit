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
}

class IMCViewModel: IMCViewModelProtocol {
    
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
    
}
