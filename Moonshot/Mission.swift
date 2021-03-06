//
//  Mission.swift
//  Moonshot
//
//  Created by Waveline Media on 12/7/20.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            return dateFormatter.string(from: launchDate)
        }
        return "NA"
    }
    
}
