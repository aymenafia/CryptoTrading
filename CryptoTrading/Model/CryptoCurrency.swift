//
//  CryptoCurrency.swift
//  CryptoTrading
//
//  Created by Mohamed aymen AFIA on 19/12/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import Foundation
import UIKit

class CryptoCurrency {
    var id : String? = nil
    var name: String? = nil
    var symbol: String? = nil
    var rank: String? = nil
    var priceUSD: String? = nil
    var priceBitcoin: String? = nil
    var volumeUSD24h: String? = nil
    var marketCapUSD: String? = nil
    var availableSupply: String? = nil
    var totalSupply: String? = nil
    var percentChange1h: String? = nil
    var percentChange24h: String? = nil
    var percentChange7d: String? = nil
    var state: String? = nil
    
    
    
    init(id: String?, name: String?, symbol: String?, rank: String?, priceUSD:  String?,
         priceBitcoin: String?, volumeUSD24h: String?, marketCapUSD: String?,
         availableSupply:  String?, totalSupply: String?, percentChange1h: String?,
         percentChange24h: String?, percentChange7d:  String?) {
        
        self.id = id
        self.name = name
        self.symbol = symbol
        self.rank = rank
        self.priceUSD = priceUSD
        self.priceBitcoin = priceBitcoin
        self.volumeUSD24h = volumeUSD24h
        self.marketCapUSD = marketCapUSD
        self.availableSupply = availableSupply
        self.totalSupply = totalSupply
        self.percentChange1h = percentChange1h
        self.percentChange24h = percentChange24h
        self.percentChange7d = percentChange7d
    }
    
    
    
    init(id: String?, name: String?, symbol: String?, rank: String?, priceUSD:  String?,
         priceBitcoin: String?, volumeUSD24h: String?, marketCapUSD: String?,
         availableSupply:  String?, totalSupply: String?, percentChange1h: String?,
         percentChange24h: String?, percentChange7d:  String?,state: String?) {
        
        self.id = id
        self.name = name
        self.symbol = symbol
        self.rank = rank
        self.priceUSD = priceUSD
        self.priceBitcoin = priceBitcoin
        self.volumeUSD24h = volumeUSD24h
        self.marketCapUSD = marketCapUSD
        self.availableSupply = availableSupply
        self.totalSupply = totalSupply
        self.percentChange1h = percentChange1h
        self.percentChange24h = percentChange24h
        self.percentChange7d = percentChange7d
        self.state = state
    }
    
    
    
    
    
    init() {
    }
}

