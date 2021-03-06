//
//  PhoneEnteryViewModel.swift
//  TestApp
//
//  Created by Дмитрий Брагин on 06.08.2021.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var phone: String = "" {
        didSet {
            isPhoneComplete = phone.count < 15 ? false : true
        }
    }
    
    @Published var code: String = "" {
        didSet {
            isCodeComplete = code.count < 4 ? false : true
        }
    }
    
    @Published var nextPage: Bool = false
    @Published var picturesPage: Bool = false
    @Published var isPhoneComplete = false
    @Published var isCodeComplete = false
    @Published var visibleError: Error? = nil
    
    let phoneMask = "(XXX) XXX-XX-XX"
    
    func initFirstPageProperties() {
        phone = ""
        nextPage = false
        visibleError = nil
    }
    
    func initSecondPageProperties() {
        code = ""
        picturesPage = false
        visibleError = nil
    }
    
    func checkPhone(){
        if self.phone == "9998887766".format(with: phoneMask) {
            self.isPhoneComplete = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                // По идее для этого нужен отдельный метод, который будет взаимойдействовать с сервером, но на данный момент решил не раздувать код для этого.
                self.nextPage = true
                self.visibleError = nil
                self.isPhoneComplete = true
            }
        }
        else {
            self.visibleError = LoginError.UnknownPhone
        }
    }
    
    func verifyCode() {
        // Тут мы отправляем код подтверждения на сервер
        
        if self.code == "1111" {
            isCodeComplete = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.picturesPage = true
                self.visibleError = nil
                self.isCodeComplete = true
                UserDefaults.standard.set(true, forKey: "isLogin")
            }
        } else {
            self.visibleError = LoginError.CodeError
        }
    }
}
