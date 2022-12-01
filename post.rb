class Post

  # Конструктор
  def initialize
    @created_at = Time.now # дата создания записи
    @text = nil # массив строк записи — пока пустой
  end

  # Этот метод вызывается в программе, когда нужно
  # считать ввод пользователя и записать его в нужные поля объекта
  def read_from_console
    # должен быть реализован классами-детьми,
    # которые знают как именно считывать свои данные из консоли
  end

  # Этот метод возвращает состояние объекта в виде массива строк, готовых к записи в файл
  def to_strings
    # должен быть реализован классами-детьми,
    # которые знают как именно хранить себя в файле
  end

  # Этот метод записывает текущее состояние объекта в файл
  def save
    file = File.new(file_path)

    for item in to_strings do
      file.puts(item)
    end

    file.close
    # он будет только у родителя, его мы напишем позже
  end

  def file_path
    current_path=File.dirname(__FILE__)

    file_name = @created_at.strftime("#{self.class.name}_%Y-%m-%d_%H-%M-%S.txt")

    return current_path + "/" + file_name
  end
end
