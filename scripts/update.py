#!/usr/local/bin/python3
  
import json
from sys import argv

version = str(argv[1])

with open("ReactorKit", 'r+') as file:
    data = json.load(file)
    file.seek(0)
    data[version] = "https://github.com/kawoou/ReactorKit-Carthage/releases/download/" + version + "/ReactorKit.framework.zip"
    json.dump(data, file, indent=4, sort_keys=True)
    file.close()

with open("ReactorKit-Static", 'r+') as file:
    data = json.load(file)
    file.seek(0)
    data[version] = "https://github.com/kawoou/ReactorKit-Carthage/releases/download/" + version + "/ReactorKit-Static.framework.zip"
    json.dump(data, file, indent=4, sort_keys=True)
    file.close()
