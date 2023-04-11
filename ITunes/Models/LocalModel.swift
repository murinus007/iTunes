//
//  LocalData.swift
//  ITunes
//
//  Created by Alex Serhiiev on 10.04.2023.
//

import Foundation
import RealmSwift

class LocalModel: Object {
    @Persisted var artworkUrl100: String
    @Persisted var longDescription: String
    @Persisted var trackName: String
    @Persisted var releaseDate: Date
    @Persisted var primaryGenreName: String
    @Persisted var previewURL: String?
    @Persisted var trackViewURL: String
    @Persisted(primaryKey: true) var trackID: Int
    
    convenience init(element: Result) {
        self.init()
        artworkUrl100 = element.artworkUrl100
        longDescription = element.longDescription
        trackName = element.trackName
        releaseDate = element.releaseDate
        primaryGenreName = primaryGenreName
        trackID = element.trackID
        previewURL = element.previewURL
        trackViewURL = element.trackViewURL
    }
}
