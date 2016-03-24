defmodule Parallel do
  def map(collection, func) do
    Enum.map(collection, func)
  end

  def pmap(collection, func) do
    me = self

    collection
    |> Enum.map(fn (elem) ->
      spawn_link fn -> send(me, { self, func.(elem) }) end
    end)
    |> Enum.map(fn (pid) ->
      receive do { ^pid, result } -> result end
    end)
  end

  def tmap(collection, func) do
    collection
    |> Enum.map(&(Task.async(fn -> func.(&1) end)))
    |> Enum.map(&Task.await/1)
  end
end
