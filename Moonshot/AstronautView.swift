//
//  AstronautView.swift
//  Moonshot
//
//  Created by Waveline Media on 12/7/20.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    let missions: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    Text("Crew member on:")
                        .fontWeight(.bold)
                        .padding(.top)
                    ForEach(self.missions) { mission in
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 44, height: 44)
                            
                            VStack(alignment: .leading) {
                                Text(mission.displayName)
                                    .font(.headline)
                                Text(mission.formattedLaunchDate)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut) {
        let allMissions: [Mission] = Bundle.main.decode("missions.json")
        var missionMatches = [Mission]()
        for mission in allMissions {
            if mission.crew.contains(where: {$0.name == astronaut.id}) {
                missionMatches.append(mission)
            }
        }
        self.missions = missionMatches
        self.astronaut = astronaut
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
