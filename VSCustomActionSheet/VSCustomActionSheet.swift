//
//  VSCustomActionSheet.swift
//  VSCustomActionSheet
//
//  Created by Vijay on 02/12/19.
//  Copyright © 2019 Loco Team. All rights reserved.
//

import Foundation
import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SHEET_TITLE_HEIGHT : Int = 20
let LAST_BUTTON_PADDING : Int = 20
let NOTCH_BOTTOM_VALUE : Int = 30

let SPRING_DAMPING_ANIMATION_DURATION_SCREENSHOT : CGFloat = 0.8
let SPRING_VELOCITY_DURATION_SCREENSHOT : CGFloat = 0.5

let SPRING_DAMPING_ANIMATION_DURATION_BUTTON_CONTAINER : CGFloat = 0.8
let SPRING_VELOCITY_DURATION_BUTTON_CONTAINER : CGFloat = 0.7

let BUTTON_HEIGHT : Int = 60

let NORMAL_BUTTON_BG_COLOR = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
let CANCEL_BUTTON_BG_COLOR = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
let SHEET_TITLE_TEXT_COLOR = #colorLiteral(red: 0.5764705882, green: 0.6431372549, blue: 0.6784313725, alpha: 1)
let SHEET_BUTTON_TOP_BORDER_COLOR = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
let CANCEL_BUTTON_TEXT_COLOR = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
let NORMAL_BUTTON_TEXT_COLOR = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

class VSCustomActionSheet: UIView {

    // MARK: - Public var
    // MARK: -
    var buttonTittle : [String] = []
    var containerView = UIView()
    var sheetTitle = ""
    
    // MARK: - Completion handler
    // MARK: -
    typealias alertCompletionBlock = ((Int) -> Void)?
    private var block : alertCompletionBlock?
    
