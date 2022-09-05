//
//  ViewController.swift
//  WorldFlags
//
//  Created by Ivan Hirsinger on 16.08.2022..
//

import UIKit

class ViewController: UITableViewController {
    
    // Set array to store all images of flags
    var allFlags = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flags of the World"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Get path to the bundle with flags
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let images = try! fm.contentsOfDirectory(atPath: path)
        
        for image in images {
            if image.hasSuffix(".jpg") {
                // Add all found images of flags to allFlags array
                allFlags.append(image)
            }
        }
        // log allFlags array to check if it contains data
        print(allFlags)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allFlags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "flagImageName", for: indexPath)
        
        // Set name of image next to flag image
        if let nameLabel = cell.viewWithTag(100) as? UILabel {
            
            let userAtIndexPath = allFlags[indexPath.row]
            nameLabel.text = userAtIndexPath
        } else {
            
            let nameLabel = UILabel(frame: CGRect(x: 150, y: 18, width: 200, height: 20))
            nameLabel.tag = 100
            let userAtIndexPath = allFlags[indexPath.row]
            nameLabel.text = userAtIndexPath
            cell.addSubview(nameLabel)
        }
        
        // Set image
        let cellImg: UIImageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 100, height: 50))
        cellImg.image = UIImage(named: allFlags[indexPath.row])
        cellImg.contentMode = .scaleAspectFill
        cellImg.clipsToBounds = true
        cellImg.layer.cornerRadius = 20
        cellImg.layer.borderWidth = 1
        cellImg.layer.borderColor = UIColor.lightGray.cgColor

        cell.addSubview(cellImg)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailImage") as? DetailViewController {
            vc.selectedImage = allFlags[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

