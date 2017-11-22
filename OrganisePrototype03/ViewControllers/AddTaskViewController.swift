//
//  AddTaskViewController.swift
//  OrganisePrototype03
//
//  Created by Thomas Houghton on 18/11/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

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
    
    @IBOutlet weak var WeekDaySegmentControl: UISegmentedControl!
    @IBOutlet weak var WeekSegmentControl: UISegmentedControl!
    @IBOutlet weak var LoginButton: UIButton!
    
    // MARK: - View Setup.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepareViewForAnimation() // Make sure that everything is hidden when the view- loads.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        prepareViewForAnimation() // When the view appears make sure that everything is hidden.
        openAnimation() // Then use the open animation to make it so that everything which was hidden comes back into view.
    }
    
    func prepareViewForAnimation() {
        self.view.backgroundColor = UIColor.clear
        self.subView.alpha = 0
        TaskNameTextField.alpha = 0
        StartTimeLabel.alpha = 0
        StartTimePicker.alpha = 0
        EndTimeLabel.alpha = 0
        EndTimePicker.alpha = 0
        TaskDescriptionTextView.alpha = 0
        LoginButton.alpha = 0
        WeekDaySegmentControl.alpha = 0
        WeekSegmentControl.alpha = 0
    }
    
    func openAnimation() {
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
                            UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: {
                                self.WeekDaySegmentControl.alpha = 1
                                self.WeekSegmentControl.alpha = 1
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
            })
        }
    }
    
    // MARK: Firebase
    func addTask() {
        let currentUserUID = Auth.auth().currentUser!.uid
        let chosenDay = pullDay()
        let chosenWeek = pullWeek()
        let chosenStartTime = pullStartTime(getStart: true)
        let chosenEndTime = pullStartTime(getStart: false)
        
        print("CONTENT!!!")
        print(chosenDay)
        print(chosenWeek)
        print(chosenStartTime)
        print(chosenEndTime)
        
        let databaseData:[String:String] = ["subject": TaskNameTextField.text!, "startTime": chosenStartTime, "endTime": chosenEndTime, "description": TaskDescriptionTextView.text]
        Database.database().reference().child("Users").child(currentUserUID).child("Timetable").child(chosenWeek).child(chosenDay).childByAutoId().setValue(databaseData)
        
    }
    
    // MARK: Pull dates and weeks.
    func pullDay() -> String {
        var returnValue = ""
        if (WeekDaySegmentControl.selectedSegmentIndex == 0) {
            returnValue = "Monday"
        }else if (WeekDaySegmentControl.selectedSegmentIndex == 1) {
            returnValue = "Tuesday"
        }else if (WeekDaySegmentControl.selectedSegmentIndex == 2) {
            returnValue = "Wednesday"
        }else if (WeekDaySegmentControl.selectedSegmentIndex == 3) {
            returnValue = "Thursday"
        }else if (WeekDaySegmentControl.selectedSegmentIndex == 4) {
            returnValue = "Friday"
        }else if (WeekDaySegmentControl.selectedSegmentIndex == 5) {
            returnValue = "Saturday"
        }else if (WeekDaySegmentControl.selectedSegmentIndex == 6) {
            returnValue = "Sunday"
        }
        return returnValue
    }
    
    func pullWeek() -> String {
        var returnValue = ""
        if (WeekSegmentControl.selectedSegmentIndex == 0) {
            returnValue = "WeekA"
        }else if (WeekSegmentControl.selectedSegmentIndex == 1) {
            returnValue = "WeekB"
        }
        return returnValue
    }
    
    func pullStartTime(getStart:Bool) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        var date = ""
        if (getStart != true) {
            date = dateFormatter.string(from: EndTimePicker.date)
        }else {
            date = dateFormatter.string(from: EndTimePicker.date)
        }
        return date
    }
    
    // MARK: Actions
    @IBAction func AddButtonTapped(_ sender: Any) {
        addTask()
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
