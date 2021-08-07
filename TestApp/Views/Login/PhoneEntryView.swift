//
//  PhoneEntryView.swift
//  TestApp
//
//  Created by Дмитрий Брагин on 06.08.2021.
//

import SwiftUI

struct PhoneEntryView: View {
    
    @StateObject var vm = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack (spacing: 20) {
                if vm.visibleError != nil { ErrorView(vm: vm) }
                header
                PhoneNumTextField(vm: vm)
                
                Spacer()
                
                TapButton(btnText: "Подтвердить номер", disabled: $vm.isPhoneComplete)
                    .padding(.bottom, 50)
                    .frame(width: 250)
                    .onTapGesture {
                        guard vm.isPhoneComplete else { return }
                        vm.checkPhone()
                    }
                
                NavigationLink(destination: CodeEntryView(vm:vm), isActive: $vm.nextPage) {
                    EmptyView()
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            vm.initFirstPageProperties()
        }
    }
    
    var header: some View {
        VStack (spacing: 15) {
//            Text("ШАГ 1/2")
//                .font(.footnote)
//                .bold()
            Text("Введите номер своего телефона чтобы начать")
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
                .frame(height: 70)
            Text("Мы пришлем на него проверочный код")
                .font(.footnote)
        }
    }
}
