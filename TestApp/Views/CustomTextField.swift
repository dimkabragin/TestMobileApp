//
//  CustomTextField.swift
//  TestApp
//
//  Created by Дмитрий Брагин on 05.08.2021.
//

import SwiftUI

struct CustomTextField: View {
    @State var label: String
    @State var isCorrect: Bool
    @Binding var text: String
    @State var isSecure: Bool
    
    var body: some View {
        HStack {
            if isSecure {
                SecureField (label, text: $text)
                    .foregroundColor(.black)
                    .padding()
            } else {
                TextField (label, text: $text)
                    .foregroundColor(.black)
                    .padding()
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
        .overlay(
            RoundedRectangle(cornerRadius: 10).stroke(isCorrect ? Color.red : Color.clear, lineWidth: 3)
        )
        .padding(.horizontal)
    }
}