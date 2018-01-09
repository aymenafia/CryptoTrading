//
//  MainScreenTableViewViewController.swift
//  CryptoTrading
//
//  Created by Mohamed aymen AFIA on 19/12/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

private let reuseIdentifier = "Cell"

class MainScreenTableViewViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
 var cryptoArray: [CryptoCurrency] = []
    var CurrentcryptoArray: [CryptoCurrency] = []
 let requestURL = "https://api.coinmarketcap.com/v1/ticker/?limit=50"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUpSearchBar()
        getDataFrom(url: requestURL)
        
        print(CurrentcryptoArray)
        
        
//        let myButton = UIButton(type: UIButtonType.system)
//        //Set a frame for the button. Ignored in AutoLayout/ Stack Views
//        myButton.frame = CGRect(x: 30, y: 600, width: 113, height: 48)
//        //Set background color
//        myButton.backgroundColor = UIColor.darkGray
//        myButton.setTitle("chart", for: .normal)
//        myButton.setTitleColor(UIColor.white, for: .normal)
//        view.addSubview(myButton)
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func loadView() {
        super.loadView()
       // self.view.backgroundColor = UIColor.purple
        print("Main view's loadView() called.")
        
        // Initialize
        let items = ["Purple", "Green", "Blue"]
        let customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0
        
        // Set up Frame and SegmentedControl
        let frame = UIScreen.main.bounds
        customSC.frame = CGRect(x: 40, y: 650, width: 345, height: 51)
        //CGRect(x: frame.minX + 10, y: frame.minY + 50, width: frame.width - 20, height: frame.height*0.1)
        // Style the Segmented Control
        customSC.layer.cornerRadius = 5.0  // Don't let background bleed
        customSC.backgroundColor = UIColor(rgb: 0x22252A)
        customSC.tintColor = UIColor.white
        
        customSC.setImage(UIImage(named: "Icon1.png"), forSegmentAt: 0)
        customSC.setImage(UIImage(named: "Icon2.png"), forSegmentAt: 1)
        customSC.setImage(UIImage(named: "Icon3.png"), forSegmentAt: 2)
       
        // Add target action method
       // customSC.addTarget(self, action: "changeColor:", for: .touchUpInside)
        customSC.addTarget(self, action: #selector(changeColor(sender:)), for: .valueChanged)
       customSC.selectedSegmentIndex = 0
        
        // Add this custom Segmented Control to our view
        self.view.addSubview(customSC)
        
        
        let customView = UIView()
        customView.frame = CGRect(x: 0, y: 700, width: 1000, height: 51)
        //customView.backgroundColor = UIColor.white     //give color to the view
        
        
        customView.alpha = 1
      //  let gradient = CAGradientLayer()
       // gradient.frame = CGRect(x: 0, y: 650, width: 1000, height: 60)
       // gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        //customView.layer.insertSublayer(gradient, at: 0)
       
        //view.layer.addSublayer(gradient)
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [
            UIColor(white: 1, alpha: 1).cgColor,
            UIColor(white: 1, alpha: 1).cgColor,
            UIColor(white: 1, alpha: 1).cgColor,
            UIColor(white: 1, alpha: 0).cgColor
        ]
        gradient.locations = [0, 0.4, 0.6, 1]
        view.layer.mask = gradient
       
        // view.layer.insertSublayer(customView, above: gradient)
        
//        var darkBlur:UIBlurEffect = UIBlurEffect()
//
//        if #available(iOS 10.0, *) { //iOS 10.0 and above
//            darkBlur = UIBlurEffect(style: UIBlurEffectStyle.prominent)//prominent,regular,extraLight, light, dark
//        } else { //iOS 8.0 and above
//            darkBlur = UIBlurEffect(style: UIBlurEffectStyle.light) //extraLight, light, dark
//        }
//        let blurView = UIVisualEffectView(effect: darkBlur)
//        blurView.frame = CGRect(x: 0, y: 700, width: 500, height: 90) //your view that have any objects
//        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        blurView.alpha = 1
        
       
        
        
        
        
        
        
        
    }
    
    
    @objc func changeColor(sender: UISegmentedControl) {
        print("Change color handler is called.")
        print("Changing Color to ")
        print(sender)
        switch sender.selectedSegmentIndex {
        case 0:
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "mainview") as! MainScreenTableViewViewController
            
            show(viewController, sender: nil)
            //self.view.backgroundColor = UIColor.purple
            print("Purple")
            
            
            
           // self.view.backgroundColor = UIColor.green
            print("Green")
        case 1:
            //self.view.backgroundColor = UIColor.blue
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "socket") as! SocketViewController
            present(viewController, animated: true, completion: nil)
            
            
            
            print("Blue")
        default:
             print("default")
           
        }
    }
    
    
   func  setUpSearchBar(){
    
    
    searchBar.delegate = self
    
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        CurrentcryptoArray = cryptoArray.filter({ (CryptoCurrency) -> Bool in
            
            guard !(searchBar.text?.isEmpty)! else {
            
            CurrentcryptoArray = cryptoArray
                tableview.reloadData()
                return true
            
            }
            
            
            
            guard let text = searchBar.text else {return false}
            
            return (CryptoCurrency.name?.contains(text))!
            
        })
        
        tableview.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return CurrentcryptoArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let crypto = CurrentcryptoArray[indexPath.row]
         let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MainScreenTableViewCell
        //https://www.cryptocompare.com//media/19633/btc.png
          cell.coinImage.image = UIImage(named: "\(String(describing: crypto.symbol!).lowercased()).png")
        
        //let url = URL(string: "https://www.cryptocompare.com//media/19633/\(String(describing: crypto.symbol!)).png")
        //cell.coinImage.kf.setImage(with: url)
        
        
        
        if cell.coinImage.image == nil {
            cell.coinImage.image = UIImage(named: "INC.png")
        }
        
        let value = crypto.percentChange1h!
        
      if (value as NSString).doubleValue < 0.0 {
        cell.percent_change_1h.text = crypto.percentChange1h
        cell.percent_change_1h.textColor = UIColor.red
        cell.arrow.image = UIImage(named: "Rectangle2.png")
        }else{
        
        cell.percent_change_1h.textColor = UIColor.green
        cell.percent_change_1h.text = crypto.percentChange1h
         cell.arrow.image = UIImage(named: "Rectangle.png")
        }
        
        //cell.percent_change_1h.text = crypto.percentChange1h
        cell.nameLabel.text = crypto.name?.uppercased()
        cell.priceLabel.text = crypto.priceUSD
        cell.symbolLabel.text = "(\(crypto.symbol!))"
       
        //cell.textLabel?.text = cryptoArray[indexPath.row].name
        
        return cell
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "toDetail") as! DetailViewController
        
      //   let viewController = storyboard.instantiateViewController(withIdentifier: "socketEmbed") as! SocketEmbeddedViewController
        
        viewController.cryptoCurrency = self.cryptoArray[indexPath.row]
        print("cool")
        present(viewController, animated: true, completion: nil)
      //show(viewController, sender: nil)
       // self.navigationController?.pushViewController(viewController, animated: true)
        //self.navigationController? .pushViewController (viewController, animated:true)
        //self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
