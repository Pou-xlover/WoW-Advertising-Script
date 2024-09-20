#NoTrayIcon
AutoItSetOption("PixelCoordMode",2)
If $CmdLine[0] = 3 Then
$z = PixelGetColor($CmdLine[2],$CmdLine[3],WinGetHandle($CmdLine[1]))
Exit $z
EndIf
Exit 0