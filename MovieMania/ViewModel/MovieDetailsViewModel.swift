//
//  MovieDetailsViewModel.swift
//  moviePoster
//
//  Created by Invision on 07/02/2018.
//  Copyright © 2018 invision. All rights reserved.
//

import Foundation
import SwiftyJSON

//protocols to communicate between modelview and Movie controller
protocol MovieDetailsProtocol:class {
    
    func movieDetailsSuccess(hasMovies: Bool)
    func movieDetailsfailure(message: String)

    
}

class MovieDetailsViewModel: NSObject {

//movie delegate object
weak var delegate : MovieDetailsProtocol?
    
    //movies Array for getting movies from Model
    var movies:[Movie] = []
    
    //logic bool to check if server hit still in the process for movie fetching
    private var isLoadingData = false
    //currentpage property by default is 1
    private  var currentPage = 1
    
    //searchMovie method
    func searchMovies(route :String, query: String? = nil, page: Int? = nil)  {
        NetworkConfig.getMoviedetails(route: route, query: query, page: page) { (response, error) in
            
            //error check
            if error == nil {
                
            //parsing response to dictionary and mapping objects in Movie Array
          let jsonDictionary   =   JSON(response as Any).dictionaryValue
                if let results = jsonDictionary["results"]?.array, results.count > 0 {
                    
                    self.movies.append(contentsOf: results.map{ Movie(json: $0) })
                    
                    //if search successfull store the query in suggestion list
                    SearchHistory.addSuggestion(query: self.currentQuery?.replacingOccurrences(of: "%20", with: " "))
                    //calling success delegate method returning true
                      self.delegate?.movieDetailsSuccess(hasMovies: true)

                }
                //movies check
                 if self.movies.count == 0 {
                     //calling success delegate method and returning false
                    self.delegate?.movieDetailsSuccess(hasMovies: false)

                }
                
        
                }
                
        
          
            
            else {
                //if error != nil return call failure delegate passing error description
                self.delegate?.movieDetailsfailure(message: (error?.localizedDescription)!)
            }
        
        //after  request completed assign isLoadingData property false
          self.isLoadingData = false

            
        }
    }
    
    // setting previousQuery propery
    var previousQuery:String? {
        
        didSet {
            currentPage = 1
            movies.removeAll()
        }
    }
    var currentQuery : String? {
        
        didSet {
            
            if currentQuery != previousQuery {
                previousQuery = currentQuery
            }
            else {
                
                currentPage += 1
            }
              updateResults()
        }
    }
    
    
    func updateResults(){
        if isLoadingData{ return }
        if currentQuery == nil || currentQuery!.isEmpty{
            
            searchMovies(route: Routes.discoverMovies)

        }
        else{
            
            searchMovies(route: Routes.movieSearch, query: currentQuery!, page: currentPage)
        }
        self.isLoadingData = true
    }
    
    }
