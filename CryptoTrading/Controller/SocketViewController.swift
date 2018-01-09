//
//  SocketViewController.swift
//  CryptoTrading
//
//  Created by Mohamed aymen AFIA on 26/12/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SocketIO
import AVFoundation
import UIKit
   private let reuseIdentifier = "Cell"
class SocketViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
     @IBOutlet weak var tableview: UITableView!
     var cryptoArray: [CryptoCurrency] = []
    var name: [String] = []
     let requestURL = "https://api.coinmarketcap.com/v1/ticker/?limit=50"
 
    let manager = SocketManager(socketURL: URL(string: "https://coincap.io")!, config: [.log(true), .compress])
    
    var CurrentcryptoArray: [CryptoCurrency] = []
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismiss(animated: true, completion: nil)
        changeData()

        getDataFrom(url: requestURL)
  
        // Do any additional setup after loading the view.
    }
    
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cryptoArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let crypto = cryptoArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MainScreenTableViewCell
        //https://www.cryptocompare.com//media/19633/btc.png
        cell.coinImage.image = UIImage(named: "\(String(describing: crypto.symbol!).lowercased()).png")
        
        //let url = URL(string: "https://www.cryptocompare.com//media/19633/\(String(describing: crypto.symbol!)).png")
        //cell.coinImage.kf.setImage(with: url)
     
          
