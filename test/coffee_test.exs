defmodule CoffeeTest do
  use ExUnit.Case
  doctest Coffee

  test "greets the world" do
    assert Coffee.hello() == :world
  end
end
