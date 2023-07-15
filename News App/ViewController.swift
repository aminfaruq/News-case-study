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
    
    var viewModel = NewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        
        getData()
    }
    
    func getData() {
        viewModel.fetchNews { [weak self] result in
            switch result {
            case .success:
                // Access the news response object and its properties here
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching news: \(error)")
            }
        }
    }
   
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let data = viewModel.articles[indexPath.row]
        
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

