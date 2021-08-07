//
//  ErrorView.swift
//  TestApp
//
//  Created by Дмитрий Брагин on 07.08.2021.
//

import SwiftUI

struct ErrorView: View {
    
    @ObservedObject var vm: LoginViewModel
    
    var body: some View {
        HStack (spacing: 20){
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .padding(.leading, 20)
            Text(vm.visibleError?.localizedDescription ?? "")
                .font(.body)
                .bold()
            Spacer()
        }
        .frame(height: 60)
        .background(Color.red)
        .foregroundColor(.white)
        .cornerRadius(16)
        .padding(.horizontal)
    }
}
