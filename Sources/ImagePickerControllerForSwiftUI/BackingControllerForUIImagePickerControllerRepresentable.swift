//
//  MIT License
//
//  Copyright (c) 2024 Tristan Farkas
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
//  File: BackingControllerForUIImagePickerControllerRepresentable.swift

import UIKit
import SwiftUI

internal class BackingControllerForUIImagePickerControllerRepresentable: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private var imageCallback: @Sendable (UIImage) async -> ()
    private let pickerController: UIImagePickerController
    @Binding private var isBeingPresented: Bool
    
    init(imageCallback: @escaping @Sendable (UIImage) async -> (), isBeingPresented: Binding<Bool>, pickerController: UIImagePickerController) {
        self.imageCallback = imageCallback
        self.pickerController = pickerController
        _isBeingPresented = isBeingPresented

        super.init()
        self.pickerController.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        Task {
            await imageCallback((info[UIImagePickerController.InfoKey.originalImage] as! UIImage))
        }
        DispatchQueue.main.async {
            self.pickerController.dismiss(animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        $isBeingPresented.wrappedValue = false
    }
}
