module StatesHelper
  def state_header_url(state)
    if state.lead_photo.url.include? "missing.png"
     "#{request.protocol}#{request.host_with_port}#{asset_path '/images/backgrounds/camping-header.jpg'}"
    else
      state.lead_photo.url(:header)
    end
  end
  def state_thumb_photo(state)
    if state.lead_photo.url.include? "missing.png"
      asset_path "/images/thumb-test.png"
    else
      state.lead_photo.url(:thumb)
    end
  end
  def search_state_map(state)
    distance = state.zoom || 500
    searches_path(keywords:"#{state.latitude}, #{state.longitude}", distance:distance)
  end
end
