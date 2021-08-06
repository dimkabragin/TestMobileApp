//
//  CustomTextField.swift
//  TestApp
//
//  Created by Дмитрий Брагин on 05.08.2021.
//

import SwiftUI

struct CustomTextField: View {
    @State var label: String
    @Binding var isCorrect: Bool
    @Binding var text: String
    @State var isSecure: Bool
    
    var body: some View {
        HStack {
            if isSecure {
                SecureField (label, text: $text)
                    .foregroundColor(.black)
                    .padding()
                if isCorrect {
                    Text("Неверный код")
                        .font(.footnote)
                        .foregroundColor(Color.red)
                        .padding()
                }
            } else {
                HStack {
                    TextField (label, text: $text)
                        .foregroundColor(.black)
                        .padding()
                    if isCorrect {
                        Text("Неверный номер")
                            .font(.footnote)
                            .foregroundColor(Color.red)
                            .padding()
                    }
                }
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
