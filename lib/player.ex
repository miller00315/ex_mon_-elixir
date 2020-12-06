defmodule ExMon.Player do
  # variavel de modulo, não precisa atribuir com =
  @max_life 100
  @required_keys [:life, :move_avg, :move_heal, :move_rnd, :name]

  # define quais chaves ão aobrigatorias
  @enforce_keys @required_keys

  # define as chaves da struct
  defstruct @required_keys

  def build(move_avg, move_heal, move_rnd, name) do
    %ExMon.Player{
      life: @max_life,
      move_avg: move_avg,
      move_heal: move_heal,
      move_rnd: move_rnd,
      name: name
    }
  end
end
