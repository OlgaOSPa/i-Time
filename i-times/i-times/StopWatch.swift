//
//  ViewController.swift
//  i-times
//
//  Created by user on 01.12.2022.
//

import UIKit

class StopWatch: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var TimerOutput: UILabel!
    
    @IBOutlet weak var lapAndResetButton: UIButton!
    
    @IBOutlet weak var table: UITableView!
    
    var stopWatch = Timer ()
    var playTimer: Bool = true
    var lapTimer: Bool = true
    var counter: Double = 0.0
    var lapList: [String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func LapAndResertTimer(_ sender: UIButton) {
        if lapTimer{
        lapList.append(TimerOutput.text!)
        table.reloadData()
    }else {
        guard playTimer else {return}
        lapList.removeAll()
        table.reloadData()
        TimerOutput.text = "00:00"
        counter = 0.0
    }
    }
    
    
    @IBAction func StartAndPauseTimer(_ sender: UIButton) {
        if playTimer{
            stopWatch = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            lapAndResetButton .isEnabled = true
            changeStartAndPauseButton(by: sender, "pause.fill", text: "Pause")
            lapTimer = true
            
        }else{
            stopWatch.invalidate()
            changeStartAndPauseButton(by: sender, "play.fill", text: "Start")
            changeLapAndResetButton(by: lapAndResetButton, "clear.fill", text: "Resert")
            lapTimer = false
        }
    }
    @objc func updateTimer(){
        counter += 0.035
        
        var minutes: String = "\((Int)(counter / 60))"
        if (Int)(counter) < 10 {
            minutes = "0\((Int)(counter) / 60))"
            
        }
        
        
        var seconds: String = String(format: "%.2f",counter .truncatingRemainder(dividingBy: 60))
        if counter.truncatingRemainder(dividingBy:60) < 10{
            seconds = "0" + seconds
        
        }
        TimerOutput.text = minutes + ":" + seconds
    }
    
    func changeStartAndPauseButton (by button: UIButton, _ image: String, text title: String){
        playTimer = !playTimer
        button.setTitle(title, for: UIControl.State())
        button.setImage(UIImage(systemName: image), for: UIControl.State())
    }
    func changeLapAndResetButton (by button: UIButton, _ image: String, text title: String){
        button.setTitle(title, for: UIControl.State())
        button.setImage(UIImage(systemName: image), for: UIControl.State())
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableRow", for: indexPath) as! TableCell
        
        cell.tableLable.text = lapList[indexPath.row]
        return cell
    }
    
    
}

