//
//  UserService.swift
//  ITunes
//
//  Created by Alex Serhiiev on 08.04.2023.
//

import Foundation
import RealmSwift


class UserService {
    
    static var shared: UserService = {
        let instance = UserService()
        return instance
    }()
    
    let realm = try! Realm()
    let defaults = UserDefaults.standard
    
    func objectExist (login: String) -> Bool {
        return realm.object(ofType: UserModel.self, forPrimaryKey: login) != nil
    }
    
    func saveUser(data: UserModel) {
        try! realm.write {
            realm.add(data)
        }
    }
    
    func getUser(login: String) -> UserModel? {
        realm.object(ofType: UserModel.self, forPrimaryKey: login)
    }
    
    func saveCurentUser(login: String) {
        defaults.set(login, forKey: "userEmail")
    }
    
    func getCurentUser() -> String? {
        defaults.string(forKey: "userEmail")
    }
    
    func logOutUser() {
        defaults.set(nil, forKey: "userEmail")
    }
    
}
