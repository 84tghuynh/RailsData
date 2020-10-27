class GeojsonBuilder
  def build_event(event, geojson)
    geojson << {
      type:       "Feature",
      geometry:   {
        type:        "Point",
        coordinates: [event.longitude.to_f, event.latitude.to_f] # this part is tricky
      },
      properties: {
        title:           event.name,
        address:         event.street_address,
        "marker-color":  "#FFFFFF",
        "marker-symbol": "circle",
        "marker-size":   "medium"
      }
    }
  end
end
