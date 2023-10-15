//
// SimulationSummaryViewController.swift
// Evolution simulator
//
// Created by Vlasto, Benedict (JDN) on 27/09/2020.
//

import UIKit
import Charts

class SimulationSummaryViewController: UIViewController {

    // stores the Environment from the simulation screen
    var environment: Environment?

    // For bar chart
    @IBOutlet weak var displayGenerationNumber: UILabel!
    let xValues: [String] = ["1-10", "11-20", "21-30", "31-40", "41-50", "51-60", "61-70", "71-80", "81-90", "91-100"]
    @IBOutlet weak var generationSelector: UISlider!
    @IBOutlet weak var simulationSummaryBarChartView: BarChartView!
    
    // For line chart
    @IBOutlet weak var simulationSummaryLineChartView: LineChartView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Sets slider bounds, bar chart, and line chart
        generationSelector.minimumValue = 1
        generationSelector.maximumValue = Float(environment!.populationHistory.count)
        setBarChart(generation: 1)
        setLineChart()
    }

    func setBarChart(generation: Int) {

        displayGenerationNumber.text = String(generation)

        var yValues = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        var dataEntries: [BarChartDataEntry] = []

        for creature in environment!.populationHistory[generation-1] {
            if 1...10 ~= creature.traitValue {
                yValues[0] += 1
            } else if 11...20 ~= creature.traitValue {
                yValues[1] += 1
            } else if 21...30 ~= creature.traitValue {
                yValues[2] += 1
            } else if 31...40 ~= creature.traitValue {
                yValues[3] += 1
            } else if 41...50 ~= creature.traitValue {
                yValues[4] += 1
            } else if 51...60 ~= creature.traitValue {
                yValues[5] += 1
            } else if 61...70 ~= creature.traitValue {
                yValues[6] += 1
            } else if 71...80 ~= creature.traitValue {
                yValues[7] += 1
            } else if 81...90 ~= creature.traitValue {
                yValues[8] += 1
            } else if 91...100 ~= creature.traitValue {
                yValues[9] += 1
            }
        }

        for i in 0 ..< xValues.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(yValues[i]))
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(dataEntries)
        let chartData = BarChartData(dataSet: chartDataSet)
        simulationSummaryBarChartView.data = chartData

    }

    func setLineChart() {

        var xValues: [Int] = []
        for i in 1 ... environment!.populationHistory.count {
            xValues.append(i)
        }

        var yValues: [Int] = []

        for i in 0 ..< environment!.populationHistory.count {
            yValues.append(environment!.populationHistory[i].count)
        }

        var dataEntries: [ChartDataEntry] = []
        for i in 0 ..< xValues.count {
            let dataEntry = ChartDataEntry(x: Double(xValues[i]), y: Double(yValues[i]))
            dataEntries.append(dataEntry)
        }

        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: nil)
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        simulationSummaryLineChartView.data = lineChartData

    }
    
    // Called when generationSelector slider is changed
    @IBAction func selectedGenerationChanged(_ sender: UISlider) {
        let value = Int(sender.value)
        setBarChart(generation: value)
    }

    //
    @IBAction func showMainMenuVC(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(identifier: "mainMenuVC") as? ViewController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
}