//
//  FavouritesViewController.swift
//  ITunes
//
//  Created by Alex Serhiiev on 10.04.2023.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var elements: [LocalModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(.init(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        elements = LocalDataService.shared.getData()
        collectionView.reloadData()
    }
    
}

extension FavouritesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(element: elements[indexPath.row], isFavourite: true, favouritePressed: {
            let element = self.elements[indexPath.row]
            LocalDataService.shared.delete(id: element.trackID)
            self.elements = LocalDataService.shared.getData()
            collectionView.reloadData()
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        newViewController.data = elements[indexPath.row]
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
}

extension FavouritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
        let offset: CGFloat = 10
        return CGSize(width: UIScreen.main.bounds.width / numberOfColumns - offset, height: 400)
    }
}
