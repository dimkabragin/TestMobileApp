//
//  PhoneNumTextField.swift
//  TestApp
//
//  Created by Дмитрий Брагин on 06.08.2021.
//

import SwiftUI

struct PhoneNumTextField: View {
    
    @ObservedObject var vm: LoginViewModel
    
    
    
    var body: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.white)
                .shadow(radius: 3)
                .frame(height: 60)
            HStack {
                Text("+7")
                    .font(.headline)
                    .padding(.leading)
                    .foregroundColor(Color.gray)
                phoneNumEntry
            }
        }
        .frame(width: 350)
    }
    
    var phoneNumEntry: some View {
        TextField(vm.phoneMask, text: $vm.phone)
            .keyboardType(.numberPad)
            .onChange(of: vm.phone) { value in
                vm.phone = vm.phone.format(with: vm.phoneMask)
            }
    }
}
