#!/usr/bin/env python

import webapp2
import lib
import httplib
import urllib
import parse_rest
from parse_rest.user import User
from parse_rest.core import ResourceRequestNotFound

def login_required(func):
    def ret(obj, *args, **kw):
        if obj.request.cookies.get('user_id') is not None:
            u = User.Query.get(objectId = obj.request.cookies.get('user_id'))
            if u is not None and u.sessionToken == obj.request.cookies.get('session_token'):
                b = Business.Query.get(objectId=u.otherId)
                setattr(obj, 'current_user', u)
                setattr(obj, 'business', b)
                return func(obj, *args, **kw)
        return obj.redirect('/')
    #end def
    return ret


class Business(parse_rest.datatypes.Object):
    pass

class Order(parse_rest.datatypes.Object):
    pass



class HomePage(webapp2.RequestHandler):
    def get(self):
        template = lib.HtmlLoader.load_template('sign_in.html')
        self.response.write(template.render())

    def post(self):
        #autheticate
        username = self.request.POST.get('username') 
        password = self.request.POST.get('password')
        try:
            u = User.login(username, password)
            self.response.set_cookie('session_token',u.sessionToken,3600)
            self.response.set_cookie('user_id',u.objectId,3600)
        except ResourceRequestNotFound:
            return self.redirect('/?error=1')

        if u.user_type != 'Business':
            return self.redirect('/?error=2')

        try:
            bId = u.otherId
        except AttributeError:
            b = Business(user_id=u)
            b.save()
            u.otherId = b.objectId
            u.save() 


        return self.redirect('/profile')

class ProfilePage(webapp2.RequestHandler):

    @login_required
    def get(self):
        u = self.current_user
        b = self.business
        template = lib.HtmlLoader.load_template('profile.html')
        self.response.write(template.render(u = u, b = b))

class MenuPage(webapp2.RequestHandler):
    @login_required
    def get(self):
        u = self.current_user 
        b = self.business
        template = lib.HtmlLoader.load_template('menu.html')
        self.response.write(template.render(u = u, b = b))

class OrderPage(webapp2.RequestHandler):
    @login_required
    def get(self):
        u = self.current_user 
        b = self.business
        orderList = Order.Query.filter(restaurant=b)
        template = lib.HtmlLoader.load_template('order.html')
        self.response.write(template.render(u = u, b = b, orderList = orderList))