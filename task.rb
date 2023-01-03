require 'date'

# Класс Задача, разновидность базового класса "Запись"
class Task < Post
  def initialize
    super # вызываем конструктор родителя

    # потом инициализируем специфичное для Задачи поле - дедлайн
    @due_date = ' '
  end

  # Этот метод пока пустой, он будет спрашивать 2 строки - описание задачи и дату дедлайна
  def read_from_console
    puts "Что вам необходимо сделать?"
    @text = STDIN.gets.chomp

    # А теперь спросим у пользователя, до какого числа ему нужно это сделать
    # И подскажем формат, в котором нужно вводить дату
    puts "До какого числа вам нужно это сделать?"
    puts "Укажите дату в формате ДД.ММ.ГГГГ, например 12.05.2003"
    input = STDIN.gets.chomp

    # Для того, чтобы записть дату в удобном формате, воспользуемся методом parse класса Time
    @due_date = Date.parse(input)
  end

  def save
    file = File.new(file_path, "w:UTF-8")
    time_string = @created_at.strftime("%Y.%m.%d, %H:%M")
    file.puts(time_string + "\n\r")

    # Так как поле @due_date указывает на объект класса Date, мы можем вызвать у него метод strftime
    # Подробнее о классе Date читайте по ссылкам в материалах
    file.puts("Сделать до #{@due_date.strftime("%Y.%m.%d")}")
    file.puts(@text)

    file.close

    # Напишем пользователю, что задача добавлена
    puts "Ваша задача сохранена"
  end

  # Массив из трех строк: дедлайн задачи, описание и дата создания
  # Будет реализован в след. уроке
  def to_strings
    deadline = "Крайний срок: #{@due_date.strftime('%Y.%m.%d')}"
    time_string = "Создано: #{@created_at.strftime('%Y.%m.%d, %H:%M:%S')} \n\r"

    [deadline, @text, time_string]
  end

  def to_db_hash
    return super.merge(
      {
        'text' => @text,
        'due_date' => @due_date.to_s
      }
    )
  end

  def load_data(data_hash)
    super

    @due_date = Date.parse(data_hash['due_date'])
  end
end
