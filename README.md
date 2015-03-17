# Vert.x Example Maven Project

Demo Vert.x server using JavaScript for UI and Ruby for app and access logic.
See my [blog post about this demo:]( https://www.blogger.com/blogger.g?blogID=11696452#editor/target=post;postID=8716957410259649405;onPublishedMenu=allposts;onClosedMenu=allposts;postNum=0;src=postname)

## Setup
First you will need Vert.x:  http://vertx.io/install.html

You will also need a jruby environment set up, I use rvm:
> rvm install jruby
>  #  Set up a gemset if you want to keep a clean space
> rvm use ...

Install all the necessary gems into the current env
> bundle install

This project uses some of the gems from rails, without pulling in the whole enchilada.  I use active_record_migrations and a custom Rakefile to set up migrations, without said enchilada.  I have one migration to set up the little database:
> rake db:migrate db=development

Finally you should be able to run the server.js verticle, defined as main in mod.json:
> mvn install vertx:runMod
