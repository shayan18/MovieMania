//
//  MovieDetailsTableViewCell.swift
//  moviePoster
//
//  Created by Invision on 07/02/2018.
//  Copyright © 2018 invision. All rights reserved.
//

import UIKit
import SDWebImage
class MovieDetailsTableViewCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // populates the cell with movies
    var movie:Movie? {
    didSet {
    movieNameLabel.text = movie?.title
    releaseDateLabel.text = movie?.releaseDate
    overViewLabel.text = movie?.overview
    posterImageView.sd_setImage(with: movie?.posterUrl, completed: nil)
    }
    
    }
  

}
