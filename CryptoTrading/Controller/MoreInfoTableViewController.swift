//
//  MoreInfoTableViewController.swift
//  CryptoTrading
//
//  Created by Mohamed aymen AFIA on 25/12/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import UIKit

class MoreInfoTableViewController: UITableViewController {
    
    var cryptoCurrency: CryptoCurrency!
    
    @IBOutlet weak var cellMarketCapLabel: UILabel!
    @IBOutlet weak var cellVolume24hLabel: UILabel!
    @IBOutlet weak var cellAvailableSupplyLabel: UILabel!
    @IBOutlet weak var cellChange1h: UILabel!
    @IBOutlet weak var cellChange24h: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
       
        cellMarketCapLabel.text = "$\(cryptoCurrency.marketCapUSD!)"
        cellVolume24hLabel.text =  "$\(cryptoCurrency.volumeUSD24h!)"
        cellAvailableSupplyLabel.text = cryptoCurrency.availableSupply
        //cellChange1h.text = cryptoCurrency.percentChange1h
        //cellChange24h.text = cryptoCurrency.percentChange24h
        
        
        
        if (cryptoCurrency.percentChange1h! as NSString).doubleValue < 0.0 {
            cellChange1h.text = "%\(cryptoCurrency.percentChange1h!)"
            cellChange1h.textColor = UIColor.red
            //cell.arrow.image = UIImage(named: "Rectangle2.png")
        }else{
            
            cellChange1h.textColor = UIColor.green
            cellChange1h.text = "+%\(cryptoCurrency.percentChange1h!)"
           // cell.arrow.image = UIImage(named: "Rectangle.png")
        }
        
        
        if (cryptoCurrency.percentChange24h! as NSString).doubleValue < 0.0 {
            cellChange24h.text = "%\(cryptoCurrency.percentChange24h!)"
            cellChange24h.textColor = UIColor.red
            //cell.arrow.image = UIImage(named: "Rectangle2.png")
        }else{
            
            cellChange24h.textColor = UIColor.green
            cellChange24h.text =  "+%\(cryptoCurrency.percentChange24h!)"
            // cell.arrow.image = UIImage(named: "Rectangle.png")
        }
        
        
       
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}

