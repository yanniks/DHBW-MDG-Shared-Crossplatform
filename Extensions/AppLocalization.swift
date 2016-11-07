//
//  MDGLocalization.swift
//  MDG Nienburg
//
//  Created by Yannik Ehlert on 21.03.16.
//  Copyright © 2016 Yannik Ehlert. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
