//
//  User.swift
//  ITunes
//
//  Created by Alex Serhiiev on 08.04.2023.
//

import Foundation
import RealmSwift

class UserModel: Object {
    @Persisted var name: String
    @Persisted(primaryKey: true) var login: String
    @Persisted var password: String

    convenience init(name: String, login: String, password: String) {
        self.init()
        self.name = name
        self.login = login
        self.password = password

    }
}
