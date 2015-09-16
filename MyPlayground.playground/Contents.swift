//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func greet(name: String, day: String) -> String
{
    return "Hello \(name), today is \(day)."
}

greet("Jack", "Wednesday");

func average(numbers: Int...) -> Int
{
    var sum = 0
    for number in numbers{
        sum += number;
    }
    return sum/numbers.count
}

average(1,2,3,4)

let numbers = [1,2,3,4,5,6]

numbers.map({
    (number: Int) -> Int in
    if number%2 == 0
    {
        return 0
    } else {
        return number
    }
})