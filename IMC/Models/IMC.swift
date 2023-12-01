//
//  IMC.swift
//  IMC
//
//  Created by Lucas Migge on 01/12/23.
//

import Foundation

struct IMC {
    let mass: Double
    let height: Double
    
    init(mass: Double, height: Double) {
        self.mass = mass
        self.height = height
    }
    
    init?(mass: Double?, height: Double?) {
        guard let safeMass = mass else { return nil }
        guard let safeHeight = height else { return nil}
        
        self.mass = safeMass
        self.height = safeHeight
    }
    
    func value() -> Double {
        return self.mass/pow(self.height, 2) * 10000.0
    }
    
}
