//
//  ConverterViewModelProtocol.swift
//  IMC
//
//  Created by Lucas Migge on 01/12/23.
//

import Foundation
import Combine

protocol ConverterViewModelProtocol: AnyObject {
    var mass: CurrentValueSubject<Double, Never> { get }
    var height: CurrentValueSubject<Double, Never> { get }
    
    func pickerValueDidChange(_ newValue: Int)
    func sliderValueDidChange(_ newValue: Int)
    func switchValueChanged(_ shouldConvertKgToLb: Bool)
}
