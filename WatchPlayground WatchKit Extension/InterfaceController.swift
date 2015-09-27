//
//  InterfaceController.swift
//  WatchPlayground WatchKit Extension
//
//  Created by Manu Kanthan on 9/26/15.
//  Copyright © 2015 Manu Kanthan. All rights reserved.
//

import WatchKit
import Foundation
import CoreMotion

class InterfaceController: WKInterfaceController {
    lazy var motionManager: CMMotionManager = {
        let motion = CMMotionManager()
        motion.accelerometerUpdateInterval = 0.1 // means update every 1 / 10 second
        return motion
    }()



    @IBOutlet var xValLabel : WKInterfaceLabel!
    @IBOutlet var yValLabel : WKInterfaceLabel!
    @IBOutlet var zValLabel : WKInterfaceLabel!
    @IBOutlet var accelerometerAvailable : WKInterfaceLabel!
    @IBOutlet var doCoolStuff : WKInterfaceButton!
    @IBOutlet var stopCoolStuff : WKInterfaceButton!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        if (motionManager.accelerometerAvailable) {
            self.accelerometerAvailable.setText("Accel:Avail")
        } else {
            self.accelerometerAvailable.setText("Accel:Unavail")
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func doCoolStuffTapped(sender : AnyObject) {
        doCoolStuff.setHidden(true)
        stopCoolStuff.setHidden(false)

        self.motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue(), withHandler: {
            (data, error) in
            let xval = data?.acceleration.x
            let yval = data?.acceleration.y
            let zval = data?.acceleration.z

            self.xValLabel.setText("X: " + String(format: "%.2f", xval!))
            self.yValLabel.setText("Y: " + String(format: "%.2f", yval!))
            self.zValLabel.setText("Z: " + String(format: "%.2f", zval!))
        })
    }

    @IBAction func stopCoolStuffTapped(sender : AnyObject) {
        doCoolStuff.setHidden(false)
        stopCoolStuff.setHidden(true)

        self.motionManager.stopAccelerometerUpdates()
        self.xValLabel.setText("X: 0")
        self.yValLabel.setText("Y: 0")
        self.zValLabel.setText("Z: 0")
    }

}
