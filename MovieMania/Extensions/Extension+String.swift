//
//  Extension+String.swift
//  MovieMania
//
//  Created by Invision on 14/02/2018.
//  Copyright © 2018 invision. All rights reserved.
//

import Foundation

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
