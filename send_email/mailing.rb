# frozen_string_literal: true

if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [$stdin, $stdout].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require_relative 'Client'

file_path = './data/Mails_address.txt'

file = File.new(file_path, 'a+:UTF-8', chomp: true)
lines = file.readlines
file.close

send_to = []

lines.each_index do |i|
  send_to.push(lines[i].chomp)
end

my_mail = ''
password = ''

puts "----------------------------------------------------\n"\
     "|                                                  |\n"\
     "|   ███╗░░░███╗░█████╗░██╗██╗░░░░░███████╗██████╗░ |\n"\
     "|   ████╗░████║██╔══██╗██║██║░░░░░██╔════╝██╔══██╗ |\n"\
     "|   ██╔████╔██║███████║██║██║░░░░░█████╗░░██████╔╝ |\n"\
     "|   ██║╚██╔╝██║██╔══██║██║██║░░░░░██╔══╝░░██╔══██╗ |\n"\
     "|   ██║░╚═╝░██║██║░░██║██║███████╗███████╗██║░░██║ |\n"\
     "|   ╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝╚══════╝╚══════╝╚═╝░░╚═╝ |\n"\
     "----------------------------------------------------\n"
sleep(2)
puts "Присутсвующие адреса почт #{send_to}"
sleep(2)

puts "\nВведите текст оповещения:"
body = $stdin.gets.encode('UTF-8').chomp

puts "\nВведите тему письма:"
subject = $stdin.gets.encode('UTF-8').chomp

index = 0

client = Client.new(my_mail, send_to, body, subject, index, password)

while index != send_to.size
  index += 1
  client.sending(send_to, subject, body, my_mail, password, index)
end

puts "\n Выполенно успешно #{index} отправок"
