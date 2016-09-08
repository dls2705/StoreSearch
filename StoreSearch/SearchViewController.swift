//
//  ViewController.swift
//  StoreSearch
//
//  Created by Diego Legua on 8/09/16.
//  Copyright © 2016 DL.Training. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var searchResults = [SearchResult]()
    var hasSearched = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SearchViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()//
        searchResults.removeAll()
        hasSearched = true
        if searchBar.text != "Justin Bieber"{
            for i in 0...2 {
                let searchResult = SearchResult()
                searchResult.name = "Fake result \(i) for:  "
                searchResult.artistName = "'\(searchBar.text!)'"
                searchResults.append(searchResult)
            }
        }
        tableView.reloadData()
    }//Toujours connecte le delegate (ici le seachbar vers le controleur)
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .TopAttached
    }
}

extension SearchViewController:UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !hasSearched{
            return 0
        }
        else if searchResults.count == 0 {
            return 1
        }else{
            return searchResults.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchResultCell", forIndexPath: indexPath)
        if searchResults.count == 0{
            cell.textLabel!.text = "(No Result Found)"
            cell.detailTextLabel!.text = ""
            cell.selectionStyle = .None
        }else{
            let searchResult = searchResults[indexPath.row]
            cell.textLabel!.text = searchResult.name
            cell.detailTextLabel!.text = searchResult.artistName
            cell.selectionStyle = .Default
        }
        return cell
    }
}

extension SearchViewController:UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if searchResults.count == 0{
            return nil
        }else{
            return indexPath
        }
    }
}

