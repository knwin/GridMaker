Grid Maker Application
This autolisp application draws grid lines at specified interval with user defined color and lables as well.

HOW TO - 

Save both lsp and dcl file in a folder

Setting up DCL file path on autocad
------------------------------------------------------
The ddgrid3.lsp require ddgrid3.dcl which is dialog box interface.
The path to dcl file must be added into "Support File Search path".
Steps.
1.type "options" in command line or choose option menu under "Tools".
2.on the "File" tab, find "Support File Search path". 
3.click + sign to see all the path added.
4.click "Browse" button and direct the folder where ddgrid3.dcl file is kept. Select the folder and click "OK:
5.Close the option pannel by clicking "OK".


Loading AutoLISP file
----------------------------------
Option 1. manual uploading
(this method require you to upload the lisp file every time you open AutoCAD application)
1.type "appload" in command line to open "Load/Unload Applications" pannel
2.from "Look in" broswe dropdownlist find the folder where ddgrid3.lsp is kept.
3.choose "Files of type" as AutoCAD Apps or AutoLISP.
4.select ddgrid5-3.lsp file
5.click "Load" button
6.close the pannel.

Option 2. Saving the lisp file in AutoCAD permanently
1.type "cui" in command line to open Customize User Iterface pannel
2.In the Customize tab, select "LISP Files" item.
3.Righ click over "LISP Files" item and choose "Load LISP" menu
4.Select the ddgrid5-3.lsp file in the folder where you saved it.
5.Click OPEN button.
6. Click Close button of Customize User Interface pannel

Type "DDGRID" or "ddgrid" at the command line to call the grid maker application


Have fun!!

Kyaw Naing Win
kyawnaingwinknw@gmail.com



