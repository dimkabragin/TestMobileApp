//
//  CodeTextField.swift
//  TestApp
//
//  Created by Дмитрий Брагин on 06.08.2021.
//

import SwiftUI

struct CodeTextField: View {
    
    @Binding var code: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.white)
                .shadow(radius: 3)
                .frame(height: 60)
            SecureField("XXXX", text: $code)
                .font(.title)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
        }
        .frame(width: 350)
    }
}
