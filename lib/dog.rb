class Dog
  attr_reader :id
  attr_accessor :name, :breed

  def initialize(name:, breed:, id:nil)
    @id = id
    self.name = name
    self.breed = breed
  end

  def self.create_table
    sql = <<-SQL
        CREATE TABLE IF NOT EXISTS dogs(
            id INTEGER PRIMARY KEY,
            name TEXT,
            breed TEXT
        )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE dogs")
  end

  def save 
    if @id 

    else 
      
    end
  end 

end
