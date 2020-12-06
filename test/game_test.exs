defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.Player
  alias ExMon.Game

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("a", "b", "c", "d")
      computer = Player.build("a", "b", "c", "d")

      # pattern matching para validar
      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "start/0" do
    test "returns the current game state" do
      player = Player.build("a", "b", "c", "d")
      computer = Player.build("a", "b", "c", "d")

      expected_reponse = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: "a", move_heal: "b", move_rnd: "c"},
          name: "d"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: "a", move_heal: "b", move_rnd: "c"},
          name: "d"
        },
        status: :started,
        turn: :player
      }

      Game.start(computer, player)
      assert Game.info() == expected_reponse
    end
  end

  describe "update/1" do
    test "restuns the game state updated" do
      player = Player.build("a", "b", "c", "d")
      computer = Player.build("a", "b", "c", "d")

      expected_reponse = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: "a", move_heal: "b", move_rnd: "c"},
          name: "d"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: "a", move_heal: "b", move_rnd: "c"},
          name: "d"
        },
        status: :started,
        turn: :player
      }

      Game.start(computer, player)
      assert Game.info() == expected_reponse

      new_state = %{
        computer: %Player{
          life: 85,
          moves: %{move_avg: "a", move_heal: "b", move_rnd: "c"},
          name: "d"
        },
        player: %Player{
          life: 50,
          moves: %{move_avg: "a", move_heal: "b", move_rnd: "c"},
          name: "d"
        },
        status: :started,
        turn: :player
      }

      espected_reponse = %{
        computer: %Player{
          life: 85,
          moves: %{move_avg: "a", move_heal: "b", move_rnd: "c"},
          name: "d"
        },
        player: %Player{
          life: 50,
          moves: %{move_avg: "a", move_heal: "b", move_rnd: "c"},
          name: "d"
        },
        status: :continue,
        turn: :computer
      }

      Game.update(new_state)
      assert Game.info() == espected_reponse
    end
  end
end
