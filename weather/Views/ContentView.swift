//
//  ContentView.swift
//  weather
//
//  Created by Azam Abdusalomov on 22/02/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView().task {
                        do {
                            weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            
                        } catch {
                            print("Error getting data!")
                        }
                    }
                }
            } else {
                if locationManager.isLoading  {
                   LoadingView()
                } else {
                    WelcomeView().environmentObject(locationManager)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
