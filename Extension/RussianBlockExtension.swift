//
//  RussianBlockExtension.swift
//  Russian Block
//
//  Created by Chester Wong on 03/11/2017.
//  Copyright © 2017 Easy. All rights reserved.
//

import UIKit

extension GamingSceneController{
    func MonitorImageConfiguration(){
        let image = UIImage(named: "MonitorBlock.jpg")
        let MonitorBlocksize = MonitorContainerView.bounds.size
        let PixelImageSize = CGSize(width: MonitorBlocksize.width/12, height: MonitorBlocksize.height/22)
        
        for i in 0...21 {
            var temp_Moniotr_Image_View: [UIImageView] = []
            for j in 0...11 {
                var temp_Pixel_Image_View: UIImageView = UIImageView(image: image)
                temp_Pixel_Image_View = UIImageView(frame: CGRect(origin: CGPoint(x: CGFloat(j)*PixelImageSize.width, y: CGFloat(i)*PixelImageSize.height), size: PixelImageSize))
                temp_Pixel_Image_View.contentMode = .scaleAspectFill
                temp_Pixel_Image_View.image = image
                MonitorContainerView.addSubview(temp_Pixel_Image_View)
                
                temp_Moniotr_Image_View.append(temp_Pixel_Image_View)
            }
            
            Monitor_Image_View.append(temp_Moniotr_Image_View)
        }
    }
    
    func NextBlockMonitorConfiguration(){
        let image = UIImage(named: "MonitorBlock.jpg")
        let MonitorBlocksize = NextBlockContainerView.bounds.size
        let PixelImageSize = CGSize(width: MonitorBlocksize.width/4, height: MonitorBlocksize.height/4)
        
        for i in 0...3{
            var temp_Monitor_Image_view: [UIImageView] = []
            for j in 0...3{
                var temp_Pixel_Image_View: UIImageView = UIImageView(image: image)
                temp_Pixel_Image_View = UIImageView(frame: CGRect(origin: CGPoint(x: CGFloat(j)*PixelImageSize.width, y: CGFloat(i)*PixelImageSize.height), size: PixelImageSize))
                temp_Pixel_Image_View.contentMode = .scaleAspectFill
                temp_Pixel_Image_View.image = image
                NextBlockContainerView.addSubview(temp_Pixel_Image_View)
                
                temp_Monitor_Image_view.append(temp_Pixel_Image_View)
            }
            
            Next_Block_Monitor_Image_View.append(temp_Monitor_Image_view)
        }
        
        for i in 0...3{
            var temp_Monitor_Image_view: [UIImageView] = []
            for j in 0...3{
                var temp_Pixel_Image_View: UIImageView = UIImageView(image: image)
                temp_Pixel_Image_View = UIImageView(frame: CGRect(origin: CGPoint(x: CGFloat(j)*PixelImageSize.width, y: CGFloat(i)*PixelImageSize.height), size: PixelImageSize))
                temp_Pixel_Image_View.contentMode = .scaleAspectFill
                temp_Pixel_Image_View.image = image
                NextNextBlockContainerView.addSubview(temp_Pixel_Image_View)
                
                temp_Monitor_Image_view.append(temp_Pixel_Image_View)
            }
            
            Next_Next_Block_Monitor_Image_View.append(temp_Monitor_Image_view)
        }
    }
    
    func Block_regen(){
        Block.assign(type: next_block)
        next_block = next_next_block
        next_next_block = convertInttoBlockType(Int(arc4random_uniform(7)+1))
        Block.setx(4)
        Block.sety(0)
        Block_Add()
        RefreshMonitor()
    }
    
    func Block_Add(){
        let x = Block.getx()
        let y = Block.gety()
        for i in y...(y+3){
            for j in x...(x+3){
                if(Block.block[i - y][j - x]){
                    Monitor.monitor[i][j] = true
                }
            }
        }
    }
    
    func Block_Subtract(){
        let x = Block.getx()
        let y = Block.gety()
        for i in y...(y+3){
            for j in x...(x+3){
                if(Block.block[i - y][j - x] && Monitor.monitor[i][j]){
                    Monitor.monitor[i][j] = false
                }
            }
        }
    }
    
    func Crashcheck(moveX: Int, moveY: Int) -> Bool{
        let x = Block.getx() + moveX
        let y = Block.gety() + moveY
        for i in 0...3{
            for j in 0...3{
                if(Block.block[i][j] && Monitor.monitor[y + i][x + j]){
                    return true
                }
            }
        }
        return false
    }
    
    func PureCrashcheck() -> Bool{
        Block_Subtract()
        let isCrash = Crashcheck(moveX: 0, moveY: 1)
        Block_Add()
        return isCrash
    }
    
    func RotateCrashcheck() -> Bool{
        Block.rotate()
        let x = Block.getx()
        let y = Block.gety()
        for i in 0...3{
            for j in 0...3{
                if(Block.block[i][j] && Monitor.monitor[y + i][x + j]){
                    for _ in 1...3{
                        Block.rotate()
                    }
                    return true
                }
            }
        }
        for _ in 1...3{
            Block.rotate()
        }
        return false
    }
    
    func Fullcheck() -> Int{
        var flag = 0
        for j in stride(from: 20, to: 1, by: -1){
            flag = 0
            for i in 1...10{
                if(Monitor.monitor[j][i]){
                    flag += 1
                }
                if(flag >= 10){
                    return j
                }
            }
        }
        return 0
    }
    
