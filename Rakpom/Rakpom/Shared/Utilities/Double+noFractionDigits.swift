//
//  Double+noFractionDigits.swift
//  Rakpom
//
//  Created by yossa on 26/11/2567 BE.
//

import Foundation

extension Double {

  // MARK: Public
  
  public var noFractionDigits: String {
    let number = NSNumber(floatLiteral: self)
    let string = Double.noFractionFormatter.string(from: number)
    assert(string != nil, "Formatted string must not be nil.")
    return string!
  }

  // MARK: Private
  
  private static let noFractionFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 0
    formatter.locale = Locale(identifier: "th-TH")
    formatter.roundingMode = .halfUp
    formatter.numberStyle = .decimal
    return formatter
  }()
}
