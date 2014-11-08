#!/usr/bin/env python
# dropwoof project :D
# routing.py
#
# Defines all the mapping of url paths to controllers


import webapp2
import controllers
import parse_rest

app = webapp2.WSGIApplication([
    ('/', controllers.HomePage),
    ('/profile', controllers.ProfilePage),
    ('/menu', controllers.MenuPage),
    ('/order', controllers.OrderPage),
    ], debug=True)

parse_rest.connection.register("Ana8uuDGOzss5pSfm601do1BStWqojasHz3xELDw","5ADgq69PkNtlkwgk39WE6TKBj455ceFco1vzPK1g",
	master_key = "rVNOT8VLQjhCR6eBlQijm7cWGejIuXRO6Me3bHTQ")
