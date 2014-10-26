from pymongo import MongoClient
import json

client = MongoClient('mongodb://localhost:27017/') 
db = client["mydb"]
coll = db.transaction
print "There are " + str(coll.count()) + " total transactions:"
for trans in coll.find(): 
    print trans
print "This is the total grouped by buyer:"
agg = db.transaction.aggregate([
{"$match": {"isCleared": False}},
{"$group": {"_id": "$buyer", "total": {"$sum": "$amount"}, "average": {"$avg": "$amount"}}}
])
print [r for r in agg["result"]]
