# Project - *MappingItOut*


**MappingItOut** is a map interface with a visual indicator on the
map that animates from one geo-coordinate point to another (based on the given geo-coordinate points).

Time spent: *9* hours spent in total

The following functionality is completed:
- [X] Parse the JSON file
- [X] Create an application where map view encompasses most of the screen
space.
- [0.5] Within the app, you must add an in-map overlay that initially point to the first
geo-coordinate point provided from the JSON file.
- [0.5] With every passing 0.5 seconds, animate the overlay from the previous (or
initial) point to the next geo-coordinate point.
- [X] User should be able to pan and zoom the map interface, without affecting the
in-map overlay's position relative to the geo-spatial coordinate plane.
- [X] User's touch events should not block the animation from being performed,
and vice-versa.

## MappingItOut

<a href="http://imgur.com/QTXSbXz"><img src="http://i.imgur.com/QTXSbXz.png" title="source: imgur.com" /></a>

<a href="http://imgur.com/s4IyRcN"><img src="http://i.imgur.com/s4IyRcN.png" title="source: imgur.com" /></a>

## Notes

Describe any challenges encountered while building the app.
1. Parsing local data with Swift
2. Apple loads all annotations at once

## License

Copyright [2017] [Becky Chan]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
