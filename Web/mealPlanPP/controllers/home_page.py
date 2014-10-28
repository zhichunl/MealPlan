#!/usr/bin/env python

# request handler for mainpage

import webapp2
import lib

class HomePage(webapp2.RequestHandler):

    def get(self):
        template = lib.HtmlLoader.load_template('index.html')
        self.response.write(template.render())
