//
//  GalleryCell.swift
//  MyPaintApp
//
//  Created by MacBook  on 01.07.21.
//

import UIKit

class GalleryCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with image: UIImage) {
        self.imageView.image = image
        
    }
}
