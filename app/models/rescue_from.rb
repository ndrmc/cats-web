class RescueFrom
  def initialize(error_superclass, resolve_func)
    @error_superclass = error_superclass
    @resolve_func = resolve_func
  end

  def call(obj, args, ctx)
    @resolve_func.call(obj, args, ctx)
  rescue @error_superclass => err
    GraphQL::ExecutionError.new(err.message)
  end
end
