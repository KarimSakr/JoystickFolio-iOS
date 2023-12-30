//
//  ExploreViewController.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 30/12/2023.
//

import UIKit

class ExploreViewController: UIViewController {
    
    //MARK: - searchController
    let searchController: UISearchController = {
       let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search..."
        return search
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        // Do any additional setup after loading the view.
    }

}

extension ExploreViewController: UISearchResultsUpdating {
    
    //MARK: - updateSearchResults
    //TODO: Find a way to search on button pressed, not on character typing
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
           print(text)
    }
}
