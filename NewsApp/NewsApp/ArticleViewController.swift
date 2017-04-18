//
//  ArticleViewController.swift
//  NewsApp
//
//  Created by Prathiba Lingappan on 3/21/17.
//  Copyright © 2017 Prathiba Lingappan. All rights reserved.
//

import UIKit

//class ArticleViewController: UIViewController {
//
//    @IBOutlet weak var facebookButton: UIButton!
//    @IBOutlet weak var contentTextView: UITextView!
//    @IBOutlet weak var articleImage: UIImageView!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var subtitleLabel: UILabel!
//    
//    var article: Article?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        guard let article = self.article else {return}
//        titleLabel.text = article.title
//        subtitleLabel.text = article.author
//        articleImage.image = article.image
//        contentTextView.text = article.body
//        print("article content: \(contentTextView.text)")
//        
//    }
//
//    @IBAction func onClickButton(_ sender: Any) {
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//
//}


class ArticleViewController: UIViewController, UIWebViewDelegate {
    
    
    
    //@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: UIWebView!
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let newArticle = self.article else {return}
        let urlString = newArticle.articleUrl
        guard let url = URL(string: urlString) else {return}
        let request = URLRequest(url: url)
        //activityIndicator.isHidden = false
        //activityIndicator.startAnimating()

        webView.loadRequest(request)
        
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
       // activityIndicator.stopAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
