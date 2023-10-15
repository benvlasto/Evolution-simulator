//
// ParameterInputViewController.swift
// Evolution simulator
//
// Created by Vlasto, Benedict (JDN) on 27/09/2020.
//
import UIKit
class ParameterInputViewController: UIViewController {

    // All variables and IBOutlets manage the sliders being changed in parameter input screen
    var populationSize: Int = 1
    @IBOutlet weak var populationSizeSlider: UISlider!
    @IBOutlet weak var populationSizeLabel: UILabel!

    var reproductiveChance: Double = 0.5
    @IBOutlet weak var reproductiveChanceSlider: UISlider!
    @IBOutlet weak var reproductiveChanceLabel: UILabel!

    var selectionPressure: Double = 0.15
    @IBOutlet weak var selectionPressureSlider: UISlider!
    @IBOutlet weak var selectionPressureLabel: UILabel!

    var environmentColour: Int = 50
    @IBOutlet weak var environmentColourSlider: UISlider!
    @IBOutlet weak var environmentColourLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        environmentColourSlider.value = 50
    }
    
    // Button that shows simulation screen
    @IBAction func showSimulationVC(_ sender: Any) {

        let environment = Environment(environmentColour: environmentColour, reproductiveChance: self.reproductiveChance, selectionPressure: self.selectionPressure, populationSize: self.populationSize)
        
        if let vc = storyboard?.instantiateViewController(identifier: "simulationVC") as? SimulationViewController {
            vc.environment = environment
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }

    }

    // All IBActions here manage sliders being changed in parameter input screen
    @IBAction func populationSizeChanged(_ sender: UISlider) {
        let value = Int(sender.value)
        self.populationSize = value
        populationSizeLabel.text = String(value)
    }

    @IBAction func reproductiveChanceChanged(_ sender: UISlider) {
        let value = Double(sender.value)
        let roundedValue = round(value * 100)/100
        self.reproductiveChance = value
        reproductiveChanceLabel.text = String(roundedValue)
    }

    @IBAction func selectionPressureChanged(_ sender: UISlider) {
        let value = Double(sender.value)
        let roundedValue = round(value * 100)/100
        self.selectionPressure = value
        selectionPressureLabel.text = String(roundedValue)
    }

    @IBAction func environmentColourChanged(_ sender: UISlider) {
        let value = Int(sender.value)
        self.environmentColour = value
        environmentColourLabel.text = String(value)
    }

}