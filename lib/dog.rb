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
      DB[:conn].execute("UPDATE dogs SET name=?, breed=? WHERE id=?", self.name, self.breed, self.id)
    else
      DB[:conn].execute("INSERT INTO dogs (name, breed) VALUES (?, ?)", self.name, self.breed)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
      self
    end
  end

  def self.create(name:, breed:)
      dog = self.new(name: name, breed: breed)
      dog.save
      dog
  end

  def self.find_by_id(id)
      DB[:conn].execute("SELECT * FROM dogs WHERE id=?", id)[0]
  end


end
