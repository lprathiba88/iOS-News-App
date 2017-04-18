//
//  FilterManager.swift
//  NewsApp
//
//  Created by Prathiba Lingappan on 3/22/17.
//  Copyright © 2017 Prathiba Lingappan. All rights reserved.
//

import Foundation

protocol SourcesDelegate {
    //func filteredSourcesUpdated(_ sources: [String], _ searchString: String?)
    func filteredSourcesUpdated(_ sources: [String])
}

class SourcesManager {
    static let shared = SourcesManager()
    
    //var searchString: String?
    var filteredSourcesArray: [String] = []
    var delegate: SourcesDelegate?
    
    /*func setSearchString(_ string: String) {
        searchString = string
    }*/
    
    func add(_ source: String) {
        filteredSourcesArray.append(source)
    }
    
    func remove(_ source: String) {
        //print("filteredSourcesArray: \(filteredSourcesArray)")
        for i in 0..<filteredSourcesArray.count {
            if source == filteredSourcesArray[i] {
                filteredSourcesArray.remove(at: i)
                //print("filteredSourcesArray: \(filteredSourcesArray.count)")
                break
            }
        }
    }
    
    func callDelegate() {
        //delegate?.filteredSourcesUpdated(filteredSourcesArray, searchString)
        delegate?.filteredSourcesUpdated(filteredSourcesArray)
    }
 
 }
