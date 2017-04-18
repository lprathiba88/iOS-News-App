//
//  ArticleDescriptionViewController.swift
//  NewsApp
//
//  Created by Prathiba Lingappan on 3/23/17.
//  Copyright © 2017 Prathiba Lingappan. All rights reserved.
//

import UIKit

class ArticleDescriptionViewController: UIViewController {

    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var article: Article?
    
    @IBAction func buttonAction(_ sender: Any) {
        performSegue(withIdentifier: "toMainArticle", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard  let article = self.article else {
            print("No article description!")
            return
        }
        self.articleTitle.text = article.title
        self.subtitleLabel.text = article.author
        self.articleImage.image = article.image
        self.descriptionLabel.text = article.body
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destination = segue.destination as? ArticleViewController else {
            print("No Segue To Full Article")
            return
            
        }
        destination.article = article
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
