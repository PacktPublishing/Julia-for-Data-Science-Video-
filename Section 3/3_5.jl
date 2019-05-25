# code for Video 3_5:

## on command-line:
mongoimport -d iris -c lengths < iris.json
# 2015-11-30T15:10:38.525+0100    connected to: localhost
# 2015-11-30T15:10:38.661+0100    imported 150 documents

## in mongo shell:
> use iris
switched to db iris
> show collections
lengths
system.indexes
> db.lengths.count()
150
> db.lengths.findOne()
{
        "_id" : ObjectId("565c58de3449d12d21cefe41"),
        "sepalLength" : 5.1,
        "sepalWidth" : 3.5,
        "petalLength" : 1.4,
        "petalWidth" : 0.2,
        "species" : "setosa"
}

> db.lengths.find({species: "versicolor"}, {_id:0}).limit(5)
{ "sepalLength" : 7, "sepalWidth" : 3.2, "petalLength" : 4.7, "petalWidth" : 1.4,
 "species" : "versicolor" }
{ "sepalLength" : 6.4, "sepalWidth" : 3.2, "petalLength" : 4.5, "petalWidth" : 1.
5, "species" : "versicolor" }
{ "sepalLength" : 6.9, "sepalWidth" : 3.1, "petalLength" : 4.9, "petalWidth" : 1.
5, "species" : "versicolor" }
{ "sepalLength" : 5.5, "sepalWidth" : 2.3, "petalLength" : 4, "petalWidth" : 1.3,
 "species" : "versicolor" }
{ "sepalLength" : 6.5, "sepalWidth" : 2.8, "petalLength" : 4.6, "petalWidth" : 1.
5, "species" : "versicolor" }

Pkg.add("Mongo")
using Mongo, LibBSON

cl = MongoClient()
# 2015/11/30 19:54:37.0518: [ 9031]:    DEBUG:      cluster: Client initialized in direct mode.
# MongoClient(mongodb://localhost:27017/)

irisl = MongoCollection(cl, "iris", "lengths")
# MongoCollection(lengths)

spvir = BSONObject(Dict("species" => "virginica"))
# BSONObject({ "species" : "virginica" })

count(irisl, spvir) # 50

cur = find(irisl, spvir)
# Mongo.MongoCursor(Ptr{Void} @0x0000000003bd6620)

 for obj in cur
     println(obj["species"], ": ", obj["petalWidth"])
 end
# virginica: 2.5
# virginica: 1.9
# virginica: 2.1
# virginica: 1.8
# virginica: 2.2
# virginica: 2.1
# virginica: 1.7
# virginica: 1.8
# virginica: 1.8
# virginica: 2.5

new = BSONObject(Dict("species" => "virginica", "petalWidth" => 10.0))
# BSONObject({ "petalWidth" : 10.000000, "species" : "virginica" })

insert(irisl, new) # BSONOID(565d5f91f7294f259f22d551)
count(irisl, spvir) # 51

upd = BSONObject(Dict("species" => "virginica", "petalWidth" => 5.5))
# BSONObject({ "petalWidth" : 5.500000, "species" : "virginica" })
update(irisl, new, upd) # true

del = BSONObject(Dict("species" => "virginica", "petalWidth" => 5.5))
# BSONObject({ "petalWidth" : 5.500000, "species" : "virginica" })

delete(irisl, del) # true
count(irisl, spvir) # 50

## Redis:
Pkg.add("Redis")
using Redis

conn = RedisConnection()
# Redis.RedisConnection("127.0.0.1",6379,"",0,TCPSocket(open, 0 bytes waiting))

set(conn, "Iris species", "I. setosa") # true

keys(conn, *) # Set(Any["Iris species"])

println(get(conn, "Iris species")) # I. setosa
bgsave() # Ok

disconnect(conn)