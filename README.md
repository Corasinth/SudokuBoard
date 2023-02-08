# SudokuBoard

## Description 

SudokuBoard is a (Windows only) AutoHotKey script designed for improving the computer sudoku experiance. It allows you to quickly and comfortably navigate the sudoku board, enter numbers, and delete them. What makes SudokuBoard truly useful is its ability to let you navigate to any cell with two key presses.

Here's how it works:
The script creates three layers you can easily swap between, `Entry`, `Navigation`, and `Set-Coordinates`. Each layer allows you to use the WASD/arrow keys to navigate the sudoku grid as you might expect, including wrapping around when reaching the start or end of a row or column. Additionally, each layer has additional features.

In the `Entry` layer you can use the numpad or the 3x3 UIO/JKL/MCommaPeriod block of keys to enter numbers into the puzzle, granting a numpad-like functionality to those who don't have a full sized keyboard.

The `Navigation` layer lets you identify a specific spell to auto-navigate to with the numpad or that 3x3 block. The first key press will send you to one of the larger 9 'boxes' while the second sends you to a cell within that box. The keys match up to the region you want to navigate to. For example, pressing the top-left key of the numpad or 3x3 block will send you to the top-left box, and then pressing the bottom-right key will send you to the bottom-right cell of that box. 

This allows almost instant navigation across the grid without ever moving your hands off the keyboard.

Finally, the `Set-Coordinates` layer lets you tell the program which cell you started out in so it can keep track of your position.

SudokuBoard also features two modes, a Cursor Mode and a Mouse Mode. Why? 

Because not all sudoku programs/sites are created equally. Some don't let you use your arrow keys to navigate between cells, while others are inconsistent about how many presses of an arrow key it takes to get from one side of the grid to the other.

Mouse Mode lets you bypass these issues by calibrating the mouse for a specific puzzle, and then letting the mouse take you where you need to go. When you use mouse mode, you don't need to set your coordinates when you start a puzzle and you can use SudokuBoard even on sites that have inconsistent interfaces, though it does require calibration.

For the full explanation of how to install, configure, and use this program continue reading, and I hope you enjoy SudokuBoard!

--- 
## Table of Contents


