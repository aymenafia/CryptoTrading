//
//  MainScreenTableViewCell.swift
//  CryptoTrading
//
//  Created by Mohamed aymen AFIA on 24/12/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import UIKit

class MainScreenTableViewCell: UITableViewCell {

    
    @IBOutlet var myview: UIView!
    //@IBOutlet weak var bgView: UIView!
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var percent_change_1h: UILabel!
    
    @IBOutlet weak var arrow: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
