# powerline tabs + clock on the right
# based on: https://github.com/megalithic/dotfiles/blob/main/config/kitty/tab_bar.py
from datetime import datetime

from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    Formatter,
    TabBarData,
    as_rgb,
    draw_attributed_string,
    draw_tab_with_powerline,
)

REFRESH_SECONDS = 30
CLOCK_COLOR = as_rgb(0x2AA198)  # solarized cyan
RIGHT_MARGIN = 1


def _redraw_tab_bar(_):
    tm = get_boss().active_tab_manager
    if tm is not None:
        tm.mark_tab_bar_dirty()


_timer_id = None


def _draw_clock(screen: Screen, is_last: bool) -> int:
    if not is_last:
        return 0
    draw_attributed_string(Formatter.reset, screen)
    clock = datetime.now().strftime("%H:%M ")
    status_len = RIGHT_MARGIN + len(clock)
    draw_spaces = screen.columns - screen.cursor.x - status_len
    if draw_spaces < 0:
        return screen.cursor.x
    screen.draw(" " * draw_spaces)
    screen.cursor.fg = CLOCK_COLOR
    screen.cursor.bg = 0
    screen.draw(clock)
    screen.cursor.bg = 0
    return screen.cursor.x


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    global _timer_id
    if _timer_id is None:
        _timer_id = add_timer(_redraw_tab_bar, REFRESH_SECONDS, True)
    draw_tab_with_powerline(
        draw_data, screen, tab, before, max_title_length, index, is_last, extra_data
    )
    _draw_clock(screen, is_last)
    return screen.cursor.x
