# frozen_string_literal: true
class GoldConverter
  include Callable

  def call(total_copper)
    gold = total_copper / 10_000
    silver = (total_copper % 10_000) / 100
    copper = total_copper % 100

    { gold: ,silver: ,copper: }
  end
end
