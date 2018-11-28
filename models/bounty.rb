require('pg')

class Bounty

  attr_accessor :name, :species, :danger_level, :bounty_value
  attr_reader :id

  def initialize(options)
    @name = options['name']
    @species = options['species']
    @danger_level = options['danger_level']
    @bounty_value = options['bounty_value'].to_i()
    @id = options['id'].to_i if options ['id']
  end

  def save()
    # connect to the database
    db = PG.connect({dbname: 'space_cowboys', host:'localhost'})
    # create an sql string
    sql = "INSERT INTO bounties (name, species, danger_level, bounty_value) VALUES ($1, $2, $3, $4) RETURNING *;"
    values = [@name, @species, @danger_level, @bounty_value]
    # prepare the statement
    db.prepare("save", sql)
    # execute the prepared statement
    @id = db.exec_prepared("save", values)[0]['id'].to_i()
    # close the DB connection
    db.close()
  end

  def update
    db = PG.connect({dbname: 'space_cowboys', host:'localhost'})
    sql = "UPDATE bounties SET (name, species, danger_level, bounty_value) = ($1, $2, $3, $4) WHERE id = $5;"
    values = [@name, @species, @danger_level, @bounty_value, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def delete()
    db = PG.connect({dbname: 'space_cowboys', host:'localhost'})
    sql = "DELETE FROM bounties WHERE id = $1;"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

#class method needs Bounty.
  def Bounty.find_by_name(name)
    db = PG.connect({dbname: 'space_cowboys', host:'localhost'})
    sql = "SELECT * FROM bounties WHERE name = $1"
    values = [name]
    db.prepare("find_by_name", sql)
    results_array = db.exec_prepared("find_by_name", values)
    db.close()
    bounty_hash = results_array[0]
    bounty = Bounty.new(bounty_hash)
    return bounty
  end

  def Bounty.find(id) # READ
    db = PG.connect({dbname: 'bounty_hunter', host: 'localhost'})
    sql = "SELECT * FROM bounties WHERE id = $1"
    values = [@id]
    db.prepare("find", sql)
    results_array = db.exec_prepared("find", values)
    db.close()
    bounty_hash = results_array[0]
    bounty = Bounty.new(bounty_hash)
    return bounty
  end

end
