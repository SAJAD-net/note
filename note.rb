#this function saved the notes
def saver(notes, nn)
  maker()
  if not(File.exists?(".notes/#{nn}")) then
    fn = File.open(".notes/notes", "a+")
    fn.puts(nn)
    fn.close()
  end
  nf = File.new(".notes/#{nn}", "a+")
  for note in notes do
    nf.puts(note)
  end
  puts("black note ➜ #{nn} saved [ok]")
  nf.close()
end

#well, this function create the .notes folder
def maker()
  if not File.directory?(".notes") then
    Dir.mkdir(".notes")
  end
end

#function for create the new note
def newer()
  print("black note ➜ enter name of note ~ ")
  nn = gets.chomp()
  maker()
  if File.exists?(".notes/#{nn}") then
    puts("black note ➜ this file exists !")
    exit()
  end
  line = 0
  notes=[]
  while true do
    print("[#{line}]~ ")
    note=gets.chomp()
    if note == "quit" 
      print("black note ➜ save the change's [Y/n]~ ")
      yn = gets.chomp()
      if yn == "y"
        saver(notes, nn)
        exit()
      else
        exit()
      end
    end
    n = "[#{line}]~ "+note
    notes.append(n)
    line+=1
  end

end

#for lists the notes
def lister()
  if File.exists?(".notes/notes") then
    File.foreach(".notes/notes"){|line| puts("[N]~ #{line}")}
  else 
    puts("black note ➜ there aren't any notes")
  end
end

#read the notes
def reader()
  print("black note ➜ enter name of note ~ ")  
  name = gets.chomp()
  if File.exists?(".notes/#{name}") then
    File.foreach(".notes/#{name}"){|line| puts(line)}
  else
    puts("black note ➜ this file is not exists !")
  end
end

#for append note
def appender()
  print("black note ➜ enter name of note ~ ")
  name = gets.chomp()
  if File.exists?(".notes/#{name}") then
    nn = name
  else
    puts("black note ➜ this file is not exists !")
    exit()
  end

  lines = File.readlines(".notes/#{nn}")
  ln = 0
  for line in lines do
    puts(line)
    ln+=1
  end
  notes = []
  while true do
    print("[#{ln}]~ ")
    note=gets.chomp()
    if note == "quit"
      print("black note ➜ save the change's [Y/n]~ ")
      yn = gets.chomp()
      if yn == "y"
        saver(notes, nn)
        exit()
      else
        exit()
      end
    end
    n = "[#{ln}]~ "+note
    notes.append(n)
    ln+=1
  end

end

#delete the note
def deleter()
  print("black note ➜ enter name of note ~ ")
  name = gets.chomp()
  if File.exists?(".notes/#{name}") then
    File.delete(".notes/#{name}")
    puts("black note ➜ #{name} note deleted [ok]")
  else
    puts("black note ➜ this file not exists !")
    exit()
  end
end

#main function 
def notes()
  puts("welcome to `black note` ➜ tomorrow never waits \n")
  puts("\t[0]- new note\t\t[1]- append note\n\t[2]- list notes\t\t[3]- read note\n\t[4]- delete note\t[5]~ quit\n")
  print("black note ➜ enter num to chose ~ ")
  num = gets.chomp()
  if num == "0" then
    newer()
  elsif num == "1"
    appender()
  elsif num == "2"
    lister()
  elsif num == "3"
    reader()
  elsif num == "4"
    deleter()
  elsif num == "5"
    exit()
  else
    puts("black note ➜ enter the valid number !")
  end
end

notes()
