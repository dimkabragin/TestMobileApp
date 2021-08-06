//
//  PhoneEnteryViewModel.swift
//  TestApp
//
//  Created by Дмитрий Брагин on 06.08.2021.
//

import Foundation

class PhoneEntryViewModel: ObservableObject {
    @Published var phone: String = ""
    
    func sendMessage() {
        // Тут должен быть код отправки сообщения через сервис смс рассылок
        print("Send sms")
    }
}
