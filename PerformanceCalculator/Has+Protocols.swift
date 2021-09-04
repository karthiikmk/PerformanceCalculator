//
//  Has+Protocols.swift
//  PerformanceCalculator
//
//  Created by Karthik on 05/09/21.
//

import Foundation

struct APIArrayResponse<Item: Decodable>: Decodable {
    let items: [Item]

    enum CodingKeys: String, CodingKey {
        case items = "data"
    }
}

protocol HasDefault {
    static var `default`: Self { get }
}

extension Int: HasDefault {
    static var `default`: Int { 0 }
}

protocol CanBeString {
    func asString() -> String
    static func fromString(_ string: String?) -> Self?
}

extension Int: CanBeString {
    func asString() -> String { "\(self)" }
    static func fromString(_ string: String?) -> Self? {
        guard let unwrapped = string else { return nil }
        return Int(unwrapped)
    }
}

struct DecodableType {
    @propertyWrapper
    struct String<Value> {
        var wrappedValue: Value
    }
}

extension DecodableType.String: Decodable where Value: CanBeString & HasDefault {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try? container.decode(String.self)
        let casted = Value.fromString(rawValue) ?? .default
        wrappedValue = casted
    }
}
