require 'mongo'

include Mongo
# Initialize client 
mongo_client = MongoClient.new("localhost", 27017)
db = mongo_client.db("mydb")
# The collection for all transactions:
coll = db.collection("transaction")
puts "There are #{coll.count} total transactions:"
coll.find.each {|trans| puts trans.inspect}
puts "This is the total grouped by buyer:"
puts coll.aggregate([
    # Matches all uncleared transactions
    {"$match" => {isCleared: false}},
    {"$group" => { _id: "$buyer", total: {"$sum" => "$amount"}, average: {"$avg" => "$amount"}}}
  ])
