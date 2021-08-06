//
//  LoginViewModel.swift
//  TestApp
//
//  Created by Дмитрий Брагин on 06.08.2021.
//

import Foundation

class LoginViewModel:ObservableObject {
    @Published var phone: String = ""
    @Published var code: String = ""
    
    @Published var isCodeFieldShowing = false
    @Published var isButtonDisabled = false
    @Published var isFalsePhoneState = false
    @Published var isFalseCodeState = false
    
    //Состояние логина храним в UserDefaults
    @Published var navigated = UserDefaults.standard.bool(forKey: "isLogin")
    func stateManager() {
        isButtonDisabled.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if (self.isCodeFieldShowing == false) {
                if (self.phone == "+79998887766") {
                    self.isCodeFieldShowing.toggle()
                    self.isFalsePhoneState = false
                }
                else {
                    self.isFalsePhoneState = true
                }
            }
            else {
                if (self.phone == "+79998887766") {
                    if (self.code == "1111") {
                        self.navigated = true
                        UserDefaults.standard.set(true, forKey: "isLogin")
                        
                        //скидываем состояние к заводским
                        self.code = ""
                        self.phone = ""
                        self.isCodeFieldShowing = false
                        self.isFalseCodeState = false
                    }
                    else {
                        self.isFalseCodeState = true;
                    }
                }
                else {
                    self.code = ""
                    self.isCodeFieldShowing = false
                    self.isFalsePhoneState = true
                    self.isFalseCodeState = false
                }
            }
            self.isButtonDisabled.toggle()
        }
    }
}
