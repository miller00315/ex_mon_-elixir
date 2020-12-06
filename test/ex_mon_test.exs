defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Player

  describe "create_player/1" do
    test "return a player" do
      expected_response = %Player{
        life: 100,
        moves: %{move_avg: "a", move_heal: "b", move_rnd: "c"},
        name: "d"
      }

      assert expected_response == ExMon.create_player("a", "b", "c", "d")
    end
  end

  describe "start_game/1" do
    test "when game is started, returns a message" do
      player = Player.build("a", "b", "c", "d")

      messages = capture_io(fn -> assert ExMon.start_game(player) == :ok end)

      assert messages =~ "===== The game started ====="
      assert messages =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("a", "b", "c", "d")

      capture_io(fn -> ExMon.start_game(player) end)

      {:ok, player: player}
    end

    test "when the move is valid, do the move and computer makes a move" do
      messages = capture_io(fn -> assert ExMon.make_move("a") == :ok end)

      assert messages =~ "===== Its's computer turn====="
      assert messages =~ "status: :continue"
    end

    # receb o palyer do setup
    test "when the move is invalid, not do the move and computer not makes a move", %{
      player: player
    } do
      IO.inspect(player)

      messages = capture_io(fn -> ExMon.make_move("x") end)

      assert messages =~ "=====Invalid move x====="
    end
  end
end