    func GameOvercheck() -> Bool{
        for i in 1...10{
            if(Monitor.monitor[1][i]){
                return true
            }
        }
        return false
    }
    
    func DeleteRow(row: Int){
        Monitor.monitor.remove(at: row)
        var temp: [Bool] = [true]
        for _ in  1...11{
            temp.append(false)
        }
        temp[11] = true
        Monitor.monitor.insert(temp, at: 1)
        RefreshMonitor()
    }
    
    func RefreshMonitor(){
        for i in 0...21{
            for j in 0...11{
                Monitor_Image_View[i][j].isHidden = !Monitor.isTrue(i, j)
            }
        }
    }
    
    func RefreshNextBlockMonitor(){
        NextBlock.assign(type: next_block)
        NextNextBlock.assign(type: next_next_block)
        
        for i in 0...3{
            for j in 0...3{
                Next_Block_Monitor_Image_View[i][j].isHidden = !NextBlock.block[i][j]
                Next_Next_Block_Monitor_Image_View[i][j].isHidden = !NextNextBlock.block[i][j]
            }
        }
    }
    
    func BlockShiftLeft(){
        Block_Subtract()
        if(!Crashcheck(moveX: -1, moveY: 0)){
            Block.setx(Block.getx() - 1)
            Block_Add()
            RefreshMonitor()
        }
        else{
            Block_Add()
        }
    }
    
    func BlockShiftRight(){
        Block_Subtract()
        if(!Crashcheck(moveX: 1, moveY: 0)){
            Block.setx(Block.getx() + 1)
            Block_Add()
            RefreshMonitor()
        }
        else{
            Block_Add()
        }
    }
    
    func BlockShiftUp(){
        Block_Subtract()
        if(!Crashcheck(moveX: 0, moveY: -1)){
            Block.sety(Block.gety() - 1)
            Block_Add()
            RefreshMonitor()
        }
        else{
            Block_Add()
        }
    }
    
    func BlockShiftDown(){
        Block_Subtract()
        if(!Crashcheck(moveX: 0, moveY: 1)){
            Block.sety(Block.gety() + 1)
            Block_Add()
            RefreshMonitor()
        }
        else{
            Block_Add()
        }
    }
    
    func BlockRotate(){
        Block_Subtract()
        if(!RotateCrashcheck()){
            Block.rotate()
            Block_Add()
            RefreshMonitor()
        }
        else{
            Block_Add()
        }
    }
    
    @objc func RepeatForever(){
        if(PureCrashcheck()){
            var NumberOfFullColumn = 0
            var rowShouldDeleted = Fullcheck()
            while(rowShouldDeleted != 0){
                NumberOfFullColumn += 1
                print("Row \(rowShouldDeleted) has been deleted")
                DeleteRow(row: rowShouldDeleted)
                rowShouldDeleted = Fullcheck()
            }
            if(NumberOfFullColumn > 0){
                switch NumberOfFullColumn{
                case 1:
                    score += 100
                case 2:
                    score += 300
                case 3:
                    score += 600
                case 4:
                    score += 1000
                default:
                    score += 1000
                }
                ScoreLabel.text = "\(score)"
            }
            if((score-score%level_change_score)/level_change_score + 1 != level){
                level = (score-score%level_change_score)/level_change_score
                LevelLabel.text = "\(level)"
                gameTimer.invalidate()
                gameTimer = Timer.scheduledTimer(timeInterval: 0.7 - Double(level - 1)*0.05, target: self, selector: #selector(RepeatForever), userInfo: nil, repeats: true)
            }
            if(GameOvercheck()){
                gameTimer.invalidate()
                LeftBtn.isEnabled = false
                RightBtn.isEnabled = false
                DownBtn.isEnabled = false
                RotateBtn.isEnabled = false
                DownTheBottomBtn.isEnabled = false
                if(UserDefaults.standard.integer(forKey: "HighestScore") < score){
                    UserDefaults.standard.set(score, forKey: "HighestScore")
                }
                GameOverView.fadeIn()
            }
            else{
                Block_regen()
                RefreshNextBlockMonitor()
            }
        }
        BlockShiftDown()
    }
    
    func StraightDownTotheBottom(){
        while(!PureCrashcheck()){
            BlockShiftDown()
        }
        RefreshMonitor()
        var rowShouldDeleted = Fullcheck()
        var NumberOfFullColumn = 0
        while(rowShouldDeleted != 0){
            NumberOfFullColumn += 1
            print("Row \(rowShouldDeleted) has been deleted")
            DeleteRow(row: rowShouldDeleted)
            rowShouldDeleted = Fullcheck()
        }
        if(NumberOfFullColumn > 0){
            switch NumberOfFullColumn{
            case 1:
                score += 100
            case 2:
                score += 300
            case 3:
                score += 600
            case 4:
                score += 1000
            default:
                score += 1000
            }
            ScoreLabel.text = "\(score)"
        }
        if((score-score%level_change_score)/level_change_score + 1 != level){
            level = (score-score%level_change_score)/level_change_score + 1
            LevelLabel.text = "\(level)"
            gameTimer.invalidate()
            gameTimer = Timer.scheduledTimer(timeInterval: 0.7 - Double(level - 1)*0.05, target: self, selector: #selector(RepeatForever), userInfo: nil, repeats: true)
        }
        Block_regen()
        RefreshNextBlockMonitor()
        
    }
}
