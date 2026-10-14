
filesystem = require 'fs'

# file exists
String::exists = ->
  if filesystem.existsSync @.toString() then true else false

# file doesn't exist
String::nonexistent = ->
  if not filesystem.existsSync(@.toString) then true else false

# some string is a directory
String::isDir = ->
  if filesystem.statSync(@.toString()).isDirectory() then true else false

# some string is not a directory
String::isntDir = ->
  if not filesystem.statSync(@.toString()).isDirectory() then true else false

# some string is a file
String::isFile = ->
  if filesystem.statSync(@.toString()).isFile() then true else false

# some string is not a file
String::isntFile = ->
  if not filesystem.statSync(@.toString()).isFile() then true else false


