
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

# check if a file is empty
String::empty = ->
  return false unless filesystem.existsSync(@.toString())
  if filesystem.statSync(@.toString()).size is 0 then true else false

# an array of all the files in a directory
files_in = (directory) ->
  return false unless filesystem.existsSync(@.toString())
  (file for file in filesystem.readdirSync(directory) \
  when filesystem.statSync(directory + '/' + file).isFile())

# create a file
touch = (file) ->
  filesystem.openSync(file, 'a')

global.command = process.argv[2] or ""
global.flags = process.argv[3..] or []

# check if the user passed in a flag
user_passed = (flag) ->
  flag in flags

formatFileSize = (bytes) ->
  if bytes < 1024
    return bytes + " bytes"
  else if bytes < 1024 * 1024
    return (bytes / 1024).toFixed(2) + " KB"
  else
    return (bytes / 1024 / 1024).toFixed(2) + " MB"


# Alias for console.log
echo = (message) ->
  console.log message


# filter files in a directory to a specific pattern
# for example:
# fpcs_files = files_that_match '.', (file) -> file ==
files_that_match = (directory, requirement) ->
  (file for file in filesystem.readdirSync(directory) \
  when file.match(requirement))


# returns the full extension of a path
# only use this for things like .tar.gz — anything else probably won't work.
# TODO: improve this
full_extension = (path) ->
  raw = path.split('.')

  # remove the first element of the array since that can never be an extension
  raw.shift()

  # reject any extensions that are longer than 3 characters
  filtered = (ext for ext in raw when ext.length <= 3)

  # rejoin extensions
  filtered.join '.'

ext = full_extension 'foo.tar.gz'
console.log ext

# checks if the user passed in a flag
# if you argue a flag like '--format' then it will also search for '-f', for example.
user_raised = (flag) ->
  if flag.includes '--'
    # get the first letter
    shortened_flag = flag.match(/^--(.)/)?[1]
  flag in flags or shortened_flag in flags

user_passed_both = (key_one, key_two) ->
  user_raised key_one and user_raised key_two

