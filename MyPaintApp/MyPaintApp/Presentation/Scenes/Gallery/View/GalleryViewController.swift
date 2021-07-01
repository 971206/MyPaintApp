//
//  GalleryViewController.swift
//  MyPaintApp
//
//  Created by MacBook  on 01.07.21.
//

import UIKit

class GalleryViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func onCreateNew(_ sender: Any) {
        coordinator?.proceedToPaint()
    }
    
}
