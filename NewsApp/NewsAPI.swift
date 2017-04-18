//
//  NewsAPI.swift
//  NewsApp
//
//  Created by Prathiba Lingappan on 3/20/17.
//  Copyright © 2017 Prathiba Lingappan. All rights reserved.
//

import Foundation
import UIKit

class NewsAPI {
    
    func getJSONForSource(_ urlString: String, _ completion: @escaping([String]?) -> Void) {
        
        if let url = URL(string: urlString) {
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard error == nil, let data = data else {return}
                
                do {
                    guard let newsData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                        print("data - guard - else")
                        return
                    }
                    
                    guard let sourcesArray = newsData["sources"] as? [[String: Any]] else {
                        print("sources array - guard - else")
                        return
                    }
                    //print("articles array size: \(articlesArray.count) ")
                    
                    var newSourcesArray: [String] = []
                    //var count = 0
                    
                    for i in sourcesArray {
                       // if count%2 == 0 {
                            guard let sourceId = i["id"] as? String else {
                                print("for loop - guard - else")
                                return
                            }
                            //print("source ID: \(sourceId)")
                            newSourcesArray.append(sourceId)
                        //}
                        //count += 1
                    }
                    completion(newSourcesArray)
                    
                }catch {
                    print("in getJSONForSource catch: \(error)")
                }
                
            }
            task.resume()
            
        }
        else {
            print("Problem with api source url")
        }
        
    }
    
    func getJSONForArticle(_ source: String, _ completion: @escaping([Article]?) -> Void) {
        
        let urlStringforArticle = "https://newsapi.org/v1/articles?source=" + source + "&apiKey=1fc7daeea6be45e38c6f8f2bedc1e463"
        
        if let url = URL(string: urlStringforArticle) {
           
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard error == nil, let data = data else {
                    print("got error for \(url)")
                    return
                }
               
                do {
                    guard let newsData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                            print("data - guard - else")
                            return
                        }
                    
                    guard let articlesArray = newsData["articles"] as? [[String: Any]] else {
                        print("articles array - guard - else")
                        return
                    }
                    //print("articles array size: \(articlesArray.count) for source \(source) ")
                    
                    var newArticlesArray: [Article] = []
                    
                    for i in articlesArray {
                        guard let newArticle = Article.getAtricleDetails(i) else {
                            //print("for loop - guard - else")
                            continue
                        }
                        //print("new article: \(newArticle.title)")
                        newArticlesArray.append(newArticle)
                        
                    }
                    //print("newArticlesArray count: \(newArticlesArray.count) for source \(source)")
                    completion(newArticlesArray)
                    
                }catch {
                    print("in getJSON catch: \(error)")
                }
                
            }
            task.resume()
            
        }else {
            print("Problem with api article url")
        }
    }
    
}
