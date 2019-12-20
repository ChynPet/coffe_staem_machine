defmodule Coffee do

  def start_link do
    :gen_fsm.start_link({:local, __MODULE__}, __MODULE__, [], [])
  end

  def init([]) do
    IO.puts("Веберіть напій")
    :erlang.process_flag(:trap_exit, true)
    {:ok, :selection, []}
  end

  #Події
  def tea, do: :gen_fsm.send_event(__MODULE__, {:selection, :tea, 100})
  def espresso, do: :gen_fsm.send_event(__MODULE__, {:selection, :espresso, 150})
  def americano, do: :gen_fsm.send_event(__MODULE__, {:selection, :americano, 200})
  def cappuccion, do: :gen_fsm.send_event(__MODULE__, {:selection, :cappuccion, 300})
  def pay(coin), do: :gen_fsm.send_event(__MODULE__, {:pay, coin})
  def cancel(), do: :gen_fsm.send_event(__MODULE__, :cancel)
  def cup_removed, do: :gen_fsm.send_event(__MODULE__, :cup_removed)
  def compression, do: gen_fsm.send_event(__MODULE__, :compression)
  #Стани
  def selection({:selection, :tea, 100}, []) do
    {:next_state, :payment, {:tea, 100, 0}};
  end
  def selection({:selection, :espresso, 150}, []) do
    {:next_state, :payment, {:espresso, 150,0}};
  end
  def selection({:selection, :americano, 200}, []) do
    {:next_state, :payment, {:americano, 200, 0}};
  end
  def selection({:selection, :cappuccion, 300}, []) do
    {:next_state, :payment, {:cappuccino, 300, 0}};
  end

  def payment({:pay, coin}, {type, price, paid}) when coin+paid < price do
    new_paid = coin+paid
    IO.puts("Пожалуста оплатите #{price-new_paid}")
    {:next_state, :payment, {type, price, new_paid}}
  end

  def payment({:pay, coin}, {type, price, paid}) when coin+paid >= price do
    new_paid = coin+paid
    IO.puts("Готовиться напій")
    IO.puts("Заберіть напій")
    {:next_state, :comression, nil}
  end

  # def selection(_Other, LoopData) do
  #   {:next_state, :selection, LopoData}
  # end
end
