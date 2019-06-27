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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = generateRandomColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    @objc func shareTapped() {
        let activity = UIActivityViewController(activityItems: [], applicationActivities: [])
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
                sender.stopAnimation(animationStyle: .normal, revertAfterDelay: 0, completion: nil)
                self.view.backgroundColor = self.generateRandomColor()
            })
        })
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
    
    func generateRandomColor() -> UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
}
