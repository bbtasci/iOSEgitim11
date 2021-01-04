//
//  WeatherInfo.swift
//  WeatherBoard
//
//  Created by Baris Berkin Tasci on 4.01.2021.
//

import Foundation

final class WeatherModel: Codable {
    var consolidated_weather: [ConsolidatedWeatherModel]?
}
