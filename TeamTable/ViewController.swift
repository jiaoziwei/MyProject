//
//  ViewController.swift
//  TeamTable
//
//  Created by 陈嘉伟 on 16/1/27.
//  Copyright © 2016年 陈嘉伟. All rights reserved.
//

import UIKit

class ViewController: UITableViewController,UISearchBarDelegate {

    @IBOutlet weak var MySearchBar: UISearchBar!
    var teams:NSArray!
    var teamlist:NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sourcePath = NSBundle.mainBundle().pathForResource("team", ofType: "plist")
        teams = NSArray(contentsOfFile: sourcePath!)
        MySearchBar.showsScopeBar = false
        MySearchBar.sizeToFit()
        MySearchBar.delegate = self
        searchTextByFliter("", scope: -1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamlist.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell",forIndexPath: indexPath) as! MyTableCell
        //cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "subtitleCell")
        let team = teamlist[indexPath.row] as? NSDictionary
        cell.label.text = team!["name"] as? String
        let imagefile = team!["image"] as! String
        cell.TeamImage.image = UIImage(named:imagefile)
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let team = teams[indexPath.row] as! NSDictionary
        let teamName = team["name"] as! String
        print(teamName)
        
    }
    
    func searchTextByFliter(searchText:NSString,scope:Int){
        
        var tempArray:NSArray!
        
        if(searchText.length == 0)
        {
          teamlist = NSMutableArray(array: teams)
          return
        }
        if (scope == 1)
        {
          let scopePredicate = NSPredicate(format: "SELF.image contains[c]%@", searchText)
          tempArray = teams.filteredArrayUsingPredicate(scopePredicate)
          teamlist = NSMutableArray(array: tempArray)
        }else if(scope == 0)
        {
          let scopePredicate = NSPredicate(format: "SELF.name contains[c]%@", searchText)
          tempArray = teams.filteredArrayUsingPredicate(scopePredicate)
          teamlist = NSMutableArray(array: tempArray)
        }else
        {
          teamlist = NSMutableArray(array: teams)
        }
    }
    //SearchBarDelegate的方法实现
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        MySearchBar.showsScopeBar = true
        MySearchBar.sizeToFit()
        return true
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        MySearchBar.showsScopeBar = false
        MySearchBar.resignFirstResponder()
        MySearchBar.sizeToFit()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchTextByFliter("", scope: -1)
        MySearchBar.showsScopeBar = false
        MySearchBar.resignFirstResponder()
        MySearchBar.sizeToFit()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchTextByFliter(searchText, scope: MySearchBar.selectedScopeButtonIndex)
        tableView.reloadData()
        print(searchText)
    }
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        searchTextByFliter(MySearchBar.text!, scope: selectedScope)
        tableView.reloadData()
    }
}

