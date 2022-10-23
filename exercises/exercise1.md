## > luo uusi panimo "BrewDog", perustamisvuosi 2007
```
irb(main):018:0> panimo = Brewery.create name: "BrewDog", year: 2007
  TRANSACTION (0.1ms)  begin transaction
  Brewery Create (0.3ms)  INSERT INTO "breweries" ("name", "year", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["name", "BrewDog"], ["year", "2007"], ["created_at", "2022-10-23 11:14:47.893930"], ["updated_at", "2022-10-23 11:14:47.893930"]]                                                                          
  TRANSACTION (15.8ms)  commit transaction                                   
=>                                                                           
#<Brewery:0x00007f6db3230578                                                 
...    
```
## lisää panimolle kaksi olutta ja lisää molemmille muutama reittaus

- Punk IPA (tyyli IPA)
- Nanny State (tyyli lowalcohol)

### Punk IPA

```
irb(main):023:0> b = panimo.beers.create name: "Punk IPA", style: "IPA"
  TRANSACTION (0.1ms)  begin transaction
  Beer Create (0.3ms)  INSERT INTO "beers" ("name", "style", "brewery_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["name", "Punk IPA"], ["style", "IPA"], ["brewery_id", 5], ["created_at", "2022-10-23 11:21:53.723466"], ["updated_at", "2022-10-23 11:21:53.723466"]]                              
  TRANSACTION (15.8ms)  commit transaction                      
=>                                                              
#<Beer:0x00007f6db4970260                                       
...                                                             
irb(main):024:0> b.ratings.create score: 20
  TRANSACTION (0.1ms)  begin transaction
  Rating Create (0.5ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 20], ["beer_id", 15], ["created_at", "2022-10-23 11:22:32.512073"], ["updated_at", "2022-10-23 11:22:32.512073"]]
  TRANSACTION (23.6ms)  commit transaction                                          
=>                                                                                  
#<Rating:0x00007f6db4961710                                                         
 id: 5,                                                                             
 score: 20,                                                                         
 beer_id: 15,                                                                       
 created_at: Sun, 23 Oct 2022 11:22:32.512073000 UTC +00:00,                        
 updated_at: Sun, 23 Oct 2022 11:22:32.512073000 UTC +00:00>                        
irb(main):025:0> b.ratings.create score: 21
  TRANSACTION (0.1ms)  begin transaction
  Rating Create (0.6ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 21], ["beer_id", 15], ["created_at", "2022-10-23 11:22:34.728001"], ["updated_at", "2022-10-23 11:22:34.728001"]]
  TRANSACTION (18.5ms)  commit transaction
=> 
#<Rating:0x00007f6db3a91c30
 id: 6,
 score: 21,
 beer_id: 15,
 created_at: Sun, 23 Oct 2022 11:22:34.728001000 UTC +00:00,
 updated_at: Sun, 23 Oct 2022 11:22:34.728001000 UTC +00:00>
 irb(main):026:0> b.ratings.create score: 22
  TRANSACTION (0.1ms)  begin transaction
  Rating Create (0.5ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 22], ["beer_id", 15], ["created_at", "2022-10-23 11:22:49.784868"], ["updated_at", "2022-10-23 11:22:49.784868"]]
  TRANSACTION (18.5ms)  commit transaction
=> 
#<Rating:0x00007f6db41518e0
 id: 7,
 score: 22,
 beer_id: 15,
 created_at: Sun, 23 Oct 2022 11:22:49.784868000 UTC +00:00,
 updated_at: Sun, 23 Oct 2022 11:22:49.784868000 UTC +00:00>
```
### Nanny State

```
irb(main):027:0> b = panimo.beers.create name: "Nanny State", style: "lowalcohol"
  TRANSACTION (0.1ms)  begin transaction
  Beer Create (0.4ms)  INSERT INTO "beers" ("name", "style", "brewery_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["name", "Nanny State"], ["style", "lowalcohol"], ["brewery_id", 5], ["created_at", "2022-10-23 11:23:52.665343"], ["updated_at", "2022-10-23 11:23:52.665343"]]
  TRANSACTION (17.5ms)  commit transaction
=> 
#<Beer:0x00007f6db33b3238
...
irb(main):028:0> b.ratings.create score: 30
  TRANSACTION (0.1ms)  begin transaction
  Rating Create (1.0ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 30], ["beer_id", 16], ["created_at", "2022-10-23 11:23:56.716829"], ["updated_at", "2022-10-23 11:23:56.716829"]]
  TRANSACTION (18.8ms)  commit transaction
=> 
#<Rating:0x00007f6db32a3488
 id: 8,
 score: 30,
 beer_id: 16,
 created_at: Sun, 23 Oct 2022 11:23:56.716829000 UTC +00:00,
 updated_at: Sun, 23 Oct 2022 11:23:56.716829000 UTC +00:00>
irb(main):029:0> b.ratings.create score: 31
  TRANSACTION (0.1ms)  begin transaction
  Rating Create (1.0ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 31], ["beer_id", 16], ["created_at", "2022-10-23 11:23:58.509819"], ["updated_at", "2022-10-23 11:23:58.509819"]]
  TRANSACTION (19.6ms)  commit transaction
=> 
#<Rating:0x00007f6db320a198
 id: 9,
 score: 31,
 beer_id: 16,
 created_at: Sun, 23 Oct 2022 11:23:58.509819000 UTC +00:00,
 updated_at: Sun, 23 Oct 2022 11:23:58.509819000 UTC +00:00>

```

