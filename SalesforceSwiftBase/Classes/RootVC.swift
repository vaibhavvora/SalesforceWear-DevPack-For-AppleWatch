/*
Copyright (c) 2011, salesforce.com, inc. All rights reserved.

Redistribution and use of this software in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:
* Redistributions of source code must retain the above copyright notice, this list of conditions
and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of
conditions and the following disclaimer in the documentation and/or other materials provided
with the distribution.
* Neither the name of salesforce.com, inc. nor the names of its contributors may be used to
endorse or promote products derived from this software without specific prior written
permission of salesforce.com, inc.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/


import UIKit

class RootVC: UIViewController {
    

    let approvalsHandler: ApprovalsHandler = ApprovalsHandler()
    
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var responseButton: UIButton!
   
    
    //  #pragma mark - view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = " Mobile SDK & Salesforce Watch Sample App"
        
        //let userDefaults = NSUserDefaults(suiteName: "group.com.salesforce.SalesforceWatch")
       // let data = "jack".dataUsingEncoding(NSUTF8StringEncoding)
       // userDefaults?.setValue(data, forKeyPath: "user.name")
       // userDefaults?.synchronize()
       // println("syncing app group")
        
        //add observer to listen for requests from WatchKit
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("handleWatchKitNotification:"),
            name: "WatchKitSaysHello",
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("handleWatchKitNotification:"),
            name: "approval-count",
            object: nil)
        
        homeLabel.text = "VC"
        
        
        var sharedInstance = SFRestAPI.sharedInstance()
        
    }
    
    func handleWatchKitNotification(notification: NSNotification) {
        
        println("Got a watch notification")
        homeLabel.text = "Got a notification"
        
        
        if let watchInfo = notification.object as? WatchInfo {
             self.approvalsHandler.watchInfo = watchInfo
        }
      }
    
    @IBAction func responseTapped(sender: AnyObject) {
       
        self.approvalsHandler.getApprovals()
        
   }
    

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}