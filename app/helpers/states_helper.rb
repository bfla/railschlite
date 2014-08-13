module StatesHelper
  def state_header_url(state)
    asset_path "/images/backgrounds/camping-header.jpg"
  end
  def search_state_map(state)
    distance = state.zoom || 500
    searches_path(keywords:"#{state.latitude}, #{state.longitude}", distance:distance)
  end
end
