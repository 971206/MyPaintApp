//
//  GalleryViewController.swift
//  MyPaintApp
//
//  Created by MacBook  on 01.07.21.
//

import UIKit

class GalleryViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var dataSource: GalleryDataSource!
    let fileManager = FileManager.default
    private var documentsDirectoryURL: URL? {
        try? fileManager.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: false)
    }
    private var urls: [URL]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = GalleryDataSource(with: collectionView)
        collectionView.registerNib(class: GalleryCell.self)
        read()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        dataSource.paintingsList.removeAll()
        read()
    }
    
    @IBAction func onCreateNew(_ sender: Any) {
        coordinator?.proceedToPaint()
    }
    
    func read() {
        guard let imageURLs = try? fileManager.contentsOfDirectory(at: documentsDirectoryURL!,
                                                                   includingPropertiesForKeys: nil,
                                                                   options: [.skipsHiddenFiles])  else {return}
        self.urls = imageURLs
        
        guard let dir = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else {return}
        imageURLs.forEach { (path) in
            let fileName = path.pathComponents.last
            guard let image =  UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(fileName ?? "").path) else {return}
            dataSource.paintingsList.append(image)
        }
        collectionView.reloadData()
    }
}






