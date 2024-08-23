import Foundation

struct Movie: Codable {
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String
    let genre: String?
    let plot: String?
    let imdbRating: String?
    let released: String?
    let runtime: String?
    let director: String?
    let writer: String?
    let actors: String?
    let language: String?
    let country: String?
    let awards: String?
    let metascore: String?
    let imdbVotes: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID = "imdbID"
        case type = "Type"
        case poster = "Poster"
        case genre = "Genre"
        case plot = "Plot"
        case imdbRating = "imdbRating"
        case released = "Released"
        case runtime = "Runtime"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case metascore = "Metascore"
        case imdbVotes = "imdbVotes"
    }
}

struct MovieResponse: Codable {
    let search: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}
