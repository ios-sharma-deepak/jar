//
//  ComputerItem.swift
//  Assignment
//
//  Created by Kunal on 10/01/25.
//

import Foundation


// MARK: - ComputerItem
struct DeviceData: Decodable, Identifiable, Hashable, Equatable {
    static func == (lhs: DeviceData, rhs: DeviceData) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: String
    let name: String
    let data: ItemData?
}

struct ItemData: Codable{
    
    let color: String?
    let capacity: String?
    let price: Double?
    let capacityGB: Int?
    let screenSize: Double?
    let description: String?
    let generation: String?
    let strapColour: String?
    let caseSize: String?
    let cpuModel: String?
    let hardDiskSize: String?

    enum CodingKeys: String, CodingKey {
        case color
        case capacity
        case price
        case capacityGB = "capacity GB"
        case screenSize = "Screen size"
        case description = "Description"
        case generation = "Generation"
        case strapColour = "Strap Colour"
        case caseSize = "Case Size"
        case cpuModel = "CPU model"
        case hardDiskSize = "Hard disk size"
    }
}
