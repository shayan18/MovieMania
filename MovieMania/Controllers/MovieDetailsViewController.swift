//
//  ViewController.swift
//  moviePoster
//
//  Created by Invision on 07/02/2018.
//  Copyright © 2018 invision. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    
    //MARK: IBOutlets
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var suggestionTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    
    //MARK: Properties
    let reuseIdentifier = "movieCell"
    let movieViewModel = MovieDetailsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //server hit to get movieslist
        startSpinner(spinner: spinnerView)
        movieViewModel.updateMoviesList()
        
        movieViewModel.delegate = self
        searchBar.delegate = self
       
    }
    
    func viewSuggestion(){
        suggestionTableView.isHidden = !suggestionTableView.isHidden
    }
    


}


extension MovieDetailsViewController : MovieDetailsProtocol {
    
    
    
    //success delegate method to update movies tableView
    func movieDetailsSuccess(hasMovies: Bool) {
        
        stopSpinner(spinner: spinnerView)
        //hasMovies bool true reload movies tableView
        if hasMovies {
            moviesTableView.reloadData()
            
            
        }
            //show error alert
        else {
            self.showAlert(title: "Search Failed", message: "Searched movie not available")
            
            
        }
        
    }
    //failure delegate method to show error
    func movieDetailsfailure(message: String) {
        
        stopSpinner(spinner: spinnerView)
        self.showAlert(title: "Error", message: message)
    }
    
    
}


//MARK: TableView Delegate Methods
extension MovieDetailsViewController: UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //condition for which tableview and model data counts to return
        if tableView == suggestionTableView {
            
            return SearchHistory.suggestions.count
        }
        
        return movieViewModel.movies.count

    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if tableView == moviesTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MovieDetailsTableViewCell
            
            //index bound exception handling 
            if movieViewModel.movies.count > 0 {
                //populating MovieTableView with movieViewModel Movies Array
                cell.movie = movieViewModel.movies[indexPath.row]

            }
            return cell
            
        }
        
        //suggestion tableview and populating suggestions
        let cell = UITableViewCell()
        cell.textLabel?.text = SearchHistory.suggestions[indexPath.row]
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == suggestionTableView{
            guard let cell = tableView.cellForRow(at: indexPath) else {return}
            searchBar.text = cell.textLabel?.text
         
           
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == movieViewModel.movies.count-1 {
            //updating current query
            movieViewModel.currentQuery = searchBar.text
            
        }
    }
    
}

//MARK: Searchbar Delegate
extension MovieDetailsViewController: UISearchBarDelegate {
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //replacing whitespaces with %20 so that search query can include spaces without getting invalid url string error
        startSpinner(spinner: spinnerView)
        movieViewModel.currentQuery = searchBar.text
        
      

        searchBar.endEditing(true)
        viewSuggestion()
        
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //reload suggestion tableview
        suggestionTableView.reloadData()
        viewSuggestion()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        viewSuggestion()
        searchBar.endEditing(true)
    }
    
}

