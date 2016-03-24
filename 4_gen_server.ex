defmodule GenSer do
  use GenServer

  def start do
    IO.inspect "si"
    GenServer.start_link(__MODULE__, [], name: :list)
  end

  def handle_call(:pop, _from, [h|t]) do
    {:reply, h, t}
  end

  def handle_call(:peek, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:push, item}, state) do
    {:noreply, [item|state]}
  end
end
