package template

import "core:strings"

import rl "vendor:raylib"

import "dusk"

TitleScreen :: struct {
    using state:dusk.State,

    title_text:cstring,
    title_text_font_size:i32,
    title_text_position:[2]i32,

    press_to_play_text:cstring,
    press_to_play_text_font_size:i32,
    press_to_play_text_position:[2]i32,
}

create_title_screen :: proc() -> ^TitleScreen {
    title_screen := new(TitleScreen)
    title_screen.enter = title_screen_enter
    title_screen.exit = title_screen_exit
    title_screen.update = title_screen_update
    title_screen.render = title_screen_render    
    return title_screen
}

title_screen_enter :: proc(state:^dusk.State, game:^dusk.Game) -> bool {
    state := cast(^TitleScreen)state
    game := cast(^TemplateGame)game
    
    state.title_text = strings.clone_to_cstring(game.name, context.allocator)
    state.title_text_font_size = 128
    text_width := rl.MeasureText(state.title_text, state.title_text_font_size)
    state.title_text_position.x =  game.screen_size.x / 2 - text_width / 2
    state.title_text_position.y = 100

    state.press_to_play_text = strings.clone_to_cstring("Press [SPACE BAR] to play!", context.allocator)
    state.press_to_play_text_font_size = 32
    text_width = rl.MeasureText(state.press_to_play_text, state.press_to_play_text_font_size)
    state.press_to_play_text_position.x = game.screen_size.x / 2 - text_width / 2
    state.press_to_play_text_position.y = game.screen_size.y - state.press_to_play_text_font_size - 80

    game.clear_color = rl.DARKPURPLE

    return true
}

title_screen_update :: proc(state:^dusk.State, game:^dusk.Game, delta_time, run_time:f32) -> bool {
    game := cast(^TemplateGame)game
    
    if rl.IsKeyPressed(.SPACE) {
        dusk.push_state(game, new_game(game))
    }

    return true
}

title_screen_render :: proc(state:^dusk.State, game:^dusk.Game) {
    state := cast(^TitleScreen)state

    rl.DrawText(
        state.title_text,
        state.title_text_position.x,
        state.title_text_position.y,
        state.title_text_font_size,
        rl.WHITE,
    )

    rl.DrawText(
        state.press_to_play_text,
        state.press_to_play_text_position.x,
        state.press_to_play_text_position.y,
        state.press_to_play_text_font_size,
        rl.PURPLE,
    )
}

title_screen_exit :: proc(state:^dusk.State, game:^dusk.Game) {
    state := cast(^TitleScreen)state    
    delete(state.title_text)
    delete(state.press_to_play_text)
}