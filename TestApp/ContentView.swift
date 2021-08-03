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
    
    var body: some View {
        VStack {
            HStack {
                TextField ("Введите номер телефона", text: $phone)
                    .foregroundColor(.black)
                    .padding()
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 3)
            .overlay(
                RoundedRectangle(cornerRadius: 10).stroke(isFalsePhoneState ? Color.red : Color.clear, lineWidth: 3)
            )
            .padding(.horizontal)
            
            // Также нужно еще реализовать сюда таймер для обратного отсчета для повторного запроса кода.
            
            if isCodeFieldShowing {
                HStack {
                    SecureField ("Введите код из смс", text: $code)
                        .foregroundColor(.black)
                        .padding()
                }
                
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 3)
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(isFalseCodeState ? Color.red : Color.clear, lineWidth: 3)
                )
                .padding()
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
                                isFalseCodeState = false;
                                //Вот тут входим в нашу главную страничку и записываем данные в CoreData о входе
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


