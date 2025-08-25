//
//  Money.swift
//  Suma
//
//  Created by Pavel Pavel on 25/08/2025.
//
struct Money: Equatable {
    let minor: Int64
    let currency: String
    
    var isPositive: Bool { minor > 0}
    var isZero: Bool { minor == 0}
}
