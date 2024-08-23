import Foundation

class MovieService {
    private let apiKey = "64e5c48a" // Replace with your actual API key
    
    // Fetch movies based on a search query
    func fetchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let urlString = "http://www.omdbapi.com/?apikey=\(apiKey)&type=movie&s=\(query)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }

            // Convert data to JSON string for debugging
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON Response: \(jsonString)")
            }
            
            do {
                // Decode JSON into MovieResponse
                let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                // Pass the decoded movies to the completion handler
                completion(.success(movieResponse.search))
            } catch {
                // Handle decoding error
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    // Fetch detailed information for a specific movie
    func fetchMovieDetails(imdbID: String, completion: @escaping (Result<Movie, Error>) -> Void) {
        let urlString = "http://www.omdbapi.com/?apikey=\(apiKey)&i=\(imdbID)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                // Decode JSON into Movie
                let movie = try JSONDecoder().decode(Movie.self, from: data)
                // Pass the decoded movie to the completion handler
                completion(.success(movie))
            } catch {
                // Handle decoding error
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
