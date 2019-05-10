//
//  ViewController.swift
//  SurfTestProjectKostrub
//
//  Created by xcode on 07.05.2019.
//  Copyright © 2019 vsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating{

    @IBOutlet weak var EmptyLabel: UILabel!
    var searchResult: [[String:Any]] = []
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        loadData()
        if WordList.count != 0 {
            EmptyLabel.text = ""
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if WordList.count != 0 {
            EmptyLabel.text = ""
        }
        tableView.reloadData()
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if searchController.isActive{
            return searchResult.count
        }else{
            return WordList.count
        }
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let currentItem = (searchController.isActive) ? searchResult[indexPath.row]: WordList[indexPath.row]
        cell.textLabel?.text = currentItem["Str"] as! String
        return cell
        
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        if searchController.isActive{
            return false
        }
        else{
            return true
        }
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete {
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            if WordList.count == 0
            {
                EmptyLabel.text = "Словарь пуст"
            }
        }else if editingStyle == .insert {
        }
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentItem = (searchController.isActive) ? searchResult[indexPath.row]: WordList[indexPath.row]
        
        let translateMenu = UIAlertController(title: "Перевод", message: currentItem["TranslateStr"] as! String, preferredStyle: .actionSheet)
        let canselAction = UIAlertAction(title: "Назад" , style: .cancel
           , handler:  nil)
        
        translateMenu.addAction(canselAction)
        
        self.present(translateMenu, animated: true, completion: nil)
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            filterContent(searchText: searchText)
            tableView.reloadData()
        }
    }
    
    func filterContent(searchText:String){
        searchResult = WordList.filter({(word: [String:Any]) -> Bool in
            let strFromWord:String?
            let strFromWordTranslated:String?
            
            strFromWord = word["Str"] as! String
            strFromWordTranslated = word["TranslateStr"] as! String
            
            
            let strMatch = strFromWord?.range(of: searchText, options:String.CompareOptions.caseInsensitive)
            
            let translateMatch = strFromWordTranslated?.range(of: searchText, options:String.CompareOptions.caseInsensitive)
            
            return strMatch != nil || translateMatch != nil

        })
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

