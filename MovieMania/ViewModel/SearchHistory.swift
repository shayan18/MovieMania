//
//  SearchHistory.swift
//  MovieMania
//
//  Created by Shayan on 13/02/2018.
//  Copyright © 2018 shayan. All rights reserved.
//

import Foundation


class SearchHistory {
    
    static private let suggestionsKey = "suggestions"
    
    
    /*
    variable returns suggestions based on previous history
     get suggestions from UserDefaults
     returns: array of string.
     */

    
    static var suggestions: [String] {
        guard let suggestions = UserDefaults.standard.array(forKey: suggestionsKey) as? [String] else {
            return []
        }
        return suggestions
    }
    
    /*
     Adds the query in suggestions
     Adds a query if doesn't exist. Limits the suggestion to 10 items.
     parameter query: Query to save in suggestions.
     */
    static func addSuggestion(query:String?) {
        var _suggestions = suggestions
        guard let query = query, !query.isEmpty, !_suggestions.contains(query) else {return}
        if _suggestions.count == 10 {
            _suggestions.removeLast()
        }
        _suggestions.insert(query, at: 0)
        UserDefaults.standard.setValue(_suggestions, forKey: suggestionsKey)
    }
}
