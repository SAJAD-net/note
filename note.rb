require "sqlite3"

#Saves the notes on database
def saver(notes, nn)
    maker()
    if not(File.exists?(".notes/#{nn}")) then
        db = SQLite3::Database.open ".notes/.notes.db"
        db.execute "INSERT INTO notes (name) VALUES (?)", "#{nn}"
        db.close()

        ##----Saves in a file----
        #fn = File.open(".notes/notes", "a+")
        #fn.puts(nn)
        #fn.close()
    end

    nf = File.new(".notes/#{nn}", "a+")
    for note in notes do
        nf.puts(note)
    end

    puts("xnote ➜ #{nn} saved [ok]")
    nf.close()

end

#Builds the .notes folder, if it's not exists
def maker()
    if not File.directory?(".notes") then
        Dir.mkdir(".notes")
        db = SQLite3::Database.open '.notes/.notes.db'
        db.execute "CREATE TABLE IF NOT EXISTS notes(name varchar(20))"
        db.close()
    end
end

#Builds new note
def newer()
    print("xnote ➜ enter name of note ~ ")
    nn = gets.chomp()
    maker()
    
    if File.exists?(".notes/#{nn}") then
        puts("xnote ➜ this note is already exists !")
        exit()
    end

    line = 0
    notes=[]
    
    while true do
        print("[#{line}]~ ")
        note=gets.chomp()
        
        if note == "quit" 
            print("xnote ➜ do you want to save the changes [Y/n] ~ ")
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

#Displays a list of the notes name
def lister()
    if File.exists?(".notes/.notes.db") then

        #----Read and displays the notes name from 'notes' file
        #File.foreach(".notes/notes"){|line| puts("[N]~ #{line}")}
        
        db = SQLite3::Database.open '.notes/.notes.db'
        db.execute("SELECT * FROM notes") do |note|
            puts "[n]~ #{note[0]}"
        end
        db.close()

    else 
        puts("xnote ➜ there aren't any notes !")
    end
end

#Reads the note
def reader()
    print("xnote ➜ enter the note name ~ ")  
    name = gets.chomp()
    
    if File.exists?(".notes/#{name}") then
        File.foreach(".notes/#{name}"){|line| puts(line)}
    else
        puts("xnote ➜ this note isn't exists !")
    end

end

#Appends the notes at the end of a note file
def appender()
    print("xnote ➜ enter the note name ~ ")
    name = gets.chomp()
    if File.exists?(".notes/#{name}") then
        nn = name
    else
        puts("xnote ➜ this file isn't exists !")
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
            print("xnote ➜ do you want to save the changes [Y/n]~ ")
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

#Removes the note
def deleter()
    print("xnote ➜ enter the note name ~ ")
    name = gets.chomp()
    if File.exists?(".notes/#{name}") then
        db = SQLite3::Database.open '.notes/.notes.db'
        db.execute "DELETE FROM notes WHERE name = '#{name}'"
        db.close()
        File.delete(".notes/#{name}")
        puts("xnote ➜ #{name} note successfully deleted [ok]")
    else
        puts("xnote ➜ this file isn't exists !")
        exit()
    end
end

#Main function 
def main()
    puts("welcome to `xnote` ➜ tomorrow never waits \n")
    puts("\t[0]- new\t\t[1]- append\n\t[2]- notes\t\t[3]- read\n\t[4]- delete\t\t[5]~ quit\n")
 
    print("xnote ➜ choose the operation number ~ ")
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
        puts("xnote ➜ enter the valid number !")
    end
end

main()
