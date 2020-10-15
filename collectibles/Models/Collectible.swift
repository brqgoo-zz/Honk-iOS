//
//  Collectible.swift
//  collectibles
//
//  Created by Burak Keceli on 15.07.20.
//  Copyright © 2020 Burak Keceli. All rights reserved.
//

import Foundation

struct Collectible: Decodable {
    let status: String
    let message: String
    
    let result: [resultObject]
    
}

struct resultObject: Decodable {
    let tokenID:String
    let tokenName:String
    let to:String
}

