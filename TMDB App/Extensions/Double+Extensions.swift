//
//  Double+Extensions.swift
//  TMDB App
//
//  Created by Carlos Paredes on 23/3/24.
//

import Foundation

extension Double {
    func formatAsCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: self)) ?? "0.00"
    }
}
