defmodule Spawn do
  def spawner do
    spawn &process/0
    IO.puts "in spawner"
  end

  def process do
    :timer.sleep 1_000
    IO.puts "in process"
  end

  def spawner_link(true) do
    spawn_link &broken_process/0
    IO.puts "in spawner"
    IO.inspect self
  end
  def spawner_link(false) do
    spawn &broken_process/0
    IO.puts "in spawner"
    IO.inspect self
  end

  def broken_process do
    :timer.sleep 1_000
    raise "Errore!"
  end

  def receiver do
    pid = self
    spawn fn ->
      :timer.sleep 1_000
      send pid, "sender!"
    end
    receive do
      anything -> IO.puts(anything)
    end
    IO.puts "in receiver"
  end
end
