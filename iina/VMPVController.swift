//
//  VMPVController.swift
//  iina
//
//  Created by Ibrahim Baig on 12/10/2020.
//  Copyright © 2020 lhc. All rights reserved.
//

import Foundation

class VMPVController: NSObject {
  // The mpv_handle
  var mpv: OpaquePointer!
  var mpvRenderContext: OpaquePointer?

  var mpvClientName: UnsafePointer<CChar>!
  var mpvVersion: String!
  
  
  func mpvInit() {
    // Create a new mpv instance and an associated client API handle to control the mpv instance.
    mpv = mpv_create()

    // Get the name of this client handle.
    mpvClientName = mpv_client_name(mpv)

  
    


    
//    // Set a custom function that should be called when there are new events.
//    mpv_set_wakeup_callback(self.mpv, { (ctx) in
//      let mpvController = unsafeBitCast(ctx, to: VMPVController.self)
//      mpvController.readEvents()
//      }, mutableRawPointerOf(obj: self))
    
    
    // get version
    mpvVersion = getString(MPVProperty.mpvVersion)
  }
  
  func command(rawString: String) -> Int32 {
    return mpv_command_string(mpv, rawString)
  }

  func getString(_ name: String) -> String? {
    let cstr = mpv_get_property_string(mpv, name)
    let str: String? = cstr == nil ? nil : String(cString: cstr!)
    mpv_free(cstr)
    return str
  }
  
  
}
