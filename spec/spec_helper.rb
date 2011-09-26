def ensure_constant_defined(namespace, constant_name)
  if not namespace.const_defined? constant_name
    eval "#{namespace}::#{constant_name} = true"
  end
end
