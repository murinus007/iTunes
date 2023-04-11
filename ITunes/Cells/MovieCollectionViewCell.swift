//
//  MovieCollectionViewCell.swift
//  Movie
//
//  Created by Alex Serhiiev on 13.03.2023.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var ganreLabel: UILabel!
    
    @IBOutlet weak var favouriteButton: UIButton!
    
    var favouritePressed: (() -> ())?
    
    var isFavourite = false
    
    override func prepareForReuse() {
        super.prepareForReuse()
        favouriteButton.setImage(.init(systemName: "heart"), for: .normal)
    }

    @IBAction func favouritePressed(_ sender: Any) {
        favouritePressed?()
        if isFavourite {
            favouriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            self.isFavourite = false
        } else {
            favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            self.isFavourite = true
        }
        
    }
    
    
    func configure(element: LocalModel, isFavourite: Bool, favouritePressed: @escaping () -> ()) {
        self.isFavourite = isFavourite
        self.favouritePressed = favouritePressed
        imageView.sd_setImage(with: .init(string: element.artworkUrl100)!)
        
        nameLabel.text = element.trackName
        
        let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "MM/dd/yyyy"
        let string = dateFormatter.string(from: element.releaseDate)

        
        dateLabel.text = string
        
        ganreLabel.text = element.primaryGenreName
        
        if isFavourite {
            favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
    
}


