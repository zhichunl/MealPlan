import webapp2
import lib

class MainPage(webapp2.RequestHandler):
    def get(self):
        template = lib.HtmlLoader.load_template('index.html')
        self.response.write(template.render())

application = webapp2.WSGIApplication([
    ('/', MainPage),
], debug=True)
