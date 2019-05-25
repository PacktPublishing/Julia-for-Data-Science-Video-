# Code for video 3_4:

Pkg.add("ODBC")
using ODBC

conn = ODBC.connect("irisDSN")
# ODBC Connection Object
# ----------------------
# Connection Data Source: irisDSN
# irisDSN Connection Number: 1
# Contains resultset(s)? No

results = query("select * from iris_species")
3x2 DataFrames.DataFrame
| Row | id | species         |
|-----|----|-----------------|
| 1   | 1  | "I. setosa"     |
| 2   | 2  | "I. versicolor" |
| 3   | 3  | "I. virginica"  |

julia> results = query("select * from iris")
150x5 DataFrames.DataFrame
| Row | sepal_length | sepal_width | petal_length | petal_width | species |
|-----|--------------|-------------|--------------|-------------|---------|
| 1   | 5.1          | 3.5         | 1.4          | 0.2         | 1       |
| 2   | 4.9          | 3.0         | 1.4          | 0.2         | 1       |
| 3   | 4.7          | 3.2         | 1.3          | 0.2         | 1       |
| 4   | 4.6          | 3.1         | 1.5          | 0.2         | 1       |
...

sql1 = "select sepal_length, petal_length, iris_species.species 
        from iris, iris_species 
        where iris_species.id = iris.species 
        and iris_species.id = 2"
results = query(sql1)
50x3 DataFrames.DataFrame
| Row | sepal_length | petal_length | species         |
|-----|--------------|--------------|-----------------|
| 1   | 7.0          | 4.7          | "I. versicolor" |
| 2   | 6.4          | 4.5          | "I. versicolor" |
| 3   | 6.9          | 4.9          | "I. versicolor" |
| 4   | 5.5          | 4.0          | "I. versicolor" |
| 5   | 6.5          | 4.6          | "I. versicolor" |
| 6   | 5.7          | 4.5          | "I. versicolor" |
| 7   | 6.3          | 4.7          | "I. versicolor" |
| 8   | 4.9          | 3.3          | "I. versicolor" |
| 9   | 6.6          | 4.6          | "I. versicolor" |
| 10  | 5.2          | 3.9          | "I. versicolor" |
| 11  | 5.0          | 3.5          | "I. versicolor" |
⋮
| 39  | 5.6          | 4.1          | "I. versicolor" |
| 40  | 5.5          | 4.0          | "I. versicolor" |
| 41  | 5.5          | 4.4          | "I. versicolor" |
| 42  | 6.1          | 4.6          | "I. versicolor" |
| 43  | 5.8          | 4.0          | "I. versicolor" |
| 44  | 5.0          | 3.3          | "I. versicolor" |
| 45  | 5.6          | 4.2          | "I. versicolor" |
| 46  | 5.7          | 4.2          | "I. versicolor" |
| 47  | 5.7          | 4.2          | "I. versicolor" |
| 48  | 6.2          | 4.3          | "I. versicolor" |
| 49  | 5.1          | 3.0          | "I. versicolor" |
| 50  | 5.7          | 4.1          | "I. versicolor" |

sql1 =  "select sepal_length, petal_length, iris_species.species" 
sql1 *= " from iris, iris_species" 
sql1 *= " where iris_species.id = iris.species" 
sql1 *= " and iris_species.id = 2"

results = query(sql1, conn)

conn.resultset
50x3 DataFrames.DataFrame
| Row | sepal_length | petal_length | species         |
|-----|--------------|--------------|-----------------|
| 1   | 7.0          | 4.7          | "I. versicolor" |
| 2   | 6.4          | 4.5          | "I. versicolor" |
| 3   | 6.9          | 4.9          | "I. versicolor" |

