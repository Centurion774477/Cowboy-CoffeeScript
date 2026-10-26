
filesystem = require 'fs'

# file exists
String::exists = ->
  if filesystem.existsSync @.toString() then true else false

# file doesn't exist
String::nonexistent = ->
  if not filesystem.existsSync(@.toString()) then true else false

# some string is a directory
String::isDir = ->
  return false unless filesystem.existsSync(@.toString())
  if filesystem.statSync(@.toString()).isDirectory() then true else false

# some string is not a directory
String::isntDir = ->
  return false unless filesystem.existsSync(@.toString())
  if not filesystem.statSync(@.toString()).isDirectory() then true else false

# some string is a file
String::isFile = ->
  return false unless filesystem.existsSync(@.toString())
  if filesystem.statSync(@.toString()).isFile() then true else false

# some string is not a file
String::isntFile = ->
  return false unless filesystem.existsSync(@.toString())
  if not filesystem.statSync(@.toString()).isFile() then true else false

String::empty = ->
  return false unless filesystem.existsSync(@.toString())
  if filesystem.statSync(@.toString()).size is 0 then true else false

files_in = (directory) ->
  return false unless filesystem.existsSync(@.toString())
  (file for file in filesystem.readdirSync(directory) \
  when filesystem.statSync(directory + '/' + file).isFile())

touch = (file) ->
  filesystem.openSync(file, 'a')
