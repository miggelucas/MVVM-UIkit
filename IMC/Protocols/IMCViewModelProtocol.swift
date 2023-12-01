//
//  IMCViewModelProtocol.swift
//  IMC
//
//  Created by Lucas Migge on 01/12/23.
//

import Foundation

protocol IMCViewModelProtocol {
    func changeTextAndImageResult(_ resultIMC: Double) -> (subtitleResultLabel: String, imageName: String)
    func converterButtonPressed(handler: @escaping (IMCError) -> Void)
    func calculateButtonPressed() -> Result<(String, String), IMCError>
    func userDidUpdateHeitgh(newValue: String)
    func userDidUpdateMass(newValue: String)
}

