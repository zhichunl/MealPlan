#!/usr/bin/env python
# dropwoof project :D
# routing.py
#
# Defines all the mapping of url paths to controllers


import webapp2
import controllers

app = webapp2.WSGIApplication([
    ('/', controllers.HomePage),
    ], debug=True)
