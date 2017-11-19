//
//  AddTaskViewController.swift
//  OrganisePrototype03
//
//  Created by Thomas Houghton on 18/11/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var AddTaskLabel: UILabel!
    @IBOutlet weak var TaskNameTextField: UITextField!

    // Part of time section 01
    @IBOutlet weak var StartTimeLabel: UILabel!
    @IBOutlet weak var StartTimePicker: UIDatePicker!
    
    // Part of time section 02
    @IBOutlet weak var EndTimeLabel: UILabel!
    @IBOutlet weak var EndTimePicker: UIDatePicker!

    @IBOutlet weak var TaskDescriptionTextView: UITextView!
    @IBOutlet weak var LoginButton: UIButton!
    
    // MARK: - View Setup.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.clear
        self.subView.alpha = 0
        TaskNameTextField.alpha = 0
        StartTimeLabel.alpha = 0
        StartTimePicker.alpha = 0
        EndTimeLabel.alpha = 0
        TaskDescriptionTextView.alpha = 0
        LoginButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.view.backgroundColor = UIColor.clear
        self.subView.alpha = 0
        TaskNameTextField.alpha = 0
        StartTimeLabel.alpha = 0
        StartTimePicker.alpha = 0
        EndTimeLabel.alpha = 0
        EndTimePicker.alpha = 0
        TaskDescriptionTextView.alpha = 0
        LoginButton.alpha = 0
        setupView()
    }
    
    func setupView() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: {
            self.view.backgroundColor = UIColor.init(red: 16/255, green: 156/255, blue: 146/255, alpha: 1)
            self.subView.alpha = 1
        }) { (true) in
            UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: {
                self.TaskNameTextField.alpha = 1
            }, completion: { (true) in
                UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: {
                    self.StartTimeLabel.alpha = 1
                    self.StartTimePicker.alpha = 1
                    self.EndTimeLabel.alpha = 1
                    self.EndTimePicker.alpha = 1
                    
                    self.StartTimePicker.backgroundColor = UIColor.init(red: 77/255, green: 214/255, blue: 177/255, alpha: 1)
                    self.EndTimePicker.backgroundColor = UIColor.init(red: 77/255, green: 214/255, blue: 177/255, alpha: 1)
                    
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: {
                        self.TaskDescriptionTextView.alpha = 1
                    }, completion: { (true) in
                        UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: {
                            self.LoginButton.alpha = 1
                        }, completion: { (true) in
                            UIView.animate(withDuration: 1.5, delay: 0, options: .allowUserInteraction, animations: {
                                self.TaskNameTextField.layer.cornerRadius = 10
                                
                                // Start Time Label
                                let StartTimeLabelRect = CAShapeLayer()
                                StartTimeLabelRect.bounds = self.StartTimeLabel.frame
                                StartTimeLabelRect.position = self.StartTimeLabel.center
                                StartTimeLabelRect.path = UIBezierPath(roundedRect: self.StartTimeLabel.bounds, byRoundingCorners: UIRectCorner.topLeft, cornerRadii: CGSize(width: 10, height: 10)).cgPath
                                self.StartTimeLabel.layer.mask = StartTimeLabelRect
                                
                                // End Time Label
                                let EndTimeLabelRect = CAShapeLayer()
                                EndTimeLabelRect.bounds = self.EndTimeLabel.frame
                                EndTimeLabelRect.position = self.EndTimeLabel.center
                                EndTimeLabelRect.path = UIBezierPath(roundedRect: self.StartTimeLabel.bounds, byRoundingCorners: UIRectCorner.topRight, cornerRadii: CGSize(width: 10, height: 10)).cgPath
                                self.EndTimeLabel.layer.mask = EndTimeLabelRect
                                
                                // Start Time Picker View ISSUE !!!!!!!
                                let StartTimePickerRect = CAShapeLayer()
                                StartTimePickerRect.bounds = self.StartTimePicker.frame
                                StartTimePickerRect.position = self.StartTimePicker.center
                                StartTimePickerRect.path = UIBezierPath(roundedRect: self.EndTimePicker.bounds, byRoundingCorners: UIRectCorner.bottomLeft, cornerRadii: CGSize(width: 10, height: 10)).cgPath
                                self.StartTimePicker.layer.mask = StartTimePickerRect
                                
                                // End Time Picker View
                                let EndTimeRect = CAShapeLayer()
                                EndTimeRect.bounds = self.EndTimePicker.frame
                                EndTimeRect.position = self.EndTimePicker.center
                                EndTimeRect.path = UIBezierPath(roundedRect: self.EndTimePicker.bounds, byRoundingCorners: UIRectCorner.bottomRight, cornerRadii: CGSize(width: 10, height: 10)).cgPath
                                self.EndTimePicker.layer.mask = EndTimeRect
    
                                self.TaskDescriptionTextView.layer.cornerRadius = 10
                                self.LoginButton.layer.cornerRadius = 10
                                self.subView.layer.cornerRadius = 10
                            }, completion: { (true) in
                                print("Animation Complete")
                            })
                        })
                    })
                })
            })
        }
    }
    
    func openAnimation() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
