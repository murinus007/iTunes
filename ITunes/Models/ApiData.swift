
import Foundation

// MARK: - APIData
struct APIData: Codable {
    let resultCount: Int
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let wrapperType, kind: String
        let trackID: Int
        let artistName, trackName, trackCensoredName: String
        let trackViewURL: String
        let previewURL: String?
        let artworkUrl30, artworkUrl60, artworkUrl100: String
        let collectionPrice, trackPrice: Double?
        let collectionHDPrice: Double?
        let trackHDPrice: Double?
        let releaseDate: Date
        let collectionExplicitness, trackExplicitness: String
        let trackTimeMillis: Int?
        let country, currency, primaryGenreName, contentAdvisoryRating: String
        let longDescription: String
        let shortDescription: String?
        let hasITunesExtras: Bool?

    enum CodingKeys: String, CodingKey {
            case wrapperType, kind
            case trackID = "trackId"
            case artistName, trackName, trackCensoredName
            case trackViewURL = "trackViewUrl"
            case previewURL = "previewUrl"
            case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice
            case collectionHDPrice = "collectionHdPrice"
            case trackHDPrice = "trackHdPrice"
            case releaseDate, collectionExplicitness, trackExplicitness, trackTimeMillis, country, currency, primaryGenreName, contentAdvisoryRating, longDescription, shortDescription, hasITunesExtras
        }
}

