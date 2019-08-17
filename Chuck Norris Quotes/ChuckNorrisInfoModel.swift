//
//  ChuckNorrisInfoModel.swift
//  Chuck Norris Quotes
//
//  Created by Johan Park on 6/25/19.
//  Copyright © 2019 Johan Park. All rights reserved.
//

import Foundation

struct ChuckNorrisInfoModel: Codable {
    
    let quote: String
    
    private enum CodingKeys: String, CodingKey {
        case quote = "value"
    }
}
