//
//  ViewController.swift
//  News App
//
//  Created by Amin faruq on 28/05/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var articles : [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        addArticle()
    }
    
    func addArticle() {
        articles.append(Article(
            source: Source(id: "reuters", name: "Reuters"),
            author: "Callum Keown",
            title: "United Airlines CEO says US in a 'business recession' but consumers 'strong' - Reuters.com",
            description: "The United States is in a \"business recession\" but the consumer is \"strong\", Scott Kirby, chief executive of United Airlines (UAL.O), the world's largest carrier, told reporters at an aviat…",
            url: "https://www.reuters.com/business/aerospace-defense/united-airlines-ceo-expresses-concern-over-competing-carriers-crossing-russia-2023-06-05/",
            urlToImage: "https://www.reuters.com/resizer/DJWPfAGaQ7SRorgdtvyz57BDptU=/1200x628/smart/filters:quality(80)/cloudfront-us-east-2.images.arcpublishing.com/reuters/ZVWRR7T23ZJNFMX2MRMJDKFMCE.jpg",
            publishedAt: "2023-06-05",
            content: "ISTANBUL, June 5 (Reuters) - The United States is in a \"business recession\" but the consumer is \"strong\", Scott Kirby, chief executive of United Airlines (UAL.O), the world's largest carrier, told re… [+2801 chars]"
        ))
        articles.append(Article(
            source: Source(id: nil, name: "Barron's"),
            author: "Callum Keown, Emily Dattilo",
            title: "Palo Alto, Dish Network, C3.ai, EPAM Systems, and More Stock Market Movers - Barron's",
            description: "Palo Alto Networks rises on news it will join S&P 500 Index later this month, replacing Dish Network, while EPAM Systems falls on cut to guidance.",
            url: "https://www.barrons.com/articles/stock-market-movers-f48662b5",
            urlToImage: "https://images.barrons.com/im-401574/social",
            publishedAt: "2023-06-05",
            content: "U.S. stock futures were mixed early Monday after the \r\nS&P 500\r\n enjoyed its best week since the end of March, helped by the strong May jobs report.\r\n Palo Alto Networks\r\n(ticker: PANW) stock cli… [+980 chars]"
        ))
        articles.append(Article(
            source: Source(id: "reuters", name: "Reuters"),
            author: "Callum Keown",
            title: "United Airlines CEO says US in a 'business recession' but consumers 'strong' - Reuters.com",
            description: "The United States is in a \"business recession\" but the consumer is \"strong\", Scott Kirby, chief executive of United Airlines (UAL.O), the world's largest carrier, told reporters at an aviat…",
            url: "https://www.reuters.com/business/aerospace-defense/united-airlines-ceo-expresses-concern-over-competing-carriers-crossing-russia-2023-06-05/",
            urlToImage: "https://www.reuters.com/resizer/DJWPfAGaQ7SRorgdtvyz57BDptU=/1200x628/smart/filters:quality(80)/cloudfront-us-east-2.images.arcpublishing.com/reuters/ZVWRR7T23ZJNFMX2MRMJDKFMCE.jpg",
            publishedAt: "2023-06-05",
            content: "ISTANBUL, June 5 (Reuters) - The United States is in a \"business recession\" but the consumer is \"strong\", Scott Kirby, chief executive of United Airlines (UAL.O), the world's largest carrier, told re… [+2801 chars]"
        ))
        articles.append(Article(
            source: Source(id: nil, name: "Barron's"),
            author: "Callum Keown, Emily Dattilo",
            title: "Palo Alto, Dish Network, C3.ai, EPAM Systems, and More Stock Market Movers - Barron's",
            description: "Palo Alto Networks rises on news it will join S&P 500 Index later this month, replacing Dish Network, while EPAM Systems falls on cut to guidance.",
            url: "https://www.barrons.com/articles/stock-market-movers-f48662b5",
            urlToImage: "https://images.barrons.com/im-401574/social",
            publishedAt: "2023-06-05",
            content: "U.S. stock futures were mixed early Monday after the \r\nS&P 500\r\n enjoyed its best week since the end of March, helped by the strong May jobs report.\r\n Palo Alto Networks\r\n(ticker: PANW) stock cli… [+980 chars]"
        ))
        tableView.reloadData()
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

