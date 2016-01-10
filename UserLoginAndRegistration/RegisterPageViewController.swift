//
//  RegisterPageViewController.swift
//  UserLoginAndRegistration
//
//  Created by Hugo Sanchez on 1/2/16.
//  Copyright © 2016 Hugo Sanchez. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonTapped(sender: AnyObject) {
        
        let userEmail = userEmailTextField.text;
        let userPassword = userPasswordTextField.text;
        let retypedPassword = repeatPasswordTextField.text;
        
        // CHECK FOR EMPTY FIELDS
        if(userEmail!.isEmpty || userPassword!.isEmpty || retypedPassword!.isEmpty){
            displayMyAlertMessage("All fields are required!");
            return;
        }
        
        // CHECK IF PASSWORD FIELDS MATCH
        if(userPassword != retypedPassword){
            displayMyAlertMessage("Passwords do not match!")
            return;
        }
        // STORE DATA
        NSUserDefaults.standardUserDefaults().setObject(userEmail, forKey: "userEmail");
        NSUserDefaults.standardUserDefaults().setObject(userPassword, forKey: "userPassword");
        NSUserDefaults.standardUserDefaults().synchronize();
        
        // DISPLAY ALERT MESSAGE WITH COMFORMATION
        let myAlert = UIAlertController(title:"Alert", message:"Registration Successful!", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){ action in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated:true, completion: nil)
        
//        let myUrl = NSURL(string: "/Users/HugoSanchez/Documents/School/CS/Senior_Design/iOS-weather-master/UserLoginAndRegistration/php_scripts/userRegister.php")
//        let request = NSMutableURLRequest(URL: myUrl!)
//        request.HTTPMethod = "POST"
//        
//        let postString = "email=\(userEmail)&password=\(userPassword)"
//        
//        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
//        
//        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
//            data, response, error in
//            
//            if error != nil{
//                print("error=\(error)")
//                return
//            }
//            
////            var err: NSError?
//            
//            do{
//                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
//                if let parseJSON = json{
//                    let resultValue = parseJSON["status"] as? String
//                    print("result: \(resultValue)")
//                    
//                    var isUserRegistered:Bool = false
//                    if(resultValue=="Success") { isUserRegistered = true }
//                    
//                    var messageToDisplay:String = parseJSON["message"] as! String!
//                    if(!isUserRegistered){
//                        messageToDisplay = parseJSON["message"] as! String
//                    }
//                    
//                    dispatch_async(dispatch_get_main_queue(), {
//                        
//                        // DISPLAY ALERT MESSAGE WITH COMFORMATION
//                        let myAlert = UIAlertController(title:"Alert", message:messageToDisplay, preferredStyle: UIAlertControllerStyle.Alert)
//                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){ action in
//                            self.dismissViewControllerAnimated(true, completion: nil)
//                        }
//                        
//                        myAlert.addAction(okAction)
//                        self.presentViewController(myAlert, animated:true, completion: nil)
//                        
//                    });
//                }
//                
//            }catch _{
//                print("THERE WAS IN ERROR!")
//            }
//            
//        
//        
//        
//        }
//        
//        task.resume()

        

    }
    
    func displayMyAlertMessage(userMessage:String){
        let myAlert = UIAlertController(title:"Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil);
        
        myAlert.addAction(okAction);
        self.presentViewController(myAlert, animated:true, completion: nil);
    }
    
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
