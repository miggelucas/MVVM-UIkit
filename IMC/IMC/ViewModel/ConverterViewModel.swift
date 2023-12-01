//
//  ConverterViewModel.swift
//  IMC
//
//  Created by Juliano Cezar Teles Vaz on 29/11/21.
//


import Foundation
import Combine
import UIKit

protocol ConverterViewModelProtocol: AnyObject {
    var mass: CurrentValueSubject<Double, Never> { get }
    var height: CurrentValueSubject<Double, Never> { get }
    
    func pickerValueDidChange(_ newValue: Int)
    func sliderValueDidChange(_ newValue: Int)
    func switchValueChanged(_ shouldConvertKgToLb: Bool)
}

class ConverterViewModel: ConverterViewModelProtocol {
    var mass: CurrentValueSubject<Double, Never>
    
    var height: CurrentValueSubject<Double, Never>
    
    init(mass: Double, height: Double) {
        self.mass = CurrentValueSubject(mass)
        self.height = CurrentValueSubject(height)
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



