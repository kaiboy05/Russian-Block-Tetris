//
//  GamingSceneController.swift
//  Russian Block
//
//  Created by Chester Wong on 02/11/2017.
//  Copyright © 2017 Easy. All rights reserved.
//

import UIKit

class GamingSceneController: UIViewController{

    @IBOutlet weak var MonitorContainerView: UIView!
    @IBOutlet weak var GameOverView: UIView!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var LevelLabel: UILabel!
    @IBOutlet weak var HighestScoreLabel: UILabel!
    
    @IBOutlet weak var NextBlockContainerView: UIView!
    @IBOutlet weak var NextNextBlockContainerView: UIView!
    @IBOutlet weak var PauseView: UIView!
    
    @IBOutlet weak var LeftBtn: UIButton!
    @IBOutlet weak var RightBtn: UIButton!
    @IBOutlet weak var DownBtn: UIButton!
    @IBOutlet weak var RotateBtn: UIButton!
    @IBOutlet weak var DownTheBottomBtn: UIButton!
    
    @IBOutlet weak var PauseBtn: UIButton!
    @IBOutlet weak var RestartBtn: UIButton!
    
    
    var gameTimer: Timer!
    var isPaused: Bool = false
    let level_change_score = 1500
    
    var Monitor = MonitorBool()
    var Block = BlockBool()
    var NextBlock = BlockBool()
    var NextNextBlock = BlockBool()
    var Monitor_Image_View: [[UIImageView]] = []
    var Next_Block_Monitor_Image_View: [[UIImageView]] = []
    var Next_Next_Block_Monitor_Image_View: [[UIImageView]] = []
    var score:Int = 0
    var level:Int = 1
    var next_block: BlockType = convertInttoBlockType(0)
    var next_next_block: BlockType = convertInttoBlockType(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(UserDefaults.standard.object(forKey: "HighestScore") == nil){
            UserDefaults.standard.set(0, forKey: "HighestScore")
            HighestScoreLabel.text = ""
        }
        if(UserDefaults.standard.integer(forKey: "HighestScore") > 0){
            HighestScoreLabel.text = "\(UserDefaults.standard.integer(forKey: "HighestScore"))"
        }
        else{
            HighestScoreLabel.text = "Add Oil"
        }
        
        MonitorImageConfiguration()
        NextBlockMonitorConfiguration()
        RefreshMonitor()
        
        next_block = convertInttoBlockType(Int(arc4random_uniform(7)+1))
        next_next_block = convertInttoBlockType(Int(arc4random_uniform(7)+1))
        Block_regen()
        RefreshNextBlockMonitor()
        
        ScoreLabel.text = "\(score)"
        LevelLabel.text = "\(level)"
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(GamingSceneController.RepeatForever), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func LeftBtnPressed(_ sender: Any) {
        BlockShiftLeft()
    }
    @IBAction func RightBtnPressed(_ sender: Any) {
        BlockShiftRight()
    }
    @IBAction func DownBtnPressed(_ sender: Any) {
        BlockShiftDown()
    }
    @IBAction func RotateBtnPressed(_ sender: Any) {
        BlockRotate()
    }
    @IBAction func DownTheBottomBtnPressed(_ sender: Any) {
        StraightDownTotheBottom()
    }
    @IBAction func PauseBtnPressed(_ sender: Any) {
        if(isPaused){
            PauseView.isHidden = true
            LeftBtn.isEnabled = true
            RightBtn.isEnabled = true
            DownBtn.isEnabled = true
            RotateBtn.isEnabled = true
            DownTheBottomBtn.isEnabled = true
            PauseBtn.setTitle("PAUSE", for: .normal)
            gameTimer = Timer.scheduledTimer(timeInterval: 0.7 - Double(level - 1)*0.05, target: self, selector: #selector(RepeatForever), userInfo: nil, repeats: true)
            isPaused = false
        }
        else{
            PauseBtn.setTitle("PLAY", for: .normal)
            PauseView.isHidden = false
            gameTimer.invalidate()
            LeftBtn.isEnabled = false
            RightBtn.isEnabled = false
            DownBtn.isEnabled = false
            RotateBtn.isEnabled = false
            DownTheBottomBtn.isEnabled = false
            isPaused = true
        }
    }
    @IBAction func RestartBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func SurveyButtonPressed(_ sender: Any) {
        PauseBtn.setTitle("PLAY", for: .normal)
        PauseView.isHidden = false
        gameTimer.invalidate()
        LeftBtn.isEnabled = false
        RightBtn.isEnabled = false
        DownBtn.isEnabled = false
        RotateBtn.isEnabled = false
        DownTheBottomBtn.isEnabled = false
        isPaused = true
    }
}
