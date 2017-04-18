//
//  Article.swift
//  NewsApp
//
//  Created by Prathiba Lingappan on 3/20/17.
//  Copyright © 2017 Prathiba Lingappan. All rights reserved.
//

import Foundation
import UIKit

class Article {
    
    let title: String
    let author: String
    let body: String
    let articleUrl: String
    let imageUrl: String
    var image: UIImage?
    
    init(_ title: String, _ author: String, _ body: String, _ imageUrl: String, _ articleUrl: String ) {
        self.title = title
        self.author = author
        self.body = body
        self.imageUrl = imageUrl
        self.articleUrl = articleUrl
    }
    
    func downloadImage(_ completion: @escaping(UIImage) -> Void) {
        
        guard let url = URL(string: self.imageUrl) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data else {
                print("first guard- else")
                return
            }
            guard let image = UIImage(data: data) else {
                print("second - guard - else")
                return
            }
            completion(image)
        }
        task.resume()

    }
    
    static func getAtricleDetails(_ articleDictionary: [String: Any]) -> Article? {
        
        guard let title = articleDictionary["title"] as? String else {return nil}
        guard let author = articleDictionary["author"] as? String else {return nil}
        guard let body = articleDictionary["description"] as? String else {return nil}
        guard let articleUrl = articleDictionary["url"] as? String else {return nil}
        guard let imageUrl = articleDictionary["urlToImage"] as? String else {
            print("image url guard - else")
            return nil
        }
        
        return Article(title, author, body, imageUrl, articleUrl)
    }
}
