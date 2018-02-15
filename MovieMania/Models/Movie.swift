//
//  Results.swift
//
//  Created by Invision on 12/02/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public struct Movie {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let posterPath = "poster_path"
    static let backdropPath = "backdrop_path"
    static let genreIds = "genre_ids"
    static let voteCount = "vote_count"
    static let overview = "overview"
    static let originalTitle = "original_title"
    static let popularity = "popularity"
    static let releaseDate = "release_date"
    static let id = "id"
    static let video = "video"
    static let originalLanguage = "original_language"
    static let voteAverage = "vote_average"
    static let title = "title"
    static let adult = "adult"
  }

  // MARK: Properties
  public var posterPath: String?
  public var backdropPath: String?
  public var genreIds: [Int]?
  public var voteCount: Int?
  public var overview: String?
  public var originalTitle: String?
  public var popularity: Float?
  public var releaseDate: String?
  public var id: Int?
  public var video: Bool? = false
  public var originalLanguage: String?
  public var voteAverage: Float?
  public var title: String?
  public var adult: Bool? = false

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public  init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public  init(json: JSON) {
    posterPath = json[SerializationKeys.posterPath].string
    backdropPath = json[SerializationKeys.backdropPath].string
    if let items = json[SerializationKeys.genreIds].array { genreIds = items.map { $0.intValue } }
    voteCount = json[SerializationKeys.voteCount].int
    overview = json[SerializationKeys.overview].string
    originalTitle = json[SerializationKeys.originalTitle].string
    popularity = json[SerializationKeys.popularity].float
    releaseDate = json[SerializationKeys.releaseDate].string
    id = json[SerializationKeys.id].int
    video = json[SerializationKeys.video].boolValue
    originalLanguage = json[SerializationKeys.originalLanguage].string
    voteAverage = json[SerializationKeys.voteAverage].float
    title = json[SerializationKeys.title].string
    adult = json[SerializationKeys.adult].boolValue
  }

  
}

extension Movie{
    
    
    
     //property returns  url to get movie image poster
    
    
    var posterUrl:URL?{
        if posterPath == nil {return nil}
        return URL(string: "\(Routes.imageUrl)\(posterPath!)")
}

}
