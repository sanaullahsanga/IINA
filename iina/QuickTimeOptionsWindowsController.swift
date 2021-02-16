//
//  QuickTimeOptionsWindowsController.swift
//  iina
//
//  Created by Ibrahim Baig on 08/10/2020.
//  Copyright © 2020 lhc. All rights reserved.
//
import Cocoa
class QuickTimeOptionsWindowsController: NSWindowController, NSWindowDelegate {
  
  //declaring UI Objects
  @IBOutlet weak var pathurl: NSTextField!
    //for buttons
    @IBOutlet weak var Cancel: NSButton!
    @IBOutlet weak var OK: NSButton!
    //end
    
    //for selecting codec from list
    @IBOutlet weak var videoCodec: NSPopUpButton!
    //end
  
    //selecting quality to enhance or degrade the video
    @IBOutlet weak var videoQuality: NSSlider!
    @IBOutlet weak var speed: NSPopUpButton!
    //end
    
    //get quality from nsSlider and store in NsTextField next to it
    @IBOutlet weak var value: NSTextField!
    //end
    
    //Advance setting
    @IBOutlet weak var ASkeyFrameCheckBox: NSButton!
    @IBOutlet weak var ASframeRecordingCheckBox: NSButton!
    //end
  
    //Limit datarate setting
    @IBOutlet weak var BSlimitDataRateCheckBox: NSButton!
    //end
  
    //Last portion befor ok & cancel button
    @IBOutlet weak var setStartTimeCheckBox: NSButton!
    @IBOutlet weak var RenderAlphaChanelCheckBox: NSButton!
    //end
  
    //displaying progress
    @IBOutlet weak var output: NSTextField!
    //end
    
    //displaying conversion status
    @IBOutlet weak var circularprogress: NSProgressIndicator!
    @IBOutlet weak var horizentalprogressbar: NSProgressIndicator!
    //end
    
  //end
  
  // for storing video url
  var urls: [URL] = []
  //end
  
  /*
  var mpv: VMPVController = {
    let controller = VMPVController()
    controller.mpvInit()
    return controller
  }()*/
    
    //getting video quality from slider and store in NSTextField
    @IBAction func VideoQua(_ sender: NSSlider){
        value.intValue = videoQuality.intValue
    }
    //end
  
