//
//  StringSubscript.swift
//  MDG Nienburg
//
//  Created by Yannik Ehlert on 21.03.16.
//  Copyright © 2016 Yannik Ehlert. All rights reserved.
//

import Foundation

extension String {
    subscript (i: Int) -> Character {
        return self[self.characters.index(self.startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: CountableClosedRange<Int>) -> String {
        return substring(with: characters.index(startIndex, offsetBy: r.lowerBound)..<characters.index(startIndex, offsetBy: r.upperBound))
    }
}
