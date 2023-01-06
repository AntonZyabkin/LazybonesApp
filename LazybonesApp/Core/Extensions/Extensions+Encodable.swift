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
    static let tochkaPurpleBackground = UIColor(hex: "E6DBFD")
    static let tochkaIncome = UIColor(hex: "28B400")
    static let tochkaExpense = UIColor(hex: "EE1415")
    static let tochkaPurpleAccent = UIColor(hex: "8042E0")
    static let tochkaGreenAccent = UIColor(hex: "8AC7AA")
    static let chartPink = UIColor(hex: "FF7790")
    static let chartOrange = UIColor(hex: "FFBE70")
    static let chartGreen = UIColor(hex: "19F3E5")
    static let chartPurple = UIColor(hex: "7A25F8")
    static let myGray = UIColor(hex: "fafafa")
    static let textGreen = UIColor(hex: "1b8366")
    static let textBlue = UIColor(hex: "334079")
    static let textRed = UIColor(hex: "BD3D3A")
}

extension UIFont {
    static func tochkaLightArial(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "NotoSansMyanmar-Light", size: size) else { return UIFont() }
        return font
    }
//    ArialHebrew-Light
    static func tochkaBoldArial(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "NotoSansMyanmar-Bold", size: size) else { return UIFont() }
        return font
    }
//    ArialHebrew-Bold
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