## Tulokset

```
irb(main):030:0> Brewery.find_by name: "BrewDog" 
  Brewery Load (0.3ms)  SELECT "breweries".* FROM "breweries" WHERE "breweries"."name" = ? LIMIT ?  [["name", "BrewDog"], ["LIMIT", 1]]                                                      
=>                                                                 
#<Brewery:0x00007f6db33d3bf0                                       
 id: 5,                                                            
 name: "BrewDog",                                                  
 year: "2007",                                                     
 created_at: Sun, 23 Oct 2022 11:14:47.893930000 UTC +00:00,       
 updated_at: Sun, 23 Oct 2022 11:14:47.893930000 UTC +00:00> 

 irb(main):038:0> Beer.where brewery_id: 5
  Beer Load (0.1ms)  SELECT "beers".* FROM "beers" WHERE "beers"."brewery_id" = ?  [["brewery_id", 5]]
=>                                                     
[#<Beer:0x00007f6db31bcf60                             
  id: 15,
  name: "Punk IPA",
  style: "IPA",
  brewery_id: 5,
  created_at: Sun, 23 Oct 2022 11:21:53.723466000 UTC +00:00,
  updated_at: Sun, 23 Oct 2022 11:21:53.723466000 UTC +00:00>,
 #<Beer:0x00007f6db31bce98
  id: 16,
  name: "Nanny State",
  style: "lowalcohol",
  brewery_id: 5,
  created_at: Sun, 23 Oct 2022 11:23:52.665343000 UTC +00:00,
  updated_at: Sun, 23 Oct 2022 11:23:52.665343000 UTC +00:00>]

  irb(main):039:0> Rating.where beer_id: 15
  Rating Load (0.1ms)  SELECT "ratings".* FROM "ratings" WHERE "ratings"."beer_id" = ?  [["beer_id", 15]]
=>                                                                
[#<Rating:0x00007f6db49b92a8                                      
  id: 5,                                                          
  score: 20,                                                      
  beer_id: 15,                                                    
  created_at: Sun, 23 Oct 2022 11:22:32.512073000 UTC +00:00,     
  updated_at: Sun, 23 Oct 2022 11:22:32.512073000 UTC +00:00>,    
 #<Rating:0x00007f6db49b91e0                                      
  id: 6,                                                          
  score: 21,                                                      
  beer_id: 15,                                                    
  created_at: Sun, 23 Oct 2022 11:22:34.728001000 UTC +00:00,     
  updated_at: Sun, 23 Oct 2022 11:22:34.728001000 UTC +00:00>,    
 #<Rating:0x00007f6db49b9118                                      
  id: 7,
  score: 22,
  beer_id: 15,
  created_at: Sun, 23 Oct 2022 11:22:49.784868000 UTC +00:00,
  updated_at: Sun, 23 Oct 2022 11:22:49.784868000 UTC +00:00>]

irb(main):040:0> Rating.where beer_id: 16
  Rating Load (0.1ms)  SELECT "ratings".* FROM "ratings" WHERE "ratings"."beer_id" = ?  [["beer_id", 16]]
=> 
[#<Rating:0x00007f6db33e5080
  id: 8,
  score: 30,
  beer_id: 16,
  created_at: Sun, 23 Oct 2022 11:23:56.716829000 UTC +00:00,
  updated_at: Sun, 23 Oct 2022 11:23:56.716829000 UTC +00:00>,
 #<Rating:0x00007f6db33e4f68
  id: 9,
  score: 31,
  beer_id: 16,
  created_at: Sun, 23 Oct 2022 11:23:58.509819000 UTC +00:00,
  updated_at: Sun, 23 Oct 2022 11:23:58.509819000 UTC +00:00>]
```
