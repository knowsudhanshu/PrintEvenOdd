//
//  ViewController.swift
//  PrintEvenOdd
//
//  Created by Sudhanshu Sudhanshu on 28/07/20.
//  Copyright © 2020 Times Internet Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createOddEvenAsyncTasks()
    }
    
    var start: Int = 1
    var end: Int = 100
    
    let globalQueue = DispatchQueue(label: "Global", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .none)
    
    let semaphore = DispatchSemaphore(value: 0)
    
    func createOddEvenAsyncTasks() {
        
        globalQueue.async {
            self.printOdd()
        }
        
        globalQueue.async {
            self.printEven()
        }

    }

    func printOdd()
    {
//        while start <= end {
        for _ in start...end {
            if(self.start % 2 == 1)
            {
                print("\(start)")
                start += 1
                self.semaphore.signal()
            }else {
                self.semaphore.wait()
            }
        }
    }
    
    func printEven()
    {
//        while start <= end {
        for _ in start...end {
            if(self.start % 2 == 0)
            {
                print("\(start)")
                self.start += 1
                self.semaphore.signal()
            }else {
                self.semaphore.wait()
            }
        }
    }
}

