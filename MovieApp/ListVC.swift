import UIKit

class ListVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var searchmovies: UISearchBar!
    @IBOutlet weak var table: UITableView!

    var movies: [Movie] = []
    var filteredMovies: [Movie] = []
    private let movieService = MovieService()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie List"
        table.dataSource = self
        table.delegate = self
        searchmovies.delegate = self
        fetchMovies(query: "Don")
    }

    func fetchMovies(query: String) {
        movieService.fetchMovies(query: query) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.movies = movies
                    self?.filteredMovies = movies
                    self?.table.reloadData()
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = filteredMovies[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.movieImg.loadImage(from: movie.poster)
        cell.title.text = movie.title
        cell.releasDate.text = movie.year
        
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "moviedetails", sender: self)
    }

    // MARK: - UISearchBarDelegate

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        fetchMovies(query: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moviedetails" {
            if let indexPath = table.indexPathForSelectedRow {
                let selectedMovie = filteredMovies[indexPath.row]
                let destinationVC = segue.destination as! SelectMovieVC
                destinationVC.imdbID = selectedMovie.imdbID // Pass IMDb ID instead of Movie object
            }
        }
    }
}

// Extension to load image asynchronously
extension UIImageView {
    func loadImage(from url: String) {
        guard let imageUrl = URL(string: url) else { return }
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageUrl) {
                DispatchQueue.main.async {
                    self.image = UIImage(data: imageData)
                }
            }
        }
    }
}
