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
    var colorGenerate = GenerateRandomColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        title = "Categories"
        
    }
}

extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Category Cell", for: indexPath) as! CategoriesCollectionViewCell
        cell.layer.cornerRadius = 20
        cell.categoryLabel.text = categories[indexPath.item]
        cell.backgroundColor = colorGenerate.generateRandomColor()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.item].lowercased()
        if let destVC = storyboard?.instantiateViewController(withIdentifier: "QuoteViewController") as? QuoteViewController {
            destVC.categoryName = category
            navigationController?.pushViewController(destVC, animated: true)
        }
    }
}

