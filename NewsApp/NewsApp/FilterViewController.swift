//
//  FilterViewController.swift
//  NewsApp
//
//  Created by Prathiba Lingappan on 3/22/17.
//  Copyright © 2017 Prathiba Lingappan. All rights reserved.
//

import UIKit

class FilterViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var subscribeButton: UIButton!
    @IBOutlet weak var technologySwitch: UISwitch!
    @IBOutlet weak var sportSwitch: UISwitch!
    @IBOutlet weak var businessSwitch: UISwitch!
    @IBOutlet weak var scienceSwitch: UISwitch!
    @IBOutlet weak var entertainmentSwitch: UISwitch!
    @IBOutlet weak var musicSwitch: UISwitch!
    //@IBOutlet weak var searchTextField: UITextField!

    
    @IBAction func subscribeOnClick(_ sender: Any) {
        
        let alertController = UIAlertController(title: "HELLO!", message: "To subscribe, please go to our website: www.newsroom.com", preferredStyle: UIAlertControllerStyle.alert)
        
        let centerAction = UIAlertAction(title: "Got it!", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController.addAction(centerAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.searchTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        //guard let searchString = textField.text else {return false}
        //SourcesManager.shared.setSearchString(searchString)
        
        return false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SourcesManager.shared.callDelegate()
    }
    
    @IBAction func technologyStateChanged(_ sender: UISwitch) {
        print("In switch 1")
        if sender.isOn {
            print("In switch 1---if")
            SourcesManager.shared.add("technology")
            //SourcesManager.shared.filteredSourcesArray.append("technology")
        }
        else{
            SourcesManager.shared.remove("technology")
        }
    }

    @IBAction func sportStateChanged(_ sender: UISwitch) {
        print("In switch 2")
        if sender.isOn {
            print("In switch 2---if")
            SourcesManager.shared.add("sport")
            //SourcesManager.shared.filteredSourcesArray.append("sport")
        }
        else{
            SourcesManager.shared.remove("sport")
        }
    }

    @IBAction func businessStateChanged(_ switchState: UISwitch) {
        print("In switch 3")
        if switchState.isOn {
            print("In switch 3---if")
            SourcesManager.shared.filteredSourcesArray.append("business")
        }
        else{
            SourcesManager.shared.remove("business")
        }
    }
    
    @IBAction func musicStateChanged(_ switchState: UISwitch) {
        if switchState.isOn {
            SourcesManager.shared.filteredSourcesArray.append("music")
        }
        else{
            SourcesManager.shared.remove("music")
        }
    }
    
    @IBAction func entertainmentStateChanged(_ switchState: UISwitch) {
        if switchState.isOn {
            SourcesManager.shared.filteredSourcesArray.append("entertainment")
        }
        else{
            SourcesManager.shared.remove("entertainment")
        }
    }
    
    @IBAction func scienceStateChanged(_ switchState: UISwitch) {
        if switchState.isOn {
            SourcesManager.shared.filteredSourcesArray.append("science-and-nature")
        }
        else{
            SourcesManager.shared.remove("science-and-nature")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
