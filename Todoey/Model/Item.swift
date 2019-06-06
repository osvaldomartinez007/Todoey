//
//  Item.swift
//  Todoey
//
//  Created by OSVALDO MARTINEZ on 6/3/19.
//  Copyright © 2019 OSVALDO MARTINEZ. All rights reserved.
//

import Foundation

class Item: Codable {
    // be able to be encodable to a plist or JSON, but has to have standard properties and not things like custom variables or objects within (arrays and dictionaries ok as well)
    var itemName: String = ""
    var checked: Bool = false
    
    
}
