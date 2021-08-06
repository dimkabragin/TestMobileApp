//
//  ContentView.swift
//  TestApp
//
//  Created by Дмитрий Брагин on 03.08.2021.
//

import SwiftUI

struct ContentView: View {
    @State var phone: String = ""
    @State var code: String = ""
    
    @State var isCodeFieldShowing = false
    @State var isButtonDisabled = false
    @State var isFalsePhoneState = false
    @State var isFalseCodeState = false
    
    //Состояние логина храним в UserDefaults
    @State var navigated = UserDefaults.standard.bool(forKey: "isLogin")
    
    var body: some View {
        NavigationView{
            VStack {
                CustomTextField(label: "Телефон", isCorrect: $isFalsePhoneState, text: $phone, isSecure: false)
                
                if isCodeFieldShowing {
                    TimerLabel(timerValue: 60)
                    
                    CustomTextField(label: "Код из смс", isCorrect: $isFalseCodeState, text: $code, isSecure: true)
                }
                
                Button(action: {
                    StateManager()
                }) {
                    Text(isCodeFieldShowing ?  "Войти" : "Запросить СМС")
                        .padding()
                }
                .background(isButtonDisabled ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(isButtonDisabled)
                
                // Выполняем переход к изображениям
                NavigationLink(destination: PicturesListView(), isActive: $navigated) {
                    EmptyView()
                }
            }
        }
    }
    
    
    // Тут, конечно, знатный говнокод, если останется время лучше переделать это чтобы каждый контрол отвечал за свой контент, тогда не потребуется тысяча вложенных if. Но за неимением времени пока оставлю так. Если будет время - поправлю чтобы было повкуснее
    
    func StateManager() {
        isButtonDisabled.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if (isCodeFieldShowing == false) {
                if (phone == "+79998887766") {
                    isCodeFieldShowing.toggle()
                    isFalsePhoneState = false
                }
                else {
                    isFalsePhoneState = true
                }
            }
            else {
                if (phone == "+79998887766") {
                    if (code == "1111") {
                        self.navigated = true
                        UserDefaults.standard.set(true, forKey: "isLogin")
                        
                        //скидываем состояние к заводским
                        code = ""
                        phone = ""
                        isCodeFieldShowing = false
                        isFalseCodeState = false
                    }
                    else {
                        isFalseCodeState = true;
                    }
                }
                else {
                    code = ""
                    isCodeFieldShowing = false
                    isFalsePhoneState = true
                    isFalseCodeState = false
                }
            }
            isButtonDisabled.toggle()
        }
    }
}


