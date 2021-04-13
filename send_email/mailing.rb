# frozen_string_literal: true

require_relative 'Client'

my_mail = ''
password = ''
send_to = %w[]

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
puts "Присутсвующие адреса почт #{send_to.to_s}"
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
