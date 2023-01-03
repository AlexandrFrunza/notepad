# Класс Ссылка, разновидность базового класса "Запись"
class Link < Post

  def initialize
    super # вызываем конструктор родителя

    # потом инициализируем специфичное для ссылки поле
    @url = ''
  end

  # Этот метод пока пустой, он будет спрашивать 2 строки — адрес ссылки и описание
  def read_from_console
    puts "Введите адрес ссылки"
    @url = STDIN.gets.chomp

    # И описание ссылки (одной строчки будет достаточно)
    puts "Напишите пару слов о том, куда ведёт ссылка"
    @text = STDIN.gets.chomp
  end

  def save
    # Метод save во многом повторяет метод родителя, но отличия существенны

    file = File.new(file_path, "w:UTF-8")
    time_string = @created_at.strftime("%Y.%m.%d, %H:%M")
    file.puts(time_string + "\n\r")

    # Помимо текста мы ещё сохраняем в файл адрес ссылки
    file.puts(@url)
    file.puts(@text)

    file.close

    # Напишем пользователю, что запись добавлена
    puts "Ваша ссылка сохранена"
  end
  # Массив из трех строк: адрес ссылки, описание и дата создания
  # Будет реализован в след. уроке
  def to_strings
    time_string = "Создано: #{@created_at.strftime('%Y.%m.%d, %H:%M:%S')} \n\r"

    [@url, @text, time_string]
  end

  def to_db_hash
    return super.merge(
      {
        'text' => @text,
        'url' => @url
      }
    )
  end

  def load_data(data_hash)
    super(data_hash)

    @url = data_hash['url']
  end
end
