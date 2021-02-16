//
//  OutputModuleSettingsController.swift
//  iina
//
//  Created by Ibrahim Baig on 08/10/2020.
//  Copyright © 2020 lhc. All rights reserved.
//

import Cocoa

class OutputModuleSettingsController: NSWindowController, NSWindowDelegate {
  
  override var windowNibName: NSNib.Name {
    return NSNib.Name("OutputModuleSettings")
  }
    
    //demo
    @IBOutlet weak var demo: NSTextFieldCell!
    //Buttons
    @IBOutlet weak var cancel: NSButton!
    @IBOutlet weak var ok: NSButton!
    @IBOutlet weak var VideoOutputFormatButton: NSTabView!
    @IBOutlet weak var AudioOutputFormatButton: NSTabView!
    //Main Top Section
    @IBOutlet weak var QuickTimeFormat: NSPopUpButton!
    @IBOutlet weak var ProjectLink: NSButton!
    @IBOutlet weak var PostRenderAction: NSPopUpButton!
    @IBOutlet weak var IncludeSource: NSButton!
    //Video OutPut Section
    @IBOutlet weak var VideoOutputSection: NSButton!
    @IBOutlet weak var Channels: NSPopUpButton!
    @IBOutlet weak var Depth: NSPopUpButton!
    @IBOutlet weak var Color: NSPopUpButton!
    @IBOutlet weak var starting: NSTextField!
    @IBOutlet weak var useComputerFrame: NSButton!
    //// Resize Section
    @IBOutlet weak var ResizeSection: NSButton!
    @IBOutlet weak var RenderingWidth: NSTextField!
    @IBOutlet weak var RenderingHeight: NSTextField!
    @IBOutlet weak var ResizeWidth: NSTextField!
    @IBOutlet weak var ResizeHeight: NSTextField!
    @IBOutlet weak var LockAspectRatio: NSButton!
    @IBOutlet weak var CustomDropDown: NSPopUpButton!
    @IBOutlet weak var ResizeQualityDropDown: NSPopUpButton!
    //// Crop Section
    @IBOutlet weak var CropSection: NSButton!
    @IBOutlet weak var UseRegionOfInterest: NSButton!
    @IBOutlet weak var FinalSizeWidth: NSTextField!
    @IBOutlet weak var FinalSizeHeight: NSTextField!
    @IBOutlet weak var top: NSTextField!
    @IBOutlet weak var left: NSTextField!
    @IBOutlet weak var bottom: NSTextField!
    @IBOutlet weak var right: NSTextField!
    // Main Bottom
    @IBOutlet weak var AudioOutputSection: NSPopUpButton!
    @IBOutlet weak var KHz: NSPopUpButton!
    @IBOutlet weak var Bit: NSPopUpButton!
    @IBOutlet weak var Stereo: NSPopUpButton!
  
    var urls: [URL] = []
  
    // Methods for Buttons
    @IBAction func videoformataction(_ sender: Any) {
      let delegate=NSApplication.shared.delegate as! AppDelegate
      guard !delegate.option.urls.isEmpty else { return}
      let url: URL = delegate.option.urls[0]
      if url.absoluteString=="" {
        demo.stringValue=url.absoluteString
        //delegate.option.showWindow(self)
      }
      else{
        self.window!.close()
        delegate.option.showWindow(self)
      }
      
    }
    @IBAction func reject(_ sender: Any) {
        self.window!.close()
    }
    @IBAction func proceed(_ sender: Any) {
        let delegate=NSApplication.shared.delegate as! AppDelegate
        guard !urls.isEmpty else { return}
        let url: URL = delegate.option.urls[0];
        demo.stringValue=url.absoluteString
        //Main Top Section
        demo.stringValue=QuickTimeFormat.titleOfSelectedItem!
        demo.stringValue = PostRenderAction.titleOfSelectedItem!
        switch ProjectLink.state {
        case .on:
            demo.stringValue = "on"
        default:
          demo.stringValue = "off"
        }
        switch IncludeSource.state {
        case .on:
            demo.stringValue = "on"
        default:
          demo.stringValue = "off"
        }
        //Video Output section
        demo.stringValue = Channels.titleOfSelectedItem!
        demo.stringValue = Depth.titleOfSelectedItem!
        demo.stringValue = Color.titleOfSelectedItem!
        demo.intValue = starting.intValue
        switch useComputerFrame.state {
        case .on:
            demo.stringValue = "on"
        default:
          demo.stringValue = "off"
        }
        //Resize Section
        demo.intValue = RenderingWidth.intValue
        demo.intValue = RenderingHeight.intValue
        demo.intValue = RenderingWidth.intValue
        demo.intValue = RenderingHeight.intValue
        switch LockAspectRatio.state {
        case .on:
            demo.stringValue = "on"
        default:
          demo.stringValue = "off"
        }
        demo.stringValue=CustomDropDown.titleOfSelectedItem!
        demo.stringValue=ResizeQualityDropDown.titleOfSelectedItem!
        //Crop Section
        switch UseRegionOfInterest.state {
        case .on:
            demo.stringValue = "on"
        default:
          demo.stringValue = "off"
        }
        demo.intValue=FinalSizeWidth.intValue
        demo.intValue=FinalSizeHeight.intValue
        demo.intValue=top.intValue
        demo.intValue=left.intValue
        demo.intValue=bottom.intValue
        demo.intValue=right.intValue
        //Last Section
        demo.stringValue=KHz.titleOfSelectedItem!
        demo.stringValue=Bit.titleOfSelectedItem!
        demo.stringValue=Stereo.titleOfSelectedItem!
        //demo.stringValue=url.absoluteString
    }
}
