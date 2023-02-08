readConfigSettings(theKey){
    Return IniRead("./settings.ini", "Configuration Settings", theKey)
}

readMouseSettings(theKey){
    Return IniRead("./settings.ini", "Mouse Mode Settings", theKey)
}

saveCalibrationSettings(startPositionX, startPositionY, xOffset, yOffset){
    IniWrite(startPositionX, "./settings.ini", "Mouse Mode Settings", "startPositionX")
    IniWrite(startPositionY, "./settings.ini", "Mouse Mode Settings", "startPositionY")
    IniWrite(xOffset, "./settings.ini", "Mouse Mode Settings", "xOffset")
    IniWrite(yOffset, "./settings.ini", "Mouse Mode Settings", "yOffset")
}