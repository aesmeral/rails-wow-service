# frozen_string_literal: true

module Callable
  extend ActiveSupport::Concern

  class_methods do
    def call(*args, **kwargs, &)
      if block_given?
        new.call(*args, **kwargs, &)
      else
        new.call(*args, **kwargs)
      end
    end
  end

  def call
    raise NotImplementedError
  end
end
