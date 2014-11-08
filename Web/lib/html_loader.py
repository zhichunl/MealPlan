# html_loader.py
#
# All the functionalities related to loading html templates

import jinja2
import os


class HtmlLoader(object):
    # Not sure whether this is the best way to do this...
    _PATH_TO_HTMLS = os.path.abspath(__file__ + "/../../ui/")

    _JINJA_ENVIRONMENT = jinja2.Environment(
        loader=jinja2.FileSystemLoader(_PATH_TO_HTMLS),
        extensions=['jinja2.ext.autoescape'],
        autoescape=True)

    @classmethod
    def load_template(cls, filename):
        return cls._JINJA_ENVIRONMENT.get_template(filename)
