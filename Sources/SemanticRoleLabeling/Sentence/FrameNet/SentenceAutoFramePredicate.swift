//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 23.04.2022.
//

import Foundation
import FrameNet
import AnnotatedSentence

public class SentenceAutoFramePredicate{
    
    var frameNet: FrameNet = FrameNet()
    
    public func autoPredicate(sentence: AnnotatedSentence) -> Bool{
        return true
    }
}
