//
//  PhoneEntryView.swift
//  TestApp
//
//  Created by Дмитрий Брагин on 06.08.2021.
//

import SwiftUI

struct PhoneEntryView: View {
    
    @ObservedObject var vm = PhoneEntryViewModel()
    
    var body: some View {
        VStack (spacing: 30) {
            header
            PhoneNumTextField(vm: vm)
            
            Spacer()
            TapButton(btnText: "Подтвердить номер")
                .padding(.bottom, 50)
                .frame(width: 250)
                .onTapGesture {
                    vm.sendMessage()
                    //CodeEnteryView(vm:vm)
                }
            
        }
    }
    
    var header: some View {
        VStack (spacing: 15) {
            Text("Шаг 1/2")
                .font(.footnote)
                .bold()
            Text("Введите номер своего телефона чтобы начать")
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
            Text("Мы пришлем на него проверочный код")
                .font(.footnote)
        }
        .padding()
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .principal) {
//                ProgressStepper(range: 0...2, fill: 1)
//                    .frame(width: 120)
//            }
//        }
    }
}
