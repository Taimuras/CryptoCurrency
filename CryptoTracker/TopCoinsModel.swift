//
//  TopCoinsModel.swift
//  CryptoTracker
//
//  Created by tami on 11/26/20.
//

import UIKit





struct TopCoinsModel: Codable {
    let data: [Datum]

}

struct Datum: Codable {
    let coinInfo: CoinInfo
    let display: Display
}

struct CoinInfo: Codable {
    let fullName: String
    let imageUrl: String
    
}

struct Display: Codable {
    let usd: DisplayUsd
}

struct DisplayUsd: Codable {
    let price: String
}