    // MARK: - Init coder
    // MARK: -
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Frame creation
    // MARK: -
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        self.backgroundColor = UIColor.clear
        containerView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        containerView.backgroundColor = UIColor.black
        containerView.isUserInteractionEnabled = true
        self.addSubview(containerView)
        
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(hide)))
    }
    
    // MARK: - Inital setup
    // MARK: -
    init(title : String, cancelButtonTitle : String,
         otherButtonTitle : [String],
         completion : alertCompletionBlock) {
        
        self.init()
        setupView(cancelButtonTitle: cancelButtonTitle, otherButtonTitle: otherButtonTitle)
        block = completion
        sheetTitle = title
    }
    
    
    // MARK: - Setup view
    // MARK: -
    func setupView(cancelButtonTitle : String,
                   otherButtonTitle : [String]) {
        
        buttonTittle = otherButtonTitle
        buttonTittle.append(cancelButtonTitle)
    }
    
    // MARK: - Show buttons
    // MARK: -
    func showButtons(_ viewSubs : UIView)  {
        
        let screenShot = viewSubs.window?.snapshotView(afterScreenUpdates: true)
            screenShot?.tag = 200
        
        viewSubs.addSubview(self)
        
        let blurEffect = UIView()
            blurEffect.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
            blurEffect.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.38)
            blurEffect.tag = 202

            containerView.addSubview(screenShot!)
            containerView.addSubview(blurEffect)

                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: SPRING_DAMPING_ANIMATION_DURATION_SCREENSHOT, initialSpringVelocity: SPRING_VELOCITY_DURATION_SCREENSHOT, options: .curveEaseOut, animations: {
                        screenShot!.layer.masksToBounds = true
                        screenShot!.layer.cornerRadius = 10
                        screenShot!.transform = CGAffineTransform(scaleX: 0.95, y: 0.95);

                }) { (_) in

                    let viewHeight = self.hasNotch ? CGFloat((self.buttonTittle.count * BUTTON_HEIGHT) + SHEET_TITLE_HEIGHT + (LAST_BUTTON_PADDING * 2) + NOTCH_BOTTOM_VALUE) : CGFloat((self.buttonTittle.count * BUTTON_HEIGHT) + SHEET_TITLE_HEIGHT + (LAST_BUTTON_PADDING * 2))

                    let menuContainerView = UIView.init(frame: CGRect(x: 20, y: SCREEN_HEIGHT + 310, width: SCREEN_WIDTH - 40, height: CGFloat((self.buttonTittle.count * BUTTON_HEIGHT) + SHEET_TITLE_HEIGHT + LAST_BUTTON_PADDING)))
                        menuContainerView.backgroundColor = UIColor.clear
                        menuContainerView.layer.cornerRadius = 10
                        menuContainerView.tag = 201
                        self.containerView.addSubview(menuContainerView)
                    
                    let normalButtonContainerView = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 40, height: CGFloat(((self.buttonTittle.count - 1) * BUTTON_HEIGHT) + SHEET_TITLE_HEIGHT + LAST_BUTTON_PADDING)))
                        normalButtonContainerView.backgroundColor = NORMAL_BUTTON_BG_COLOR
                        normalButtonContainerView.layer.cornerRadius = 10
                        menuContainerView.addSubview(normalButtonContainerView)
                    
                    let cancelButtonContainerView = UIView.init(frame: CGRect(x: 0, y: Int(viewHeight) - ((BUTTON_HEIGHT) + (self.hasNotch ? NOTCH_BOTTOM_VALUE : 0)), width: Int(SCREEN_WIDTH - 40), height: BUTTON_HEIGHT))
                        cancelButtonContainerView.backgroundColor = CANCEL_BUTTON_BG_COLOR
                        cancelButtonContainerView.layer.cornerRadius = 10
                        menuContainerView.addSubview(cancelButtonContainerView)
                  
                    
                    let sheetTitleLabel = UILabel.init(frame: CGRect(x: 0, y: 10, width: Int(menuContainerView.frame.width), height: SHEET_TITLE_HEIGHT))
                        sheetTitleLabel.text = self.sheetTitle
                        sheetTitleLabel.textAlignment = .center
                        sheetTitleLabel.font = UIFont.init(name: "HelveticaNeue-Bold", size: 18)
                        sheetTitleLabel.textColor = SHEET_TITLE_TEXT_COLOR
                        menuContainerView.addSubview(sheetTitleLabel)
                    
                    //Add button
                    for i in 0..<self.buttonTittle.count {
                        let button = UIButton.init(type: .system)
                        button.frame = CGRect(x: 0, y: i == self.buttonTittle.count - 1 ? 0 : (BUTTON_HEIGHT * i) + 40 , width: Int(menuContainerView.frame.width), height: BUTTON_HEIGHT)
                        button.setTitle(self.buttonTittle[i], for: .normal)
                        button.setTitleColor(NORMAL_BUTTON_TEXT_COLOR, for: .normal)
                        button.isUserInteractionEnabled = true
                        button.tag = i

                        if(i == self.buttonTittle.count - 1) {
                            button.setTitleColor(CANCEL_BUTTON_TEXT_COLOR, for: .normal)
                            button.titleLabel?.font = UIFont.init(name: "HelveticaNeue-Bold", size: 18)
                            cancelButtonContainerView.addSubview(button)
                        } else {
                            button.addTopBorderWithColor(color: SHEET_BUTTON_TOP_BORDER_COLOR, width: 0.3)
                            normalButtonContainerView.addSubview(button)
                            button.titleLabel?.font = UIFont.init(name: "HelveticaNeue-Regular", size: 20)
                        }
                        button.addTarget(self, action: #selector(self.chosenOption(_:)), for: .touchUpInside)
                       
                    }

                    UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: SPRING_DAMPING_ANIMATION_DURATION_BUTTON_CONTAINER, initialSpringVelocity: SPRING_VELOCITY_DURATION_BUTTON_CONTAINER, options: .curveEaseOut, animations: {

                        menuContainerView.frame = CGRect(x: 20, y: SCREEN_HEIGHT - viewHeight, width: SCREEN_WIDTH - 40, height: viewHeight)

                    }) { (_) in

                    }
                }
    }
   
    
    // MARK: - Button tap
    // MARK: -
    @objc func chosenOption(_ sender : UIButton) {
        block!!(sender.tag)
        hide()
    }
   
    // MARK: - Hide
    // MARK: -
    @objc func hide () {
                
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: SPRING_DAMPING_ANIMATION_DURATION_BUTTON_CONTAINER, initialSpringVelocity: SPRING_VELOCITY_DURATION_BUTTON_CONTAINER, options: .curveEaseOut, animations: {
            
                let screenShot = self.viewWithTag(200)
                    screenShot!.transform = CGAffineTransform(scaleX: 1, y: 1)
            
                let blurView = self.viewWithTag(202)
                    blurView?.backgroundColor = UIColor.clear
            
                let buttonContainerView = self.viewWithTag(201)
                    buttonContainerView!.frame = CGRect(x: 20, y: SCREEN_HEIGHT + 500, width: SCREEN_WIDTH - 40, height: CGFloat(BUTTON_HEIGHT * self.buttonTittle.count) + 40)
            
               
            
        }) { (_) in
            
                self.removeFromSuperview()
        }
    }
    
    // MARK: - Check notch
       // MARK: -
       var hasNotch: Bool {
           
           if #available(iOS 11.0, *) {
               let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
               return bottom > 0
           }
           
           return false
       }
   
}

// MARK: - Button add top border
// MARK: -
extension UIView {
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0,y: 0, width:self.frame.size.width, height:width)
        self.layer.addSublayer(border)
    }
}



