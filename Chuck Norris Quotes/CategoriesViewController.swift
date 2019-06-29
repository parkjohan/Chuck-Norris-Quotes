//
//  ViewController.swift
//  Chuck Norris Quotes
//
//  Created by Johan Park on 6/25/19.
//  Copyright © 2019 Johan Park. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {

    var categories = ["Animal","Career","Celebrity","Dev","Explicit","Fashion","Food","History","Money","Movie","Music","Political","Religion","Science","Sport","Travel"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Categories"
    }
}

extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Category Cell", for: indexPath) as! CategoriesCollectionViewCell
        cell.layer.cornerRadius = 10
        cell.categoryLabel.text = categories[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.item].lowercased()
        let destVC = storyboard?.instantiateViewController(withIdentifier: "QuoteViewController") as! QuoteViewController
        destVC.categoryName = category
        
        let urlString = "https://api.chucknorris.io/jokes/random?category=\(category)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                if let quoteData = try? JSONDecoder().decode(ChuckNorrisInfoModel.self, from: data) {
                    
                    DispatchQueue.main.async {
                        destVC.quoteLabel.text = quoteData.quote
                    }
                }
            }
        }.resume()
    
        navigationController?.pushViewController(destVC, animated: true)
    }
}