//
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toDetail" {
//            if let indexPaths = tableview?.item{
//                let indexPath = indexPaths.first!
//                let dvc = segue.destination as! DetailViewController
//                dvc.cryptoCurrency = self.cryptoArray[indexPath.row]
//            }
//        }
//    }

    
    
    
    
    
    
    
    
    
    func getDataFrom(url: String) {
        Alamofire.request(url).responseJSON { (responseData) -> Void in
            
            if((responseData.result.value) != nil) {
                 //print(responseData.result.value!)
                let json = JSON(responseData.result.value!)
              //   print(json)
                
                if let resData = json.arrayObject {
                    print((resData as? [[String:AnyObject]])!)

                    for crypto in (resData as? [[String:AnyObject]])! {
                      
                        
                        let cryptoCurrency = CryptoCurrency()
                        cryptoCurrency.id = crypto["id"] as! String
                        cryptoCurrency.name = crypto["name"] as! String
                        cryptoCurrency.symbol = crypto["symbol"] as! String
                        cryptoCurrency.rank = crypto["rank"] as! String
                        cryptoCurrency.priceUSD = crypto["price_usd"] as! String
                        cryptoCurrency.priceBitcoin = crypto["price_btc"] as! String
                        cryptoCurrency.volumeUSD24h = crypto["24h_volume_usd"] as! String
                        cryptoCurrency.marketCapUSD = crypto["market_cap_usd"] as! String
                        cryptoCurrency.availableSupply = crypto["available_supply"] as! String
                        cryptoCurrency.totalSupply = crypto["total_supply"] as! String
                        cryptoCurrency.percentChange1h = crypto["percent_change_1h"] as! String
                        cryptoCurrency.percentChange24h = crypto["percent_change_24h"] as! String
                        cryptoCurrency.percentChange7d = crypto["percent_change_7d"] as! String
                        self.cryptoArray.append(cryptoCurrency)
                         self.CurrentcryptoArray.append(cryptoCurrency)
                        print("add")
                        //print(cryptoCurrency.id!)
                        //print(self.cryptoArray)
                    }
                }
                
                if self.cryptoArray.count > 0 {
                    self.tableview?.reloadData()
                    
                }
            }
        }
  
    }

    
    
    
 
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
