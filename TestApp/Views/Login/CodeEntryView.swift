//
//  CodeEntryView.swift
//  TestApp
//
//  Created by Дмитрий Брагин on 06.08.2021.
//

import SwiftUI

struct CodeEntryView: View {
    
    @ObservedObject var vm: LoginViewModel
    
    
    var body: some View {
        VStack(spacing: 20) {
            if vm.visibleError != nil { ErrorView(vm: vm) }
            header
            CodeTextField(code: $vm.code)
            TimerLabel(timerValue: 60)
            
            Spacer()
            
            Button(action: {
                vm.verifyCode()
                // Переход к списку изображений
            }, label: {
                TapButton(btnText: "Подтвердить", disabled: $vm.isCodeComplete)
                    .padding(.bottom, 50)
                    .frame(width: 250)
                    .onTapGesture {
                        guard vm.isCodeComplete else { return }
                        vm.verifyCode()
                    }
            })
            
            NavigationLink(destination: PicturesListView(), isActive: $vm.picturesPage) {
                EmptyView()
            }
        }
        .onAppear {
            vm.initSecondPageProperties()
        }
    }
    
    var header: some View {
        VStack(spacing: 15) {
//            Text("ШАГ 2/2")
//                .font(.footnote)
//                .bold()
//                .tracking(1.5)
            
            Text("Подтвердите номер")
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
            
            Text("Мы направили код подтверждения на номер \n +7 \(vm.phone)")
                .font(.footnote)
                .multilineTextAlignment(.center)
        }
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .principal) {
//                ProgressStepper(range: 0...2, fill: 2)
//                    .frame(width: 120)
//            }
//        }
    }
    
//    var phoneNumEntry: some View {
//        Rectangle()
//        //PhoneNumEntryView()
//    }
    
//    var errorView: some View {
//        HStack {
//            Spacer()
//            Image.warning
//                .resizable()
//                .renderingMode(.template)
//                .foregroundColor(.slateBlue)
//                .frame(width: 18, height: 18, alignment: .center)
//            Text(viewModel.visibleError?.localizedDescription ?? "")
//                .font(.medTwelve)
//            Spacer()
//        }
//
//    }
    
//    func backBtnTapped() {
//        self.presentationMode.wrappedValue.dismiss()
//    }
}
