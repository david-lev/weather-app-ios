//
//  WeatherView.swift
//  weather
//
//  Created by David Lev on 02/06/2022.
//

import SwiftUI

struct WeatherView: View {
    let darkBlue = Color(hue: 0.692, saturation: 1.0, brightness: 0.591)
    var weather: ResponseBody
    @State var units: Units = .celsius
    @State var unitsSymbol = "°C"
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.name)
                        .bold()
                        .font(.title)
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                
                VStack {
                    HStack {
                        VStack(spacing: 20) {
                            Image(systemName: "sun.max")
                                .font(.system(size: 40))
                            Text(weather.weather[0].main)
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        Button(action: {
                            switch units {
                            case .celsius:
                                units = .fahrenheit
                                unitsSymbol = "°C"
                            case .fahrenheit:
                                units = .celsius
                                unitsSymbol = "°F"
                            }
                        }, label: {
                            Text(weather.main.feelsLike.convertUnit(unit: units).roundDouble() + unitsSymbol)
                                .font(.system(size: 80))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding()
                            
                        })
                    }
                    Spacer()
                        .frame(height: 80)
                    
                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    Text("Weather now")
                        .bold().padding(.bottom)
                    HStack {
                        WeatherRow(logo: "thermometer", name: "Min temp", value: (weather.main.tempMin.convertUnit(unit: units).roundDouble() + unitsSymbol))
                        Spacer()
                        WeatherRow(logo: "thermometer", name: "Max temp", value: (weather.main.tempMax.convertUnit(unit: units).roundDouble() + unitsSymbol))
                    }
                    HStack {
                        WeatherRow(logo: "wind", name: "Wind speed", value: (weather.wind.speed.roundDouble()))
                        Spacer()
                        WeatherRow(logo: "humidity", name: "Humidity", value: (weather.main.humidity.roundDouble() + "%"))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(darkBlue)
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
            
        }.edgesIgnoringSafeArea(.bottom)
            .background(darkBlue)
            .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