  //Proceed button that take all parameters from UI and combine them in array and send them to the FFMPEG Controllers.
    @IBAction func Proceed(_ sender: Any) {
      circularprogress.isHidden=false
      //Getting path from panel for video and store that path in url
      guard !urls.isEmpty else { return}
      var command:[String]=[]
      let url: URL = urls[0];
      //end
      
      //Append input video address to Array command
      command.append("-i")
      command.append(url.absoluteString)
      //end
      //Append video quality to Array command
      
      command.append("-crf")
      //command.append("-qscale")
      let videoqua:String=String(101-value.intValue)
      command.append(videoqua)
      //end
      
      //Appending Advance setting to Array command
        switch ASkeyFrameCheckBox.state {
        case .on:
          //Appending Frame rate
          command.append("-vcodec:v")
          command.append("libx264")
          command.append("-x264opts")
          command.append("keyint=48:min-keyint=48:no-scenecut")
        default:
          output.stringValue = "off"
        }
          //endf
        switch ASframeRecordingCheckBox.state {
        case .on:
          //Appending Reordering
          output.stringValue = "on"
        default:
          output.stringValue = "off"
        }
          //end
      //end
      
      //increase the conversion speed
      let speedo=speed.titleOfSelectedItem!
      command.append("-preset")
      if speedo=="Fast"{
        command.append("ultrafast")
      }
      else if speedo=="Medium"{
        command.append("fast")
      }
      else if speedo=="Slow"{
        command.append("slow")
      }
      
      //end
      
      //Appending BitRate Setting to Array command
        switch BSlimitDataRateCheckBox.state {
        case .on:
          
          //command.append("ultrafast")
        
          command.append("-b:v")
          command.append("400k")
          command.append("-minrate")
          command.append("100k")
          command.append("-maxrate")
          command.append("900k")
          command.append("-bufsize")
          command.append("100M")
        default:
          output.stringValue = "off"
        }
      //end
      
      //setting start time code for output video
        switch setStartTimeCheckBox.state {
        case .on:
          output.stringValue = "on"
        default:
          output.stringValue = "off"
        }
      //end
      
      //setting the alpha channel
        switch RenderAlphaChanelCheckBox.state {
        case .on:
          output.stringValue = "on"
        default:
          output.stringValue = "off"
        }
      //end
      
      /*
      let Tomp4Iphone: URL = url.deletingPathExtension().appendingPathExtension("mp4")
      let command3 = url.absoluteString + " -o " + Tomp4Iphone.absoluteString + " -profile enc-to-iphone"
      var test = mpv.command(rawString: command)*/
      
      //Append output Video Address to Array command
      let codec=videoCodec.titleOfSelectedItem!
      if codec=="Apple ProRes"{
        command.append("-c:v")
        command.append("prores")
        var counter = 0
        var ToConvert:URL = url.deletingPathExtension().appendingPathExtension("mov")
        while FileManager().fileExists(atPath: ToConvert.path) {
          counter += 1
          let oldName:String = url.deletingPathExtension().lastPathComponent
          let updatePath:URL = ToConvert.deletingLastPathComponent()
          let newFileName =  oldName+"(\(counter))"
          let newURL:URL = updatePath.appendingPathComponent(newFileName).appendingPathExtension("mov")
          ToConvert = newURL // Try again...
        }
      command.append(ToConvert.absoluteString)
       
      }
      else if codec=="Animation"{
        command.append("-codec")
        command.append("copy")
        command.append("-c:v")
        command.append("qtrle")
        
        var counter = 0
        var ToConvert:URL = url.deletingPathExtension().appendingPathExtension("mov")
        while FileManager().fileExists(atPath: ToConvert.path) {
          counter += 1
          let oldName:String = url.deletingPathExtension().lastPathComponent
          let updatePath:URL = ToConvert.deletingLastPathComponent()
          let newFileName =  oldName+"(\(counter))"
          let newURL:URL = updatePath.appendingPathComponent(newFileName).appendingPathExtension("mov")
          ToConvert = newURL // Try again...
        }
        
        command.append(ToConvert.absoluteString)
        
      }
      else if codec=="Motion jpg"{
        command.append("-vcodec")
        command.append("mjpeg")
        command.append("-qscale")
        command.append("1")
        command.append("-an")
        
        var counter = 0
        var ToConvert:URL = url.deletingPathExtension().appendingPathExtension("mov")
        while FileManager().fileExists(atPath: ToConvert.path) {
          counter += 1
          let oldName:String = url.deletingPathExtension().lastPathComponent
          let updatePath:URL = ToConvert.deletingLastPathComponent()
          let newFileName =  oldName+"(\(counter))"
          let newURL:URL = updatePath.appendingPathComponent(newFileName).appendingPathExtension("mov")
          ToConvert = newURL // Try again...
        }
        
        command.append(ToConvert.absoluteString)
        
      }
      else if codec=="DNxHR/DNxHD"{
        command.append("-c:v")
        command.append("dnxhd")
        command.append("-profile:v")
        command.append("dnxhr_hq")
        command.append("-vf")
        command.append("scale=1280:720,fps=30000/1001,format=yuv422p")
        command.append("-c:a")
        command.append("pcm_s16le")
       
        var counter = 0
        var ToConvert:URL = url.deletingPathExtension().appendingPathExtension("mov")
        while FileManager().fileExists(atPath: ToConvert.path) {
          counter += 1
          let oldName:String = url.deletingPathExtension().lastPathComponent
          let updatePath:URL = ToConvert.deletingLastPathComponent()
          let newFileName =  oldName+"(\(counter))"
          let newURL:URL = updatePath.appendingPathComponent(newFileName).appendingPathExtension("mov")
          ToConvert = newURL // Try again...
        }
        
        command.append(ToConvert.absoluteString)
        
      }
      else if codec=="None (Uncompressed RGB 8-bit)"{
        
        

        command.append("-pix_fmt")
        command.append("gbrp10le")
        command.append("-acodec")
        command.append("copy")
        
        var counter = 0
        var ToConvert:URL = url.deletingPathExtension().appendingPathExtension("mov")
        while FileManager().fileExists(atPath: ToConvert.path) {
          counter += 1
          let oldName:String = url.deletingPathExtension().lastPathComponent
          let updatePath:URL = ToConvert.deletingLastPathComponent()
          let newFileName =  oldName+"(\(counter))"
          let newURL:URL = updatePath.appendingPathComponent(newFileName).appendingPathExtension("mov")
          ToConvert = newURL // Try again...
        }
        
        command.append(ToConvert.absoluteString)
        
      }
      else{
        
        
        var counter = 0
        var ToConvert:URL = url.deletingPathExtension().appendingPathExtension(codec)
        while FileManager().fileExists(atPath: ToConvert.path) {
          counter += 1
          let oldName:String = url.deletingPathExtension().lastPathComponent
          let updatePath:URL = ToConvert.deletingLastPathComponent()
          let newFileName =  oldName+"(\(counter))"
          let newURL:URL = updatePath.appendingPathComponent(newFileName).appendingPathExtension(codec)
          ToConvert = newURL // Try again...
        }
        
        command.append(ToConvert.absoluteString)
        
      }
      //end
      OK.isEnabled=false
      
      
    
      
      //let test1 = VideoConverter.runTask(["-i", url.absoluteString,"-crf",videoqua, "-vcodec","libx264","-x264-params","keyint=1:scenecut=0","-b","1000k","-minrate","1000k","-maxrate","1000k","-bufsize","1000k" ,TOConvert.absoluteString])
      
            //Executing FFMPEG Command
            command.append("-benchmark")
            let res:String = VideoConverter.runTask(command,self)
            output.stringValue=res
            //end
    }
  
    @IBAction func Reject(_ sender: Any) {
      output.stringValue=""
      OK.isEnabled=true
      OK.isHidden=false
      Cancel.title="Cancel"
      circularprogress.stopAnimation(self)
      circularprogress.isHidden=true
      self.window!.close()
      let _:String = VideoConverter.cancel_conversion(["",""])
    }
}
