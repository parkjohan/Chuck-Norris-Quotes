//
//  QuoteViewController.swift
//  Chuck Norris Quotes
//
//  Created by Johan Park on 6/25/19.
//  Copyright © 2019 Johan Park. All rights reserved.
//

import Foundation
import UIKit
import TransitionButton

class QuoteViewController: UIViewController {
    
    @IBOutlet weak var quoteLabel: UILabel!
    
    var categoryName: String?
    
    var colorGenerate = GenerateRandomColor()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = colorGenerate.generateRandomColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    @objc func shareTapped() {
        let quoteToShare = "Chuck Norris quotes"
        let activity = UIActivityViewController(activityItems: [quoteToShare], applicationActivities: [])
        activity.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(activity, animated: true)
    }
    
    @IBAction func nextPressed(_ sender: TransitionButton) {
        sender.startAnimation()
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            self.getQuote()
            DispatchQueue.main.async(execute: { () -> Void in
                sender.stopAnimation(animationStyle: .normal, revertAfterDelay: 0.5, completion: nil)
                self.view.backgroundColor = self.colorGenerate.generateRandomColor()
            })
        })
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
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
}
