//
//  ContentView.swift
//  Moonshot
//
//  Created by Waveline Media on 12/7/20.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var changeDetails = false
    @State private var missionCrew = [Int: [Astronaut]]()
    
    var body: some View {
        NavigationView {
            List(missions) {mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44)
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        self.getDetailView(currentMission: mission)
                    }
                }
            }
            .navigationTitle("Moonshot")
            .navigationBarItems(trailing:
                HStack {
                    Button(action: {
                        self.changeDetails.toggle()
                    }, label: {
                        Text(changeDetails ? "Launch Date" : "Crew Members")
                    })
                }
            )
        }
    }
    
    func getDetailView(currentMission: Mission) -> some View {
        
        if missionCrew[currentMission.id] == nil {
            var matches = [Astronaut]()
            for member in currentMission.crew {
                if let match = astronauts.first(where: {$0.id == member.name}) {
                    matches.append(match)
                } else {
                    fatalError("Missing \(member)")
                }
            }
            missionCrew[currentMission.id] = matches
        }
        
        if changeDetails {
            var astronautStr = ""
            
            if let astronauts = missionCrew[currentMission.id] {
                for (i, crewMember) in astronauts.enumerated() {
                    if i < astronauts.count - 1 {
                        astronautStr.append("\(crewMember.name), ")
                    } else {
                        astronautStr.append("\(crewMember.name)")
                    }
                }
            }
            
            return Text(astronautStr)
        } else {
            return Text(currentMission.formattedLaunchDate)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
