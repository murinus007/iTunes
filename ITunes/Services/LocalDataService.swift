//
//  LocalDataService.swift
//  ITunes
//
//  Created by Alex Serhiiev on 10.04.2023.
//

import Foundation
import RealmSwift


class LocalDataService {
    
    static var shared: LocalDataService = {
        let instance = LocalDataService()
        return instance
    }()
    
    let realm = try! Realm()

    func save(data: LocalModel) {
        try! realm.write {
            realm.add(data)
        }
    }
    
    func getData() -> [LocalModel]{
        var array: [LocalModel] = []
        let data = realm.objects(LocalModel.self)
        for element in data.elements {
            array.append(element)
        }
        return array
    }
    
    func delete(id: Int) {
        if let obj = realm.object(ofType: LocalModel.self, forPrimaryKey: id)
        { try! realm.write {
            realm.delete(obj)
        }
        }
    }
    
    func objectExist (id: Int) -> Bool {
        return realm.object(ofType: LocalModel.self, forPrimaryKey: id) != nil
    }
}
