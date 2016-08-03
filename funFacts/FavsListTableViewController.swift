//
//  ChuckFavsTableViewController.swift
//  funFacts
//
//  Created by Parker Donat on 7/19/16.
//  Copyright © 2016 Parker Donat. All rights reserved.
//

import UIKit

class FavsListTableViewController: UITableViewController {
    
    var currentColor = UIColor()
    var isLight = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = currentColor
        tableView.backgroundColor = currentColor
        
        isLightColor()
        
        //        if let alarm = alarmPin {
        //            updateViewWithAlarm(alarm)
        //        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - LOGIC FOR CHANGING ELEMENTS TO WHITE OR BLACK BASED ON RANDOM COLOR
    func isLightColor() -> Bool{
        
        let color = view.backgroundColor
        
        let componentColors = CGColorGetComponents(color!.CGColor)
        
        let colorBrightness: CGFloat = ((componentColors[0] * 299) + (componentColors[1] * 587) + (componentColors[2] * 114)) / 1000
        
        if (colorBrightness >= 0.5) {
            isLight = true
            NSLog("Background color is light \(colorBrightness)")
            // Add black color
            self.tableView.separatorColor = .blackColor()
        } else {
            isLight = false
            NSLog("Background color is dark \(colorBrightness)")
            // Add white color
            self.tableView.separatorColor = .whiteColor()
        }
        
        return isLight
    }
    
    // MARK: - COLOR FOR CELL
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if isLight == false {
            cell.textLabel?.textColor = .whiteColor()
            let image : UIImage = UIImage(named: "star")!
            cell.imageView!.image = image
        } else {
            cell.textLabel?.textColor = .blackColor()
            let image: UIImage = UIImage(named: "star")!
            cell.imageView!.image = image
        }
        cell.backgroundColor = currentColor
        cell.textLabel!.font = UIFont(name:"Adventure", size:20)
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return JokeController.sharedInstance.jokes.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("chuck", forIndexPath: indexPath)
        
        let joke = JokeController.sharedInstance.jokes[indexPath.row]
        cell.textLabel?.text = joke.text
        
        return cell
    }
    
    // Override to support editing the table view.
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            
//            let joke = JokeController.sharedInstance.jokes[indexPath.row]
//            JokeController.sharedInstance.removeJoke(joke)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        }
//    }
    
    func getCurrentBackgroundColor() -> UIColor {
        let currentColor = view.backgroundColor
        return currentColor!
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toFavorite" {
            guard let favedJokeViewController = segue.destinationViewController as? FavedJokeViewController, cell = sender as? UITableViewCell, indexPath = tableView.indexPathForCell(cell) else { return }
            
            let joke = JokeController.sharedInstance.jokes[indexPath.row]
            favedJokeViewController.joke = joke
            favedJokeViewController.currentColor = getCurrentBackgroundColor()
            
        }
    }
}
