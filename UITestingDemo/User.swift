//
//  User.swift
//  UITestingDemo
//
//  Created by 박준영 on 12/18/23.
//

import Foundation

class User: ObservableObject {
    @Published var isLoggedin = false
    @Published var username = ""
    @Published var password = ""
    
    func login() -> Bool {
        guard username == "test" && password == "pass" else {
            return false
        }
        
        password = ""
        isLoggedin = true
        
        return true
    }
}
