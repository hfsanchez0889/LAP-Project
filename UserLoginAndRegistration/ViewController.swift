//
//  ViewController.swift
//  UserLoginAndRegistration
//
//  Created by Hugo Sanchez on 12/31/15.
//  Copyright © 2015 Hugo Sanchez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    
    @IBOutlet weak var MapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var treeSelected:Bool = true
    var birdSelected:Bool = false
    
    @IBAction func treeButtonTapped(sender: UIBarButtonItem) {
        if treeSelected == true{
            sender.tintColor = UIColor.grayColor()
            treeSelected = false
        }
        else{
            sender.tintColor = UIColor.greenColor()
            treeSelected = true
        }
        
        
    }
    
    @IBAction func birdButtonTapped(sender: UIBarButtonItem) {
        if birdSelected == true{
            sender.tintColor = UIColor.grayColor()
            birdSelected = false
        }
        else{
            sender.tintColor = UIColor.redColor()
            birdSelected = true
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.MapView.showsUserLocation = true
        
//        self.MapView.mapType = MKMapType.Hybrid
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        let center = CLLocationCoordinate2DMake(location!.coordinate.latitude, location!.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.0011, longitudeDelta: 0.0011))
        
        self.MapView.setRegion(region, animated: true)
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Errors: " + error.localizedDescription)
    }
    
    override func viewDidAppear(animated: Bool) {
    
        let userLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
            
        if(!userLoggedIn){
            self.performSegueWithIdentifier("loginView", sender: self)
        }
    }
    

    @IBAction func logoutButtonTapped(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn");
        NSUserDefaults.standardUserDefaults().synchronize();
        
        self.performSegueWithIdentifier("loginView", sender: self)
    }
    
    @IBAction func screenLongPressed(sender: UILongPressGestureRecognizer) {
        // DISPLAY ERROR MESSAGE IF TREE AND BIRD IS NOT SELECTED
        if sender.state != UIGestureRecognizerState.Began{
            return;
        }
        if treeSelected == false && birdSelected == false{
            displayMessage("Select a tree or bird to place")
            return;
        }
        if treeSelected == true {
            let refreshAlert = UIAlertController(title: "LAP", message: "Add tree at this location?", preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "YES", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
                self.MapView.removeAnnotations(self.MapView.annotations)
                print("FIX THE BUG THAT REMOVES ALL ANNOTATIONS WHEN CANCEL IS PRESSED!")
            }))
            
            presentViewController(refreshAlert, animated: true, completion: nil)
        }
        self.setPin(sender)
        
        
        
    }
    func setPin(sender: UILongPressGestureRecognizer){
        let location = sender.locationInView(self.MapView)
        let locCoord = self.MapView.convertPoint(location, toCoordinateFromView: self.MapView)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = locCoord
        annotation.title = "Tree"
        annotation.subtitle = "Location of Tree"
        
//        self.MapView.removeAnnotations(self.MapView.annotations)
        self.MapView.addAnnotation(annotation)
    }
    func displayMessage(message: String){
        let myAlert = UIAlertController(title:"LAP", message:message, preferredStyle: UIAlertControllerStyle.Alert);
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil);
        myAlert.addAction(okAction);
        self.presentViewController(myAlert, animated:true, completion: nil);
    }
    
}

