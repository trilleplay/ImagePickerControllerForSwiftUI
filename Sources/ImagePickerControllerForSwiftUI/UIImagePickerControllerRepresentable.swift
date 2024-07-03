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
//  File: UIImagePickerControllerRepresentable.swift

import UIKit
import SwiftUI

/// UIViewControllerRepresentable for showing a UIImagePickerController from your SwiftUI application.
public struct UIImagePickerControllerRepresentable: UIViewControllerRepresentable {
    @Binding private var isBeingPresented: Bool
    
    private let picker: UIImagePickerController
    private let backingController: BackingControllerForUIImagePickerControllerRepresentable
    
    /// - Parameters:
    ///    - isBeingPresented: A binding to the boolean that's the source of truth for whether or not the UIImagePickerControllerRepresentable is being presented.
    ///    - sourceType: The source for the media you want to let the user pick.
    ///    - imageCallback: The callback for the image, fires when the user has selected an image.
    public init(isBeingPresented: Binding<Bool>, sourceType: UIImagePickerController.SourceType, imageCallback: @escaping @Sendable (UIImage) async -> ()) {
        self._isBeingPresented = isBeingPresented
        self.picker = UIImagePickerController()
        picker.sourceType = sourceType
        self.backingController = BackingControllerForUIImagePickerControllerRepresentable(imageCallback: imageCallback, isBeingPresented: _isBeingPresented, pickerController: picker)
    }
    
    public func makeUIViewController(context: Context) -> some UIViewController {
        return picker
    }
    
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        if !isBeingPresented {
            uiViewController.dismiss(animated: true)
        }
    }
}