by(results, :sepal_length, size)
21x2 DataFrames.DataFrame
| Row | sepal_length | x1    |
|-----|--------------|-------|
| 1   | 4.9          | (1,3) |
| 2   | 5.0          | (2,3) |
| 3   | 5.1          | (1,3) |
| 4   | 5.2          | (1,3) |
| 5   | 5.4          | (1,3) |
| 6   | 5.5          | (5,3) |
| 7   | 5.6          | (5,3) |
| 8   | 5.7          | (5,3) |
| 9   | 5.8          | (3,3) |
| 10  | 5.9          | (2,3) |
| 11  | 6.0          | (4,3) |
| 12  | 6.1          | (4,3) |
| 13  | 6.2          | (2,3) |
| 14  | 6.3          | (3,3) |
| 15  | 6.4          | (2,3) |
| 16  | 6.5          | (1,3) |
| 17  | 6.6          | (2,3) |
| 18  | 6.7          | (3,3) |
| 19  | 6.8          | (1,3) |
| 20  | 6.9          | (1,3) |
| 21  | 7.0          | (1,3) |

updsql1 = "update iris_species
           set species = 'Iris setosa'
           where id = 1"
query(updsql1)
0x0 DataFrames.DataFrame

disconnect(conn)

### SQLite

# creating the table and importing data:
# F:\Julia\Julia for Data Science\Scripts\Section 3\Video 3.4>sqlite3
# SQLite version 3.8.6 2014-08-15 11:46:33
# Enter ".help" for usage hints.
# Connected to a transient in-memory database.
# Use ".open FILENAME" to reopen on a persistent database.
# sqlite> .separator ","
# sqlite> .import iris.csv iris
# sqlite> .save iris.db
# sqlite> select count(*) from iris;
# 150
# sqlite> .ex

# F:\Julia\Julia for Data Science\Scripts\Section 3\Video 3.4>


Pkg.add("SQLite")
using SQLite

db = SQLite.DB("iris.db")
SQLite.DB("iris.db")

res = query(db, "select * from iris")
# Data.Table:
# 150x5 Data.Schema:
#  sepal_length, sepal_width, petal_length, petal_width,    species
#    UTF8String,  UTF8String,   UTF8String,  UTF8String, UTF8String
# NullableArrays.NullableArray{T,1}[NullableArrays.NullableArray{UTF8String,1}["5.1
# ","4.9","4.7","4.6","5.0","5.4","4.6","5.0","4.4","4.9"  …  "6.7","6.9","5.8","6.
# 8","6.7","6.7","6.3","6.5","6.2","5.9"],NullableArrays.NullableArray{UTF8String,1
# }["3.5","3.0","3.2","3.1","3.6","3.9","3.4","3.4","2.9","3.1"  …  "3.1","3.1","2.
# 7","3.2","3.3","3.0","2.5","3.0","3.4","3.0"],NullableArrays.NullableArray{UTF8St
# ring,1}["1.4","1.4","1.3","1.5","1.4","1.7","1.4","1.5","1.4","1.5"  …  "5.6","5.
# 1","5.1","5.9","5.7","5.2","5.0","5.2","5.4","5.1"],NullableArrays.NullableArray{
# UTF8String,1}["0.2","0.2","0.2","0.2","0.2","0.4","0.3","0.2","0.2","0.1"  …  "2.
# 4","2.3","1.9","2.3","2.5","2.3","1.9","2.0","2.3","1.8"],NullableArrays.Nullable
# Array{UTF8String,1}["I. setosa","I. setosa","I. setosa","I. setosa","I. setosa","
# I. setosa","I. setosa","I. setosa","I. setosa","I. setosa"  …  "I. virginica","I.
#  virginica","I. virginica","I. virginica","I. virginica","I. virginica","I. virgi
# nica","I. virginica","I. virginica","I. virginica"]]

typeof(res) # DataStreams.Data.Table{Array{NullableArrays.NullableArray{T,1},1}}
size(res) # (150,5)

# sqlite> create table iris (sepal_length float, sepal_width float, petal_length fl
# oat, petal_width float, species text);

sql = "select species, avg(petal_width) from iris"
sql *= " group by species" 
res = query(db, sql)
nrec = size(res)[1] # number of records returned: 3
for i = 1:nrec
    println(res[i, 1], "\n\t Mean(petal_with): ", res[i, 2])
end
Nullable("I. setosa")
         Mean(petal_with): Nullable(0.2439999999999999)
Nullable("I. versicolor")
         Mean(petal_with): Nullable(1.3259999999999998)
Nullable("I. virginica")
         Mean(petal_with): Nullable(2.026)
