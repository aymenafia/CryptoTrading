


import UIKit
import Charts
import Alamofire
import SwiftyJSON
import BetterSegmentedControl

class DetailViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet var coinImage: UIImageView!
    @IBOutlet var closeDetails: UIImageView!
    @IBOutlet var Labelname: UILabel!
    var cryptoCurrency: CryptoCurrency!
    
    @IBOutlet var greenViewText: UILabel!
    var array: [[Any]] = []
    let reqTemplate = "http://www.coincap.io/history/"
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var segmentedControl: BetterSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = cryptoCurrency.name!
        lineChartView.delegate = self
        lineChartView.backgroundColor = UIColor.black
        segmentedControl.titles = ["Today", "1Н", "1М", "3М", "6М", "1Y", "All"]
        segmentedControl.titleFont = UIFont(name: "AvenirNext-Regular", size: 12.0)!
        segmentedControl.selectedTitleFont = UIFont(name: "AvenirNext-Regular", size: 12.0)!
      
        
        let defaultRequest = "https://www.coincap.io/history/1day/" + "\(self.cryptoCurrency.symbol!)"
        priceLabel.text = "$\(cryptoCurrency.priceUSD!)"
        greenViewText.text = "\(cryptoCurrency.percentChange1h!)%"
        
        getDataForChartFrom(url: defaultRequest)
        
        Labelname.text = cryptoCurrency.name
        coinImage.image = UIImage(named: "\(String(describing: cryptoCurrency.symbol!).lowercased()).png")
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        closeDetails.isUserInteractionEnabled = true
        closeDetails.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        //self.navigationController?.popViewController(animated: true)
        print("marja3ch")
        
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: "mainview") as! MainScreenTableViewViewController
      
        dismiss(animated: true, completion: nil)
        //show(viewController, sender: nil)
        
        // Your action
    }

    func getDataForChartFrom(url: String) {
        Alamofire.request(url).responseJSON { (responseData) in
            if((responseData.result.value) != nil) {
                let json = JSON(responseData.result.value!)
                print("teeeeeest")
                print(json)
                if let price = json["price"].arrayObject,
                    let marketCap = json["market_cap"].arrayObject {
                    
                    var cryptoPriceArray: [Double] = []
                    var cryptoDateArray: [Int] = []
                    var cryptoMarketCapArray: [Int] = []
                    
                    for data in price as! [[AnyObject]] {
                        cryptoDateArray.append(data[0] as! Int)
                        cryptoPriceArray.append(data[1] as! Double)
                    }
                    
                 for data  in marketCap as! [[AnyObject]] {
                    
                    let x = Int(truncating: data[1] as! NSNumber)
                       cryptoMarketCapArray.append(x)
                    }
                    
                    let dateArray = self.formateDate(array: cryptoDateArray)
                    self.setChart(dataPoints: dateArray, values: cryptoPriceArray)
                }
            }
        }
    }
    
    //Рисуем график
    func setChart(dataPoints: [String], values: [Double]) {
        
        lineChartView.rightAxis.enabled = false
        lineChartView.xAxis.enabled = false
        lineChartView.leftAxis.enabled = false
        
        lineChartView.chartDescription?.enabled = true
        lineChartView.legend.enabled = false
        
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.rightAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        
        lineChartView.noDataText = ""
        lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInOutCubic)
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let charDataSet = LineChartDataSet(values: dataEntries, label: nil)
        charDataSet.mode = .cubicBezier
        charDataSet.colors = [UIColor.white]
        charDataSet.drawCirclesEnabled = false
        charDataSet.lineWidth = 4
        //charDataSet.formLineWidth = 6
        // charDataSet.highlightLineWidth = 6
        charDataSet.fill = Fill.fillWithColor(UIColor.gray)
        charDataSet.drawFilledEnabled = true

        let charData = LineChartData(dataSet: charDataSet)
        self.lineChartView.data = charData
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        self.priceLabel.text = "$\(highlight.y)"
    }
    
    //Форматируем дату
    func formateDate(array: [Int]) -> [String] {
        var newArray: [String] = []
        for i in array {
            let date = Date(timeIntervalSince1970: TimeInterval(i/1000))
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.YYYY HH:mm:ss"
            dateFormatter.timeZone = TimeZone.current
            let date_ = dateFormatter.string(from: date)
            newArray.append(date_)
        }
        return newArray
    }
    
    
    @IBAction func segmentedControl(_ sender: BetterSegmentedControl) {
        
        switch sender.index {
        case 0:
            let request = "https://www.coincap.io/history/1day/" + "\(self.cryptoCurrency.symbol!)"
            getDataForChartFrom(url: request)
        case 1:
            let request = "https://www.coincap.io/history/7day/" + "\(self.cryptoCurrency.symbol!)"
            getDataForChartFrom(url: request)
        case 2:
            let request = "https://www.coincap.io/history/30day/" + "\(self.cryptoCurrency.symbol!)"
            getDataForChartFrom(url: request)
        case 3:
            let request = "https://www.coincap.io/history/90day/" + "\(self.cryptoCurrency.symbol!)"
            getDataForChartFrom(url: request)
        case 4:
            let request = "https://www.coincap.io/history/180day/" + "\(self.cryptoCurrency.symbol!)"
            getDataForChartFrom(url: request)
        case 5:
            let request = "https://www.coincap.io/history/365day/" + "\(self.cryptoCurrency.symbol!)"
            getDataForChartFrom(url: request)
        case 6:
            let request = "https://www.coincap.io/history/" + "\(self.cryptoCurrency.symbol!)"
            getDataForChartFrom(url: request)
        default:
            break
        }
    }
    
    
    //Разные запросы при переключении segmentedControl
    func segmentedControlValueChanged(_ sender: BetterSegmentedControl) {
        switch sender.index {
        case 0:
            let request = "http://www.coincap.io/history/1day/" + "\(self.cryptoCurrency.symbol!)"
            getDataForChartFrom(url: request)
        case 1:
            let request = "http://www.coincap.io/history/7day/" + "\(self.cryptoCurrency.symbol!)"
            getDataForChartFrom(url: request)
        case 2:
            let request = "http://www.coincap.io/history/30day/" + "\(self.cryptoCurrency.symbol!)"
            getDataForChartFrom(url: request)
        case 3:
            let request = "http://www.coincap.io/history/90day/" + "\(self.cryptoCurrency.symbol!)"
            getDataForChartFrom(url: request)
        case 4:
            let request = "http://www.coincap.io/history/180day/" + "\(self.cryptoCurrency.symbol!)"
            getDataForChartFrom(url: request)
        case 5:
            let request = "http://www.coincap.io/history/365day/" + "\(self.cryptoCurrency.symbol!)"
            getDataForChartFrom(url: request)
        case 6:
            let request = "http://www.coincap.io/history/" + "\(self.cryptoCurrency.symbol!)"
            getDataForChartFrom(url: request)
        default:
            break
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMoreInfo" {
            let dvc = segue.destination as! MoreInfoTableViewController
            dvc.cryptoCurrency = self.cryptoCurrency
        }
        //socketEmbed
        
        if segue.identifier == "socketEmbedded" {
            let dvc = segue.destination as! SocketEmbeddedViewController
            dvc.cryptoCurrency = self.cryptoCurrency
        }
        
    }
   
}

