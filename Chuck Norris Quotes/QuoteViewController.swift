//
//  QuoteViewController.swift
//  Chuck Norris Quotes
//
//  Created by Johan Park on 6/25/19.
//  Copyright © 2019 Johan Park. All rights reserved.
//

import Foundation
import UIKit

class QuoteViewController: UIViewController {
    
    @IBOutlet weak var quoteLabel: UILabel!
    
    var categoryName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //getQuote()
    }
    
    func getQuote() {
        if let category = categoryName {
            let urlString = "https://api.chucknorris.io/jokes/random?category=\(category)"
            guard let url = URL(string: urlString) else { return }

            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, error == nil {
                    if let quoteData = try? JSONDecoder().decode(ChuckNorrisInfoModel.self, from: data) {

                        DispatchQueue.main.async {
                            self.quoteLabel.text = quoteData.quote
                        }
                    }
                }
            }.resume()
        }
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        getQuote()
    }
}
