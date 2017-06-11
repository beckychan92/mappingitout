# Project - *MappingItOut*


**MappingItOut** is a map interface with a visual indicator on the
map that animates from one geo-coordinate point to another (based on the given geo-coordinate points).

The following functionality is completed:
[ ] Correctly parse the JSON file
[ ] Create an application where map view encompasses most of the screen
space.
[ ] Within the app, you must add an in-map overlay that initially point to the first
geo-coordinate point provided from the JSON file.
[ ] With every passing 0.5 seconds, animate the overlay from the previous (or
initial) point to the next geo-coordinate point.
[ ] User should be able to pan and zoom the map interface, without affecting the
in-map overlay's position relative to the geo-spatial coordinate plane.
[ ] User's touch events should not block the animation from being performed,
and vice-versa.