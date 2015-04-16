#!/usr/bin/env ruby

require 'json'


file = File.read('drink-water.json')
waters = JSON.parse(file)


result = {
  type: "FeatureCollection",
  features: []
}

waters.each do |w|
  properties = w
  puts w
  long = w["Longitude"].to_f
  lat = w["Latitude"].to_f

  properties.delete('Longitude')
  properties.delete('Latitude')
  properties.delete('FIELD19')
  water = {
    type: "Feature",
    geometry: {
      type: "Point",
      coordinates: [long, lat]
    },
    properties: properties
  }
  result[:features] << water
end


File.open("drink-water.geojson","w") do |f|
  f.write(result.to_json)
end
