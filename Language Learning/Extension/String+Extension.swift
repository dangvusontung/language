//
//  String+Extension.swift
//  Language Learning
//
//  Created by TungDVS on 04/12/2023.
//

import Foundation

extension String: LocalizedError {
    public var errorDescription: String? {
        return self
    }
}
