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
    
    //MARK: - init UIColor with Hex color code (use 6 or 8 numbers, depend of alpha)
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
    
    //MARK: - Some custon colors for this app

    static let myPurpleLight = UIColor(hex: "d8c6f5")
    static let myPurple = UIColor(hex: "#a67ae9")
    static let myPurpleBold = UIColor(hex: "733bc9")

    static let myGreenText = UIColor(hex: "#267365")
    static let myRedText = UIColor(hex: "#F23030")
    static let myOrangeText = UIColor(hex: "#F29F05")
    static let myBlueText = UIColor(hex: "#01109B")

    static let myGray = UIColor(hex: "757575")
    static let myBackgroundGray = UIColor(hex: "F2F2F2")

    static let myBackgroundPurpleLight = UIColor(hex: "f2ecfb")
}

extension UIFont {
    static func tochkaLightArial(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "NotoSansMyanmar-Light", size: size) else { return UIFont() }
        return font
    }
    static func tochkaBoldArial(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "NotoSansMyanmar-Bold", size: size) else { return UIFont() }
        return font
    }
    static func mainHelvetica(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Helvetica", size: size) else { return UIFont() }
        return font
    }
    static func mainLightHelvetica(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Helvetica-Light", size: size) else { return UIFont() }
        return font
    }
//    static func mainBoldHelvetica(size: CGFloat) -> UIFont {
//        guard let font = UIFont(name: "Helvetica-Bold", size: size) else { return UIFont() }
//        return font
//    }
    static func mainBoldHelvetica(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "TimesNewRomanPS-BoldMT", size: size) else { return UIFont() }
        return font
    }
}

