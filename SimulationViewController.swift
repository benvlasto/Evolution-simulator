//
// SimulationViewController.swift
// Evolution simulator
//
// Created by Vlasto, Benedict (JDN) on 27/09/2020.
//

import UIKit
import Charts
import SpriteKit

class SimulationViewController: UIViewController {

    // stores the Environment initialised in parameter input screen
    var environment: Environment?

    // timer used for automatic advance of generations
    var timer: Timer?

    // Displays population size
    @IBOutlet weak var populationSizeLabel: UILabel!

    // For bar chart
    let xValues: [String] = ["1-10", "11-20", "21-30", "31-40", "41-50", "51-60", "61-70", "71-80", "81-90", "91-100"]
    @IBOutlet weak var simulationBarChartView: BarChartView!

    // For animations
    @IBOutlet weak var skView: SKView!
    var scene: AnimationScene?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        scene = AnimationScene(size: skView.bounds.size)
        scene!.environment = environment
        scene!.setBackgroundColour()
        scene!.placeCreatures()
        scene!.hideBorders()
        self.skView.presentScene(scene)
    }

    // Updates bar chart and population size label
    func updateViews() {
        setChart()
        populationSizeLabel.text = String(self.environment!.creatures.count)
    }

    func setChart() {

        var yValues = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        var dataEntries: [BarChartDataEntry] = []

        for creature in environment!.creatures {
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
        simulationBarChartView.data = chartData

    }

    // Called by advanceOneGeneration() if population size hits 0
    func extinctionAlert() {
        let alert = UIAlertController(title: "Extinction!", message: "This species of creature didn't adapt fast enough - it is now extinct.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Show summary screen", style: .default, handler: { action in
            self.showSummaryVC()
        }))
        self.present(alert, animated: true)
    }

    func advanceOneGeneration() {
        if environment?.advanceOneGeneration() == "extinct" {
            extinctionAlert()
        } else {
            updateViews()
            scene!.placeCreatures()
            if showBorders.isOn == false {
                scene!.hideBorders()
            }
        }
    }

    // Button that calls advanceOneGeneration once
    @IBAction func advanceOneGenerationButton(_ sender: Any) {
        advanceOneGeneration()
    }

    // Button that calls advanceOneGeneration five times
    @IBAction func advanceFiveGenerations(_ sender: Any) {
        for _ in 1...5 {
            advanceOneGeneration()
        }
    }

    // Button that starts/stops auto advance of generations
    @IBAction func startStopAutoAdvance(_ sender: Any) {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                self.advanceOneGeneration()
            }
        } else {
            timer!.invalidate()
            timer = nil
        }
    }

    // Shows or hides the sprite borders
    @IBOutlet weak var showBorders: UISwitch!
    @IBAction func showOrHideBorders(_ sender: Any) {
        if showBorders.isOn == true {
            scene!.showBorders()
        } else {
            scene!.hideBorders()
        }
    }

    // Button that ends simulation and shows summary screen
    @IBAction func showSummaryVC(_ sender: UIButton? = nil) {
        if let vc = storyboard?.instantiateViewController(identifier: "simulationSummaryVC") as? SimulationSummaryViewController {
            if timer != nil {
                timer!.invalidate()
                timer = nil
            }
            vc.environment = environment
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }

}