package template

import rl "vendor:raylib"

import "dusk"

PlayState :: struct {
    using state:dusk.State,
}

new_game :: proc(game:^TemplateGame) -> ^PlayState {
    game.play_state = create_play_state()
    return game.play_state
}

create_play_state :: proc() -> ^PlayState {
    play_state := new(PlayState)
    play_state.enter = play_state_enter
    play_state.exit = play_state_exit
    play_state.update = play_state_update
    play_state.render = play_state_render

    return play_state
}

play_state_enter :: proc(state:^dusk.State, game:^dusk.Game) -> bool {
    game.clear_color = rl.DARKBLUE
    return true
}

play_state_update :: proc(state:^dusk.State, game:^dusk.Game, delta_time, run_time:f32) -> bool {
    return true
}

play_state_render :: proc(state:^dusk.State, game:^dusk.Game) {
    game := cast(^TemplateGame)game
    rl.DrawText(
        "TODO: Make Game!",
        game.screen_size.x / 2 - rl.MeasureText("TODO: Make Game!", 128) / 2,
        game.screen_size.y / 2 - 64,
        128,
        rl.WHITE,
    )
}

play_state_exit :: proc(state:^dusk.State, game:^dusk.Game) {
}