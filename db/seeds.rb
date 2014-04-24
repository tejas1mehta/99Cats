User.create!(user_name: "test1", password: "qwerty")
User.create!(user_name: "test2", password: "qwerty")
User.create!(user_name: "test3", password: "qwerty")
User.create!(user_name: "test4", password: "qwerty")

cat1 = Cat.create( {name: "Tom", age: 24, birth_date: "1989-10-30", sex: "M", color: "orange", user_id: 1})
cat2 = Cat.create( {name: "Mabel", age: 3, birth_date: "2011-04-23", sex: "F", color: "brown", user_id: 1})
cat3 = Cat.create( {name: "Gun Cat", age: 2, birth_date: "2012-10-30", sex: "M", color: "black", user_id: 1})
cat4 = Cat.create( {name: "Ferrari Cat", age: 1, birth_date: "2013-03-13", sex: "F", color: "white", user_id: 2})
cat5 = Cat.create( {name: "Ned", age: 1, birth_date: "2014-03-15", sex: "M", color: "orange", user_id: 2})

cat1.save!
cat2.save!
cat3.save!
cat4.save!
cat5.save!

CatRentalRequest.create!(cat_id: 1, start_date: "2014-01-23", end_date: "2014-02-23")
CatRentalRequest.create!(cat_id: 1, start_date: "2014-01-24", end_date: "2014-01-30")
CatRentalRequest.create!(cat_id: 1, start_date: "2014-03-13", end_date: "2014-04-01")
CatRentalRequest.create!(cat_id: 2, start_date: "2014-03-13", end_date: "2014-04-01")
CatRentalRequest.create!(cat_id: 5, start_date: "2014-01-24", end_date: "2014-01-30")
