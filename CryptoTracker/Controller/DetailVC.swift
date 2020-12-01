//
//  DetailVC.swift
//  CryptoTracker
//
//  Created by tami on 11/29/20.
//

import UIKit
import SwiftyJSON
import Charts


class DetailVC: UIViewController, ChartViewDelegate {
    let detailSegue = "DetailViewSegue"
    
    var name: String?
    var barTitle: String?
    let networking = Networking()
    var entries = [ChartDataEntry]()
    let url = "https://min-api.cryptocompare.com/data/v2/histohour?tsym=USD&limit=23&api_key=62b75013483ec331b5654dc205098b009a02793ccd55150caf4f69cd6f98440e&fsym="
    
    
    @IBOutlet weak var confirmLabel: UILabel!
    @IBOutlet weak var lineChart: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabel()
        networking.fetchingData(url: url + name!) { (data) in
            let json = JSON(data)
            
            
            for i in 0 ..< json["Data"].count {
                let price = Double(json["Data"][i]["high"].stringValue)
                self.entries.append(ChartDataEntry(x: Double(i), y: Double(price!)))
            }
            self.lineChartData()
        }
        
        lineChart.delegate = self
    }
    
    private func setupLabel () {
        
        guard let text = name else {return}
        confirmLabel.text = text
        
        guard let barTitleName = barTitle else {return}
        navigationItem.title = barTitleName
        
    }
    
    func lineChartData() {
        let set = LineChartDataSet(entries: entries)
        lineChart.noDataText = "Handling Data From API"
        set.colors = [UIColor(red: 255 / 255, green: 205 / 255, blue: 0 / 255, alpha: 1)]
        lineChart.xAxis.labelPosition = .bottom
        let data = LineChartData(dataSet: set)
        lineChart.data = data
        lineChart.animate(xAxisDuration: 1.0, yAxisDuration: 0)
        
        
    }

    

}
