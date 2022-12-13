//
//  String+leftPadding.swift
//  Noriba
//
//  Created by a on 12/14/22.
//

extension String {
    func leftPadding(toLength: Int, withPad: String) -> String {
        let stringLength = self.count
        if stringLength < toLength {
            return String(repeating:withPad, count: toLength - stringLength) + self
        } else {
            return String(self.suffix(toLength))
        }
    }
}
