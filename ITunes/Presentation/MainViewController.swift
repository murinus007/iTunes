//
//  MainViewController.swift
//  ITunes
//
//  Created by Alex Serhiiev on 10.04.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    var elements: [LocalModel] = []
    var favourites = LocalDataService.shared.getData()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ApiService.shared.search(text: searchBar.text ?? "") { result in
            self.elements = result.results.map({ result in
                LocalModel.init(element: result)
            })
            self.collectionView.reloadData()
        }
        
        // collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favourites = LocalDataService.shared.getData()
    }
    
    private func configure() {
        collectionView.register(.init(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        
        let isFavourite: Bool = favourites.contains { model in
            elements[indexPath.row].trackID == model.trackID
        }
        
        cell.configure(element: elements[indexPath.row], isFavourite: isFavourite, favouritePressed: {
            let element = self.elements[indexPath.row]
            if LocalDataService.shared.objectExist(id: element.trackID) {
                LocalDataService.shared.delete(id: element.trackID)
            } else {
                LocalDataService.shared.save(data: element)
            }
            self.favourites = LocalDataService.shared.getData()
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

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2 - 10, height: 400)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
        } else {
            ApiService.shared.search(text: searchText) { result in
                self.elements = result.results.map({ result in
                    LocalModel.init(element: result)
                })
                self.collectionView.reloadData()
            }
        }
    }
}
