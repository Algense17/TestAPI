//
//  ViewController.swift
//  TestAPI
//
//  Created by Vasiliy on 06.04.2025.
//

import UIKit

enum Link {
    case link
    
    var url: URL {
        switch self {
        case .link:
            URL(string: "https://similar-movies.p.rapidapi.com/similar?id=24168-titanic")!
        }
    }
}

enum Alert {
    case success
    case failed
    
    var title: String {
        switch self {
        case .success:
            "Success"
        case .failed:
            "Failed"
        }
    }
    
    var message: String {
        switch self {
        case .success:
            "You can see the results in the Debug area"
        case .failed:
            "You can see error in the Debug area"
        }
    }
}

final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func buttonAction() {
        var request = URLRequest(url: Link.link.url)
        request.httpMethod = "GET"
        let headers = [
            "x-rapidapi-key": "9aeb58e1dfmsh04143f590a61cddp14be33jsn423a0b68d424",
            "x-rapidapi-host": "similar-movies.p.rapidapi.com"
        ]
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let self else { return }
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let moviesResponse = try decoder.decode(MoviesResponse.self, from: data)
                showAlert(withStatus: .success)
                for movieArray in moviesResponse.movies {
                    for movie in movieArray {
                        print("Title: \(movie.title)")
                        print("Genre: \(movie.genre)")
                        print("Rating: \(movie.rating)")
                        print("Country: \(movie.country)")
                        print("Duration: \(movie.duration)")
                        print("Story: \(movie.story)")
                        print("Style: \(movie.style)")
                        print("Audience: \(movie.audience)")
                        print("Plot: \(movie.plot)")
                        print("ID: \(movie.id)")
                        print("Image: \(movie.img)")
                        print("---")
                    }
                }
                
            } catch let error {
                print(error.localizedDescription)
                showAlert(withStatus: .failed)
            }
            
        }.resume()
    }
    
    
}

// MARK: - Internal Methods
private extension ViewController {
    func showAlert(withStatus status: Alert) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(
                title: status.title,
                message: status.message,
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            
            self?.present(alert, animated: true)
        }
    }
}

