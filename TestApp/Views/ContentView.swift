//
//  ContentView.swift
//  TestApp
//
//  Created by Дмитрий Брагин on 03.08.2021.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State var phone: String = ""
    @State var code: String = ""
    

    
    @State var isCodeFieldShowing = false
    @State var isButtonDisabled = false
    @State var isFalsePhoneState = false
    @State var isFalseCodeState = false
    @State var navigated = UserDefaults.standard.bool(forKey: "isLogin")
    
    var body: some View {
        NavigationView{
            VStack {
                CustomTextField(label: "Введите номер телефона", isCorrect: $isFalsePhoneState, text: $phone, isSecure: false)
                
                if isCodeFieldShowing {
                    
                    TimerLabel(timerValue: 60)
                    
                    CustomTextField(label: "Введите код из смс", isCorrect: $isFalseCodeState, text: $code, isSecure: true)
                }
                
                // Тут, конечно, знатный говнокод, если останется время лучше переделать это чтобы каждый контрол отвечал за свой контент, тогда не потребуется тысяча вложенных if. Но за неимением времени пока оставлю так. Если будет время - поправлю чтобы было повкуснее
                
                Button(action: {
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
                            }
                        }
                        isButtonDisabled.toggle()
                    }
                    
                }) {
                    Text(isCodeFieldShowing ?  "Войти" : "Запросить СМС")
                        .padding()
                }
                .background(isButtonDisabled ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(isButtonDisabled)
                
                NavigationLink(destination: PicturesListView(), isActive: $navigated) {
                    EmptyView()
                }
            }
        }
    }
}


