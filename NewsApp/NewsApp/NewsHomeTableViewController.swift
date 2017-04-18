//
//  NewsHomeTableViewController.swift
//  NewsApp
//
//  Created by Prathiba Lingappan on 3/20/17.
//  Copyright © 2017 Prathiba Lingappan. All rights reserved.
//

import UIKit

class NewsHomeTableViewController: UITableViewController {

    var spinner = UIActivityIndicatorView()
    let loadingView = UIView()
    let loadingLabel = UILabel()
    
    var sourcesArray: [String] = []
    var articlesListArray: [Article] = []
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .none
        self.setLoadingScreen()
        
        var urlString: String
        
        if SourcesManager.shared.filteredSourcesArray.isEmpty{
            urlString = "https://newsapi.org/v1/sources?language=en"
            self.getSources(urlString)
        }
        /*else {
            sourcesArray.removeAll()
            sourcesArray = SourcesManager.shared.filteredSourcesArray
            articlesListArray.removeAll()
            for i in sourcesArray {
                let urlString = "https://newsapi.org/v1/sources?category=" + i + "&language=en"
                self.getSources(urlString)
            }
        }*/
       
        SourcesManager.shared.delegate = self
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "customNewsCell")
        
    }
    
    private func setLoadingScreen() {
        
        // Sets the view which contains the loading text and the spinner
        let width: CGFloat = 120
        let height: CGFloat = 30
        let x = (self.tableView.frame.width / 2) - (width / 2)
        let y = (self.tableView.frame.height / 2) - (height / 2) - (self.navigationController?.navigationBar.frame.height)!
        loadingView.frame = CGRect(x: x, y: y, width: width, height: height)
        
        // Sets loading text
        self.loadingLabel.textColor = UIColor.gray
        self.loadingLabel.textAlignment = NSTextAlignment.center
        self.loadingLabel.text = "Loading..."
        self.loadingLabel.frame = CGRect(x: 0, y: 0, width: 140, height: 30)
        
        // Sets spinner
        self.spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.spinner.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        self.spinner.startAnimating()
        
        // Adds text and spinner to the view
        loadingView.addSubview(self.spinner)
        loadingView.addSubview(self.loadingLabel)
        
        self.tableView.addSubview(loadingView)
        
    }
    
    // Remove the activity indicator from the main view
    private func removeLoadingScreen() {
        
        // Hides and stops the text and the spinner
        self.spinner.stopAnimating()
        self.loadingLabel.isHidden = true
        self.tableView.separatorStyle = .singleLine
        
    }
    
    func getSources(_ urlString: String) {
        
        let newsAPI = NewsAPI()
        
        newsAPI.getJSONForSource(urlString) { (sources) in
            guard let tempSources = sources else {return}
            self.sourcesArray = tempSources
            print("sources list count: \(self.sourcesArray.count)")
            self.getArticles(newsAPI)
        }
    }

    func getArticles(_ newsAPI: NewsAPI) {
        
        if !self.sourcesArray.isEmpty {
            for i in self.sourcesArray {
                //print("source of articles: \(i)")
                newsAPI.getJSONForArticle(i) { (articles) in
                    
                    guard let tempArticles = articles else {return}
                    var count = 0
                    
                    for j in tempArticles{
                        count += 1
                        self.articlesListArray.append(j)
                        //print("added article \(count) from source \(i) total articles:\(self.articlesListArray.count)")
                        if SourcesManager.shared.filteredSourcesArray.isEmpty {
                            SaveArticles.savedArticles.append(j)
                        }
                    }
                    if i == self.sourcesArray[self.sourcesArray.count-1] {
                        DispatchQueue.main.async {
                            self.removeLoadingScreen()
                            self.tableView.reloadData()
                        }
                    }
                    
                }
            }
        }
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        print("number of rows: \(articlesListArray.count)")
        return articlesListArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        guard let newsCell = tableView.dequeueReusableCell(withIdentifier: "customNewsCell", for: indexPath) as? NewsCell else {return UITableViewCell()}
        
        //print("\(indexPath.row) --- title: \(articlesListArray[indexPath.row].title)")
        
        newsCell.newsTitle.text = articlesListArray[indexPath.row].title
        //newsCell.newsSubtitle.text = articlesListArray[indexPath.row].author
        newsCell.newsImage.image = nil
        
        articlesListArray[indexPath.row].downloadImage() { (image) in
            if tableView.indexPathsForVisibleRows?.contains(indexPath) == true {
                self.articlesListArray[indexPath.row].image = image
                DispatchQueue.main.async {
                    newsCell.newsImage.image = self.articlesListArray[indexPath.row].image
                }
            }
        }
        
        return newsCell
        
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        performSegue(withIdentifier: "toArticleDescription", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? ArticleDescriptionViewController {
            guard let selectedIndexPath = selectedIndexPath else {return}
            destination.article = articlesListArray[selectedIndexPath.row]
        }
    }
    
}

extension NewsHomeTableViewController: SourcesDelegate {
    
    func filteredSourcesUpdated(_ sources: [String]) {
            
            if !SourcesManager.shared.filteredSourcesArray.isEmpty {
                articlesListArray.removeAll()
                for i in sources {
                    let urlString = "https://newsapi.org/v1/sources?category=" + i + "&language=en"
                    self.getSources(urlString)
                }
            }
            else {
                articlesListArray = SaveArticles.savedArticles
                tableView.reloadData()
            }
        
    }
    
   /* func filteredSourcesUpdated(_ sources: [String], _ searchString: String?) {
        
        if let string = searchString {
            articlesListArray.removeAll()
            for i in SaveArticles.savedArticles {
                var words = [String]()
                if char == " " {
                    continue
                }else{
                    words.append(char)
                }
                if string.lowercased() == i.title.lowercased() {
                    articlesListArray.append(i)
                }
            }
        }
        else {
            
            if !SourcesManager.shared.filteredSourcesArray.isEmpty {
                articlesListArray.removeAll()
                for i in sources {
                    let urlString = "https://newsapi.org/v1/sources?category=" + i + "&language=en"
                    self.getSources(urlString)
                }
            }
            else {
                articlesListArray = SaveArticles.savedArticles
            }
            
        }
        
    }*/

}
 
