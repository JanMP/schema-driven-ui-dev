# schema-driven-ui-dev

## this is a work in progress and it's really quite a bit of a mess, atm

This is a test/demo app I use while developing [janmp:schema-driven-ui](https://github.com/JanMP/schema-driven-ui), a meteor package that offers a quick way to
create an ui around heavy duty, infinite scrolling, virtualized, editable datatables whith very little code (and that package
is a messy wip, too). 

It's deployed on 
[Galaxy](https://galaxy.meteor.com/app/schema-driven-ui-dev.meteorapp.com) and it's "working" (it doesn't crash and the data evantually shows up)
even thogh it's running on a free deploy and we have it sort through 10k entries in a reactive aggregation.

When you open the app you will get to a desktop with several minimized windows (it's not set up with a reasonable default placement of
those windows yet). Just can drag them around and resize them (lower right corner for resizing).

In it's current state it's not suitable for use in a publi facing web app (it's been developed for use in a small company that does
heavy duty data crunching with just a handfull of users and a server that can handle several aggregation pipelines at the same time.

To get an idea what it takes to use the data table check out 
https://github.com/JanMP/schema-driven-ui-dev/blob/master/imports/api/AutoTableTest.coffee
and
https://github.com/JanMP/schema-driven-ui-dev/blob/master/imports/ui/AutoTableTest.coffee

