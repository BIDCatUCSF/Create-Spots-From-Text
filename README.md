# Create-Spots-From-Text
Description:

    Creates an Imaris spots object from x,y,z-positions in a CSV file. The spots size is determined by the user.
    Positions must be within the image boundary, for example, no negative values. Additionally, remove all headers and whitespace from CSV     file.The CSV document should only contain x,y,z-position data.


  Dependencies:
  
    Matlab 2015 or newer  
    Imaris     
  
  Installation:   
  
    Copy the 'createSpotsFromCSV.m' file into your Imaris XT Matlab directory.           
    Select the 'Tools' Icon in Imaris.     
    From the list of extentions choose 'Create Spots from CSV.'     
    From the pop up dialog window, input the desired spot size.    
    Click 'Ok'    
