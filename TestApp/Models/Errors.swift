//
//  Errors.swift
//  TestApp
//
//  Created by Дмитрий Брагин on 07.08.2021.
//

import Foundation

enum LoginError: Error {
    case UnknownPhone
    case CodeError
}

extension LoginError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .UnknownPhone:
            return "Этот номер телефона не зарегистрирован"
            
        case .CodeError:
            return "Неверный код! Повторите попытку"
        }
    }
}
