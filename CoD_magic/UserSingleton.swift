//
//  UserSingleton.swift
//  CoD_magic
//
//  Created by user230431 on 4/9/23.
//

import Foundation

class UserSingleton {
    static let shared = UserSingleton()
    var user: User?
    private init() {}
}
