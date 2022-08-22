//
//  Order.swift
//  Cupcake Corner
//
//  Created by Alpay Calalli on 15.08.22.
//

import SwiftUI

class Order: ObservableObject, Codable{
    
    enum CodingKeys: CodingKey{
        case type, quantity, extraFrosting, addSprinkles, name, streetAdress, city, zip
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequest = false{
        didSet{
            if specialRequest == false{
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAdress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAdress: Bool{
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAdress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            return false
        }
        return true
    }
    
    var cost: Double{
        // $2 per cake
        var cost = Double(quantity) * 2
        
        cost += (Double(type) / 2)
        
        // $1 per cake for extra frosting
        if extraFrosting{
            cost += Double(quantity)
        }
        
        // $0.50 per cake for sprinkles
        if addSprinkles{
            cost += (Double(quantity) / 2)
        }
        
        return cost
    }
    
    init(){ }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        
        try container.encode(name, forKey: .name)
        try container.encode(streetAdress, forKey: .streetAdress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }

    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        
        name = try container.decode(String.self, forKey: .name)
        streetAdress = try container.decode(String.self, forKey: .streetAdress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
}
