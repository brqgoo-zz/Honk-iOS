//
//  CryptoKitty.swift
//  collectibles
//
//  Created by Burak Keceli on 17.07.20.
//  Copyright © 2020 Burak Keceli. All rights reserved.
//

import Foundation

struct CryptoKitty: Decodable {
    let kitties: [kitties]
    
}

struct kitties: Decodable {
    let image_url_png:String
}
