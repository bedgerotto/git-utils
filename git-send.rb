#!/usr/bin/ruby
#Place this file on a directory that is in your $PATH and remove the extension, like this: /usr/local/bin/git-send

# Get the modified and new files
modifiedFiles = `git ls-files -m -o`.split("\n")

puts "Enter the number of each file you want to commit separated by comma. Or enter blank to all files"
# List files with numbers to user
modifiedFiles.each_with_index do |file, i|
  puts i.to_s + " " + file
end

# Get the files user want to send
toAdd = gets.chomp
toAdd = toAdd.gsub(" ", "").split(",")

# If is empty sendo all files
if toAdd.length == 0
  a = "."
else
  files = []
  # Check the files that user selected to send
  modifiedFiles.each_with_index do |file, j|
    if toAdd.include? j.to_s
      files.push file
    end
  end
  # Join all files user has selected in a string
  a = files.join(" ")
end

# Add files to be commited
system "git add #{a}"

# Get Commit message from user
puts("Enter a message to commit: ")
commitMessage = gets.chomp
# Exit if user no send a message
if commitMessage.length == 0
  puts "Message is empty. No commit has sended"
  exit false
end

# Commit the files with user message
system "git commit -m \'#{commitMessage}\'"

#Get the actual branch and push the changes to remote repo
puts("Pushing to remote")
branch = `git symbolic-ref --short HEAD`
if branch
    # Send the commit to remote
    system "git push origin #{branch}"
end
exit true
