//
//  Result.swift
//  Pets Info
//
//  Created by Yurii on 13.12.2022.
//

import Foundation

enum Result<Value, Error> {
  case success(Value)
  case failure(Error)

  var value: Value? {
    switch self {
    case .success(let value):
      return value
    default:
      return nil
    }
  }

  var error: Error? {
    switch self {
    case .failure(let error):
      return error
    default:
      return nil
    }
  }
}
