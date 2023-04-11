//
//  ApiService.swift
//  ITunes
//
//  Created by Alex Serhiiev on 10.04.2023.
//

import Foundation
import Alamofire

class ApiService {
    
    static var shared: ApiService = {
        let instance = ApiService()
        return instance
    }()
    
    func search(text: String, completionHandler: @escaping (APIData) -> ()) {
        let url = "https://itunes.apple.com/search?term=\(text)&media=movie"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        AF.request(url).responseDecodable (of: APIData.self, decoder: decoder) { responce  in
            switch responce.result {
            case .success(let result):
                completionHandler(result)
            case .failure(let error):
                print(error)
            }
        }
    }
}
