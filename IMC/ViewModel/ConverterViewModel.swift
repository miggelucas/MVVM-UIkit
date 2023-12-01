//
//  ConverterViewModel.swift
//  IMC
//
//  Created by Juliano Cezar Teles Vaz on 29/11/21.
//


import Foundation
import Combine
import UIKit



class ConverterViewModel: ConverterViewModelProtocol {
    var mass: CurrentValueSubject<Double, Never>
    
    var height: CurrentValueSubject<Double, Never>
    
    init(imc: IMC) {
        self.mass = CurrentValueSubject(imc.mass)
        self.height = CurrentValueSubject(imc.height)
    }
    
    public func pickerValueDidChange(_ newValue: Int) {
        self.height.value = Double(newValue)
    }
    
    public func sliderValueDidChange(_ newValue: Int) {
        self.mass.value = Double(newValue)
    }
    
    
    public func switchValueChanged(_ shouldConvertKgToLb: Bool) {
        if shouldConvertKgToLb {
            self.mass.value = convertKgToLibra(self.mass.value)
        } else {
            self.mass.value = convertLibraToKg(self.mass.value)
        }
        
    }
    
    internal func convertKgToLibra(_ kg: Double) -> Double {
        return 2.2*kg
    }
    
    internal  func convertLibraToKg(_ libra: Double) -> Double {
        return libra/2.2
    }
}



