//
//  PhoneNumTextField.swift
//  TestApp
//
//  Created by Дмитрий Брагин on 06.08.2021.
//

import SwiftUI

struct PhoneNumTextField: View {
    
    @ObservedObject var vm: PhoneEntryViewModel
    
    let phoneMask = "(XXX) XXX-XXXX"
    
    var body: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.white)
                .shadow(radius: 3)
                .frame(height: 60)
            HStack {
                Text("+7")
                    .font(.headline)
                    .padding(.horizontal)
                    .foregroundColor(Color.gray)
                phoneNumEntry
            }
        }
        .frame(width: 350)
    }
    
    var phoneNumEntry: some View {
        TextField(phoneMask, text: $vm.phone)
            .keyboardType(.numberPad)
            .onChange(of: vm.phone) { value in
                vm.phone = vm.phone.format(with: phoneMask)
            }
    }
}
