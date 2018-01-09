//
//  SocketTableViewController.swift
//  CryptoTrading
//
//  Created by Mohamed aymen AFIA on 26/12/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import UIKit
import SocketIO
import SwiftyJSON
import AVFoundation
class SocketTableViewController: UITableViewController {
    let manager = SocketManager(socketURL: URL(string: "https://coincap.io")!, config: [.log(true), .compress])
    
    var ary = ["1","2","3","4"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 //self.playAnimation()
      
    }

   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ary.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        
       // cell.textLabel?.text = ary[indexPath.row]
        // Configure the cell...

        
        
        
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
                    cell.textLabel?.text = crypto["msg"]!.value(forKey: "long") as! String
                }
                
                
            }
        }
            socket.connect()
    return cell
    }
    

    ////////////////////////////////////////////////////Begin
    
    var counter = 0
    @IBOutlet weak var imageView: UIImageView!
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
        self.imageView.layer.sublayers?.removeAll()
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
        self.view.sendSubview(toBack: imageView)
        emitter = CAEmitterLayer()
        self.createFireWorks()
        
    }
    
    func createFireWorks(){
        self.playSound(soundName: "firework", extensionName: "mp3")
        let image = UIImage(named: "coins")
        let img: CGImage = (image?.cgImage)!
        emitter.emitterPosition = CGPoint(x: self.imageView.bounds.size.width/2, y: self.imageView.frame.size.height + 10)
        emitter.renderMode = kCAEmitterLayerAdditive
        let emitterCell = CAEmitterCell()
        emitterCell.emissionLongitude = -CGFloat(M_PI / 2)
        emitterCell.emissionLatitude = 0
        emitterCell.lifetime = 2.0
        emitterCell.birthRate = 2
        emitterCell.velocity = 100
        emitterCell.velocityRange = 0
        emitterCell.yAcceleration = 0
        emitterCell.emissionRange = CGFloat(M_PI / 4)
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
        flareCell.yAcceleration = -320
        flareCell.emissionRange = CGFloat(M_PI / 7)
        flareCell.alphaSpeed = 1
        flareCell.scaleSpeed = -0.1
        flareCell.scaleRange = 0
        flareCell.beginTime = 0.01
        flareCell.duration = 1.7
        let fireworkCell = CAEmitterCell()
        fireworkCell.contents = img
        fireworkCell.birthRate = 100
        fireworkCell.scale = 0.1
        fireworkCell.velocity = 130
        fireworkCell.lifetime = 100
        fireworkCell.alphaSpeed = 1
        fireworkCell.yAcceleration = -60
        fireworkCell.beginTime = 1.5
        fireworkCell.duration = 0.1
        fireworkCell.emissionRange = 2 * CGFloat(M_PI)
        fireworkCell.scaleSpeed = -0.1
        fireworkCell.spin = 0
        fireworkCell.scale = 0.4
        fireworkCell.lifetime = 0.25
        fireworkCell.lifetimeRange = 0.8
        fireworkCell.scaleSpeed = 0.2
        fireworkCell.scaleRange = 1.0
        emitterCell.emitterCells = [flareCell,fireworkCell]
        self.emitter.emitterCells = [emitterCell]
        self.imageView.layer.addSublayer(emitter)
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




