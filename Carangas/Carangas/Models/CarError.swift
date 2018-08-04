//
//  CarError.swift
//  Carangas
//
//  Created by Aluno on 03/08/18.
//  Copyright © 2018 Eric Brito. All rights reserved.
//

import Foundation

enum CarError {
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
}
