//
//  ContentView.swift
//  TermimapProto
//
//  Created by Adam Mason on 10/30/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTerminal: String? = nil
    let terminals = ["PIT", "MYR", "SCE", "LAX"]

    var body: some View {
        NavigationView {
            VStack {
                
                Text("AirGuide")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 10) // Adds spacing from the top of the screen
                    .padding(.bottom, 10)
                
                Text("Select Terminal")
                    .font(.headline)
                    .padding(.bottom, 5)
                
                Picker("Select Terminal", selection: Binding(
                    get: { selectedTerminal ?? terminals.first! },
                    set: { selectedTerminal = $0 }
                )) {
                    ForEach(terminals, id: \.self) { terminal in
                        Text(terminal)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.4), radius: 2, x: 0, y: 2)
                
                // Show "Next" button only if a terminal is selected
                if selectedTerminal != nil {
                    NavigationLink(destination: MapView(selectedTerminal: selectedTerminal ?? "PIT")) {
                        Text("Next")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: UIScreen.main.bounds.width * 0.5)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    }
                    .padding(.top, 10)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .ignoresSafeArea()
        }
    }
}

// New MapView where you can add a map image
struct MapView: View {
    var selectedTerminal: String
    @State private var displayedImage: String
    @State private var currentLocation: String? = nil
    @State private var destination: String? = nil
    let terminals = ["A2", "A4", "A6", "A8", "B2", "B4", "B6", "B8"]

    init(selectedTerminal: String) {
        self.selectedTerminal = selectedTerminal
        self._displayedImage = State(initialValue: "\(selectedTerminal)_map")
    }

    var body: some View {
        VStack {
            Spacer()
                .frame(height: 50) // Ensures space below the dynamic island

            Text("Terminal Map")
                .font(.title)
                .padding()

            // Map image positioned dynamically
            Image(displayedImage)
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .padding()

            VStack(spacing: 20) {
                // Current Location Dropdown
                VStack(alignment: .leading) {
                    Text("Current Location:")
                        .font(.headline)
                    Picker("Select Current Location", selection: Binding(
                        get: { currentLocation ?? terminals.first! },
                        set: { currentLocation = $0 }
                    )) {
                        ForEach(terminals, id: \.self) { terminal in
                            Text(terminal)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(maxWidth: 300)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.4), radius: 2, x: 0, y: 2)
                }

                // Destination Dropdown
                VStack(alignment: .leading) {
                    Text("Destination:")
                        .font(.headline)
                    Picker("Select Destination", selection: Binding(
                        get: { destination ?? terminals.first! },
                        set: { destination = $0 }
                    )) {
                        ForEach(terminals, id: \.self) { terminal in
                            Text(terminal)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(maxWidth: 300)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.4), radius: 2, x: 0, y: 2)
                }
            }

            // Find Route Button
            if currentLocation != nil && destination != nil {
                Button(action: {
                    // Action to find the route and update the map image
                    if let current = currentLocation, let dest = destination {
                        displayedImage = "\(current)_to_\(dest)" // Example: "A2_to_B8"
                    }
                }) {
                    Text("Find Route")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.5)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                }
                .padding(.top, 20)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
