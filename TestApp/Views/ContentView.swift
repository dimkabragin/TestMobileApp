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
    
    // Тут делаем константу с изначальным значением таймера, чтобы было проще работать
    let timeValue = 60
    @State var timeRemaining = 60
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var isCodeFieldShowing = false
    @State var isButtonDisabled = false
    @State var isFalsePhoneState = false
    @State var isFalseCodeState = false
    @State var isTimerTextUpdate = false
    @State var navigated = UserDefaults.standard.bool(forKey: "isLogin")
    
    var body: some View {
        NavigationView{
            VStack {
                CustomTextField(label: "Введите номер телефона", isCorrect: isFalsePhoneState, text: $phone, isSecure: false)
                
                if isCodeFieldShowing {
                    Button(action: {
                        if (timeRemaining == 0) {
                            isTimerTextUpdate.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                timeRemaining = timeValue
                                isTimerTextUpdate.toggle()
                            }
                        }
                    }) {
                        Text(self.timeRemaining > 0 ? "Повторить запрос кода через \(timeRemaining)" : "Повторить запрос")
                    }
                    .foregroundColor(self.timeRemaining > 0 || isTimerTextUpdate ? Color.gray : Color.blue)
                    .font(Font.caption)
                    .onReceive(timer) { time in
                        if self.isCodeFieldShowing == true &&
                            self.timeRemaining > 0 {
                            self.timeRemaining -= 1
                        }
                    }
                    .disabled(timeRemaining > 0 || isTimerTextUpdate)
                    
                    CustomTextField(label: "Введите код из смс", isCorrect: isFalseCodeState, text: $code, isSecure: true)
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
                                    timeRemaining = timeValue
                                    isCodeFieldShowing = false
                                    isFalseCodeState = false
                                }
                                else {
                                    isFalseCodeState = true;
                                }
                            }
                            else {
                                code = ""
                                timeRemaining = timeValue
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


