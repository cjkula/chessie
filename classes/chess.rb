class Chess
  # generic way to initialize objects
  def initialize(params={})
    params.each do |k, v|
      self[k] = v
    end
  end
  # cop some functionality from Rails
  def []=(key, value)
    instance_variable_set "@#{key}", value
  end
  def [](key)
    instance_variable_get "@#{key}"
  end
end