* [Installation](#installation)
* [Configuration](#configuration)
    * [Settings](#settings)
    * [Mouse Calibration](#mouse-calibration)
* [Usage](#usage)
    * [Controls](#controls)
    * [Navigation](#navigation)
    * [Mouse Mode](#mouse-mode)
* [Features](#features)
    * [Coordinate Systems](#coordinate-systems)
    * [Mouse Mode](#mouse-mode)
* [Contributing](#contributing)
* [License](#license)


--- 
## Installation

To use this program, you must first install AutoHotKey V2, which [you can do here](https://www.autohotkey.com/v2/).

Then you can download this script using the green 'Code' button, selecting 'Download as Zip', and extracting the files. 

With AHK installed you can run the script by double clicking `SudokuBoard.ahk`.

--- 
## Configuration 

SudokuBoard has several configuration options to let you customize your experience. These are mostly located and controlled via the `settings.ini` file, but this section also discusses how to calibrate the mouse.

### Settings 

The settings here can be edited by opening the `settings.ini` file in Notepad, changing the settings, and saving the file. The changes take place once you start or reload the script.

`tooltipOn`, `xCoordinate`, and `yCoordinate` allow you to set the details of the tooltip that displays the controls, current layer, and whether or not mouse mode is engaged. Setting `tooltipOn` to 0 turns the tooltip off and setting it to 1 turns it back on. The `xCoordinate` and `yCoordinate` settings let you specify where which pixel on the screen the tooltip should appear (so on a 1920x1080 screen, setting those coordinates would have the tooltip appear in the lower left).

`sqrSize` is a setting that, in future iterations, will let you use SudokuBoard for larger and smaller puzzles with dimensions that are perfect squares. Best not to mention it for now.

`mouseMode` lets you start the script in Mouse Mode by default. You can of course toggle Mouse Mode while the script is running, but this setting lets you make Mouse Mode the default. 

The next four settings hold the data for the mouse calibration. You can read more about in [Features](#features). The values saved here work for one puzzle in the position you calibrated the mouse in. If you want to recalibrate for a diffrent position or puzzle you can comment out these four values by preceding them with a comma, like so:
```
; startPositionX =0
; startPositionY=0
; xOffset =0
; yOffset =0
``` 

Then you can do another calibration to generate a new set of values, and easily swap between the two by only leaving uncommented the set you wish to use. 

### Mouse Calibration 

Mouse calibration can be triggered by pressing `Control + Alt + Shift + c`, or by right-clicking the tray icon and selecting the appropriate option.

Instructions for calibration will then pop up. Once you read these and close the dialogue box, the next four left clicks/Enter key presses will record the appropriate information.

You'll need to click the top-left corner of the sudoku grid, the top-right corner, the bottom-left corner, and lastly the bottom-right corner, in that order. You can move the mouse, or use the arrow/WASD keys to move the mouse one pixel. It isn't necessary to be pixel-perfect, but you should try to be accurate. If you have issues, you can always recalibrate.

After calibration, you'll have the option to save the calibration, save the calibration but start a new calibration, or discard the data and exit. You can also check a box to save the relevant data as the default (directly to the `settings.ini` file).

--- 
## Usage 

The following three sections detail how exactly to use SudokuBoard. This will cover the keyboard controls, how exactly to use SudokuBoard's navigation method in the best way, and how and why to use mouse mode.

### Controls 

These are the controls that are active in each layer. In each layer, the arrow/WASD keys can be used to move one cell in any direction. However, in both the `Navigation` and `Set-Coordinates` layer, using these single-cell navigation keys will automatically send you back to the `Entry` layer. This is to make it easier to swap between the layers, and make the experiance of using the script at high speed more comfortable. 

Additionally, in each layer you can use the E key to backspace the current cell, though this does not send you back to the `Entry` layer since sometimes you just visit a cell to delete its contents and then move on.

It's also worth going over the specific ways you can enter and exit each layer.

The script starts in `Entry`. From there, pressing either CapsLock or the Numpad Plus will send you to `Navigation`. 

In `Navigation` pressing CapsLock or Numpad Plus will send you back to `Entry`.

From either of these layers you can press F or Numpad 0 to go to the `Set-Coordinates` layer. In `Set-Coordinates`, CapsLock/Numpad Plus will send you to `Navigation` while F/Numpad 0 will send you to `Entry`. However, these last controls will be rarely used, since once coordinates have been successfully set, you'll be sent directly back to `Entry` automatically.

Finally, from any layer you can press `Control + Alt + Shift + Letter` to activate a variety of effects. 

Replacing `Letter` with `Q` will quit the program. `S` will suspend the program, disabling all the key commands except for these combos. `C` will start the mouse calibration, and `M` will toggle mouse mode. 

Don't worry if the `Navigation` and `Set-Coordinates` controls don't totally make sense, the [Navigation section](#navigation) will explain.

#### Entry 

`w/Up Arrow`: Move up one cell.  
`s/Down Arrow`: Move down one cell.  
`a/Left Arrow`: Move left one cell.   
`d/Right Arrow`: Move right one cell.  
`e`: Backspace.   
`u/Numpad 1`: Enter 1.  
`i/Numpad 2`: Enter 2.  
`o/Numpad 3`: Enter 3.  
`j/Numpad 4`: Enter 4.  
`k/Numpad 5`: Enter 5.   
`l/Numpad 6`: Enter 6.  
`m/Numpad 7`: Enter 7.  
`./Numpad 8`: Enter 8.  
`,/Numpad 9`: Enter 9.  
`CapsLock/Numpad +`: Go to `Navigation` layer.  
`f/Numpad 0`: Go to `Set-Coordinates` layer (except in mouse mode).  

#### Navigation 

`w/Up Arrow`: Move up one cell, and return to `Entry`.  
`s/Down Arrow`: Move down one cell, and return to `Entry`.  
`a/Left Arrow`: Move left one cell, and return to `Entry`.   
`d/Right Arrow`: Move right one cell, and return to `Entry`.  
`e`: Backspace.   
`u/Numpad 7`: Enter top-left.  
`i/Numpad 8`: Enter top-center.   
`o/Numpad 9`: Enter top-right.   
`j/Numpad 4`: Enter middle-left.   
`k/Numpad 5`: Enter middle-center.   
`l/Numpad 6`: Enter middle-right.   
`m/Numpad 1`: Enter bottom-left.  
`./Numpad 2`: Enter bottom-center.   
`,/Numpad 3`: Enter bottom-right.   
`CapsLock/Numpad +`: Go to `Entry` layer.  
`f/Numpad 0`: Go to `Set-Coordinates` layer (except in mouse mode).  

#### Set-Coordinates

`w/Up Arrow`: Move up one cell, and return to `Entry`.  
`s/Down Arrow`: Move down one cell, and return to `Entry`.  
`a/Left Arrow`: Move left one cell, and return to `Entry`.   
`d/Right Arrow`: Move right one cell, and return to `Entry`.  
`e`: Backspace.   
`u/Numpad 7`: Enter top-left. Second press returns to `Entry`.  
`i/Numpad 8`: Enter top-center. Second press returns to `Entry`.   
`o/Numpad 9`: Enter top-right. Second press returns to `Entry`.  
`j/Numpad 4`: Enter middle-left. Second press returns to `Entry`.  
`k/Numpad 5`: Enter middle-center. Second press returns to `Entry`.  
`l/Numpad 6`: Enter middle-right. Second press returns to `Entry`.  
`m/Numpad 1`: Enter bottom-left.Second press returns to `Entry`.  
`./Numpad 2`: Enter bottom-center. Second press returns to `Entry`.  
`,/Numpad 3`: Enter bottom-right. Second press returns to `Entry`.  
`CapsLock/Numpad +`: Go to `Navigation` layer.  
`f/Numpad 0`: Go to `Entry` layer.  
  
### Navigation 

Navigation is designed to be easy to learn and deeply intuitive. That said, it might be a little confusing in text. 

A sudoku grid can be divided into 9 larger boxes, each of which contains 9 cells. Coincidentally, both the numpad and the remapped block of letter keys are also a 3x3 block containing 9 keys.

Thus, any cell in the sudoku grid can be identified by selecting one of the boxes, then one of the cells, using the physical placement of the 3x3 block.

For example, you might press the top-right key (which is U/Numpad 7), and select this box:

![bigCell](./assets/readMeImages/bigExample1.png)

And then press the bottom-left key (which is M/Numpad 1) to select this cell within the selected box:

![littleCell](./assets/readMeImages/littleExample7.png)

This method is how the navigation layer works, as well as how you set the coordinates when using cursor mode. It is critical to set the coordinates before using any of the controls. If the controls are not working as expected, it is likely because the coordinates have not been set properly, or have gotten out of tune. Selecting a cell with the mouse, manually as it where, isn't tracked by the program, so if you do that it is important te set the coordinates again.

The final note on navigation is that you need not press both the key to identify the box and the key to identify the cell. Once you press the first of the pair, the program will auto navigate to the box you have selected, at the same cell. So if you have selected the middle-center cell, and move to a new box, the middle-center cell of that box will be selected. You can then choose to select the exact cell you want, or navigate with the WASD/arrow keys. Leaving the `Navigation` layer resets the count, so that on returning your next key press will select the boxes again. 

### Mouse Mode 

Mouse mode, as mentioned previously, requires prior calibration. It is best used for sites that don't let you select every cell, or sometimes require more than one press of the usual arrow keys to cross a cell (looking at you [websudoku.com](http://www.websudoku.com/)). 

Most importantly, once mouse calibration is completed you do not need to use the `Set-Coordinates` layer, and it is disabled in mouse mode. 

Otherwise, you can use mouse mode with just the same controls as the default cursor mode.

--- 
## Features

This section is more for those interested in some of the behind-the-scenes details of how this script works. 

### Coordinate Systems 

There are two coordinate systems that one might use for picking out a particular cell in a sudoku grid. One, as described, is what I call box notation that follows this format: (box, cell). You can assign a number to each box like so:  
![bigGrid](./assets/readMeImages/bigGrid.png)

And a number to each of the smaller cells like so:  
![littleGrid](./assets/readMeImages/fullGrid.png)

You could also, as is demonstrated in the photos, use a more traditional cartesian coordinate system. 

So, the box method is very intuitive, and easy to translate to keyboard inputs. But it is very difficult to calculate the cursor key inputs needed to move from one point to another, at least compared to the cartesian coordinate system. In that system, you can simply subtract the old X and Y coordinates from the new ones to get a number whose sign denotes its direction (right vs. left, up vs. down).

My solution to this mismatch, one system easy to use but hard to use for path-finding, and vice versa, was to develop a sysem of equations to translate between the two coordinate systems. Here are those equations below, in the functions I use to translate between them:
```r
cartesianToBox(coordArr){
    x := coordArr[1]
    y := coordArr[2]

    a := Round(Ceil(x/rootSqrSize) + ((Ceil(y/rootSqrSize)-1)*3))
    b := Round((Mod((x-1), rootSqrSize)) + ((Mod((y-1), rootSqrSize)*rootSqrSize)+1))
    Return [a, b]
}

boxToCartesian(coordArr){
    a := coordArr[1]
    b := coordArr[2]

    x := Round((Mod((a-1), rootSqrSize)*3) + (Mod((b-1), rootSqrSize)+1))
    y := Round((a-(Mod((a-1), rootSqrSize))) + (Ceil(b/3)-1))
    Return [x, y]
}
```
Here, `rootSqrSize` is simply the number 3, the square of the size of the grid. `Mod()` is a function which calculates the remainder when you divide the first parameter by the second, and `Ceil()` rounds the parameter it takes up to the next integer as long as the parameter isn't an integer (but a floating point number).

With these functions I can calculate exactly where a person wants to be with box notation, translate it, and generate the outputs. It's also useful to translate back the other way when I want to move to the same cell, but a different box, as when you press a key for the first time in the `Navigation` layer.

### Mouse Mode

Mouse mode works very simply. The calibration picks out the coordinates of the four points of the sudoku grid on one's screen. It uses these points to calculate the average width and height recorded, which are then used to calculate the approximate height and width of each cell. 

Theses values are used as the x and y offset, the number of pixels the mouse needs to move along the x or y axis to move to a new cell. The start position of the mouse is determined by moving 55% down from the top right corner and 80% over to the right. This last part is essential, since the cursor needs to be clicked to the right of whatever number is in the cell for sites that let you move the cursor to the right or left of the number.

--- 
## Contributing

If you'd like to contribute to this repository feel free to fork it/create a pull request. Possible areas of improvement include improving the GUI and tooltip, adding support for 4x4 and 16x16 size puzzle grids, and if you are feeling particularly ambitious, finding a way to rewrite this script for Linux and Mac ecosystems.

Other bug fixes, cleanups, and features are also welcomed.

--- 
## [License](./LICENSE)
This website uses the open-source MIT License.

--- 