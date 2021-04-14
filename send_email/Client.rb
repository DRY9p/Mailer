# frozen_string_literal: true

require 'pony'
require 'io/console'

# Class create more easily access to the 'Pony' library
class Client
  attr_accessor :my_mail, :send_to, :body, :subject

  def initialize(my_mail, send_to, body, subject, index, password)
    @my_mail = my_mail
    @password = password
    @send_to = send_to
    @body = body
    @subject = subject
    @index = index
  end

  # @param [Object] send_to
  # @param [Object] subject
  # @param [Object] body
  # @param [Object] my_mail
  # @param [Object] password
  def sending(send_to, subject, body, my_mail, password, index)

    Pony.mail(
      subject: subject,
      body: body,
      to: send_to,
      from: my_mail,
      via: :smtp,
      via_options: {
        address: 'smtp.gmail.com',
        port: '587',
        enable_starttls_auto: true,
        user_name: my_mail,
        password: password,
        authentication: :plain
      }
    )
    catching_errors(index)
  end

  def catching_errors(index)
    success = true
  rescue SocketError
    puts 'Не могу соединится с сервером'
  rescue Net::SMTPSyntaxError => e
    puts "Вы некорретно задали параментры письма #{e.message}"
  rescue Net::SMTPAuthenticationError => e
    puts "Неправильные данные учетной записи, возможно вы неправельно ввели пароль или логин #{e.message}"
  ensure
    puts "\n Выполненных отправок #{index}"
  end
end
