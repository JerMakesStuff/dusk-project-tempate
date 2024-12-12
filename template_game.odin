package template

import "dusk"

Difficulty :: enum {
    easy,
    normal,
    hard,
}

TemplateGame :: struct {
    using game:dusk.Game,
    difficulty:Difficulty,
    title_screen:^TitleScreen,
    play_state:^PlayState,
}

start :: proc(game:^dusk.Game) -> bool {
    game := cast(^TemplateGame)game
    game.difficulty = dusk.get_setting_as_enum(game, "gameplay", "difficulty", Difficulty.normal)
    game.title_screen = create_title_screen()
    dusk.push_state(game, game.title_screen)
    return true
}

shutdown :: proc(game:^dusk.Game) {
}

main :: proc() {
    my_game := TemplateGame{
        name = "My Game",
        start = start,
        shutdown = shutdown,
    }
    dusk.run(&my_game)
}
