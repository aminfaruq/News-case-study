//
//  ViewController.swift
//  News App
//
//  Created by Amin faruq on 28/05/23.
//

import UIKit
/*
 Get api from
 
 https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=API-KEY
 
 */

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var articles : [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        
        fetchNews { result in
            switch result {
            case .success(let newsResponse):
                // Access the news response object and its properties here
                DispatchQueue.main.async {
                    self.articles = newsResponse.articles
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching news: \(error)")
            }
        }
    }
    
    func fetchNews(completion: @escaping (Result<NewsResponse, Error>) -> Void) {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=\(Constans.API_KEY)") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let newsResponse = try decoder.decode(NewsResponse.self, from: data)
                    completion(.success(newsResponse))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
            }
        }
        
        task.resume()
    }
   
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let data = articles[indexPath.row]
        
        cell.publisherlabel.text = data.source?.name
        cell.titleLabel.text = data.title
        cell.authorLabel.text = data.author
        cell.releaseDateLabel.text = data.publishedAt
        
        if let url = URL(string: data.urlToImage ?? "") {
            cell.newsImageView.setImage(from: url)
        }
        
        return cell
    }
    
    
}

