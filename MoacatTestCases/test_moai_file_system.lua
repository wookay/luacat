-- test_moai_file_system.lua
--                           wookay.noh at gmail.com 

package.path = package.path .. ";../moacat/?.lua"
require 'moacat'

function test_moai_file_system()

  assert_true(
    String.end_with(MOAIFileSystem:getAbsoluteFilePath(),
                    'MoacatTestCases/'))
  assert_true(
    String.end_with(MOAIFileSystem:getAbsoluteDirectoryPath(),
                    'MoacatTestCases/'))
  assert_true(
    String.end_with(MOAIFileSystem:getWorkingDirectory(),
                    'MoacatTestCases/'))

  assert_equal({".", "..", "fonts", "images"},
               MOAIFileSystem:listDirectories())

  assert_true(
    Table.include(MOAIFileSystem:listFiles(),
                  'test_moai_file_system.lua'))

  --[[
  MOAIFileSystem
 	affirmPath -- Creates a folder at 'path' if none exists.
 	checkFileExists -- Check for the existence of a file.
 	checkPathExists -- Check for the existence of a path.
 	deleteDirectory -- Deletes a directory and all of its contents.
 	deleteFile -- Deletes a file
 	getAbsoluteFilePath -- Returns the absolute path to a file. Result includes the file name.
 	getAbsoluteDirectoryPath -- Returns the absolute path given a relative path.
 	getWorkingDirectory -- Returns the path to current working directory.
 	listDirectories -- Lists the sub-directories contained in a directory.
 	listFiles -- Lists the files contained in a directory.
 	mountVirtualDirectory -- Mount an archive as a virtual filesystem directory.
 	rename -- Renames a file or folder.
 	setWorkingDirectory -- Sets the current working directory.
]]--
end



if is_main() then
  UnitTest.run()
end

