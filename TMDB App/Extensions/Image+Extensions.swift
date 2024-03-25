//
//  Image+Extensions.swift
//  TMDB App
//
//  Created by Carlos Paredes on 22/3/24.
//

import Foundation

import SwiftUI

extension Image {
    func imageModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    
    func iconModifier() -> some View {
        self
            .imageModifier()
            .frame(maxWidth: 128)
            .foregroundColor(.purple)
            .opacity(0.5)
    }
    
    func castModifier() -> some View {
        self
            .imageModifier()
            .frame(maxHeight: 250)
            .padding(0)
            .clipShape(Circle())
            .padding(.bottom, -10)
    }
}
