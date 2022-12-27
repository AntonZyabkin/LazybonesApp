//
//  Extensions+Encodable.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 10.11.2022.
//

import Foundation
import UIKit
extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}

extension UIColor {
    convenience init(hex: String) {
        var lockalHex = hex
        if (lockalHex.hasPrefix("#")) {
            lockalHex.remove(at: lockalHex.startIndex)
        }
        let r, g, b, a: CGFloat
        var hexNumber: UInt64 = 0
        Scanner(string: lockalHex).scanHexInt64(&hexNumber)
        if lockalHex.count == 6 {
            r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
            g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
            b = CGFloat(hexNumber & 0x0000ff) / 255
            self.init(red: r, green: g, blue: b, alpha: 1)
            return
        } else if lockalHex.count == 8 {
            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000ff) / 255
            self.init(red: r, green: g, blue: b, alpha: a)
            return
        }
        self.init(red: 0, green: 0, blue: 0, alpha: 0)
    }
}
