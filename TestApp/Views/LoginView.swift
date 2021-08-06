//
//  ContentView.swift
//  TestApp
//
//  Created by Дмитрий Брагин on 03.08.2021.
//

import SwiftUI

struct LoginView: View {
    @StateObject var vm = LoginViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                CustomTextField(label: "Телефон", isCorrect: $vm.isFalsePhoneState, text: $vm.phone, isSecure: false)
                
                if vm.isCodeFieldShowing {
                    TimerLabel(timerValue: 60)
                    
                    CustomTextField(label: "Код из смс", isCorrect: $vm.isFalseCodeState, text: $vm.code, isSecure: true)
                }
                
                Button(action: {
                    vm.stateManager()
                }) {
                    Text(vm.isCodeFieldShowing ?  "Войти" : "Запросить СМС")
                        .padding()
                }
                .background(vm.isButtonDisabled ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(vm.isButtonDisabled)
                
                // Выполняем переход к изображениям
                NavigationLink(destination: PicturesListView(), isActive: $vm.navigated) {
                    EmptyView()
                }
            }
        }
    }
}


