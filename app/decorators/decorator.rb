class Decorator

  attr_accessor :object

  def initialize(object)
    self.object = object
  end

  def method_missing(m, *args, &block)
    object.send(m, *args, &block)
  end
end