//            DispatchQueue.main.async {
//                for dataVal in self.cryptoArray {
//
//                    if dataVal.state! == true {
//
//                        cell.nameLabel.textColor = UIColor.green
//                        //                UIView.animate(withDuration: 3, animations: {
//                        //
//                        //
//                        //                        cell.nameLabel.alpha = 0.6
//                        //
//                        //                }, completion: { (true) in
//                        //                    cell.nameLabel.alpha = 0
//                        //                })
//                    }else{
//
//                        cell.nameLabel.textColor = UIColor.white
//
//                    }
//                   dataVal.state! = false
//            }
//
        
            
   //     }
        
        
    
    
        
        
        
        
        if (crypto.state == "red"){
             cell.myview.alpha = 0.5
            UIView.animate(withDuration: 1, animations: {
               
                if ((cell.priceLabel.text! as NSString).doubleValue > (crypto.priceUSD! as NSString).doubleValue){
                     cell.myview.backgroundColor = UIColor.red
                }else{
                    
                    cell.myview.backgroundColor = UIColor.green
                }
               
            })
        
        crypto.state = "white"
        }else {
            
          cell.myview.alpha = 0
            
        }
        
        
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
        viewController.cryptoCurrency = self.cryptoArray[indexPath.row]
        print("cool")
        
        show(viewController, sender: nil)
        dismiss(animated: true, completion: nil)
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
        customSC.addTarget(self, action: "changeColor:", for: .touchUpInside)
        customSC.addTarget(self, action: #selector(changeColor(sender:)), for: .valueChanged)
        customSC.selectedSegmentIndex = 1
        
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
            
            
            
            // self.view.backgroundColor = UIColor.green
            print("Green")
        case 1:
            //self.view.backgroundColor = UIColor.blue
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "socket") as! SocketViewController
            present(viewController, animated: true, completion: nil)
            dismiss(animated: true, completion: nil)
            
            print("Blue")
        default:
          
            //self.view.backgroundColor = UIColor.purple
            print("Purple")
        }
    }
    
    
    
    
    
    
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
                        cryptoCurrency.state = "white"
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
    
    
    
    func changeData(){
        
        let socket = manager.defaultSocket
        
        
        socket.on(clientEvent: .connect) {data, ack in
            // print("socket connected")
        }
        
        socket.on("trades") {data, ack in
            let cur = data[0] as! [String:AnyObject]
            let json = JSON(data)
            //   print(json)
            
            if let resData = json.arrayObject {
                print("xxxxxxxxxx")
                
                //  print((resData as? [[String:AnyObject]])!)
                
                for crypto in (resData as? [[String:AnyObject]])! {
                    print("longlong")
                    print(crypto["msg"]!.value(forKey: "long"))
                    
                    // cell.priceLabel.text = crypto.priceUSD
                    
                    
                    for dataVal in self.cryptoArray {
                        
                        if dataVal.name == (crypto["msg"]!.value(forKey: "long")) as! String {
                            
                            dataVal.priceUSD = (crypto["msg"]!.value(forKey: "price") as! NSNumber).stringValue
                            dataVal.state = "red"
                            
                            //dataVal.state = true
                            
                            
                            DispatchQueue.main.async {
                                // faire quelque chose
                                self.tableview.reloadData()
                                
                            }
                        }
                        
                        
                    }
                    
                    
                }
                
            }
            }
            
            socket.connect()
            
        
    }
    
    
    
    ////////////////////////////////////////////////////Begin
    
    var counter = 0
   // @IBOutlet weak var imageView: UIImageView!
    var player:  AVAudioPlayer?
    var gameTimer: Timer!
    
    
    
    func playSound(soundName : String, extensionName : String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: extensionName) else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            gameTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: false)
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    @objc func runTimedCode() {
        player?.stop()
       // self.imageView.layer.sublayers?.removeAll()
        counter += 1
        let when = DispatchTime.now() + 0.1
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            if self.counter % 3 == 1 {
                self.emitter = CAEmitterLayer()
                self.type = Types.Confetti
                self.playAnimation()
            }
            else if self.counter % 3 == 0 {
                self.emitter = CAEmitterLayer()
                self.type = Types.FireWorks
                self.playAnimation()
            }
            else {
                self.emitter = CAEmitterLayer()
                self.type = Types.Balloons
                self.playAnimation()
            }
        }
    }
    
    
    
    
    var emitter = CAEmitterLayer()
    var colors:[UIColor] = [
        Colors.red,
        Colors.blue,
        Colors.green,
        Colors.yellow
    ]
    var images:[UIImage] = [
        Images.box,
        Images.triangle,
        Images.circle,
        Images.swirl
    ]
    var velocities:[Int] = [
        100,
        90,
        150,
        200
    ]
    var baloonColors: [UIColor] = [
        UIColor.init(patternImage: #imageLiteral(resourceName: "darkBlue").resizeImage(newWidth: 300)),
        UIColor.init(patternImage: #imageLiteral(resourceName: "darkGreen").resizeImage(newWidth: 300)),
        UIColor.init(patternImage: #imageLiteral(resourceName: "deepRed").resizeImage(newWidth: 300)),
        UIColor.init(patternImage: #imageLiteral(resourceName: "orange").resizeImage(newWidth: 300)),
        UIColor.init(patternImage: #imageLiteral(resourceName: "pink").resizeImage(newWidth: 300)),
        UIColor.init(patternImage: #imageLiteral(resourceName: "skyBlue").resizeImage(newWidth: 300)),
        UIColor.init(patternImage: #imageLiteral(resourceName: "white").resizeImage(newWidth: 300)),
        UIColor.init(patternImage: #imageLiteral(resourceName: "yellow").resizeImage(newWidth: 300))
    ]
    var type = Types.Balloons
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.playAnimation()
    }
    
    func playAnimation(){
       // self.view.sendSubview(toBack: imageView)
        emitter = CAEmitterLayer()
        self.createFireWorks()
        
    }
    
    func createFireWorks(){
      //  self.playSound(soundName: "firework", extensionName: "mp3")
        let image = UIImage(named: "coin1")
        let img: CGImage = (image?.cgImage)!
        emitter.emitterPosition = CGPoint(x: self.view.bounds.size.width/2, y: self.view.frame.size.height + 10)
        emitter.renderMode = kCAEmitterLayerAdditive
        let emitterCell = CAEmitterCell()
        emitterCell.emissionLongitude = -CGFloat(M_PI / 2)
        emitterCell.emissionLatitude = 0
        emitterCell.lifetime = 2.0
        emitterCell.birthRate = 2
        emitterCell.velocity = 100
        emitterCell.velocityRange = 0
        emitterCell.yAcceleration = 0
       // emitterCell.emissionRange = CGFloat(M_PI / 4)
        let newColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5).cgColor
        emitterCell.redRange = 0
        emitterCell.greenRange = 0
        emitterCell.blueRange = 0
        emitterCell.name = "base"
        let flareCell =  CAEmitterCell()
        flareCell.contents = img
        flareCell.emissionLongitude = -CGFloat(4 * M_PI) / 2
        flareCell.scale = 0.4
        flareCell.velocity = 80
        flareCell.birthRate = 1
        flareCell.lifetime = 0.5
        flareCell.yAcceleration = -1000
        flareCell.emissionRange = 0.1
        flareCell.alphaSpeed = 1
        flareCell.scaleSpeed = -0.1
        flareCell.scaleRange = 0
        flareCell.beginTime = 0.01
        flareCell.duration = 1.7
        let fireworkCell = CAEmitterCell()
        fireworkCell.contents = img
        fireworkCell.birthRate = 10
        fireworkCell.scale = 0.1
        fireworkCell.velocity = 130
        fireworkCell.lifetime = 100
        fireworkCell.alphaSpeed = 1
        fireworkCell.yAcceleration = -60
        fireworkCell.beginTime = 1.5
        fireworkCell.duration = 0.1
        fireworkCell.emissionRange = 1
        fireworkCell.scaleSpeed = -0.1
        fireworkCell.spin = 0
        fireworkCell.scale = 0.4
        fireworkCell.lifetime = 0
        fireworkCell.lifetimeRange = 0.8
        fireworkCell.scaleSpeed = 0.2
        fireworkCell.scaleRange = 1.0
        emitterCell.emitterCells = [flareCell,fireworkCell]
        self.emitter.emitterCells = [emitterCell]
        self.view.layer.addSublayer(emitter)
    }
    private func generateBalloonEmitterCells()  -> [CAEmitterCell] {
        var cells : [CAEmitterCell] = [CAEmitterCell]()
        for index in 0..<1 {
            let cell = CAEmitterCell()
            cell.birthRate = 2
            cell.lifetime = 10.0
            cell.lifetimeRange = 0.0
            cell.velocity = CGFloat(self.getRandomVelocity())
            cell.emissionLongitude = CGFloat(0)
            cell.emissionRange = 0.0
            cell.spinRange = 0.0
            cell.scaleRange = 1
            cell.scale = 0.1
            let image : UIImage = UIImage.init(named: "coins")!
            //let newImage = image.overlayed(by: baloonColors[index])
            cell.contents = image.cgImage
            cells.append(cell)
            // let image = UIImage(named: "coins")
        }
        return cells
    }
    
    private func generateEmitterCells() -> [CAEmitterCell] {
        var cells:[CAEmitterCell] = [CAEmitterCell]()
        for index in 0..<16 {
            let cell = CAEmitterCell()
            cell.birthRate = 4.0
            cell.lifetime = 14.0
            cell.lifetimeRange = 0
            cell.velocity = CGFloat(getRandomVelocity())
            cell.velocityRange = 0
            cell.emissionLongitude = CGFloat(Double.pi)
            cell.emissionRange = 0.5
            cell.spin = 3.5
            cell.spinRange = 0.5
            cell.color = getNextColor(i: index)
            cell.contents = getNextImage(i: index)
            cell.scaleRange = 0.32
            cell.scale = 0.1
            cells.append(cell)
        }
        return cells
    }
    private func getRandomVelocity() -> Int {
        return velocities[getRandomNumber()]
    }
    private func getRandomNumber() -> Int {
        return Int(arc4random_uniform(4))
    }
    private func getNextColor(i:Int) -> CGColor {
        if i <= 4 {
            return colors[0].cgColor
        } else if i <= 8 {
            return colors[1].cgColor
        } else if i <= 12 {
            return colors[2].cgColor
        } else {
            return colors[3].cgColor
        }
    }
    private func getNextImage(i:Int) -> CGImage {
        return images[i % 4].cgImage!
    }
    ////////////////////////////////////////////////////////Finish
    
    
    
}
enum Types : Int {
    case Confetti = 1
    case Balloons = 2
    case FireWorks = 3
}

enum Colors {
    static let red = UIColor(red: 1.0, green: 0.0, blue: 77.0/255.0, alpha: 1.0)
    static let blue = UIColor.blue
    static let green = UIColor(red: 35.0/255.0 , green: 233/255, blue: 173/255.0, alpha: 1.0)
    static let yellow = UIColor(red: 1, green: 209/255, blue: 77.0/255.0, alpha: 1.0)
}
enum Images {
    static let box = UIImage(named: "Box")!
    static let triangle = UIImage(named: "Triangle")!
    static let circle = UIImage(named: "Circle")!
    static let swirl = UIImage(named: "Spiral")!
}
extension UIImage {
    func overlayed(by overlayColor: UIColor) -> UIImage {
        //  Create rect to fit the image
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        // Create image context. 0 means scale of device's main screen
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let context = UIGraphicsGetCurrentContext()!
        //  Fill the rect by the final color
        overlayColor.setFill()
        context.fill(rect)
        //  Make the final shape by masking the drawn color with the images alpha values
        self.draw(in: rect, blendMode: .destinationIn, alpha: 1)
        //  Make the final shape by masking the drawn color with the images alpha values
        let overlayedImage = UIGraphicsGetImageFromCurrentImageContext()!
        //  Release context
        UIGraphicsEndImageContext()
        return overlayedImage
    }
    func resizeImage(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize.init(width: newWidth, height: newHeight))
        self.draw(in: CGRect.init(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

