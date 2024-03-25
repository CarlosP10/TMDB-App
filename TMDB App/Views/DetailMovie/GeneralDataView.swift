//
//  GeneralDataView.swift
//  TMDB App
//
//  Created by Carlos Paredes on 23/3/24.
//

import SwiftUI

struct GeneralDataView: View {
    let name: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(name)
            Text(value)
        }
        .padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 20))
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        .padding(.leading, 5)
        .padding(.bottom, 5)
        .font(.footnote)
        .foregroundColor(.gray)
    }
}

#Preview {
    GeneralDataView(name: "Length", value: "149 min")
}
