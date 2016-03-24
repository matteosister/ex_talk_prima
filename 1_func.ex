defmodule Func do
  def run! do
    Enum.map([1, 2, 3], fn (v) -> v * 2 end)
  end

  def run!(func) do
    Enum.map([1, 2, 3], func)
  end

  def add(what) do
    &(what + &1)
  end

  def adder(fst, snd) do
    fst + snd
  end
end
