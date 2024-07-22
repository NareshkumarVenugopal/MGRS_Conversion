//
//  ViewController.swift
//  mgrs
//
//  Created by Sathishkumar Thulasiraman on 06/03/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textfiels: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let mgrsString = getMGRSString(lat: -32.84267, lon: 147.77905)
        print(mgrsString)
        textfiels.text = mgrsString
    }
    
    func getMGRSString(lat: Double, lon: Double) -> String {
        if lat < -80 { return "Too far South" }
        if lat > 84 { return "Too far North" }
        
        let c = 1 + Int(floor((lon + 180) / 6))
        let e = Double(c * 6 - 183)
        let k = lat * .pi / 180
        let l = lon * .pi / 180
        let m = e * .pi / 180
        let n = cos(k)
        let o = 0.006739496819936062 * pow(n, 2)
        let p = 40680631590769.0 / (6356752.314 * sqrt(1 + o))
        let q = tan(k)
        let r = q * q
        let t = l - m
        let u = 1.0 - r + o
        let v = 5.0 - r + 9 * o + 4.0 * (o * o)
        let w = 5.0 - 18.0 * r + (r * r) + 14.0 * o - 58.0 * r * o
        let x = 61.0 - 58.0 * r + (r * r) + 270.0 * o - 330.0 * r * o
        let y = 61.0 - 479.0 * r + 179.0 * (r * r) - (r * r * r)
        let z = 1385.0 - 3111.0 * r + 543.0 * (r * r) - (r * r * r)
        
        var aa = p * n * t + (p / 6.0 * pow(n, 3) * u * pow(t, 3))
        + (p / 120.0 * pow(n, 5) * w * pow(t, 5))
        + (p / 5040.0 * pow(n, 7) * y * pow(t, 7))
        var ab = 6367449.14570093 * (k - (0.00251882794504 * sin(2 * k))
                                     + (0.00000264354112 * sin(4 * k)) - (0.00000000345262 * sin(6 * k))
                                     + (0.000000000004892 * sin(8 * k)))
        + (q / 2.0 * p * pow(n, 2) * pow(t, 2))
        + (q / 24.0 * p * pow(n, 4) * v * pow(t, 4))
        + (q / 720.0 * p * pow(n, 6) * x * pow(t, 6))
        + (q / 40320.0 * p * pow(n, 8) * z * pow(t, 8))
        
        aa = aa * 0.9996 + 500000.0
        ab = ab * 0.9996
        if ab < 0.0 { ab += 10000000.0 }
        
        let index = String.Index(utf16Offset: Int(floor(lat / 8 + 10)), in: "CDEFGHJKLMNPQRSTUVWXX")
        let ad = "CDEFGHJKLMNPQRSTUVWXX"[index]
        
        
        let ae = Int(floor(aa / 100000))
        let ArrIndex = (c - 1) % 3
        let array = ["ABCDEFGH", "JKLMNPQR", "STUVWXYZ"]
        let str = array[ArrIndex]
        let index1 = String.Index(utf16Offset: (ae - 1), in: str)
        let af = array[ArrIndex][index1]
        
        let ag = Int(floor(ab / 100000)) % 20
        let ArrIndex1 = (c - 1) % 2
        let array1 = ["ABCDEFGHJKLMNPQRSTUV", "FGHJKLMNPQRSTUVABCDE"]
        let str2 = array1[ArrIndex1]
        let index2 = String.Index(utf16Offset: (ag), in: str2)
        let ah = array1[ArrIndex1][index2]
        
        let aaString = String(format: "%.0f", aa.truncatingRemainder(dividingBy: 100000))
        let abString = String(format: "%.0f", ab.truncatingRemainder(dividingBy: 100000))
        //44PMV1421531465
        return "\(c)\(ad) \(af)\(ah) \(aaString) \(abString)"
    }
    
    func pad(_ val: Double) -> String {
        let intValue = Int(val)
        if val < 10 { return "0000\(intValue)" }
        else if val < 100 { return "000\(intValue)" }
        else if val < 1000 { return "00\(intValue)" }
        else if val < 10000 { return "0\(intValue)" }
        return "\(intValue)"
    }
}

