//
//  CalculatorModel.swift
//  Calculator-Ios13
//
//  Created by wesam Khallaf on 4/23/20.
//  Copyright © 2020 wesam Khallaf. All rights reserved.
//

import Foundation
class CalculatorModel {
    
    var stack : [String] = []
    var result : Double = 0.0
     
    var allPossibleOperations : [String : (Double , Double?) -> Double] = [
        "*" : { $0 * $1!} ,
        "/" : { $0 / $1!} ,
        "+" : { $0 + $1!} ,
        "-" : { $0 - $1!} ,
        "sin" : { (m , nil) in sin(m * Double.pi / 180)},
        "cos" : { (m , nil) in cos(m * Double.pi / 180)},
        "tan" : { (m , nil) in tan(m * Double.pi / 180)}
    ]
    
    
    
    
    func Scan()  {
        let indexesOfOpeningParantheses = stack.indexes(of: "(")
        let indexesOfClosingParantheses = stack.indexes(of: ")")
        let tempOpeningIndex = indexesOfOpeningParantheses.last
        if tempOpeningIndex != nil {
            let tempClosingElemrnt =  indexesOfClosingParantheses.filter ({$0 > tempOpeningIndex!}).first
            if (tempClosingElemrnt != nil) {
                var tempArray : [String] = []
                for i in tempOpeningIndex! + 1 ... tempClosingElemrnt! - 1 {
                    tempArray.append(stack[i])
                    
                }
                print ("tempArray is ")
                print (tempArray)
                
                for j in stride(from: tempClosingElemrnt!, through: tempOpeningIndex!, by: -1) {
                    stack.remove(at: j)
                }
                
                print ("new stack is ")
                
                stack.insert(calcStackresult(Stack: &tempArray), at: tempOpeningIndex!)
                print (stack)
                Scan()
            }
                
            else {
                print ("syntax error")
                return
            }
            
            
            //print (indexesOfOpeningParantheses)
           // print (indexesOfClosingParantheses)
          //  print (tempOpeningIndex!)
          //  print (tempClosingElemrnt!)
        }
        else {
            // tempindexOpening = nil  i.e program has no brackets
           // print ("unary operator indexes :")
           // print (stack.indexes(of: ["sin" , "cos" , "tan"]))
            print(stack)
            var tempStack = stack
            result = Double(calcStackresult(Stack: &tempStack))!
            
            
            print("result is \(result)")
            return
            
        }
        
        
        //return stack
    }
    
    func calcStackresult ( Stack tempStackArray:inout [String]) -> String {
       
        
        
        if tempStackArray.count == 1
        {
            return tempStackArray[0]
        }
        // first process unary operation
        tempStackArray = ProcessAllUnaryOperation(temp: &tempStackArray)
        tempStackArray = ProcessAllBinaryOperations(temp: &tempStackArray)
        
         
            
        
       return tempStackArray[0]
    }
    
    func ProcessAllUnaryOperation ( temp tempStackArray:inout [String]) -> [String] {
        
        
        var myUnaryFunc : (Double , Double?)->Double
    let indexesOfUnaryOperator = tempStackArray.indexes(of: ["sin" , "cos" , "tan"])
    if indexesOfUnaryOperator.count > 0
    {
        var value : Double = 0.0
        for i in indexesOfUnaryOperator
        {
            myUnaryFunc = allPossibleOperations[tempStackArray[i]]!
            value = myUnaryFunc(Double(tempStackArray[i-1])! , nil)
            // value = self.allPossibleOperations[tempStackArray[i]]!(
           // print ("value is ")
           // print (value)
            tempStackArray.remove(at: i)
            tempStackArray.remove(at: i-1)
            tempStackArray.insert(String(value), at: i-1)
            
        }
        
        
    }
        
        return tempStackArray
   }
    
    func ProcessAllBinaryOperations ( temp tempStackArray:inout [String]) -> [String]
    {
         
       // var indexesOfBinaryOperator :[Int] = []
        print (tempStackArray)
            var myUnaryFunc : (Double , Double?)->Double
             
        var indexesOfBinaryOperator = tempStackArray.indexes(of: ["+" , "-" , "*" ,"/"])
        
         
             if indexesOfBinaryOperator.count > 0 {
             
             var valueBinary : Double = 0.0
                for i in indexesOfBinaryOperator.reversed()
                {
                     myUnaryFunc = allPossibleOperations[tempStackArray[i]]!
                    valueBinary = myUnaryFunc(Double(tempStackArray[i-1])! , Double(tempStackArray[i+1]))
                  //   print ("value is ")
                   //  print (valueBinary)
                    
                     tempStackArray.remove(at: i+1)
                     tempStackArray.remove(at: i)
                     tempStackArray.remove(at: i-1)
                     tempStackArray.insert(String(valueBinary), at: i-1)
                    
                 }
                

         }
         
         
         return tempStackArray
    }
}
    
extension Array where Element: Equatable {
    func indexes(of element: Element) -> [Int] {
        return self.enumerated().filter({ element == $0.element }).map({ $0.offset })
    }
    
    
    func indexes(of elements: [Element]) -> [Int] {
        var indexes : [Int] = []
        for element in elements {
            indexes = indexes + self.indexes(of: element)
        }
        return indexes
    }
}


