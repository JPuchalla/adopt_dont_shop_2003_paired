# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dumb_friends = Shelter.create(name: "Dumb Friends League",
                              address: "2080 S. Quebec St.",
                              city: "Denver",
                              state: "CO",
                              zip: "80231")

denver_animal = Shelter.create(name: "Denver Animal Shelter",
                               address: "1241 W. Bayaud Ave.",
                               city: "Denver",
                               state: "CO",
                               zip: "80223")

cassidy = Pet.create(image: "cute_dog.jpg",
                     name: "Cassidy",
                     description: "A very adorable pupper.",
                     approx_age: 10,
                     sex: "female",
                     adopt_status: 'adoptable',
                     shelter_id: dumb_friends.id)

hobbes = Pet.create(image: "smug_cat.jpg",
                    name: "Hobbes",
                    description: "A very mischievous cat.",
                    approx_age: 5,
                    sex: "male",
                    adopt_status: 'adoptable',
                    shelter_id: dumb_friends.id)

clifford = Pet.create(image: "big_dog.jpg",
                     name: "Clifford",
                     description: "A big, friendly dog.",
                     approx_age: 3,
                     sex: "male",
                     adopt_status: 'adoptable',
                     shelter_id: denver_animal.id)

garfield = Pet.create(image: "fat_cat.jpg",
                    name: "Garfield",
                    description: "A lazy, occasionally grumpy cat.",
                    approx_age: 15,
                    sex: "male",
                    adopt_status: 'adoptable',
                    shelter_id: denver_animal.id)

mabel = Pet.create(image: "small_hedgehog.jpg",
                     name: "Mabel",
                     description: "A cute, tiny hedgehog.",
                     approx_age: 2,
                     sex: "female",
                     adopt_status: 'adoptable',
                     shelter_id: denver_animal.id)

raymond = Pet.create(image: "gray_tabby.jpg",
                    name: "Raymond",
                    description: "Cat who can be friendly and welcoming.",
                    approx_age: 6,
                    sex: "male",
                    adopt_status: 'adoptable',
                    shelter_id: denver_animal.id)

mordecai = Pet.create(image: "tuxedo_cat.jpg",
                     name: "Mordecai",
                     description: "A cat who thinks too much of himself.",
                     approx_age: 12,
                     sex: "male",
                     adopt_status: 'adoptable',
                     shelter_id: dumb_friends.id)

amber = Pet.create(image: "lop_bunny.jpg",
                    name: "Amber",
                    description: "An adorable little rabbit.",
                    approx_age: 5,
                    sex: "female",
                    adopt_status: 'adoptable',
                    shelter_id: dumb_friends.id)

taro = Pet.create(image: "hamster_tube.jpg",
                  name: "Taro",
                  description: "A playful little hamster.",
                  approx_age: 3,
                  sex: "male",
                  adopt_status: 'adoptable',
                  shelter_id: denver_animal.id)

spot = Pet.create(image: "spotted_puppy.jpg",
                    name: "Spot",
                    description: "A little guy who's still growing!",
                    approx_age: 1,
                    sex: "male",
                    adopt_status: 'adoptable',
                    shelter_id: dumb_friends.id)
