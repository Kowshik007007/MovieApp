import UIKit

class SelectMovieVC: UIViewController {
    var imdbID: String? // IMDb ID passed from previous view controller

    @IBOutlet weak var movieDetailsTextView: UITextView!
    @IBOutlet weak var selectedMovieImg: UIImageView!

    private let movieService = MovieService()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let imdbID = imdbID else {
            print("No IMDb ID available")
            return
        }

        // Fetch movie details using IMDb ID
        fetchMovieDetails(imdbID: imdbID)
    }

    func fetchMovieDetails(imdbID: String) {
        movieService.fetchMovieDetails(imdbID: imdbID) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movie):
                    self?.updateUI(with: movie)
                case .failure(let error):
                    print("Error fetching movie details: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func updateUI(with movie: Movie) {
        let movieDetails = """
        Title: \(movie.title)
        Release Date: \(movie.released ?? "N/A")
        Genre: \(movie.genre ?? "N/A")
        Plot: \(movie.plot ?? "N/A")
        IMDb Rating: \(movie.imdbRating ?? "N/A")
        Released: \(movie.released ?? "N/A")
        Runtime: \(movie.runtime ?? "N/A")
        Director: \(movie.director ?? "N/A")
        Writer: \(movie.writer ?? "N/A")
        Actors: \(movie.actors ?? "N/A")
        Language: \(movie.language ?? "N/A")
        Country: \(movie.country ?? "N/A")
        Awards: \(movie.awards ?? "N/A")
        Metascore: \(movie.metascore ?? "N/A")
        IMDb Votes: \(movie.imdbVotes ?? "N/A")
        """
        
        movieDetailsTextView.text = movieDetails

        if let posterURL = URL(string: movie.poster) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: posterURL) {
                    DispatchQueue.main.async {
                        self.selectedMovieImg.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
}
