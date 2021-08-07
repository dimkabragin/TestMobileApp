//
//  SwiftUIView.swift
//  TestApp
//
//  Created by Дмитрий Брагин on 06.08.2021.
//

import SwiftUI

struct TapButton: View {
    
    @State var btnText: String
    @Binding var disabled: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(disabled ? .blue : .gray)
                .frame(height: 56, alignment: .center)
            Text(btnText)
                .foregroundColor(.white)
                .font(.headline)
        }
    }
}
